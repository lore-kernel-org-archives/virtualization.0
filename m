From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: Re: [E1000-eedc] [PATCH 05/10] implementation of VDP
Date: Fri, 24 Sep 2010 16:15:17 +0200
Message-ID: <201009241615.17923.jens@linux.vnet.ibm.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
	<1282739262-14968-6-git-send-email-jens@linux.vnet.ibm.com>
	<4C9AA580.2010102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C9AA580.2010102@intel.com>
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
> > This patch contains an initial implemention of VDP as specified in IEEE
> > 802.1Qbg.
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

snip

> =

> =

> Few minor nits otherwise looks good. Please merge relevant parts with pat=
ch 4 though.

I will address all your comments in my next posting of the series.

Thanks !

Jens

-- =


IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
