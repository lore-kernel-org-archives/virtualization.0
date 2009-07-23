From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 0/2] virtio: device removal fixes
Date: Thu, 23 Jul 2009 14:57:16 +0300
Message-ID: <20090723115716.GA12293__34159.1705837802$1248350368$gmane$org@redhat.com>
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

Here are a couple of fixes for virtio device removal.
Since these fix regressions (for devices with msi-x capability), I think
we need them for 2.6.31.

Changes since v1:
  - rewrote the patches according to Rusty's comments

Michael S. Tsirkin (2):
  virtio: fix double free_irq on device removal
  virtio: fix memory leak on device removal

 drivers/virtio/virtio_pci.c |   66 ++++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 28 deletions(-)
