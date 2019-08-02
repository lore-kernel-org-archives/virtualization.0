From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
	with worker
Date: Fri, 2 Aug 2019 09:46:13 -0300
Message-ID: <20190802124613.GA11245__29896.6861491621$1564750005$gmane$org@ziepe.ca>
References: <20190731084655.7024-1-jasowang@redhat.com>
	<20190731084655.7024-8-jasowang@redhat.com>
	<20190731123935.GC3946@ziepe.ca>
	<7555c949-ae6f-f105-6e1d-df21ddae9e4e@redhat.com>
	<20190731193057.GG3946@ziepe.ca>
	<a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
	<20190801141512.GB23899@ziepe.ca>
	<42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 02, 2019 at 05:40:07PM +0800, Jason Wang wrote:
> > This must be a proper barrier, like a spinlock, mutex, or
> > synchronize_rcu.
> 
> 
> I start with synchronize_rcu() but both you and Michael raise some
> concern.

I've also idly wondered if calling synchronize_rcu() under the various
mm locks is a deadlock situation.

> Then I try spinlock and mutex:
> 
> 1) spinlock: add lots of overhead on datapath, this leads 0 performance
> improvement.

I think the topic here is correctness not performance improvement

> 2) SRCU: full memory barrier requires on srcu_read_lock(), which still leads
> little performance improvement
 
> 3) mutex: a possible issue is need to wait for the page to be swapped in (is
> this unacceptable ?), another issue is that we need hold vq lock during
> range overlap check.

I have a feeling that mmu notififers cannot safely become dependent on
progress of swap without causing deadlock. You probably should avoid
this.

> > And, again, you can't re-invent a spinlock with open coding and get
> > something better.
> 
> So the question is if waiting for swap is considered to be unsuitable for
> MMU notifiers. If not, it would simplify codes. If not, we still need to
> figure out a possible solution.
> 
> Btw, I come up another idea, that is to disable preemption when vhost thread
> need to access the memory. Then register preempt notifier and if vhost
> thread is preempted, we're sure no one will access the memory and can do the
> cleanup.

I think you should use the spinlock so at least the code is obviously
functionally correct and worry about designing some properly justified
performance change after.

Jason
