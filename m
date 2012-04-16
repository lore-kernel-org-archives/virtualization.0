From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: fixes for 3.4
Date: Mon, 16 Apr 2012 16:49:06 +0300
Message-ID: <20120416134905.GA13301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, asias@redhat.com, david@gibson.dropbear.id.au, mst@redhat.com, renmx@cn.fujitsu.com, wuzhy@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

I know that -rc3 went out meanwhile but git handles that fine.
Please pull for 3.4, thanks!

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git for_linus

for you to fetch changes up to 3ccc9372ed0fab33d20f10be3c1efd5776ff5913:

  virtio_balloon: fix handling of PAGE_SIZE != 4k (2012-04-15 11:51:06 +0300)

----------------------------------------------------------------
virtio: fixes on top of 3.4-rc2

Here are some virtio fixes for 3.4:
a test build fix, a patch by Ren fixing naming for systems with a massive
number of virtio blk devices, and balloon fixes for powerpc
by David Gibson.

There was some discussion about Ren's patch for virtio disc naming: some people
wanted to move the legacy name mangling function to the block core.  But
there's no concensus on that yet, and we can always deduplicate later.
Added comments in the hope that this will stop people from
copying this legacy naming scheme into future drivers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Gibson (1):
      virtio_balloon: Fix endian bug

Michael S. Tsirkin (1):
      virtio_balloon: fix handling of PAGE_SIZE != 4k

Ren Mingxin (1):
      virtio_blk: helper function to format disk names

Zhi Yong Wu (1):
      tools/virtio: fix up vhost/test module build

 drivers/block/virtio_blk.c      |   41 +++++++++++++++++++--------
 drivers/vhost/test.c            |    2 +-
 drivers/virtio/virtio_balloon.c |   58 +++++++++++++++++++++++++++++++--------
 3 files changed, 76 insertions(+), 25 deletions(-)
