From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
	with worker
Date: Sat, 3 Aug 2019 21:14:00 -0300
Message-ID: <20190804001400.GA25543@ziepe.ca>
References: <20190731123935.GC3946@ziepe.ca>
	<7555c949-ae6f-f105-6e1d-df21ddae9e4e@redhat.com>
	<20190731193057.GG3946@ziepe.ca>
	<a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
	<20190801141512.GB23899@ziepe.ca>
	<42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
	<20190802124613.GA11245@ziepe.ca>
	<20190802100414-mutt-send-email-mst@kernel.org>
	<20190802172418.GB11245@ziepe.ca>
	<20190803172944-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190803172944-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 03, 2019 at 05:36:13PM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 02, 2019 at 02:24:18PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 02, 2019 at 10:27:21AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Aug 02, 2019 at 09:46:13AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Aug 02, 2019 at 05:40:07PM +0800, Jason Wang wrote:
> > > > > > This must be a proper barrier, like a spinlock, mutex, or
> > > > > > synchronize_rcu.
> > > > > 
> > > > > 
> > > > > I start with synchronize_rcu() but both you and Michael raise some
> > > > > concern.
> > > > 
> > > > I've also idly wondered if calling synchronize_rcu() under the various
> > > > mm locks is a deadlock situation.
> > > > 
> > > > > Then I try spinlock and mutex:
> > > > > 
> > > > > 1) spinlock: add lots of overhead on datapath, this leads 0 performance
> > > > > improvement.
> > > > 
> > > > I think the topic here is correctness not performance improvement
> > > 
> > > The topic is whether we should revert
> > > commit 7f466032dc9 ("vhost: access vq metadata through kernel virtual address")
> > > 
> > > or keep it in. The only reason to keep it is performance.
> > 
> > Yikes, I'm not sure you can ever win against copy_from_user using
> > mmu_notifiers?
> 
> Ever since copy_from_user started playing with flags (for SMAP) and
> added speculation barriers there's a chance we can win by accessing
> memory through the kernel address.

You think copy_to_user will be more expensive than the minimum two
atomics required to synchronize with another thread?

> > Also, why can't this just permanently GUP the pages? In fact, where
> > does it put_page them anyhow? Worrying that 7f466 adds a get_user page
> > but does not add a put_page??

You didn't answer this.. Why not just use GUP?

Jason
