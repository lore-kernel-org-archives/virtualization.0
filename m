From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Date: Thu, 13 Feb 2020 13:37:26 +0100
Message-ID: <20200213123728.61216-1-pasic@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Two patches are handling new edge cases introduced by doing DMA mappings
(which can fail) in virtio core.

I stumbled upon this while stress testing I/O for Protected Virtual
Machines. I deliberately chose a tiny swiotlb size and have generated
load with fio. With more than one virtio-blk disk in use I experienced
hangs.

The goal of this series is to fix those hangs.

Halil Pasic (2):
  virtio-blk: fix hw_queue stopped on arbitrary error
  virtio-blk: improve virtqueue error to BLK_STS

 drivers/block/virtio_blk.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)


base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
-- 
2.17.1
