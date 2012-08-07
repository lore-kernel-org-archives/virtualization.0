From: Asias He <asias@redhat.com>
Subject: [PATCH V6 0/2] Improve virtio-blk performance
Date: Tue,  7 Aug 2012 16:47:13 +0800
Message-ID: <1344329235-17449-1-git-send-email-asias@redhat.com>
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

Hi, all

This version reworked on REQ_FLUSH and REQ_FUA support as suggested by
Christoph and dropped the block core bits since Jens has picked them up.

Fio test shows bio-based IO path gives the following performance improvement:

1) Ramdisk device
     With bio-based IO path, sequential read/write, random read/write
     IOPS boost         : 28%, 24%, 21%, 16%
     Latency improvement: 32%, 17%, 21%, 16%
2) Fusion IO device
     With bio-based IO path, sequential read/write, random read/write
     IOPS boost         : 11%, 11%, 13%, 10%
     Latency improvement: 10%, 10%, 12%, 10%

Asias He (2):
  virtio-blk: Add bio-based IO path for virtio-blk
  virtio-blk: Add REQ_FLUSH and REQ_FUA support to bio path

 drivers/block/virtio_blk.c | 306 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 268 insertions(+), 38 deletions(-)

-- 
1.7.11.2
