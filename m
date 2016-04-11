From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/1] virtio_ccw: new status accessor in driver
Date: Mon, 11 Apr 2016 13:23:36 +0200
Message-ID: <1460373817-43522-1-git-send-email-cornelia.huck__25119.1910276704$1460373865$gmane$org@de.ibm.com>
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
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

This patch implements the new status accessor in the ccw device,
as laid out in "[PATCH v2 1/1] ccw: add CCW_CMD_READ_STATUS".

Changes from the RFC (back in September):
- rebased

Pierre Morel (1):
  virtio/s390: support READ_STATUS command for virtio-ccw

 drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.6.6
