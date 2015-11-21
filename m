From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH -qemu] nvme: support Google vendor extension
Date: Sat, 21 Nov 2015 13:56:16 +0100
Message-ID: <565069F0.5000805@redhat.com>
References: <1447825624-17011-1-git-send-email-mlin@kernel.org>
	<1447825624-17011-3-git-send-email-mlin@kernel.org>
	<564DA682.8050706@redhat.com> <1448007096.3473.10.camel@hasee>
	<564EE0A0.1020800@redhat.com> <1448060745.6565.1.camel@ssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448060745.6565.1.camel@ssi>
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
Cc: fes@google.com, axboe@fb.com, tytso@mit.edu, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, keith.busch@intel.com, Rob Nelson <rlnelson@google.com>, Christoph Hellwig <hch@lst.de>, Mihai Rusu <dizzy@google.com>
List-Id: virtualization@lists.linuxfoundation.org



On 21/11/2015 00:05, Ming Lin wrote:
> [    1.752129] Freeing unused kernel memory: 420K (ffff880001b97000 - ffff880001c00000)
> [    1.986573] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x30e5c9bbf83, max_idle_ns: 440795378954 ns
> [    1.988187] clocksource: Switched to clocksource tsc
> [    3.235423] clocksource: timekeeping watchdog: Marking clocksource 'tsc' as unstable because the skew is too large:
> [    3.358713] clocksource:                       'refined-jiffies' wd_now: fffeddf3 wd_last: fffedd76 mask: ffffffff
> [    3.410013] clocksource:                       'tsc' cs_now: 3c121d4ec cs_last: 340888eb7 mask: ffffffffffffffff
> [    3.450026] clocksource: Switched to clocksource refined-jiffies
> [    7.696769] Adding 392188k swap on /dev/vda5.  Priority:-1 extents:1 across:392188k 
> [    7.902174] EXT4-fs (vda1): re-mounted. Opts: (null)
> [    8.734178] EXT4-fs (vda1): re-mounted. Opts: errors=remount-ro
> 
> Then it doesn't response input for almost 1 minute.
> Without this patch, kernel loads quickly.

Interesting.  I guess there's time to debug it, since QEMU 2.6 is still 
a few months away.  In the meanwhile we can apply your patch as is, 
apart from disabling the "if (new_head >= cq->size)" and the similar 
one for "if (new_ tail >= sq->size".

But, I have a possible culprit.  In your nvme_cq_notifier you are not doing the 
equivalent of:

	start_sqs = nvme_cq_full(cq) ? 1 : 0;
        cq->head = new_head;
        if (start_sqs) {
            NvmeSQueue *sq;
            QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
                timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
            }
            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
        }

Instead, you are just calling nvme_post_cqes, which is the equivalent of

	timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);

Adding a loop to nvme_cq_notifier, and having it call nvme_process_sq, might
fix the weird 1-minute delay.

Paolo

> void memory_region_add_eventfd(MemoryRegion *mr,
>                                hwaddr addr,
>                                unsigned size,
>                                bool match_data,
>                                uint64_t data,
>                                EventNotifier *e)
> 
> Could you help to explain what "match_data" and "data" mean?

If match_data is true, the eventfd is only signalled if "data" is being written to memory.

Paolo
