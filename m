From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [PATCH v2] virtio_blk: unlock vblk->lock during kick
Date: Wed, 30 May 2012 14:19:23 +0100
Message-ID: <1338383963-17910-1-git-send-email-stefanha__25626.7841709361$1338384628$gmane$org@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, khoa@us.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Holding the vblk->lock across kick causes poor scalability in SMP
guests.  If one CPU is doing virtqueue kick and another CPU touches the
vblk->lock it will have to spin until virtqueue kick completes.

This patch reduces system% CPU utilization in SMP guests that are
running multithreaded I/O-bound workloads.  The improvements are small
but show as iops and SMP are increased.

Khoa Huynh <khoa@us.ibm.com> provided initial performance data that
indicates this optimization is worthwhile at high iops.

Asias He <asias@redhat.com> reports the following fio results:

Host: Linux 3.4.0+ #302 SMP x86_64 GNU/Linux
Guest: same as host kernel

Average 3 runs:
with locked kick
-------------------------
read    iops=119907.50 bw=59954.00 runt=35018.50 io=2048.00
write   iops=217187.00 bw=108594.00 runt=19312.00 io=2048.00
read    iops=33948.00 bw=16974.50 runt=186820.50 io=3095.70
write   iops=35014.00 bw=17507.50 runt=181151.00 io=3095.70
clat (usec)     max=3484.10 avg=121085.38 stdev=174416.11 min=0.00
clat (usec)     max=3438.30 avg=59863.35 stdev=116607.69 min=0.00
clat (usec)     max=3745.65 avg=454501.30 stdev=332699.00 min=0.00
clat (usec)     max=4089.75 avg=442374.99 stdev=304874.62 min=0.00
cpu     sys=615.12 majf=24080.50 ctx=64253616.50 usr=68.08 minf=17907363.00
cpu     sys=1235.95 majf=23389.00 ctx=59788148.00 usr=98.34 minf=20020008.50
cpu     sys=764.96 majf=28414.00 ctx=848279274.00 usr=36.39 minf=19737254.00
cpu     sys=714.13 majf=21853.50 ctx=854608972.00 usr=33.56 minf=18256760.50

with unlocked kick
-------------------------
read    iops=118559.00 bw=59279.66 runt=35400.66 io=2048.00
write   iops=227560.00 bw=113780.33 runt=18440.00 io=2048.00
read    iops=34567.66 bw=17284.00 runt=183497.33 io=3095.70
write   iops=34589.33 bw=17295.00 runt=183355.00 io=3095.70
clat (usec)     max=3485.56 avg=121989.58 stdev=197355.15 min=0.00
clat (usec)     max=3222.33 avg=57784.11 stdev=141002.89 min=0.00
clat (usec)     max=4060.93 avg=447098.65 stdev=315734.33 min=0.00
clat (usec)     max=3656.30 avg=447281.70 stdev=314051.33 min=0.00
cpu     sys=683.78 majf=24501.33 ctx=64435364.66 usr=68.91 minf=17907893.33
cpu     sys=1218.24 majf=25000.33 ctx=60451475.00 usr=101.04 minf=19757720.00
cpu     sys=740.39 majf=24809.00 ctx=845290443.66 usr=37.25 minf=19349958.33
cpu     sys=723.63 majf=27597.33 ctx=850199927.33 usr=35.35 minf=19092343.00

FIO config file
-------------------------------------

[global]
exec_prerun="echo 3 > /proc/sys/vm/drop_caches"
group_reporting
norandommap
ioscheduler=noop
thread
bs=512
size=4MB
direct=1
filename=/dev/vdb
numjobs=256
ioengine=aio
iodepth=64
loops=3

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 693187d..1a50f41 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -201,8 +201,14 @@ static void do_virtblk_request(struct request_queue *q)
 		issued++;
 	}
 
-	if (issued)
-		virtqueue_kick(vblk->vq);
+	if (!issued)
+		return;
+
+	if (virtqueue_kick_prepare(vblk->vq)) {
+		spin_unlock(&vblk->lock);
+		virtqueue_notify(vblk->vq);
+		spin_lock(&vblk->lock);
+	}
 }
 
 /* return id (s/n) string for *disk to *id_str
-- 
1.7.10
