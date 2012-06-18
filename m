From: Asias He <asias@redhat.com>
Subject: [PATCH v2 0/3] Improve virtio-blk performance
Date: Mon, 18 Jun 2012 14:53:07 +0800
Message-ID: <1340002390-3950-1-git-send-email-asias@redhat.com>
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
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patchset implements bio-based IO path for virito-blk to improve
performance.

Fio test shows it gives, 28%, 24%, 21%, 16% IOPS boost and 32%, 17%, 21%, 16%
latency improvement for sequential read/write, random read/write respectively.

Asias He (3):
  block: Introduce __blk_segment_map_sg() helper
  block: Add blk_bio_map_sg() helper
  virtio-blk: Add bio-based IO path for virtio-blk

 block/blk-merge.c          |  117 +++++++++++++++++--------
 drivers/block/virtio_blk.c |  203 +++++++++++++++++++++++++++++++++++---------
 include/linux/blkdev.h     |    2 +
 3 files changed, 247 insertions(+), 75 deletions(-)

-- 
1.7.10.2
