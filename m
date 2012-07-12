From: Asias He <asias@redhat.com>
Subject: [PATCH 0/5] Add vhost-blk support
Date: Thu, 12 Jul 2012 23:35:01 +0800
Message-ID: <1342107302-28116-1-git-send-email-asias@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi folks,

This patchset adds vhost-blk support. vhost-blk is a in kernel virito-blk
device accelerator. Compared to userspace virtio-blk implementation, vhost-blk
gives about 5% to 15% performance improvement.

Asias He (5):
  aio: Export symbols and struct kiocb_batch for in kernel aio usage
  eventfd: Export symbol eventfd_file_create()
  vhost: Make vhost a separate module
  vhost-net: Use VHOST_NET_FEATURES for vhost-net
  vhost-blk: Add vhost-blk support

 drivers/vhost/Kconfig  |   20 +-
 drivers/vhost/Makefile |    6 +-
 drivers/vhost/blk.c    |  600 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/net.c    |    4 +-
 drivers/vhost/test.c   |    4 +-
 drivers/vhost/vhost.c  |   48 ++++
 drivers/vhost/vhost.h  |   18 +-
 fs/aio.c               |   37 ++-
 fs/eventfd.c           |    1 +
 include/linux/aio.h    |   21 ++
 include/linux/vhost.h  |    1 +
 11 files changed, 729 insertions(+), 31 deletions(-)
 create mode 100644 drivers/vhost/blk.c

-- 
1.7.10.4
