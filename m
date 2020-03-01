From: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PATCH v3 0/3] virtio-net: introduce features defined in the spec
Date: Sun,  1 Mar 2020 16:32:59 +0200
Message-ID: <20200301143302.8556-1-yuri.benditovich@daynix.com>
Return-path: <virtio-dev-return-6822-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yan@daynix.com, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.

Changes from v2: reformatted structure in patch 1

Yuri Benditovich (3):
  virtio-net: Introduce extended RSC feature
  virtio-net: Introduce RSS receive steering feature
  virtio-net: Introduce hash report feature

 include/uapi/linux/virtio_net.h | 100 ++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 4 deletions(-)

-- 
2.17.1
