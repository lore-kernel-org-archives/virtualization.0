From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [PATCH] virtio_net: large tx MTU support
Date: Fri, 28 Nov 2008 09:29:55 +0000
Message-ID: <1227864595.3643.13.camel__36330.8700886138$1227864948$gmane$org@blaa>
References: <1227707891.9579.44.camel@blaa>
	<200811272300.58151.rusty@rustcorp.com.au>
	<1227794225.24571.36.camel@blaa>
	<200811281052.33474.rusty@rustcorp.com.au>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200811281052.33474.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2008-11-28 at 10:52 +1030, Rusty Russell wrote:
> On Friday 28 November 2008 00:27:05 Mark McLoughlin wrote:
> > Hi Rusty,
> >
> > On Thu, 2008-11-27 at 23:00 +1030, Rusty Russell wrote:
> > > On Thursday 27 November 2008 00:28:11 Mark McLoughlin wrote:
> > > > We don't really have a max tx packet size limit, so allow configuring
> > > > the device with up to 64k tx MTU.
> > >
> > > Hi Mark,
> > >
> > > Just one comment: maybe we should be conservative and maybe limit to 1500
> > > if the host doesn't offer any of the GSO or MRG_RXBUF features?
> >
> > That was actually what I was going to do until I thought about it a bit
> > more and discussed it with Herbert.
> >
> > The virtio_net MTU only affects the transmit path, so there shouldn't be
> > any issue with a host that doesn't support those features.
> 
> Not quite what I meant.

Well, you did mention MRG_RXBUF :-)

> A minimal host can reasonably expect ethernet-fitting packets.  If it
> supports GSO of course it must handle larger ones.

I think this is orthogonal to GSO - e.g. a host may support GSO even if
it can only physically transmit 1500 byte frames.

MTU configuration is commonly a trial and error thing, so we're better
off allowing larger MTU sizes in cases where the host might not support
it rather than disallowing it in cases where the host can support it.

> Otherwise we should add YA feature bit or even a max-mtu field.

If e.g. we allowed physical device assignment via virtio, then the MTU
would be limited to the MTU supported by the physical device. In that
case it might make sense to add a max-mtu field or similar, but IMHO
it's fine to allow larger MTU sizes in the mean time.

Cheers,
Mark.
