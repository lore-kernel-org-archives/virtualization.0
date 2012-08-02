From: Asias He <asias@redhat.com>
Subject: [PATCH V5 0/4] Improve virtio-blk performance
Date: Thu,  2 Aug 2012 14:25:52 +0800
Message-ID: <1343888757-25723-1-git-send-email-asias@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org


Hi folks,

This version added REQ_FLUSH and REQ_FUA support as suggested by Christoph and
rebased against latest linus's tree. 

Jens, could you please consider picking up the dependencies 1/4 and 2/4 in your
tree. Thanks!

This patchset implements bio-based IO path for virito-blk to improve
performance.

Fio test shows bio-based IO path gives the following performance improvement:

1) Ramdisk device
     With bio-based IO path, sequential read/write, random read/write
     IOPS boost         : 28%, 24%, 21%, 16%
     Latency improvement: 32%, 17%, 21%, 16%
2) Fusion IO device
     With bio-based IO path, sequential read/write, random read/write
     IOPS boost         : 11%, 11%, 13%, 10%
     Latency improvement: 10%, 10%, 12%, 10%

Asias He (4):
  block: Introduce __blk_segment_map_sg() helper
  block: Add blk_bio_map_sg() helper
  virtio-blk: Add bio-based IO path for virtio-blk
  virtio-blk: Add REQ_FLUSH and REQ_FUA support to bio path

 block/blk-merge.c          | 117 +++++++++++++------
 drivers/block/virtio_blk.c | 279 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h     |   2 +
 3 files changed, 324 insertions(+), 74 deletions(-)

-- 
1.7.11.2
