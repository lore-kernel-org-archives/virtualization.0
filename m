From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC 0/3] virtio_ring: define flags as shifts consistently
Date: Fri,  7 Dec 2018 16:48:39 +0800
Message-ID: <20181207084842.13133-1-tiwei.bie__23877.0059346736$1544172538$gmane$org@intel.com>
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
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This is a follow up of the discussion in this thread:
https://patchwork.ozlabs.org/patch/1001015/#2042353

Tiwei Bie (3):
  virtio_ring: define flags as shifts consistently
  virtio_ring: add VIRTIO_RING_NO_LEGACY
  virtio_ring: use new vring flags

 drivers/virtio/virtio_ring.c     | 100 ++++++++++++++++++-------------
 include/uapi/linux/virtio_ring.h |  61 +++++++++++++------
 2 files changed, 103 insertions(+), 58 deletions(-)

-- 
2.17.1
