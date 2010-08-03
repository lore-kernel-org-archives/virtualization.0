From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: Re: [E1000-eedc] [PATCH 11/17] ECP implementation
Date: Tue, 3 Aug 2010 14:02:44 +0200
Message-ID: <201008031402.44207.jens@linux.vnet.ibm.com>
References: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
	<1279881273-10261-12-git-send-email-jens@linux.vnet.ibm.com>
	<4C57B8EC.4000604@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C57B8EC.4000604@intel.com>
Content-Disposition: inline
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

On Tuesday 03 August 2010, John Fastabend wrote:
> Jens Osterkamp wrote:
> > This is the implementation of the edge control protocol (ECP) as specif=
ied
> > in IEEE 802.1Qbg.
> > =

> > For this it extends the infrastructure defined lldpad to send and recei=
ve
> > ECP frames with a new (yet to be defined) ethertype.
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

> > Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
> > ---
> >  Makefile.am        |    2 +
> >  ecp/ecp.c          |   77 +++++++
> >  ecp/ecp.h          |   92 ++++++++
> >  ecp/ecp_rx.c       |  597 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  ecp/ecp_tx.c       |  467 ++++++++++++++++++++++++++++++++++++++++
> >  include/lldp_evb.h |    6 +
> >  include/lldp_vdp.h |  157 ++++++++++++++
> >  lldp/l2_packet.h   |    2 +
> >  lldp/ports.h       |   25 ++-
> >  lldp_evb.c         |    2 +
> >  10 files changed, 1424 insertions(+), 3 deletions(-)
> >  create mode 100644 ecp/ecp.c
> >  create mode 100644 ecp/ecp.h
> >  create mode 100644 ecp/ecp_rx.c
> >  create mode 100644 ecp/ecp_tx.c
> >  create mode 100644 include/lldp_vdp.h
> > =

> =

> snip
> =

> > +
> > +struct vdp_user_data {
> > +       LIST_HEAD(vdp_head, vdp_data) head;
> > +};
> > +
> > +struct lldp_module *vdp_register(void);
> > +void vdp_unregister(struct lldp_module *mod);
> > +struct vdp_data *vdp_data(char *ifname);
> > +struct packed_tlv *vdp_gettlv(struct port *port, struct vsi_profile *p=
rofile);
> > +void vdp_vsi_sm_station(struct vsi_profile *profile);
> > +struct vsi_profile *vdp_add_profile(struct vsi_profile *profile);
> > +
> > +#define MAC_ADDR_STRLEN                18
> > +#define INSTANCE_STRLEN                32
> > +
> > +#define PRINT_PROFILE(s, p)    \
> > +{ int c; \
> > +  c =3D sprintf(s, "\nmode: %i\n", p->mode); s +=3D c; \
> > +  c =3D sprintf(s, "response: %i\n", p->response); s +=3D c; \
> > +  c =3D sprintf(s, "state: %i\n", p->state); s +=3D c; \
> > +  c =3D sprintf(s, "mgrid: %i\n", p->mgrid); s +=3D c; \
> > +  c =3D sprintf(s, "id: %x%x%x\n", p->id[2], p->id[1], p->id[0]); \
> > +  s +=3D c; \
> > +  c =3D sprintf(s, "version: %i\n", p->version); s +=3D c; \
> > +  char instance[INSTANCE_STRLEN+2]; \
> > +  instance2str(p->instance, instance, sizeof(instance)); \
> > +  c =3D sprintf(s, "instance: %s\n", &instance); s +=3D c; \
> > +  char macbuf[MAC_ADDR_STRLEN+1]; \
> > +  mac2str(p->mac, macbuf, MAC_ADDR_STRLEN); \
> > +  c =3D sprintf(s, "mac: %s\n", macbuf); s +=3D c; \
> > +  c =3D sprintf(s, "vlan: %i\n\n", p->vlan); s +=3D c; \
> > +}
> > +
> > +#endif /* _LLDP_VDP_H */
> > diff --git a/lldp/l2_packet.h b/lldp/l2_packet.h
> > index 16f3683..0962429 100644
> > --- a/lldp/l2_packet.h
> > +++ b/lldp/l2_packet.h
> > @@ -36,6 +36,8 @@
> > =

