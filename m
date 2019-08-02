From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
	with worker
Date: Fri, 2 Aug 2019 10:27:21 -0400
Message-ID: <20190802100414-mutt-send-email-mst__13487.7432881453$1564756145$gmane$org@kernel.org>
References: <20190731084655.7024-1-jasowang@redhat.com>
	<20190731084655.7024-8-jasowang@redhat.com>
	<20190731123935.GC3946@ziepe.ca>
	<7555c949-ae6f-f105-6e1d-df21ddae9e4e@redhat.com>
	<20190731193057.GG3946@ziepe.ca>
	<a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
	<20190801141512.GB23899@ziepe.ca>
	<42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
	<20190802124613.GA11245@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190802124613.GA11245@ziepe.ca>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 02, 2019 at 09:46:13AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 02, 2019 at 05:40:07PM +0800, Jason Wang wrote:
> > > This must be a proper barrier, like a spinlock, mutex, or
> > > synchronize_rcu.
> > 
> > 
> > I start with synchronize_rcu() but both you and Michael raise some
> > concern.
> 
> I've also idly wondered if calling synchronize_rcu() under the various
> mm locks is a deadlock situation.
> 
> > Then I try spinlock and mutex:
> > 
> > 1) spinlock: add lots of overhead on datapath, this leads 0 performance
> > improvement.
> 
> I think the topic here is correctness not performance improvement

The topic is whether we should revert
commit 7f466032dc9 ("vhost: access vq metadata through kernel virtual address")

or keep it in. The only reason to keep it is performance.

Now as long as all this code is disabled anyway, we can experiment a
bit.

I personally feel we would be best served by having two code paths:

- Access to VM memory directly mapped into kernel
- Access to userspace


Having it all cleanly split will allow a bunch of optimizations, for
example for years now we planned to be able to process an incoming short
packet directly on softirq path, or an outgoing on directly within
eventfd.


-- 
MST
