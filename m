From: Asias He <asias@redhat.com>
Subject: [PATCH RESEND 0/5] Add vhost-blk support
Date: Fri, 13 Jul 2012 16:55:06 +0800
Message-ID: <1342169711-12386-1-git-send-email-asias__1678.75193660638$1342169655$gmane$org@redhat.com>
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
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@HansenPartnership.com>, Jeff Moyer <jmoyer@redhat.com>, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


Hi folks,

[I am resending to fix the broken thread in the previous one.]

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
 include/linux/vhost.h  |    3 +
 11 files changed, 731 insertions(+), 31 deletions(-)
 create mode 100644 drivers/vhost/blk.c

-- 
1.7.10.4
