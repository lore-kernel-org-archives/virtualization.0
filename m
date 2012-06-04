From: Khoa Huynh <khoa@us.ibm.com>
Subject: Re: [PATCH v3] virtio_blk: unlock vblk->lock during kick
Date: Mon, 4 Jun 2012 16:13:42 -0500
Message-ID: <OF67F6BF18.995B2F8B-ON85257A13.006E8179-86257A13.0074A4B5@us.ibm.com>
References: <1338541986-8083-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4653742830381648247=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1338541986-8083-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4653742830381648247==
Content-type: multipart/alternative;
	Boundary="0__=0ABBF080DFFD07E98f9e8a93df938690918c0ABBF080DFFD07E9"
Content-Disposition: inline

--0__=0ABBF080DFFD07E98f9e8a93df938690918c0ABBF080DFFD07E9
Content-type: text/plain; charset=US-ASCII

Stefan Hajnoczi <stefanha@linux.vnet.ibm.com> wrote on 06/01/2012 04:13:06
AM:
>
> Holding the vblk->lock across kick causes poor scalability in SMP
> guests.  If one CPU is doing virtqueue kick and another CPU touches the
> vblk->lock it will have to spin until virtqueue kick completes.
>
> This patch reduces system% CPU utilization in SMP guests that are
> running multithreaded I/O-bound workloads.  The improvements are small
> but show as iops and SMP are increased.
>
> Khoa Huynh <khoa@us.ibm.com> provided initial performance data that
> indicates this optimization is worthwhile at high iops.

Hi Stefan, I was out on vacation last week, so I could not post the details
of my performance testing with this unlocked-kick patch.

Anyway, here are more details:

Test environment:
- Host: IBM x3850 X5 server (40 cores, 256GB) running RHEL6.2
- Guest:  20 vcpus, 16GB, running Linux 3.4 kernel (w/ and w/o this patch)
- Storage:  12 block devices (from 3 SCSI target servers)
- Workload:  FIO benchmark with 8KB random reads and writes (50% split)

With RHEL6.2 qemu-kvm:
- Locked kick = 44,529 IOPS
- Unlocked kick = 44,869 IOPS ==> 0.7% gain

With Stefan's "data-plane" qemu-kvm (experimental qemu to get around
qemu mutex):
- Locked kick = 497,943 IOPS
- Unlocked kick = 532,446 IOPS ==> 6.9% gain

