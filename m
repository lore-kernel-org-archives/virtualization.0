From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH -qemu] nvme: support Google vendor extension
Date: Tue, 24 Nov 2015 12:01:47 +0100
Message-ID: <5654439B.5050408@redhat.com>
References: <1447825624-17011-1-git-send-email-mlin@kernel.org>
	<1447825624-17011-3-git-send-email-mlin@kernel.org>
	<564DA682.8050706@redhat.com> <1448007096.3473.10.camel@hasee>
	<564EE0A0.1020800@redhat.com> <1448060745.6565.1.camel@ssi>
	<565069F0.5000805@redhat.com> <1448178345.7480.2.camel@hasee>
	<1448346548.5392.4.camel@hasee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448346548.5392.4.camel@hasee>
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
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 24/11/2015 07:29, Ming Lin wrote:
>> Here is new performance number:
>>
>> qemu-nvme + google-ext + eventfd: 294MB/s
>> virtio-blk: 344MB/s
>> virtio-scsi: 296MB/s
>>
>> It's almost same as virtio-scsi. Nice.

Pretty good indeed.

> Looks like "regular MMIO" runs in vcpu thread, while "eventfd MMIO" runs
> in the main loop thread.
> 
> Could you help to explain why eventfd MMIO gets better performance?

Because VCPU latency is really everything if the I/O is very fast _or_
if the queue depth is high; signaling an eventfd is cheap enough to give
a noticeable boost in VCPU latency. Waking up a sleeping process is a
bit expensive, but if you manage to keep the iothread close to 100% CPU,
the main loop thread's poll() is usually quite cheap too.

> call stack: regular MMIO
> ========================
> nvme_mmio_write (qemu/hw/block/nvme.c:921)
> memory_region_write_accessor (qemu/memory.c:451)
> access_with_adjusted_size (qemu/memory.c:506)
> memory_region_dispatch_write (qemu/memory.c:1158)
> address_space_rw (qemu/exec.c:2547)
> kvm_cpu_exec (qemu/kvm-all.c:1849)
> qemu_kvm_cpu_thread_fn (qemu/cpus.c:1050)
> start_thread (pthread_create.c:312)
> clone
> 
> call stack: eventfd MMIO
> =========================
> nvme_sq_notifier (qemu/hw/block/nvme.c:598)
> aio_dispatch (qemu/aio-posix.c:329)
> aio_ctx_dispatch (qemu/async.c:232)
> g_main_context_dispatch
> glib_pollfds_poll (qemu/main-loop.c:213)
> os_host_main_loop_wait (qemu/main-loop.c:257)
> main_loop_wait (qemu/main-loop.c:504)
> main_loop (qemu/vl.c:1920)
> main (qemu/vl.c:4682)
> __libc_start_main

For comparison, here is the "iothread+eventfd MMIO" stack

nvme_sq_notifier (qemu/hw/block/nvme.c:598)
aio_dispatch (qemu/aio-posix.c:329)
aio_poll (qemu/aio-posix.c:474)
iothread_run (qemu/iothread.c:170)
__libc_start_main

aio_poll is much more specialized than the main thread (which uses glib
and thus wraps aio_poll with a GSource adapter), and can be faster too.
 (That said, things are still a bit in flux here.  2.6 will have pretty
heavy changes in this area, but the API will be the same).

Even more performance can be squeezed by adding a little bit of busy
waiting to aio_poll() before going to the blocking poll(). This avoids
very short idling and can improve things even more.

BTW, you may want to Cc qemu-block@nongnu.org in addition to
qemu-devel@nongnu.org.  Most people are on both lists, but some notice
things faster if you write to the lower-traffic qemu-block mailing list.

Paolo
