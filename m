From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Wed, 25 Nov 2015 12:27:50 +0100
Message-ID: <56559B36.90406@redhat.com>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com> <1448350074.6696.3.camel@hasee>
	<56544122.3010300@redhat.com> <1448393115.2925.2.camel@ssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448393115.2925.2.camel@ssi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>
Cc: qemu-devel@nongnu.org, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 24/11/2015 20:25, Ming Lin wrote:
> On Tue, 2015-11-24 at 11:51 +0100, Paolo Bonzini wrote:
>>
>> On 24/11/2015 08:27, Ming Lin wrote:
>>> handle_notify (qemu/hw/block/dataplane/virtio-blk.c:126)
>>> aio_dispatch (qemu/aio-posix.c:329)
>>> aio_poll (qemu/aio-posix.c:474)
>>> iothread_run (qemu/iothread.c:45)
>>> start_thread (pthread_create.c:312)
>>> /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)
>>>
>>> I think I'll have a "nvme_dev_notify" similar as "handle_notify"
>>>
>>> static void nvme_dev_notify(EventNotifier *e)
>>> {
>>>     ....
>>> }
>>>
>>> But then how can I know this notify is for cq or sq?
>>
>> virtio-blk has a single queue, so it has a single EventNotifier.  Your
>> code using multiple EventNotifiers is fine, you can use
>> aio_set_event_notifier multiple times on the same iothread.
> 
> I feel below patch is close to right.
> But I got "Co-routine re-entered recursively".
> 
> Program received signal SIGABRT, Aborted.
> 0x00007ffff4a45cc9 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> 56	../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff4a45cc9 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007ffff4a490d8 in __GI_abort () at abort.c:89
> #2  0x0000555555b910d1 in qemu_coroutine_enter (co=0x5555577a9ce0, opaque=0x0) at /home/mlin/qemu/util/qemu-coroutine.c:111
> #3  0x0000555555b282e0 in bdrv_co_io_em_complete (opaque=0x7fffd94e4a30, ret=0) at /home/mlin/qemu/block/io.c:2282
> #4  0x0000555555ab8ba4 in thread_pool_completion_bh (opaque=0x555557d6d440) at /home/mlin/qemu/thread-pool.c:187
> #5  0x0000555555ab7ab2 in aio_bh_call (bh=0x555557648110) at /home/mlin/qemu/async.c:64
> #6  0x0000555555ab7b88 in aio_bh_poll (ctx=0x5555565b28f0) at /home/mlin/qemu/async.c:92
> #7  0x0000555555acb3b6 in aio_dispatch (ctx=0x5555565b28f0) at /home/mlin/qemu/aio-posix.c:305
> #8  0x0000555555ab8013 in aio_ctx_dispatch (source=0x5555565b28f0, callback=0x0, user_data=0x0) at /home/mlin/qemu/async.c:231
> #9  0x00007ffff575ee04 in g_main_context_dispatch () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #10 0x0000555555ac8b35 in glib_pollfds_poll () at /home/mlin/qemu/main-loop.c:211
> #11 0x0000555555ac8c36 in os_host_main_loop_wait (timeout=0) at /home/mlin/qemu/main-loop.c:256
> #12 0x0000555555ac8cff in main_loop_wait (nonblocking=0) at /home/mlin/qemu/main-loop.c:504
> #13 0x00005555558a41d4 in main_loop () at /home/mlin/qemu/vl.c:1920
> #14 0x00005555558ac28a in main (argc=21, argv=0x7fffffffe4a8, envp=0x7fffffffe558) at /home/mlin/qemu/vl.c:4681
> (gdb)
> 
> Would you help to take a look?
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f27fd35..f542740 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -28,6 +28,8 @@
>  #include "sysemu/sysemu.h"
>  #include "qapi/visitor.h"
>  #include "sysemu/block-backend.h"
> +#include "sysemu/iothread.h"
> +#include "qom/object_interfaces.h"
>  
>  #include "nvme.h"
>  
> @@ -549,7 +551,10 @@ static void nvme_cq_notifier(EventNotifier *e)
>          container_of(e, NvmeCQueue, notifier);
>  
>      event_notifier_test_and_clear(&cq->notifier);
> +
> +    aio_context_acquire(cq->ctrl->ctx);
>      nvme_post_cqes(cq);
> +    aio_context_release(cq->ctrl->ctx);

