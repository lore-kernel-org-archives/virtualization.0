From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH v2 0/2] virtio_console: fix replug of virtio console port
Date: Thu,  8 Aug 2019 17:06:04 +0530
Message-ID: <20190808113606.19504-1-pagupta@redhat.com>
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
To: amit@kernel.org, mst@redhat.com
Cc: pagupta@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch series fixes the issue with unplug/replug of a port in virtio
console device, which fails with an error "Error allocating inbufs\n".

Patch 2 makes virtio packed ring code compatible with virtio split ring.
Tested the packed ring code with the qemu virtio 1.1 device code posted
here [1].

Changes from v1[2]
-----
Make virtio packed ring code compatible with split ring - [Michael]

[1]  https://marc.info/?l=qemu-devel&m=156471883703948&w=2
[2] https://lkml.org/lkml/2019/3/4/517

Pankaj Gupta (2):
  virtio_console: free unused buffers with port delete
  virtio_ring: packed ring: fix virtqueue_detach_unused_buf

 drivers/char/virtio_console.c | 14 +++++++++++---
 drivers/virtio/virtio_ring.c  |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.21.0
