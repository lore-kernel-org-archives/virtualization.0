From: Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH -qemu] nvme: support Google vendor extension
Date: Fri, 20 Nov 2015 15:05:45 -0800
Message-ID: <1448060745.6565.1.camel@ssi>
References: <1447825624-17011-1-git-send-email-mlin@kernel.org>
	<1447825624-17011-3-git-send-email-mlin@kernel.org>
	<564DA682.8050706@redhat.com> <1448007096.3473.10.camel@hasee>
	<564EE0A0.1020800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <564EE0A0.1020800@redhat.com>
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
Cc: fes@google.com, keith.busch@intel.com, tytso@mit.edu, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, axboe@fb.com, Rob Nelson <rlnelson@google.com>, Christoph Hellwig <hch@lst.de>, Mihai Rusu <dizzy@google.com>
List-Id: virtualization@lists.linuxfoundation.org


On Fri, 2015-11-20 at 09:58 +0100, Paolo Bonzini wrote:
> 
> On 20/11/2015 09:11, Ming Lin wrote:
> > On Thu, 2015-11-19 at 11:37 +0100, Paolo Bonzini wrote:
> >>
> >> On 18/11/2015 06:47, Ming Lin wrote:
> >>> @@ -726,7 +798,11 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
> >>>          }
> >>>  
> >>>          start_sqs = nvme_cq_full(cq) ? 1 : 0;
> >>> -        cq->head = new_head;
> >>> +        /* When the mapped pointer memory area is setup, we don't rely on
> >>> +         * the MMIO written values to update the head pointer. */
> >>> +        if (!cq->db_addr) {
> >>> +            cq->head = new_head;
> >>> +        }
> >>
> >> You are still checking
> >>
> >>         if (new_head >= cq->size) {
> >>             return;
> >>         }
> >>
> >> above.  I think this is incorrect when the extension is present, and
> >> furthermore it's the only case where val is being used.
> >>
> >> If you're not using val, you could use ioeventfd for the MMIO.  An
> >> ioeventfd cuts the MMIO cost by at least 55% and up to 70%. Here are
> >> quick and dirty measurements from kvm-unit-tests's vmexit.flat
> >> benchmark, on two very different machines:
> >>
> >> 			Haswell-EP		Ivy Bridge i7
> >>   MMIO memory write	5100 -> 2250 (55%)	7000 -> 3000 (58%)
> >>   I/O port write	3800 -> 1150 (70%)	4100 -> 1800 (57%)
> >>
> >> You would need to allocate two eventfds for each qid, one for the sq and
> >> one for the cq.  Also, processing the queues is now bounced to the QEMU
> >> iothread, so you can probably get rid of sq->timer and cq->timer.
> > 
> > Here is a quick try.
> > Too late now, I'll test it morning.
> > 
> > Do you see obvious problem?
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 3e1c38d..d28690d 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -543,6 +543,44 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >      return NVME_SUCCESS;
> >  }
> >  
> > +static void nvme_cq_notifier(EventNotifier *e)
> > +{
> > +    NvmeCQueue *cq =
> > +        container_of(e, NvmeCQueue, notifier);
> > +
> > +    nvme_post_cqes(cq);
> > +}
> > +
> > +static void nvme_init_cq_eventfd(NvmeCQueue *cq)
> > +{
> > +    NvmeCtrl *n = cq->ctrl;
> > +    uint16_t offset = (cq->cqid*2+1) * NVME_CAP_DSTRD(n->bar.cap);
> > +
> > +    event_notifier_init(&cq->notifier, 0);
> > +    event_notifier_set_handler(&cq->notifier, nvme_cq_notifier);
> > +    memory_region_add_eventfd(&n->iomem,
> > +        0x1000 + offset, 4, true, cq->cqid*2+1, &cq->notifier);
> 
> should be 0x1000 + offset, 4, false, 0, &cq->notifier
> 
> > +}
> > +
> > +static void nvme_sq_notifier(EventNotifier *e)
> > +{
> > +    NvmeSQueue *sq =
> > +        container_of(e, NvmeSQueue, notifier);
> > +
> > +    nvme_process_sq(sq);
> > +}
> > +
> > +static void nvme_init_sq_eventfd(NvmeSQueue *sq)
> > +{
> > +    NvmeCtrl *n = sq->ctrl;
> > +    uint16_t offset = sq->sqid * 2 * NVME_CAP_DSTRD(n->bar.cap);
> > +
> > +    event_notifier_init(&sq->notifier, 0);
> > +    event_notifier_set_handler(&sq->notifier, nvme_sq_notifier);
> > +    memory_region_add_eventfd(&n->iomem,
> > +        0x1000 + offset, 4, true, sq->sqid * 2, &sq->notifier);
> 
> likewise should be 0x1000 + offset, 4, false, 0, &sq->notifier

It works. But for some unknown reason, when boots guest kernel, it stuck
for almost 1 minute.

[    1.752129] Freeing unused kernel memory: 420K (ffff880001b97000 - ffff880001c00000)
[    1.986573] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x30e5c9bbf83, max_idle_ns: 440795378954 ns
[    1.988187] clocksource: Switched to clocksource tsc
[    3.235423] clocksource: timekeeping watchdog: Marking clocksource 'tsc' as unstable because the skew is too large:
[    3.358713] clocksource:                       'refined-jiffies' wd_now: fffeddf3 wd_last: fffedd76 mask: ffffffff
[    3.410013] clocksource:                       'tsc' cs_now: 3c121d4ec cs_last: 340888eb7 mask: ffffffffffffffff
[    3.450026] clocksource: Switched to clocksource refined-jiffies
[    7.696769] Adding 392188k swap on /dev/vda5.  Priority:-1 extents:1 across:392188k 
[    7.902174] EXT4-fs (vda1): re-mounted. Opts: (null)
[    8.734178] EXT4-fs (vda1): re-mounted. Opts: errors=remount-ro

Then it doesn't response input for almost 1 minute.
Without this patch, kernel loads quickly.

[    1.351095] Freeing unused kernel memory: 2968K (ffffffff81d49000 - ffffffff8202f000)
[    1.352039] Write protecting the kernel read-only data: 12288k
[    1.353340] Freeing unused kernel memory: 216K (ffff8800017ca000 - ffff880001800000)
[    1.354670] Freeing unused kernel memory: 420K (ffff880001b97000 - ffff880001c00000)
[    1.796272] Adding 392188k swap on /dev/vda5.  Priority:-1 extents:1 across:392188k 
[    1.809579] EXT4-fs (vda1): re-mounted. Opts: (null)
[    1.864834] EXT4-fs (vda1): re-mounted. Opts: errors=remount-ro
[    1.964181] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x30e58d9c595, max_idle_ns: 440795220169 ns
[    1.965610] clocksource: Switched to clocksource tsc
[    2.377965] random: dd urandom read with 19 bits of entropy available



void memory_region_add_eventfd(MemoryRegion *mr,
                               hwaddr addr,
                               unsigned size,
                               bool match_data,
                               uint64_t data,
                               EventNotifier *e)

Could you help to explain what "match_data" and "data" mean?

I use a real NVMe device as backend.

-drive file=/dev/nvme0n1,format=raw,if=none,id=D22 \
-device nvme,drive=D22,serial=1234

Here is the test results:

local NVMe: 860MB/s
qemu-nvme: 108MB/s
qemu-nvme+google-ext: 140MB/s
qemu-nvme-google-ext+eventfd: 190MB/s

root@wheezy:~# cat test.job 
[global]
bs=4k
ioengine=libaio
iodepth=64
direct=1
runtime=60
time_based
norandommap
group_reporting
gtod_reduce=1
numjobs=8

[job1]
filename=/dev/nvme0n1
rw=read
