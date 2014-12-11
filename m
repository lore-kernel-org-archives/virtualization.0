From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] minor virtio 1.0 fixups
Date: Thu, 11 Dec 2014 19:01:27 +0200
Message-ID: <1418317279-13915-1-git-send-email-mst__3063.19049927897$1418318978$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20141211170242.GA13991@redhat.com>
Resent-To: virtualization@lists.linux-foundation.org
Content-Disposition: inline
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
Cc: virtualization@lists.linux-foundation.or
List-Id: virtualization@lists.linuxfoundation.org

Here are some fixup patches on top of my latest pull request.
Will include in the next pull request.

Michael S. Tsirkin (3):
  virtio: set VIRTIO_CONFIG_S_FEATURES_OK on restore
  virtio_config: fix virtio_cread_bytes
  virtio_pci_common.h: drop VIRTIO_PCI_NO_LEGACY

 drivers/virtio/virtio_pci_common.h |  1 -
 include/linux/virtio_config.h      |  5 ++++-
 drivers/virtio/virtio.c            | 37 +++++++++++++++++++++++--------------
 3 files changed, 27 insertions(+), 16 deletions(-)

-- 
MST
