From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH v4 0/2] virtio_console: fix replug of virtio console port
Date: Tue, 13 Aug 2019 19:35:27 +0530
Message-ID: <20190813140529.12939-1-pagupta@redhat.com>
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
To: mst@redhat.com, amit@kernel.org
Cc: pagupta@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch series fixes the issue with unplug/replug of a port in virtio
console driver which fails with an error "Error allocating inbufs\n".

Patch 1 updates the next avail index for packed ring code.
Patch 2 makes use of 'virtqueue_detach_unused_buf' function to detach
the unused buffers during port hotunplug time.

Tested the packed ring code with the qemu virtio 1.1 device code posted
here [1]. Also, sent a patch to document the behavior in virtio spec as
suggested by Michael.

Changes from v3
- Swap patch 1 with patch 2  - [Michael]
- Added acked-by tag by Jason in patch 1
- Add reference to spec change
Changes from v2
- Better change log in patch2 - [Greg]
Changes from v1[2]
- Make virtio packed ring code compatible with split ring - [Michael]

[1]  https://marc.info/?l=qemu-devel&m=156471883703948&w=2
[2]  https://lkml.org/lkml/2019/3/4/517
[3]  https://lists.oasis-open.org/archives/virtio-dev/201908/msg00055.html

Pankaj Gupta (2):
  virtio: decrement avail idx with buffer detach for packed ring
  virtio_console: free unused buffers with port delete

 char/virtio_console.c |   14 +++++++++++---
 virtio/virtio_ring.c  |    6 ++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
-- 
2.21.0
