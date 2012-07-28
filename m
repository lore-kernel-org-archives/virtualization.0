From: Asias He <asias@redhat.com>
Subject: [PATCH V4 0/3] Improve virtio-blk performance
Date: Sat, 28 Jul 2012 10:21:02 +0800
Message-ID: <1343442065-15646-1-git-send-email-asias@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi, Jens & Rusty

This version is rebased against linux-next which resolves the conflict with
Paolo Bonzini's 'virtio-blk: allow toggling host cache between writeback and
writethrough' patch.

Patch 1/3 and 2/3 applies on linus's master as well. Since Rusty will pick up
patch 3/3 so the changes to block core (adding blk_bio_map_sg()) will have a
user.

Jens, could you please consider picking up the dependencies 1/3 and 2/3 in your
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

Asias He (3):
  block: Introduce __blk_segment_map_sg() helper
  block: Add blk_bio_map_sg() helper
  virtio-blk: Add bio-based IO path for virtio-blk

 block/blk-merge.c          |  117 +++++++++++++++++--------
 drivers/block/virtio_blk.c |  203 +++++++++++++++++++++++++++++++++++---------
 include/linux/blkdev.h     |    2 +
 3 files changed, 247 insertions(+), 75 deletions(-)

-- 
1.7.10.4
