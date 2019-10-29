From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 0/2] virtio: allow per vq DMA domain
Date: Tue, 29 Oct 2019 18:58:41 +0800
Message-ID: <20191029105843.12061-1-jasowang__10972.2879760497$1572346766$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: lingshan.zhu@intel.com, lulu@redhat.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

We used to have use a single parent for all DMA operations. This tends
to complicate the mdev based hardware virtio datapath offloading which
may not implement the control path over datapath like ctrl vq in the
case of virtio-net.

So this series tries to intorduce per DMA domain by allowing trasnport
to specify the parent device for each virtqueue. Then for the case of
virtio-mdev device, it can hook the DMA ops for control vq back to
itself and then using e.g VA or PA to emulate the control virtqueue
operation.

Vhost-mdev may use similar idea. Note, compiling test only.

Jason Wang (2):
  virtio: accept parent as a parameter when allocating virtqueue
  virtio: allow query vq parent device

 drivers/virtio/virtio_ring.c  | 36 +++++++++++++++++++++++++----------
 include/linux/virtio_config.h |  2 ++
 2 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.19.1
