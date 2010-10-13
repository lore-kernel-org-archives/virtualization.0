From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: Re: [E1000-eedc] [PATCH 4/9] implementation of IEEE 802.1Qbg in
	lldpad, part 2
Date: Wed, 13 Oct 2010 17:03:32 +0200
Message-ID: <201010131703.33325.jens@linux.vnet.ibm.com>
References: <1285686662-8561-1-git-send-email-jens@linux.vnet.ibm.com>
	<1285686662-8561-5-git-send-email-jens@linux.vnet.ibm.com>
	<4CB4A3A9.2060800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CB4A3A9.2060800@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: John Fastabend <john.r.fastabend@intel.com>
Cc: "chrisw@redhat.com" <chrisw@redhat.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "e1000-eedc@lists.sourceforge.net" <e1000-eedc@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 12 October 2010, John Fastabend wrote:
> On 9/28/2010 8:10 AM, Jens Osterkamp wrote:
> > This is the implementation of the edge control protocol (ECP) and VSI
> > discovery protocol (VDP) currently being specified in IEEE 802.1Qbg.
> > =

> > This implementation extends the infrastructure defined lldpad to send a=
nd
> > receive ECP frames with a new (yet to be defined) ethertype.
> > Received frames are validated and analyzed before the content is handed=
 to the
> > upper layer protocol (ULP, VDP in this case) for further processing. Fr=
ames
> > to be transmitted are compiled from VSI (guest interface) profiles regi=
stered
> > on a interface.
> > Reception and transmission of ECP frames is controlled by RX and TX sta=
te
> > machines, timeouts are handled timeout functions.
> > The patch still contains a lot of debug code to allow low-level protocol
> > analysis.
> > =

> > VDP serves as the upper layer protocol (ULP) for TLVs communicated via =
the
> > ECP protocol.
> > For this it registers as a new module in lldpad. The VDP module support=
s a
> > station and a bridge role. As a station, new VSI (virtual station inter=
face)
> > profiles can be registered to the VDP module using lldptool or libvirt.
> > These profiles are then announced to an adjacent switch. Transmitted pr=
ofiles
> > are processed to the desired state by the VDP station state machine.
> > As a bridge, the VDP module waits for new profiles received in TLVs by =
ECP.
> > The received profiles are processed to the desired state by a VDP bridge
> > state machine.
> > =

> > VDP module parameters are stored in the "vdp" section under the appropr=
iate
> > interface.
> > =

> > The patch still contains a lot of debug code to allow analysis of VDP
> > protocol behavior.
> > =

> > Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
> > ---
> >  Makefile.am        |   10 +-
> >  ecp/ecp.c          |   79 ++++
> >  ecp/ecp.h          |  101 +++++
> >  ecp/ecp_rx.c       |  599 ++++++++++++++++++++++++++
> >  ecp/ecp_tx.c       |  494 ++++++++++++++++++++++
> >  include/lldp.h     |    1 +
> >  include/lldp_evb.h |    6 +
> >  include/lldp_vdp.h |  159 +++++++
> >  lldp/l2_packet.h   |    2 +
> >  lldp/ports.h       |   11 +-
> >  lldp_vdp.c         | 1185 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  lldpad.c           |    2 +
> >  12 files changed, 2642 insertions(+), 7 deletions(-)
> >  create mode 100644 ecp/ecp.c
> >  create mode 100644 ecp/ecp.h
> >  create mode 100644 ecp/ecp_rx.c
> >  create mode 100644 ecp/ecp_tx.c
> >  create mode 100644 include/lldp_vdp.h
> >  create mode 100644 lldp_vdp.c
> > =


[snip]

> > +               return false;
> > +       case ECP_RX_RECEIVE_ECPDU:
> > +               if (vd->ecp.seqECPDU =3D=3D vd->ecp.lastSequence) {
> > +                       printf("%s(%i):-(%s) seqECPDU %x, lastSequence =
%x\n", __func__, __LINE__,
> > +                              vd->ifname, vd->ecp.seqECPDU, vd->ecp.la=
stSequence);
> > +                       ecp_rx_change_state(vd, ECP_RX_RESEND_ACK);
> > +                       return true;
> > +               }
> > +               if (vd->ecp.seqECPDU !=3D vd->ecp.lastSequence) {
> > +                       ecp_rx_change_state(vd, ECP_RX_RESEND_ACK);
> > +                       return true;
> > +               }
> > +               return false;
> > +       case ECP_RX_SEND_ACK:
> =

> How can we get to this state? Did I miss something or could the ECP_RX_SE=
ND_ACK and ECP_RX_RESEND_ACK states be combined or ECP_RX_SEND_ACK removed =
outright?

Yep, can be combined but not entirely removed because different actions nee=
d to be taken for both states according to draft. Fixed in my next series.


> =

> > +               ecp_rx_change_state(vd, ECP_RX_RECEIVE_WAIT);
> > +               return false;
> > +       case ECP_RX_RESEND_ACK:
> > +               ecp_rx_change_state(vd, ECP_RX_RECEIVE_WAIT);
> > +               return false;
> > +       default:
> > +               printf("ERROR: The ECP_RX State Machine is broken!\n");
> > +               log_message(MSG_ERR_RX_SM_INVALID, "%s", vd->ifname);
> > +               return false;