> >  #define ETH_P_LLDP 0x88cc
> > =

> > +/* TODO: use extended ethertype until final ethertype is available */
> > +#define ETH_P_ECP 0x88b7
> > =

> >  #define ETH_FRAME_LEN   1514
> > =

> > diff --git a/lldp/ports.h b/lldp/ports.h
> > index 0138efe..c2e18ec 100644
> > --- a/lldp/ports.h
> > +++ b/lldp/ports.h
> > @@ -136,21 +136,40 @@ struct porttlvs{
> >         struct unpacked_tlv *last_peer;
> >  };
> > =

> > +struct ecp {
> > +       struct l2_packet_data *l2;
> > +       int sequence;
> > +       int retries;
> > +       int ackReceived;
> > +       int ackTimerExpired;
> > +       u16 lastSequence;
> > +       u16 seqECPDU;
> > +       struct portrx rx;
> > +       struct porttx tx;
> > +       struct portstats stats;
> > +};
> > +
> =

> =

> This structure is ecp specific and should be part of the ecp module.  Not=
 in =

> ports.h.

Right, I will move it.

> =

> >  struct port {
> >         char *ifname;
> >         u8 hw_resetting;
> >         u8 portEnabled;
> >         u8 prevPortEnabled;
> >         u8 adminStatus;
> > -       u8 rxChanges;
> > -       u16   lldpdu;
> > +
> > +       /* protocol specific */
> >         struct l2_packet_data *l2;
> >         struct portrx rx;
> >         struct porttx tx;
> > -       struct porttlvs tlvs;
> >         struct portstats stats;
> >         struct porttimers timers;
> > +       u8 rxChanges;
> > +       u16   lldpdu;
> >         struct msap msap;
> > +
> > +       /* not sure */
> > +       struct porttlvs tlvs;
> > +
> > +       struct ecp ecp;
> >         struct port *next;
> >  };
> > =

> =

> This adds ecp knowledge into the generic port structure I want to keep th=
e port =

> structure module agnostic.  dcbx addresses the same issue by using the mo=
dule =

> data space.  evb should use a similar scheme and create this structure at =

> ifup(). Any reason why this can't work?

I will look into it and check if I can move it as well.

> =

> > diff --git a/lldp_evb.c b/lldp_evb.c
> > index bce01b6..b1b7edc 100644
> > --- a/lldp_evb.c
> > +++ b/lldp_evb.c
> > @@ -354,6 +354,8 @@ static void evb_statemachine(struct evb_data *ed, s=
truct tlv_info_evb *tie)
> >                  * different parameters ? Check parameters. switch stat=
e back to
> >                  * EVB_CONFIGURE ? */
> >                 printf("%s: state -> EVB_CONFIRMATION\n", __func__);
> > +               if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
> > +                       ecp_init(ed->ifname);
> >                 break;
> >         default:
> >                 fprintf(stderr, "EVB statemachine reached invalid state=
 !\n");
> > --
> > 1.7.1
> > =

> > =

> > -----------------------------------------------------------------------=
-------
> > The Palm PDK Hot Apps Program offers developers who use the
> > Plug-In Development Kit to bring their C/C++ apps to Palm for a share
> > of $1 Million in cash or HP Products. Visit us here for more details:
> > http://ad.doubleclick.net/clk;226879339;13503038;l?
> > http://clk.atdmt.com/CRS/go/247765532/direct/01/
> > _______________________________________________
> > E1000-eedc mailing list
> > E1000-eedc@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/e1000-eedc
> =

> =



-- =

Best regards, =


Jens Osterkamp
---------------------------------------------------------------------------=
-----
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
