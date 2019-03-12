From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Tue, 12 Mar 2019 16:04:50 -0400
Message-ID: <20190312200450.GA25147@redhat.com>
References: <20190308141220.GA21082@infradead.org>
	<56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
	<20190311095405-mutt-send-email-mst@kernel.org>
	<20190311.111413.1140896328197448401.davem@davemloft.net>
	<6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
	<20190311235140-mutt-send-email-mst@kernel.org>
	<76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
	<20190312075033-mutt-send-email-mst@kernel.org>
	<1552405610.3083.17.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1552405610.3083.17.camel@HansenPartnership.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 12, 2019 at 08:46:50AM -0700, James Bottomley wrote:
> On Tue, 2019-03-12 at 07:54 -0400, Michael S. Tsirkin wrote:
> > On Tue, Mar 12, 2019 at 03:17:00PM +0800, Jason Wang wrote:
> > > =

> > > On 2019/3/12 =E4=B8=8A=E5=8D=8811:52, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 12, 2019 at 10:59:09AM +0800, Jason Wang wrote:
> [...]
> > > At least for -stable, we need the flush?
> > > =

> > > =

> > > > Three atomic ops per bit is way to expensive.
> > > =

> > > =

> > > Yes.
> > > =

> > > Thanks
> > =

> > See James's reply - I stand corrected we do kunmap so no need to
> > flush.
> =

> Well, I said that's what we do on Parisc.  The cachetlb document
> definitely says if you alter the data between kmap and kunmap you are
> responsible for the flush.  It's just that flush_dcache_page() is a no-
> op on x86 so they never remember to add it and since it will crash
> parisc if you get it wrong we finally gave up trying to make them.
> =

> But that's the point: it is a no-op on your favourite architecture so
> it costs you nothing to add it.

Yes, the fact Parisc gave up and is doing it on kunmap is reasonable
approach for Parisc, but it doesn't move the needle as far as vhost
common code is concerned, because other archs don't flush any cache on
kunmap.

So either all other archs give up trying to optimize, or vhost still
has to call flush_dcache_page() after kunmap.

Which means after we fix vhost to add the flush_dcache_page after
kunmap, Parisc will get a double hit (but it also means Parisc was the
only one of those archs needed explicit cache flushes, where vhost
worked correctly so far.. so it kinds of proofs your point of giving
up being the safe choice).

Thanks,
Andrea
