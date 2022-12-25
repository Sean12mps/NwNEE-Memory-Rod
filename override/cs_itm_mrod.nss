#include "x2_inc_switches"

// Item description.
const string S_DESCRIPTION_HEADER    = "This rod remembers spells that was cast upon it. Upon activation, it will guide it's master to cast all the spells it remembers. To unmemorize all spells, place it on the ground and pick it up again.\n\n";
const string S_DESCRIPTION_UNCHARGED = "The rod is currently devoid of any magic.";
const string S_DESCRIPTION_CHARGED   = "The rod is currently charged with:\n";

// Item local vars.
const string S_LOCAL_VAR_NAME_SPELLS   = "spells";
const string S_LOCAL_VAR_NAME_SPELL_ID = "spell";

// Set item description based on saved spells.
void CsSetDescription( object oItem, json jSpells );

// Make PC cast array of item memorized spells.
void CsCastSpellsArray( json jSpells, object oPC );

// Get spell name by spell id.
string CsGetSpellName( int nSpellId );

// Main hook.
void main() {

    object oPC;
    object oItem;

    json jSpells;
    json jSpell;

    int nEvent = GetUserDefinedItemEventNumber();
    int iSpell;
    int iCasterLevel;

    string sDescCharged;

    switch ( nEvent ) {

        case X2_ITEM_EVENT_ACQUIRE:
            oPC   = GetModuleItemAcquiredBy();
            oItem = GetModuleItemAcquired();

            jSpells = JsonArray();

            SetLocalJson( oItem, S_LOCAL_VAR_NAME_SPELLS, jSpells );
            SetDescription( oItem, S_DESCRIPTION_HEADER + S_DESCRIPTION_UNCHARGED, 1 );
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC     = GetItemActivator();
            oItem   = GetItemActivated();

            jSpells = GetLocalJson( oItem, S_LOCAL_VAR_NAME_SPELLS );

            CsCastSpellsArray( jSpells, oPC );
            break;

        case X2_ITEM_EVENT_SPELLCAST_AT:
            oPC    = OBJECT_SELF;
            oItem  = GetSpellTargetObject();

            iSpell       = GetSpellId();
            iCasterLevel = GetCasterLevel( oPC );

            jSpells = GetLocalJson( oItem, S_LOCAL_VAR_NAME_SPELLS );
            jSpell  = JsonObject();

            jSpell  = JsonObjectSet( jSpell, S_LOCAL_VAR_NAME_SPELL_ID, JsonInt( iSpell ) );
            jSpells = JsonArrayInsert( jSpells, jSpell );

            SetLocalJson( oItem, S_LOCAL_VAR_NAME_SPELLS, jSpells );

            CsSetDescription( oItem, jSpells );
            break;

    }
}

// Set item description based on saved spells.
void CsSetDescription( object oItem, json jSpells ) {

    string sNewDescription = S_DESCRIPTION_HEADER + S_DESCRIPTION_CHARGED;

    int jIndex      = 0;
    int bNextSpell = TRUE;

    while ( bNextSpell ) {

        bNextSpell = FALSE;

        json jSpell = JsonArrayGet( jSpells, jIndex );

        int nSpellId = JsonGetInt( JsonObjectGet( jSpell, S_LOCAL_VAR_NAME_SPELL_ID ) );

        if ( nSpellId > 0 ) {

            bNextSpell = TRUE;

            sNewDescription = sNewDescription + "- " + CsGetSpellName( nSpellId ) + "\n";

        } else {

            bNextSpell = FALSE;
        }

        jIndex++;
    }

    SetDescription( oItem, sNewDescription, 1 );
}

// Make PC cast array of item memorized spells.
void CsCastSpellsArray( json jSpells, object oPC ) {

    int jIndex;
    int nSpellsCount = JsonGetLength( jSpells );

    for ( jIndex = 0; jIndex < nSpellsCount; jIndex++ ) {

        json jSpell = JsonArrayGet( jSpells, jIndex );

        int nSpellId = JsonGetInt( JsonObjectGet( jSpell, S_LOCAL_VAR_NAME_SPELL_ID ) );

        AssignCommand(
            oPC,
            ActionCastSpellAtObject(
                // int nSpell
                nSpellId,
                // object oTarget
                oPC,
                // int nMetaMagic = METAMAGIC_ANY
                METAMAGIC_NONE,
                // int bCheat = FALSE
                FALSE,
                // int nDomainLevel = 0
                0,
                // int nProjectilePathType = PROJECTILE_PATH_TYPE_DEFAULT
                PROJECTILE_PATH_TYPE_DEFAULT,
                // int bInstantSpell = FALSE
                FALSE
            )
        );
    }
}

// Get spell name by spell id.
string CsGetSpellName( int nSpellId ) {

    //Look up the StrRef as a string in spells.2da
    string sStrRef = Get2DAString( "spells", "Name", nSpellId );

    //Convert to an integer
    int nStrRef = StringToInt( sStrRef );

    //Look up the name in the dialog.tlk file
    string sName = GetStringByStrRef( nStrRef );

    //return the spell's name
    return sName;
}
