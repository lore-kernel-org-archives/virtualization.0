From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v20 4/7] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Tue, 2 Jan 2018 05:24:19 -0800
Message-ID: <20180102132419.GB8222__30231.1231186197$1514899391$gmane$org@bombadil.infradead.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<1513685879-21823-5-git-send-email-wei.w.wang@intel.com>
	<20171224032121.GA5273@bombadil.infradead.org>
	<201712241345.DIG21823.SLFOOJtQFOMVFH@I-love.SAKURA.ne.jp>
	<5A3F5A4A.1070009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A3F5A4A.1070009@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, quan.xu0@gmail.com, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Dec 24, 2017 at 03:42:02PM +0800, Wei Wang wrote:
> On 12/24/2017 12:45 PM, Tetsuo Handa wrote:
> > Matthew Wilcox wrote:
> > > If you can't preload with anything better than that, I think that
> > > xb_set_bit() should attempt an allocation with GFP_NOWAIT | __GFP_NOWARN,
> > > and then you can skip the preload; it has no value for you.
> > Yes, that's why I suggest directly using kzalloc() at xb_set_bit().
> 
> It has some possibilities to remove that preload if we also do the bitmap
> allocation in the xb_set_bit():
> 
> bitmap = rcu_dereference_raw(*slot);
> if (!bitmap) {
>     bitmap = this_cpu_xchg(ida_bitmap, NULL);
>     if (!bitmap) {
>         bitmap = kmalloc(sizeof(*bitmap), gfp);
>         if (!bitmap)
>             return -ENOMEM;
>     }
> }
> 
> But why not just follow the radix tree implementation style that puts the
> allocation in preload, which would be invoked with a more relaxed gfp in
> other use cases?

Actually, the radix tree does attempt allocation, and falls back to the
preload.  The IDA was the odd one out that doesn't attempt allocation,
and that was where I copied the code from.  For other users, the preload
API is beneficial, so I will leave it in.

> Its usage in virtio_balloon is just a little special that we need to put the
> allocation within the balloon_lock, which doesn't give us the benefit of
> using a relaxed gfp in preload, but it doesn't prevent us from living with
> the current APIs (i.e. the preload + xb_set pattern).
> On the other side, if we do it as above, we have more things that need to
> consider. For example, what if the a use case just want the radix tree
> implementation style, which means it doesn't want allocation within
> xb_set(), then would we be troubled with how to avoid the allocation path in
> that case?
> 
> So, I think it is better to stick with the convention by putting the
> allocation in preload. Breaking the convention should show obvious
> advantages, IMHO.

The radix tree convention is objectively awful, which is why I'm working
to change it.  Specifying the GFP flags at radix tree initialisation time
rather than allocation time leads to all kinds of confusion.  The preload
API is a pretty awful workaround, and it will go away once the XArray
is working correctly.  That said, there's no alternative to it without
making XBitmap depend on XArray, and I don't want to hold you up there.
So there's an xb_preload for the moment.
