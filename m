From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: [PATCH 0/4] virtio: Add definitions for shared memory regions
Date: Thu, 25 Jul 2019 18:50:40 +0100
Message-ID: <20190725175044.29303-1-dgilbert@redhat.com>
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
To: virtualization@lists.linux-foundation.org, mst@redhat.com, jasowang@redhat.com
Cc: sebastien.boeuf@intel.com, vgoyal@redhat.com, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the virtio shared memory region definitions that
have just got merged into the spec.

Dr. David Alan Gilbert (4):
  virtio_pci: Define id field
  virtio_pci: Define virtio_pci_cap64
  virtio_pci: Defined shared memory capability
  virito_mmio: Define shared memory region registers

 include/uapi/linux/virtio_mmio.h | 11 +++++++++++
 include/uapi/linux/virtio_pci.h  | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.21.0
