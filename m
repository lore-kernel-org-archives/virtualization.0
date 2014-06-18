From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH 2/2] block: virtio-blk: support multi virt queues per
	virtio-blk device
Date: Wed, 18 Jun 2014 12:04:48 +0800
Message-ID: <CACVXFVMkV5R5GUjM7Y-U54SA-ENZZ26dbbv4K2_OYPdmmiuUqg__47905.6982476779$1403064303$gmane$org@mail.gmail.com>
References: <1402680562-8328-1-git-send-email-ming.lei@canonical.com>
	<1402680562-8328-3-git-send-email-ming.lei@canonical.com>
	<CAJSP0QWaS--gPZ=ONFrXby1DQLw4R0RCro7bpHCdmucyjmqT_w@mail.gmail.com>
	<CACVXFVO0SybUKArQbKkj2+hbk6q_gt3SBooNNmw1jErRR8d07A@mail.gmail.com>
	<53A06475.7000308@redhat.com>
	<CACVXFVO6GDu7Cp=s7kn_XBE2EFnuh+XQs4UQKTFaCLi4_9jcgg@mail.gmail.com>
	<53A06E05.9060708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A06E05.9060708@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, linux-api@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 18, 2014 at 12:34 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 17/06/2014 18:00, Ming Lei ha scritto:
>
>>> > If you want to do queue steering based on the guest VCPU number, the
>>> > number
>>> > of queues must be = to the number of VCPUs shouldn't it?
>>> >
>>> > I tried using a divisor of the number of VCPUs, but couldn't get the
>>> > block
>>> > layer to deliver interrupts to the right VCPU.
>>
>> For blk-mq's hardware queue, that won't be necessary to equal to
>> VCPUs number, and irq affinity per hw queue can be simply set as
>> blk_mq_hw_ctx->cpumask.
>
>
> Yes, but on top of that you want to have each request processed exactly by
> the CPU that sent it.  Unless the cpumasks are singletons, most of the
> benefit went away in my virtio-scsi tests.  Perhaps blk-mq is smarter.
>
> Can you try benchmarking a 16 VCPU guest with 8 and 16 queues?

From VM side, it might be better to use one hardware queue per vCPU,
since in theory it can remove vq lock contention.

But from host side, there is still disadvantage with more queues, since
more queues means more notify times, in my virtio-blk test, even with
ioeventfd, one notification may take ~3us averagely on qemu-system-x86_64.

For virtio-blk, I don't think it is always better to take more queues, and
we need to leverage below things in host side:

- host storage top performance, generally it reaches that with more
than 1 jobs with libaio(suppose it is N, so basically we can use N
iothread per device in qemu to try to get top performance)

- iothreads' loading(if iothreads are at full loading, increasing
queues doesn't help at all)

In my test, I only use the current per-dev iothread(x-dataplane)
in qemu to handle 2 vqs' notification and precess all I/O from
the 2 vqs, and looks it can improve IOPS by ~30%.

For virtio-scsi, the current usage doesn't make full use of blk-mq's
advantage too because only one vq is active at the same time, so I
guess the multi vqs' benefit won't be very much and I'd like to post
patches to support that first, then provide test data with
more queues(8, 16).


Thanks,
--
Ming Lei
