From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Wed, 11 Oct 2017 09:51:46 +0800
Message-ID: <59DD7932.3070106__39613.1215537482$1507686624$gmane$org@intel.com>
References: <1506744354-20979-4-git-send-email-wei.w.wang@intel.com>	<20171009181612-mutt-send-email-mst@kernel.org>	<59DC76BA.7070202@intel.com>	<201710102008.FIG57851.QFJLMtVOFOHFOS@I-love.SAKURA.ne.jp>	<59DCBDE9.4050404@intel.com>
	<201710102209.DBE39528.MtFLOJQSFOFVOH@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201710102209.DBE39528.MtFLOJQSFOFVOH@I-love.SAKURA.ne.jp>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 10/10/2017 09:09 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>>> And even if we could remove balloon_lock, you still cannot use
>>> __GFP_DIRECT_RECLAIM at xb_set_page(). I think you will need to use
>>> "whether it is safe to wait" flag from
>>> "[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()" .
>> Without the lock being held, why couldn't we use __GFP_DIRECT_RECLAIM at
>> xb_set_page()?
> Because of dependency shown below.
>
> leak_balloon()
>    xb_set_page()
>      xb_preload(GFP_KERNEL)
>        kmalloc(GFP_KERNEL)
>          __alloc_pages_may_oom()
>            Takes oom_lock
>            out_of_memory()
>              blocking_notifier_call_chain()
>                leak_balloon()
>                  xb_set_page()
>                    xb_preload(GFP_KERNEL)
>                      kmalloc(GFP_KERNEL)
>                        __alloc_pages_may_oom()
>                          Fails to take oom_lock and loop forever

__alloc_pages_may_oom() uses mutex_trylock(&oom_lock).

I think the second __alloc_pages_may_oom() will not continue since the
first one is in progress.

>
> By the way, is xb_set_page() safe?
> Sleeping in the kernel with preemption disabled is a bug, isn't it?
> __radix_tree_preload() returns 0 with preemption disabled upon success.
> xb_preload() disables preemption if __radix_tree_preload() fails.
> Then, kmalloc() is called with preemption disabled, isn't it?
> But xb_set_page() calls xb_preload(GFP_KERNEL) which might sleep with
> preemption disabled.

Yes, I think that should not be expected, thanks.

I plan to change it like this:

bool xb_preload(gfp_t gfp)
{
         if (!this_cpu_read(ida_bitmap)) {
                 struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);

                 if (!bitmap)
                         return false;
                 bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
                 kfree(bitmap);
         }

         if (__radix_tree_preload(gfp, XB_PRELOAD_SIZE) < 0)
                 return false;

         return true;
}


Best,
Wei