I also tested on a smaller host and smaller guest (4 vcpus, 4GB, 4 virtual
block devices) and applied some performance tuning (e.g. smaller data sets
so most data fit into host's cache, 1KB reads) to deliver the highest I/O
rates possible to the guest with the existing RHEL6.2 qemu-kvm:
- Locked kick = 140,533 IOPS
- Unlocked kick = 143,415 IOPS ==> 2.1% gain

As you can see, the higher the I/O rate, the more performance benefit
we would get from Stefan's unlocked-kick patch.  In my performance testing,
the highest I/O rate that I could achieve with the existing KVM/QEMU was
~140,000+ IOPS, so the most performance gain that we could get from this
unlocked-kick patch in this case was about 2-3%.  However, going forward,
as we relieve the qemu mutex more and more, we should be able to get much
higher I/O rates (500,000 IOPS or higher), and so I believe that the
performance benefit of this unlocked-kick patch would be more apparent.

If you need further information, please let me know.

Thanks,
-Khoa

>
> Asias He <asias@redhat.com> reports the following fio results:
>
> Host: Linux 3.4.0+ #302 SMP x86_64 GNU/Linux
> Guest: same as host kernel
>
> Average 3 runs:
> with locked kick
> read    iops=119907.50 bw=59954.00 runt=35018.50 io=2048.00
> write   iops=217187.00 bw=108594.00 runt=19312.00 io=2048.00
> read    iops=33948.00 bw=16974.50 runt=186820.50 io=3095.70
> write   iops=35014.00 bw=17507.50 runt=181151.00 io=3095.70
> clat (usec)     max=3484.10 avg=121085.38 stdev=174416.11 min=0.00
> clat (usec)     max=3438.30 avg=59863.35 stdev=116607.69 min=0.00
> clat (usec)     max=3745.65 avg=454501.30 stdev=332699.00 min=0.00
> clat (usec)     max=4089.75 avg=442374.99 stdev=304874.62 min=0.00
> cpu     sys=615.12 majf=24080.50 ctx=64253616.50 usr=68.08
minf=17907363.00
> cpu     sys=1235.95 majf=23389.00 ctx=59788148.00 usr=98.34
minf=20020008.50
> cpu     sys=764.96 majf=28414.00 ctx=848279274.00 usr=36.39
minf=19737254.00
> cpu     sys=714.13 majf=21853.50 ctx=854608972.00 usr=33.56
minf=18256760.50
>
> with unlocked kick
> read    iops=118559.00 bw=59279.66 runt=35400.66 io=2048.00
> write   iops=227560.00 bw=113780.33 runt=18440.00 io=2048.00
> read    iops=34567.66 bw=17284.00 runt=183497.33 io=3095.70
> write   iops=34589.33 bw=17295.00 runt=183355.00 io=3095.70
> clat (usec)     max=3485.56 avg=121989.58 stdev=197355.15 min=0.00
> clat (usec)     max=3222.33 avg=57784.11 stdev=141002.89 min=0.00
> clat (usec)     max=4060.93 avg=447098.65 stdev=315734.33 min=0.00
> clat (usec)     max=3656.30 avg=447281.70 stdev=314051.33 min=0.00
> cpu     sys=683.78 majf=24501.33 ctx=64435364.66 usr=68.91
minf=17907893.33
> cpu     sys=1218.24 majf=25000.33 ctx=60451475.00 usr=101.04
minf=19757720.00
> cpu     sys=740.39 majf=24809.00 ctx=845290443.66 usr=37.25
minf=19349958.33
> cpu     sys=723.63 majf=27597.33 ctx=850199927.33 usr=35.35
minf=19092343.00
>
> FIO config file:
>
> [global]
> exec_prerun="echo 3 > /proc/sys/vm/drop_caches"
> group_reporting
> norandommap
> ioscheduler=noop
> thread
> bs=512
> size=4MB
> direct=1
> filename=/dev/vdb
> numjobs=256
> ioengine=aio
> iodepth=64
> loops=3
>
> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> ---
> Other block drivers (cciss, rbd, nbd) use spin_unlock_irq() so I
> followed that.
> To me this seems wrong: blk_run_queue() uses spin_lock_irqsave() butwe
enable
> irqs with spin_unlock_irq().  If the caller of blk_run_queue() had irqs
> disabled and we enable them again this could be a problem, right?  Can
someone
> more familiar with kernel locking comment?
>
>  drivers/block/virtio_blk.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 774c31d..d674977 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -199,8 +199,14 @@ static void do_virtblk_request(struct request_queue
*q)
>        issued++;
>     }
>
> -   if (issued)
> -      virtqueue_kick(vblk->vq);
> +   if (!issued)
> +      return;
> +
> +   if (virtqueue_kick_prepare(vblk->vq)) {
> +      spin_unlock_irq(vblk->disk->queue->queue_lock);
> +      virtqueue_notify(vblk->vq);
> +      spin_lock_irq(vblk->disk->queue->queue_lock);
> +   }
>  }
>
>  /* return id (s/n) string for *disk to *id_str
> --
> 1.7.10
>
--0__=0ABBF080DFFD07E98f9e8a93df938690918c0ABBF080DFFD07E9
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">Stefan Hajnoczi &lt;stefanha@linux.vnet.ibm.com&gt; wrote on 06/01/2012 04:13:06 AM:<br>
&gt; <br>
&gt; Holding the vblk-&gt;lock across kick causes poor scalability in SMP<br>
&gt; guests. &nbsp;If one CPU is doing virtqueue kick and another CPU touches the<br>
&gt; vblk-&gt;lock it will have to spin until virtqueue kick completes.<br>
&gt; <br>
&gt; This patch reduces system% CPU utilization in SMP guests that are<br>
&gt; running multithreaded I/O-bound workloads. &nbsp;The improvements are small<br>
&gt; but show as iops and SMP are increased.<br>
&gt; <br>
&gt; Khoa Huynh &lt;khoa@us.ibm.com&gt; provided initial performance data that<br>
&gt; indicates this optimization is worthwhile at high iops.</font></tt><br>
<br>
<tt><font size="2">Hi Stefan, I was out on vacation last week, so I could not post the details</font></tt><br>
<tt><font size="2">of my performance testing with this unlocked-kick patch.</font></tt><br>
<br>
<tt><font size="2">Anyway, here are more details:</font></tt><br>
<br>
<tt><font size="2">Test environment:</font></tt><br>
<tt><font size="2">- Host: IBM x3850 X5 server (40 cores, 256GB) running RHEL6.2</font></tt><br>
<tt><font size="2">- Guest: &nbsp;20 vcpus, 16GB, running Linux 3.4 kernel (w/ and w/o this patch)</font></tt><br>
<tt><font size="2">- Storage: &nbsp;12 block devices (from 3 SCSI target servers)</font></tt><br>
<tt><font size="2">- Workload: &nbsp;FIO benchmark with 8KB random reads and writes (50% split)</font></tt><br>
<br>
<tt><font size="2">With RHEL6.2 qemu-kvm:</font></tt><br>
<tt><font size="2">- Locked kick = 44,529 IOPS</font></tt><br>
<tt><font size="2">- Unlocked kick = 44,869 IOPS ==&gt; 0.7% gain</font></tt><br>
<br>
<tt><font size="2">With Stefan's &quot;data-plane&quot; qemu-kvm (experimental qemu to get around </font></tt><br>
<tt><font size="2">qemu mutex):</font></tt><br>
<tt><font size="2">- Locked kick = 497,943 IOPS</font></tt><br>
<tt><font size="2">- Unlocked kick = 532,446 IOPS ==&gt; 6.9% gain</font></tt><br>
<br>
<tt><font size="2">I also tested on a smaller host and smaller guest (4 vcpus, 4GB, 4 virtual</font></tt><br>
<tt><font size="2">block devices) and applied some performance tuning (e.g. smaller data sets </font></tt><br>
<tt><font size="2">so most data fit into host's cache, 1KB reads) to deliver the highest I/O </font></tt><br>
<tt><font size="2">rates possible to the guest with the existing RHEL6.2 qemu-kvm:</font></tt><br>
<tt><font size="2">- Locked kick = 140,533 IOPS</font></tt><br>
<tt><font size="2">- Unlocked kick = 143,415 IOPS ==&gt; 2.1% gain</font></tt><br>
<br>
<tt><font size="2">As you can see, the higher the I/O rate, the more performance benefit</font></tt><br>
<tt><font size="2">we would get from Stefan's unlocked-kick patch. &nbsp;In my performance testing,</font></tt><br>
<tt><font size="2">the highest I/O rate that I could achieve with the existing KVM/QEMU was</font></tt><br>
<tt><font size="2">~140,000+ IOPS, so the most performance gain that we could get from this</font></tt><br>
<tt><font size="2">unlocked-kick patch in this case was about 2-3%. &nbsp;However, going forward, </font></tt><br>
<tt><font size="2">as we relieve the qemu mutex more and more, we should be able to get much</font></tt><br>
<tt><font size="2">higher I/O rates (500,000 IOPS or higher), and so I believe that the </font></tt><br>
<tt><font size="2">performance benefit of this unlocked-kick patch would be more apparent.</font></tt><br>
<br>
<tt><font size="2">If you need further information, please let me know.</font></tt><br>
<br>
<tt><font size="2">Thanks,</font></tt><br>
<tt><font size="2">-Khoa</font></tt><br>
<tt><font size="2"><br>
&gt; <br>
&gt; Asias He &lt;asias@redhat.com&gt; reports the following fio results:<br>
&gt; <br>
&gt; Host: Linux 3.4.0+ #302 SMP x86_64 GNU/Linux<br>
&gt; Guest: same as host kernel<br>
&gt; <br>
&gt; Average 3 runs:<br>
&gt; with locked kick<br>
&gt; read &nbsp; &nbsp;iops=119907.50 bw=59954.00 runt=35018.50 io=2048.00<br>
&gt; write &nbsp; iops=217187.00 bw=108594.00 runt=19312.00 io=2048.00<br>
&gt; read &nbsp; &nbsp;iops=33948.00 bw=16974.50 runt=186820.50 io=3095.70<br>
&gt; write &nbsp; iops=35014.00 bw=17507.50 runt=181151.00 io=3095.70<br>
&gt; clat (usec) &nbsp; &nbsp; max=3484.10 avg=121085.38 stdev=174416.11 min=0.00<br>
&gt; clat (usec) &nbsp; &nbsp; max=3438.30 avg=59863.35 stdev=116607.69 min=0.00<br>
&gt; clat (usec) &nbsp; &nbsp; max=3745.65 avg=454501.30 stdev=332699.00 min=0.00<br>
&gt; clat (usec) &nbsp; &nbsp; max=4089.75 avg=442374.99 stdev=304874.62 min=0.00<br>
&gt; cpu &nbsp; &nbsp; sys=615.12 majf=24080.50 ctx=64253616.50 usr=68.08 minf=17907363.00<br>
&gt; cpu &nbsp; &nbsp; sys=1235.95 majf=23389.00 ctx=59788148.00 usr=98.34 minf=20020008.50<br>
&gt; cpu &nbsp; &nbsp; sys=764.96 majf=28414.00 ctx=848279274.00 usr=36.39 minf=19737254.00<br>
&gt; cpu &nbsp; &nbsp; sys=714.13 majf=21853.50 ctx=854608972.00 usr=33.56 minf=18256760.50<br>
&gt; <br>
&gt; with unlocked kick<br>
&gt; read &nbsp; &nbsp;iops=118559.00 bw=59279.66 runt=35400.66 io=2048.00<br>
&gt; write &nbsp; iops=227560.00 bw=113780.33 runt=18440.00 io=2048.00<br>
&gt; read &nbsp; &nbsp;iops=34567.66 bw=17284.00 runt=183497.33 io=3095.70<br>
&gt; write &nbsp; iops=34589.33 bw=17295.00 runt=183355.00 io=3095.70<br>
&gt; clat (usec) &nbsp; &nbsp; max=3485.56 avg=121989.58 stdev=197355.15 min=0.00<br>
&gt; clat (usec) &nbsp; &nbsp; max=3222.33 avg=57784.11 stdev=141002.89 min=0.00<br>
&gt; clat (usec) &nbsp; &nbsp; max=4060.93 avg=447098.65 stdev=315734.33 min=0.00<br>
&gt; clat (usec) &nbsp; &nbsp; max=3656.30 avg=447281.70 stdev=314051.33 min=0.00<br>
&gt; cpu &nbsp; &nbsp; sys=683.78 majf=24501.33 ctx=64435364.66 usr=68.91 minf=17907893.33<br>
&gt; cpu &nbsp; &nbsp; sys=1218.24 majf=25000.33 ctx=60451475.00 usr=101.04 minf=19757720.00<br>
&gt; cpu &nbsp; &nbsp; sys=740.39 majf=24809.00 ctx=845290443.66 usr=37.25 minf=19349958.33<br>
&gt; cpu &nbsp; &nbsp; sys=723.63 majf=27597.33 ctx=850199927.33 usr=35.35 minf=19092343.00<br>
&gt; <br>
&gt; FIO config file:<br>
&gt; <br>
&gt; [global]<br>
&gt; exec_prerun=&quot;echo 3 &gt; /proc/sys/vm/drop_caches&quot;<br>
&gt; group_reporting<br>
&gt; norandommap<br>
&gt; ioscheduler=noop<br>
&gt; thread<br>
&gt; bs=512<br>
&gt; size=4MB<br>
&gt; direct=1<br>
&gt; filename=/dev/vdb<br>
&gt; numjobs=256<br>
&gt; ioengine=aio<br>
&gt; iodepth=64<br>
&gt; loops=3<br>
&gt; <br>
&gt; Signed-off-by: Stefan Hajnoczi &lt;stefanha@linux.vnet.ibm.com&gt;<br>
&gt; ---<br>
&gt; Other block drivers (cciss, rbd, nbd) use spin_unlock_irq() so I <br>
&gt; followed that.<br>
&gt; To me this seems wrong: blk_run_queue() uses spin_lock_irqsave() butwe enable<br>
&gt; irqs with spin_unlock_irq(). &nbsp;If the caller of blk_run_queue() had irqs<br>
&gt; disabled and we enable them again this could be a problem, right? &nbsp;Can someone<br>
&gt; more familiar with kernel locking comment?<br>
&gt; <br>
&gt; &nbsp;drivers/block/virtio_blk.c | &nbsp; 10 ++++++++--<br>
&gt; &nbsp;1 file changed, 8 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c<br>
&gt; index 774c31d..d674977 100644<br>
&gt; --- a/drivers/block/virtio_blk.c<br>
&gt; +++ b/drivers/block/virtio_blk.c<br>
&gt; @@ -199,8 +199,14 @@ static void do_virtblk_request(struct request_queue *q)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;issued++;<br>
&gt; &nbsp; &nbsp; }<br>
&gt; &nbsp;<br>
&gt; - &nbsp; if (issued)<br>
&gt; - &nbsp; &nbsp; &nbsp;virtqueue_kick(vblk-&gt;vq);<br>
&gt; + &nbsp; if (!issued)<br>
&gt; + &nbsp; &nbsp; &nbsp;return;<br>
&gt; +<br>
&gt; + &nbsp; if (virtqueue_kick_prepare(vblk-&gt;vq)) {<br>
&gt; + &nbsp; &nbsp; &nbsp;spin_unlock_irq(vblk-&gt;disk-&gt;queue-&gt;queue_lock);<br>
&gt; + &nbsp; &nbsp; &nbsp;virtqueue_notify(vblk-&gt;vq);<br>
&gt; + &nbsp; &nbsp; &nbsp;spin_lock_irq(vblk-&gt;disk-&gt;queue-&gt;queue_lock);<br>
&gt; + &nbsp; }<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;/* return id (s/n) string for *disk to *id_str<br>
&gt; -- <br>
&gt; 1.7.10<br>
&gt; <br>
</font></tt></body></html>
--0__=0ABBF080DFFD07E98f9e8a93df938690918c0ABBF080DFFD07E9--


--===============4653742830381648247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4653742830381648247==--
