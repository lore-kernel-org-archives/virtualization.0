From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v9 3/5] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Mon, 27 Aug 2012 16:47:13 -0300
Message-ID: <20120827194713.GA6517__1457.93679771504$1346096874$gmane$org@t510.redhat.com>
References: <cover.1345869378.git.aquini@redhat.com>
	<a1ceca79d95bc7de2a6b62a2e565b95286dbdf75.1345869378.git.aquini@redhat.com>
	<20120826074244.GC19551@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120826074244.GC19551@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Aug 26, 2012 at 10:42:44AM +0300, Michael S. Tsirkin wrote:
> 
> Reading two atomics and doing math? Result can even be negative.
> I did not look at use closely but it looks suspicious.
Doc on atomic_read says:
"
The read is atomic in that the return value is guaranteed to be one of the
values initialized or modified with the interface operations if a proper
implicit or explicit memory barrier is used after possible runtime
initialization by any other thread and the value is modified only with the
interface operations.
"

There's no runtime init by other thread than balloon's itself at device register,
and the operations (inc, dec) are made by the proper interface operations
only when protected by the spinlock pages_lock. It does not look suspicious, IMHO.
I'm failing to see how it could become a negative on that case, since you cannot
isolate more pages than what was previoulsy inflated to balloon's list.


> It's already the case everywhere except __wait_on_isolated_pages,
> so just fix that, and then we can keep using int instead of atomics.
> 
Sorry, I quite didn't get you here. fix what?

 
> That's 1K on stack - and can become more if we increase
> VIRTIO_BALLOON_ARRAY_PFNS_MAX.  Probably too much - this is the reason
> we use vb->pfns.
>
If we want to use vb->pfns we'll have to make leak_balloon mutual exclusive with
page migration (as it was before), but that will inevictably bring us back to
the discussion on breaking the loop when isolated pages make leak_balloon find
less pages than it wants to release at each leak round.
