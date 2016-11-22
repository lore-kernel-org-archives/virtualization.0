From: Gonglei <arei.gonglei@huawei.com>
Subject: [PATCH 0/2] virtio: fix complaint by sparse
Date: Tue, 22 Nov 2016 13:51:48 +0800
Message-ID: <1479793910-120188-1-git-send-email-arei.gonglei@huawei.com>
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
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Gonglei <arei.gonglei@huawei.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

I found some warnings reported by sparse in the virtio code
when I checked virtio-crypto's driver stuff. Let's fix them.

Gonglei (2):
  virtio_pci_modern: fix complaint by sparse
  virtio_ring: fix complaint by sparse

 drivers/virtio/virtio_pci_modern.c | 8 ++++----
 drivers/virtio/virtio_ring.c       | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.3.1
