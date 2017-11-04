From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH v17 4/6] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Sat, 4 Nov 2017 20:28:47 +0900
Message-ID: <201711042028.EGB64074.FOLMHtFJVQOOFS__7980.28686917878$1509795020$gmane$org@I-love.SAKURA.ne.jp>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-5-git-send-email-wei.w.wang@intel.com>
	<201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>
	<59FD9FE3.5090409@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <59FD9FE3.5090409@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: aarcange@redhat.com, yang.zhang.wz@gmail.com, liliang.opensource@gmail.com, willy@infradead.org, amit.shah@redhat.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

Wei Wang wrote:
> On 11/03/2017 07:25 PM, Tetsuo Handa wrote:
> >> @@ -184,8 +307,12 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
> >>   
> >>   	num_allocated_pages = vb->num_pfns;
> >>   	/* Did we get any? */
> >> -	if (vb->num_pfns != 0)
> >> -		tell_host(vb, vb->inflate_vq);
> >> +	if (vb->num_pfns) {
> >> +		if (use_sg)
> >> +			tell_host_sgs(vb, vb->inflate_vq, pfn_min, pfn_max);
> > Please describe why tell_host_sgs() can work without __GFP_DIRECT_RECLAIM allocation,
> > for tell_host_sgs() is called with vb->balloon_lock mutex held.
> 
> Essentially, 
> tell_host_sgs()-->send_balloon_page_sg()-->add_one_sg()-->virtqueue_add_inbuf( 
> , , num=1 ,,GFP_KERNEL)
> won't need any memory allocation, because we always add one sg (i.e. 
> num=1) each time. That memory
> allocation option is only used when multiple sgs are added (i.e. num > 
> 1) and the implementation inside virtqueue_add_inbuf
> need allocation of indirect descriptor table.
> 
> We could also add some comments above the function to explain a little 
> about this if necessary.

Yes, please do so.

Or maybe replace GFP_KERNEL with GFP_NOWAIT or 0. Though Michael might remove that GFP
argument ( http://lkml.kernel.org/r/201710022344.JII17368.HQtLOMJOOSFFVF@I-love.SAKURA.ne.jp ).

> > If this is inside vb->balloon_lock mutex (isn't this?), xb_set_page() must not
> > use __GFP_DIRECT_RECLAIM allocation, for leak_balloon_sg_oom() will be blocked
> > on vb->balloon_lock mutex.
> 
> OK. Since the preload() doesn't need too much memory (< 4K in total), 
> how about GFP_NOWAIT here?

Maybe GFP_NOWAIT | __GFP_NOWARN ?
