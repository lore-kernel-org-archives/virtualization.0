From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: Re: [E1000-eedc] [PATCH 02/10] implementation of IEEE 802.1Qbg in
	lldpad, part 1
Date: Fri, 24 Sep 2010 16:23:03 +0200
Message-ID: <201009241623.04502.jens@linux.vnet.ibm.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
	<1282739262-14968-3-git-send-email-jens@linux.vnet.ibm.com>
	<4C9AA43B.9000702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C9AA43B.9000702@intel.com>
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

snip

> remove the unneeded braces in the if statements above.
> =

> > +       /* only look at the mode for now
> > +       if (tie->ccap =3D=3D ed->tie->ccap) {
> > +               ed->tie->ccap =3D tie->ccap;
> > +       }
> > +
> > +       if (tie->cvsi =3D=3D ed->tie->cvsi) {
> > +               ed->tie->cvsi =3D tie->cvsi;
> > +       }
> > +       */
> =

> Why is this commented out? I will review the spec shortly, but please
> remind me. If its not needed remove it and add it later in a clean
> patch

Its not used right now, so its commented out. I removed it for now.

> =

> > +
> > +       return TLV_OK;
> > +}
> > +
> > +/* evb_compare
> > + *
> > + * compare our own and received tlv_info_evb
> > + */
> > +static int evb_compare(struct evb_data *ed, struct tlv_info_evb *tie)
> > +{
> > +       printf("%s(%i): \n", __func__, __LINE__);
> > +
> > +       if ((ed->tie->cmode =3D=3D tie->cmode) /* &&
> > +            (ed->tie->ccap =3D=3D tie->ccap) &&
> > +           (ed->tie->cvsi =3D=3D tie->cvsi)*/)
> =

> Same here if its going to be commented out lets remove it for now.

Removed it.

> =

> > +               return 0;
> > +       else
> > +               return 1;
> > +}
> > +
> > +/* evb_statemachine:
> > + *
> > + * handle possible states during EVB capabilities exchange
> > + *
> > + * possible states:    EVB_OFFER_CAPABILITIES
> > + *                     EVB_CONFIGURE
> > + *                     EVB_CONFIRMATION
> > + */
> > +static void evb_statemachine(struct evb_data *ed, struct tlv_info_evb =
*tie)

snip

> > diff --git a/lldptool.c b/lldptool.c
> > index 5cf2846..7e166fe 100644
> > --- a/lldptool.c
> > +++ b/lldptool.c
> > @@ -39,6 +39,7 @@
> >  #include "lldp_med_clif.h"
> >  #include "lldp_8023_clif.h"
> >  #include "lldp_dcbx_clif.h"
> > +#include "lldp_evb_clif.h"
> >  #include "lldptool.h"
> >  #include "lldptool_cli.h"
> >  #include "lldp_mod.h"
> > @@ -156,6 +157,7 @@ struct lldp_module *(*register_tlv_table[])(void) =
=3D {
> >         ieee8023_cli_register,
> >         med_cli_register,
> >         dcbx_cli_register,
> > +       evb_cli_register,
> >         NULL,
> >  };
> > =

> =

> Jens, in general this looks OK. Can you fix the coding style throughout
> I prefer for single line if statements,
> =

> if (x)
> 	a_line;
> else (y)
> 	b_line;
> =

> The intent here is to use the same coding style as linux kernel where it
> is reasonable to do so. Like I said before I know lldpad is not at all
> consistent in this regard, but I want to get the rest of the code in
> order and certainly have new code be consistent.

fixed this in all the places I could find.
I will address the rest your comments in my next posting of the series.

Thanks !

Jens


-- =


IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
