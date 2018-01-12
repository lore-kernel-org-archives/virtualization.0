From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v21 2/5 RESEND] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Fri, 12 Jan 2018 17:14:09 +0800
Message-ID: <5A587C61.2010204__39945.6265419305$1515748222$gmane$org@intel.com>
References: <1515501687-7874-1-git-send-email-wei.w.wang@intel.com>	<201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>	<5A55EA71.6020309@intel.com>
	<201801112006.EHD48461.LOtVFFSOJMOFHQ@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201801112006.EHD48461.LOtVFFSOJMOFHQ@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mst@redhat.com
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, nilal@redhat.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 01/11/2018 07:06 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> Michael, could we merge patch 3-5 first?
> No! I'm repeatedly asking you to propose only VIRTIO_BALLOON_F_SG changes.
> Please don't ignore me.
>
>
>
> Patch 4 depends on patch 2. Thus, back to patch 2.

There is not strict dependence per se. I plan to split the two features 
into 2 series, and post out 3-5 first, and the corresponding hypervisor 
code.
After that's done, I'll get back to the discussion of patch 2.




> Now, proceeding to patch 4.
>
> Your patch is trying to call add_one_sg() for multiple times based on
>
> ----------------------------------------
> +	/*
> +	 * This is expected to never fail: there is always at least 1 entry
> +	 * available on the vq, because when the vq is full the worker thread
> +	 * that adds the sg will be put into sleep until at least 1 entry is
> +	 * available to use.
> +	 */

This will be more clear in the new version which is not together with 
patch 2.


>
> Now, I suspect we need to add VIRTIO_BALLOON_F_FREE_PAGE_VQ flag. I want to see
> the patch for the hypervisor side which makes use of VIRTIO_BALLOON_F_FREE_PAGE_VQ
> flag because its usage becomes tricky. Between the guest kernel obtains snapshot of
> free memory blocks and the hypervisor is told that some pages are currently free,
> these pages can become in use. That is, I don't think
>
>    The second feature enables the optimization of the 1st round memory
>    transfer - the hypervisor can skip the transfer of guest free pages in the
>    1st round.
>
> is accurate. The hypervisor is allowed to mark pages which are told as "currently
> unused" by the guest kernel as "write-protected" before starting the 1st round.
> Then, the hypervisor performs copying all pages except write-protected pages as
> the 1st round. Then, the 2nd and later rounds will be the same. That is,
> VIRTIO_BALLOON_F_FREE_PAGE_VQ requires the hypervisor to do 0th round as
> preparation. Thus, I want to see the patch for the hypervisor side.
>
> Now, what if all free pages in the guest kernel were reserved as ballooned pages?
> There will be no free pages which VIRTIO_BALLOON_F_FREE_PAGE_VQ flag would help.
> The hypervisor will have to copy all pages because all pages are either currently
> in-use or currently in balloons. After ballooning to appropriate size, there will
> be little free memory in the guest kernel, and the hypervisor already knows which
> pages are in the balloon. Thus, the hypervisor can skip copying the content of
> pages in the balloon, without using VIRTIO_BALLOON_F_FREE_PAGE_VQ flag.
>
> Then, why can't we do "inflate the balloon up to reasonable level (e.g. no need to
> wait for reclaim and no need to deflate)" instead of "find all the free pages as of
> specific moment" ? That is, code for VIRTIO_BALLOON_F_DEFLATE_ON_OOM could be reused
> instead of VIRTIO_BALLOON_F_FREE_PAGE_VQ ?
>

I think you misunderstood the work, which seems not easy to explain 
everything from the beginning here. I wish to review patch 4 (I'll send 
out a new independent version) with Michael if possible.
I'll discuss with you about patch 2 later. Thanks.

Best,
Wei
