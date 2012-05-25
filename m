From: Asias He <asias@redhat.com>
Subject: [PATCH 0/3] Fix hot-unplug race in virtio-blk
Date: Fri, 25 May 2012 10:34:46 +0800
Message-ID: <1337913289-23486-1-git-send-email-asias@redhat.com>
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
To: virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This patch set fixes the race when hot-unplug stressed disk.

Asias He (3):
  virtio-blk: Call del_gendisk() before disable guest kick
  virtio-blk: Reset device after blk_cleanup_queue()
  virtio-blk: Use block layer provided spinlock

 drivers/block/virtio_blk.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

-- 
1.7.10.2
