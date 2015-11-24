From: Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH -qemu] nvme: support Google vendor extension
Date: Mon, 23 Nov 2015 22:29:08 -0800
Message-ID: <1448346548.5392.4.camel@hasee>
References: <1447825624-17011-1-git-send-email-mlin@kernel.org>
	<1447825624-17011-3-git-send-email-mlin@kernel.org>
	<564DA682.8050706@redhat.com> <1448007096.3473.10.camel@hasee>
	<564EE0A0.1020800@redhat.com> <1448060745.6565.1.camel@ssi>
	<565069F0.5000805@redhat.com> <1448178345.7480.2.camel@hasee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448178345.7480.2.camel@hasee>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2015-11-21 at 23:45 -0800, Ming Lin wrote:
> On Sat, 2015-11-21 at 13:56 +0100, Paolo Bonzini wrote:
> > 
> > On 21/11/2015 00:05, Ming Lin wrote:
> > > [    1.752129] Freeing unused kernel memory: 420K (ffff880001b97000 - ffff880001c00000)
> > > [    1.986573] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x30e5c9bbf83, max_idle_ns: 440795378954 ns
> > > [    1.988187] clocksource: Switched to clocksource tsc
> > > [    3.235423] clocksource: timekeeping watchdog: Marking clocksource 'tsc' as unstable because the skew is too large:
> > > [    3.358713] clocksource:                       'refined-jiffies' wd_now: fffeddf3 wd_last: fffedd76 mask: ffffffff
> > > [    3.410013] clocksource:                       'tsc' cs_now: 3c121d4ec cs_last: 340888eb7 mask: ffffffffffffffff
> > > [    3.450026] clocksource: Switched to clocksource refined-jiffies
> > > [    7.696769] Adding 392188k swap on /dev/vda5.  Priority:-1 extents:1 across:392188k 
> > > [    7.902174] EXT4-fs (vda1): re-mounted. Opts: (null)
> > > [    8.734178] EXT4-fs (vda1): re-mounted. Opts: errors=remount-ro
> > > 
> > > Then it doesn't response input for almost 1 minute.
> > > Without this patch, kernel loads quickly.
> > 
> > Interesting.  I guess there's time to debug it, since QEMU 2.6 is still 
> > a few months away.  In the meanwhile we can apply your patch as is, 
> > apart from disabling the "if (new_head >= cq->size)" and the similar 
> > one for "if (new_ tail >= sq->size".
> > 
> > But, I have a possible culprit.  In your nvme_cq_notifier you are not doing the 
> > equivalent of:
> > 
> > 	start_sqs = nvme_cq_full(cq) ? 1 : 0;
> >         cq->head = new_head;
> >         if (start_sqs) {
> >             NvmeSQueue *sq;
> >             QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
> >                 timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> >             }
> >             timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> >         }
> > 
> > Instead, you are just calling nvme_post_cqes, which is the equivalent of
> > 
> > 	timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> > 
> > Adding a loop to nvme_cq_notifier, and having it call nvme_process_sq, might
> > fix the weird 1-minute delay.
> 
> I found it.
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 31572f2..f27fd35 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -548,6 +548,7 @@ static void nvme_cq_notifier(EventNotifier *e)
>      NvmeCQueue *cq =
>          container_of(e, NvmeCQueue, notifier);
>  
> +    event_notifier_test_and_clear(&cq->notifier);
>      nvme_post_cqes(cq);
>  }
>  
> @@ -567,6 +568,7 @@ static void nvme_sq_notifier(EventNotifier *e)
>      NvmeSQueue *sq =
>          container_of(e, NvmeSQueue, notifier);
>  
> +    event_notifier_test_and_clear(&sq->notifier);
>      nvme_process_sq(sq);
>  }
>  
> Here is new performance number:
> 
> qemu-nvme + google-ext + eventfd: 294MB/s
> virtio-blk: 344MB/s
> virtio-scsi: 296MB/s
> 
> It's almost same as virtio-scsi. Nice.

(strip CC)

Looks like "regular MMIO" runs in vcpu thread, while "eventfd MMIO" runs
in the main loop thread.

Could you help to explain why eventfd MMIO gets better performance?

call stack: regular MMIO
========================
nvme_mmio_write (qemu/hw/block/nvme.c:921)
memory_region_write_accessor (qemu/memory.c:451)
access_with_adjusted_size (qemu/memory.c:506)
memory_region_dispatch_write (qemu/memory.c:1158)
address_space_rw (qemu/exec.c:2547)
kvm_cpu_exec (qemu/kvm-all.c:1849)
qemu_kvm_cpu_thread_fn (qemu/cpus.c:1050)
start_thread (pthread_create.c:312)
clone

call stack: eventfd MMIO
=========================
nvme_sq_notifier (qemu/hw/block/nvme.c:598)
aio_dispatch (qemu/aio-posix.c:329)
aio_ctx_dispatch (qemu/async.c:232)
g_main_context_dispatch
glib_pollfds_poll (qemu/main-loop.c:213)
os_host_main_loop_wait (qemu/main-loop.c:257)
main_loop_wait (qemu/main-loop.c:504)
main_loop (qemu/vl.c:1920)
main (qemu/vl.c:4682)
__libc_start_main
