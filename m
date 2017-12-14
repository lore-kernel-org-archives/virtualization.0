From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Thu, 14 Dec 2017 10:12:19 -0800
Message-ID: <20171214181219.GA26124__14685.2654325359$1513275172$gmane$org@bombadil.infradead.org>
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
	<5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 15, 2017 at 01:29:45AM +0900, Tetsuo Handa wrote:
> > > Also, one more thing you need to check. Have you checked how long does
> > > xb_find_next_set_bit(xb, 0, ULONG_MAX) on an empty xbitmap takes?
> > > If it causes soft lockup warning, should we add cond_resched() ?
> > > If yes, you have to document that this API might sleep. If no, you
> > > have to document that the caller of this API is responsible for
> > > not to pass such a large value range.
> > 
> > Yes, that will take too long time. Probably we can document some 
> > comments as a reminder for the callers.
> 
> Then, I feel that API is poorly implemented. There is no need to brute-force
> when scanning [0, ULONG_MAX] range. If you eliminate exception path and
> redesign the data structure, xbitmap will become as simple as a sample
> implementation shown below. Not tested yet, but I think that this will be
> sufficient for what virtio-baloon wants to do; i.e. find consecutive "1" bits
> quickly. I didn't test whether finding "struct ulong_list_data" using radix
> tree can improve performance.

find_next_set_bit() is just badly implemented.  There is no need to
redesign the data structure.  It should be a simple matter of:

 - look at ->head, see it is NULL, return false.

If bit 100 is set and you call find_next_set_bit(101, ULONG_MAX), it
should look at block 0, see there is a pointer to it, scan the block,
see there are no bits set above 100, then realise we're at the end of
the tree and stop.

If bit 2000 is set, and you call find_next_set_bit(2001, ULONG_MAX)
tit should look at block 1, see there's no bit set after bit 2001, then
look at the other blocks in the node, see that all the pointers are NULL
and stop.

This isn't rocket science, we already do something like this in the radix
tree and it'll be even easier to do in the XArray.  Which I'm going back
to working on now.