[snip]

> > +                       if ((ptlv->size+fb_offset) > ETH_MAX_DATA_LEN)
> > +                               goto error;
> > +                       memcpy(vd->ecp.tx.frameout+fb_offset,
> > +                              ptlv->tlv, ptlv->size);
> > +                       datasize +=3D ptlv->size;
> > +                       fb_offset +=3D ptlv->size;
> =

> I think the ptlv needs to be free'd here? Else where is it getting free'd.

Fixed in my next series.

> =

> > +               }
> > +       }
> > +
> > +       /* The End TLV marks the end of the LLDP PDU */
> > +       ptlv =3D pack_end_tlv();
> > +       if (!ptlv || ((ptlv->size + fb_offset) > ETH_MAX_DATA_LEN))
> > +               goto error;
> > +       memcpy(vd->ecp.tx.frameout + fb_offset, ptlv->tlv, ptlv->size);
> > +       datasize +=3D ptlv->size;
> > +       fb_offset +=3D ptlv->size;
> > +       ptlv =3D  free_pkd_tlv(ptlv);
> > +
> > +       if (datasize > ETH_MAX_DATA_LEN)

[snip]

> > +
> > +       memset(vdp, 0, sizeof(struct tlv_info_vdp));
> > +       memcpy(vdp, tlv->info, tlv->length);
> > +
> > +       if (vdp_validate_tlv(vdp)) {
> > +               printf("%s(%i): Invalid TLV received !\n", __func__, __=
LINE__);
> > +               goto out_err;
> =

> Should be goto out_vdp

Fixed.

> =

> > +       }
> > +
> > +       profile =3D malloc(sizeof(struct vsi_profile));
> > +
> > +        if (!profile) {
> > +               printf("%s(%i): unable to allocate profile !\n", __func=
__, __LINE__);
> > +               goto out_vdp;
> > +        }
> > +
> > +       memset(profile, 0, sizeof(struct vsi_profile));
> > +
> > +       profile->mode =3D vdp->mode;
> > +       profile->response =3D vdp->response;
> > +
> > +       profile->mgrid =3D vdp->mgrid;
> > +       profile->id =3D ntoh24(vdp->id);
> > +       profile->version =3D vdp->version;
> > +       memcpy(&profile->instance, &vdp->instance, 16);
> > +       memcpy(&profile->mac, &vdp->mac_vlan.mac, MAC_ADDR_LEN);
> > +       profile->vlan =3D ntohs(vdp->mac_vlan.vlan);
> > +
> > +       profile->port =3D port;
> > +
> > +       if (vd->role =3D=3D VDP_ROLE_STATION) {
> > +               /* do we have the profile already ? */
> > +               LIST_FOREACH(p, &vd->profile_head, profile) {
> > +                       if (vdp_profile_equal(p, profile)) {
> > +                               printf("%s(%i): station: profile found,=
 localChange %i ackReceived %i!\n",
> > +                                      __func__, __LINE__, p->localChan=
ge, p->ackReceived);
> > +
> > +                               p->ackReceived =3D true;
> > +
> > +                               vdp_vsi_sm_station(p);
> > +                       } else {
> > +                               printf("%s(%i): station: profile not fo=
und !\n", __func__, __LINE__);
> > +                               /* ignore profile */
> > +                       }
> > +               }
> > +       }
> > +
> > +       if (vd->role =3D=3D VDP_ROLE_BRIDGE) {
> > +               /* do we have the profile already ? */
> > +               LIST_FOREACH(p, &vd->profile_head, profile) {
> > +                       if (vdp_profile_equal(p, profile)) {
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (p) {
> > +                       printf("%s(%i): bridge: profile found !\n", __f=
unc__, __LINE__);
> > +               } else {
> > +                       printf("%s(%i): bridge: profile not found !\n",=
 __func__, __LINE__);
> > +                       /* put it in the list  */
> > +                       profile->state =3D VSI_UNASSOCIATED;
> > +                       LIST_INSERT_HEAD(&vd->profile_head, profile, pr=
ofile );
> > +               }
> > +
> > +               vdp_vsi_sm_bridge(profile);
> > +       }
> > +
> =

> =

> Here the profile is added to a list if the port is in the VDP_ROLE_BRIDGE=
 mode. Otherwise the profile is only used to lookup an existing profile? Lo=
oks like there might be a memory leak if the profile already exists. Does t=
he profile need to be cleaned up the somewhere?

The standard is not clear on what to with profiles that e.g. have been deas=
sociated or have reached VSI_EXIT. In my next series I have added code to r=
emove the profile in the VSI_EXIT case.
> =

> > +       return 0;
> > +
> > +out_vdp:
> > +       free(vdp);
> > +out_err:
> > +       printf("%s(%i): error !\n", __func__, __LINE__);
> > +       return 1;
> > +
> > +}
> =

> =

> The rest looks good.

Thanks ! I will post a new series soon.

Jens

-- =


IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
