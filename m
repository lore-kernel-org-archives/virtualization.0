From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 0/2] virtio: find_vqs/del_vqs fixes
Date: Sun, 26 Jul 2009 15:47:52 +0300
Message-ID: <20090726124752.GA20740__1304.70571243695$1248612714$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redha
List-Id: virtualization@lists.linuxfoundation.org

Here's a patch series to fix known regressions in virtio_pci,
by refactoring code along the lines suggested by Rusty.

This is on top of patch
	virtio: fix memory leak on device removal
that has been applied by Rusty.

This supercedes patches:
	[PATCHv3] virtio: recover from vector assignment failure
	[PATCHv2] virtio: fix double free_irq on device removal

Michael S. Tsirkin (2):
  virtio: delete vq from list
  virtio: refactor find_vqs

 drivers/virtio/virtio_pci.c |  218 ++++++++++++++++++++++++-------------------
 1 files changed, 124 insertions(+), 94 deletions(-)
