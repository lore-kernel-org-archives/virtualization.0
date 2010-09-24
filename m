From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: Re: [E1000-eedc] [PATCH 04/10] ECP implementation
Date: Fri, 24 Sep 2010 16:18:26 +0200
Message-ID: <201009241618.26482.jens@linux.vnet.ibm.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
	<1282739262-14968-5-git-send-email-jens@linux.vnet.ibm.com>
	<4C9AA46D.2040802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C9AA46D.2040802@intel.com>
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

On Thursday 23 September 2010, John Fastabend wrote:
> On 8/25/2010 5:27 AM, Jens Osterkamp wrote:
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
> =

> I am hesitant to apply these without a defined ethertype. Presumably this=
 will come out of the IEEE DCB task group.

I am not familiar with the IEEE process, but my current understanding is th=
at the ethertype is defined towards the
end of the standardization process, and the extended ethertype together wit=
h the OUI has to be used until then.

> =

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
> >  9 files changed, 1422 insertions(+), 3 deletions(-)
> >  create mode 100644 ecp/ecp.c
> >  create mode 100644 ecp/ecp.h
> >  create mode 100644 ecp/ecp_rx.c
> >  create mode 100644 ecp/ecp_tx.c
> >  create mode 100644 include/lldp_vdp.h
> > =

> > diff --git a/Makefile.am b/Makefile.am
> > index d59a6fa..061f2ee 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -56,6 +56,8 @@ $(lldpad_include_HEADERS) $(noinst_HEADERS) \
> >  lldp/ports.c lldp/agent.c lldp/l2_packet_linux.c lldp/tx.c \
> >  lldp/rx.c lldp/agent.h lldp/l2_packet.h lldp/mibdata.h lldp/ports.h \
> >  lldp/states.h \
> > +ecp/ecp.c ecp/ecp_tx.c \
> > +ecp/ecp_rx.c \
> >  include/lldp.h include/lldp_mod.h \
> >  lldp_dcbx.c include/lldp_dcbx.h tlv_dcbx.c include/tlv_dcbx.h \
> >  lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
> > diff --git a/ecp/ecp.c b/ecp/ecp.c
> > new file mode 100644
> > index 0000000..ecf68f9
> > --- /dev/null
> > +++ b/ecp/ecp.c
> > @@ -0,0 +1,77 @@
> =

> snip snip
> =

snip

> Please merge the relevant pieces of this patch with the following patch s=
o it does not add 'struct ecp' to the port structure then immediately move =
it to vdp_data in the following patch.

I will address your comments in my next posting of the series and merge the=
 relevant pieces to the previous patch.

Thanks !

Jens


-- =


IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