This is not yet needed in upstream.

>  }
>  
>  static void nvme_init_cq_eventfd(NvmeCQueue *cq)
> @@ -558,9 +563,12 @@ static void nvme_init_cq_eventfd(NvmeCQueue *cq)
>      uint16_t offset = (cq->cqid*2+1) * (4 << NVME_CAP_DSTRD(n->bar.cap));
>  
>      event_notifier_init(&cq->notifier, 0);
> -    event_notifier_set_handler(&cq->notifier, nvme_cq_notifier);
>      memory_region_add_eventfd(&n->iomem,
>          0x1000 + offset, 4, false, 0, &cq->notifier);
> +    aio_context_acquire(n->ctx);
> +    aio_set_event_notifier(n->ctx, &cq->notifier, false,

This should be true, but shouldn't affect your bug.

> +                           nvme_cq_notifier);
> +    aio_context_release(n->ctx);
>  }
>  
>  static void nvme_sq_notifier(EventNotifier *e)
> @@ -569,7 +577,9 @@ static void nvme_sq_notifier(EventNotifier *e)
>          container_of(e, NvmeSQueue, notifier);
>  
>      event_notifier_test_and_clear(&sq->notifier);
> +    aio_context_acquire(sq->ctrl->ctx);
>      nvme_process_sq(sq);
> +    aio_context_release(sq->ctrl->ctx);

Same as above.

>  }
>  
>  static void nvme_init_sq_eventfd(NvmeSQueue *sq)
> @@ -578,9 +588,22 @@ static void nvme_init_sq_eventfd(NvmeSQueue *sq)
>      uint16_t offset = sq->sqid * 2 * (4 << NVME_CAP_DSTRD(n->bar.cap));
>  
>      event_notifier_init(&sq->notifier, 0);
> -    event_notifier_set_handler(&sq->notifier, nvme_sq_notifier);
>      memory_region_add_eventfd(&n->iomem,
>          0x1000 + offset, 4, false, 0, &sq->notifier);
> +    aio_context_acquire(n->ctx);
> +    aio_set_event_notifier(n->ctx, &sq->notifier, false,

Also true.

> +                           nvme_sq_notifier);
> +    aio_context_release(n->ctx);
> +}
> +
> +static void nvme_init_iothread(NvmeCtrl *n)
> +{
> +    object_initialize(&n->internal_iothread_obj,
> +                      sizeof(n->internal_iothread_obj),
> +                      TYPE_IOTHREAD);
> +    user_creatable_complete(OBJECT(&n->internal_iothread_obj), &error_abort);
> +    n->iothread = &n->internal_iothread_obj;
> +    n->ctx = iothread_get_aio_context(n->iothread);

Do you still have a blk_set_aio_context somewhere?  I'm losing track of
the changes.

In any case, I think using a separate I/O thread is a bit premature,
except for benchmarking.  In the meanwhile I think the best option is to
post a two-patch series with the vendor extension and the ioeventfd
respectively.

Paolo

>  }
>  
>  static uint16_t nvme_set_db_memory(NvmeCtrl *n, const NvmeCmd *cmd)
> @@ -595,6 +618,8 @@ static uint16_t nvme_set_db_memory(NvmeCtrl *n, const NvmeCmd *cmd)
>          return NVME_INVALID_MEMORY_ADDRESS | NVME_DNR;
>      }
>  
> +    nvme_init_iothread(n);
> +
>      /* This assumes all I/O queues are created before this command is handled.
>       * We skip the admin queues. */
>      for (i = 1; i < n->num_queues; i++) {
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 608f202..b53e69d 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -727,6 +727,10 @@ typedef struct NvmeCtrl {
>      NvmeSQueue      admin_sq;
>      NvmeCQueue      admin_cq;
>      NvmeIdCtrl      id_ctrl;
> +
> +    IOThread *iothread;
> +    IOThread internal_iothread_obj;
> +    AioContext *ctx;
>  } NvmeCtrl;
>  
>  #endif /* HW_NVME_H */
> 
> 
