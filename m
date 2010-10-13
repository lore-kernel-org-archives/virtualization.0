From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: Re: [E1000-eedc] [PATCH 2/9] implementation of IEEE 802.1Qbg in
	lldpad, part 1
Date: Wed, 13 Oct 2010 16:40:48 +0200
Message-ID: <201010131640.48715.jens@linux.vnet.ibm.com>
References: <1285686662-8561-1-git-send-email-jens@linux.vnet.ibm.com>
	<1285686662-8561-3-git-send-email-jens@linux.vnet.ibm.com>
	<4CB4A368.3030408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CB4A368.3030408@intel.com>
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
Cc: "chrisw@redhat.com" <chrisw@redhat.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, e1000-eedc@lists.sourceforge.net, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 12 October 2010, John Fastabend wrote:
> On 9/28/2010 8:10 AM, Jens Osterkamp wrote:
> > This patch contains the first part of an initial implementation of the
> > IEEE 802.1Qbg standard: it implements code for the exchange of EVB
> > capabilities between a host with virtual machines and an adjacent switc=
h.
> > For this it adds a new EVB TLV to LLDP.
> > =

> > Exchange of EVB TLV may be enabled or disabled on a per port basis.
> > Information about the information negotiated by the protocol can be
> > queried on the commandline with lldptool.
> > =

> > This patch adds support for querying and setting parameters used in
> > the exchange of EVB TLV messages.
> > The parameters that can be set are:
> > =

> >         - forwarding mode
> >         - host protocol capabilities (RTE, ECP, VDP)
> >         - no. of supported VSIs
> >         - retransmission timer exponent (RTE)
> > =

> > The parameters are implemented as a local policy: all frames received by
> > an adjacent switch are validated against this policy and taken over whe=
re
> > appropriate. Negotiated parameters are stored in lldpads config, picked=
 up
> > again and used at the next start.
> > =

> > The patch applies to lldpad 0.9.38 and still contains code to log proto=
col
> > activity more verbosely than it would be necessary in the final version.
> > =

> > Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
> > ---
> >  Makefile.am             |   10 +-
> >  include/lldp.h          |   19 ++
> >  include/lldp_evb.h      |   80 ++++++
> >  include/lldp_evb_clif.h |   51 ++++
> >  include/lldp_evb_cmds.h |   31 +++
> >  include/lldp_tlv.h      |    1 +
> >  lldp_evb.c              |  638 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  lldp_evb_clif.c         |  226 +++++++++++++++++
> >  lldp_evb_cmds.c         |  512 +++++++++++++++++++++++++++++++++++++
> >  lldpad.c                |    2 +
> >  lldptool.c              |    2 +
> >  11 files changed, 1568 insertions(+), 4 deletions(-)
> >  create mode 100644 include/lldp_evb.h
> >  create mode 100644 include/lldp_evb_clif.h
> >  create mode 100644 include/lldp_evb_cmds.h
> >  create mode 100644 lldp_evb.c
> >  create mode 100644 lldp_evb_clif.c
> >  create mode 100644 lldp_evb_cmds.c
> > =


[snip]

> > +void evb_ifup(char *ifname)
> > +{
> > +       struct evb_data *ed;
> > +       struct evb_user_data *ud;
> > +
> > +       ed =3D evb_data(ifname);
> > +       if (ed) {
> > +               fprintf(stderr, "### %s:%s exists\n", __func__, ifname);
> > +               goto out_err;
> > +       }
> > +
> > +       /* not found, alloc/init per-port tlv data */
> > +       ed =3D (struct evb_data *) calloc(1, sizeof(struct evb_data));
> > +       if (!ed) {
> > +               fprintf(stderr, "### %s:%s malloc %ld failed\n",
> > +                        __func__, ifname, sizeof(*ed));
> > +               goto out_err;
> > +       }
> > +       strncpy(ed->ifname, ifname, IFNAMSIZ);
> > +
> > +       if (!init_cfg()) {
> > +               fprintf(stderr, "### %s:%s init_cfg failed\n", __func__=
, ifname);
> =

> Need to free(ed) here too it looks like. Otherwise looks good.

Thank you for spotting this ! I fixed it in my code and will include it my =
next posting of the series.

Jens

-- =


IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
