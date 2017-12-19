From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Tue, 19 Dec 2017 20:07:01 +0200
Message-ID: <20171219200611-mutt-send-email-mst__3232.40311486206$1513706739$gmane$org@kernel.org>
References: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
	<20171219174259-mutt-send-email-mst@kernel.org>
	<ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
	<20171219095548.61d70d10@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171219095548.61d70d10@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, alexander.duyck@gmail.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 19, 2017 at 09:55:48AM -0800, Stephen Hemminger wrote:
> On Tue, 19 Dec 2017 09:41:39 -0800
> "Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:
> =

> > On 12/19/2017 7:47 AM, Michael S. Tsirkin wrote:
> > > I'll need to look at this more, in particular the feature
> > > bit is missing here. For now one question:
> > >
> > > On Mon, Dec 18, 2017 at 04:40:36PM -0800, Sridhar Samudrala wrote:  =

> > >> @@ -56,6 +58,8 @@ module_param(napi_tx, bool, 0644);
> > >>    */
> > >>   DECLARE_EWMA(pkt_len, 0, 64)
> > >>   =

> > >> +#define VF_TAKEOVER_INT	(HZ / 10)
> > >> +
> > >>   #define VIRTNET_DRIVER_VERSION "1.0.0"
> > >>   =

> > >>   static const unsigned long guest_offloads[] =3D {  =

> > > Why is this delay necessary? And why by 100ms?  =

> > =

> > This is based on netvsc implementation and here is the commit that
> > added this delay.=A0 Not sure if this needs to be 100ms.
> > =

> > commit 6123c66854c174e4982f98195100c1d990f9e5e6
> > Author: stephen hemminger <stephen@networkplumber.org>
> > Date:=A0=A0 Wed Aug 9 17:46:03 2017 -0700
> > =

> >  =A0=A0=A0 netvsc: delay setup of VF device
> > =

> >  =A0=A0=A0 When VF device is discovered, delay bring it automatically u=
p in
> >  =A0=A0=A0 order to allow userspace to some simple changes (like renami=
ng).
> > =

> > =

> > =

> =

> could be 10ms, just enough to let udev do its renaming

Isn't there a way not to depend on udev completing its thing within a given=
 timeframe?
