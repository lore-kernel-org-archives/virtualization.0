From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv8 0/3] vhost: a kernel-level virtio server
Date: Wed, 4 Nov 2009 17:52:34 +0200
Message-ID: <20091104155234.GA32673__12722.0808215954$1257350197$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-mm@kvack.org, akpm@linux-founda
List-Id: virtualization@lists.linuxfoundation.org

Ok, I think I've addressed all comments so far here.
Rusty, I'd like this to go into linux-next, through your tree, and
hopefully 2.6.33.  What do you think?

---

This implements vhost: a kernel-level backend for virtio,
The main motivation for this work is to reduce virtualization
overhead for virtio by removing system calls on data path,
without guest changes. For virtio-net, this removes up to
4 system calls per packet: vm exit for kick, reentry for kick,
iothread wakeup for packet, interrupt injection for packet.

This driver is pretty minimal, but it's fully functional (including
migration support interfaces), and already shows performance (especially
latency) improvement over userspace.

Some more detailed description attached to the patch itself.

The patches apply to both 2.6.32-rc6 and kvm.git.  I'd like them to go
into linux-next if possible.  Please comment.

Changelog from v7:
- Add note on RCU usage, mirroring this in vhost/vhost.h
- Fix locking typo noted by Eric Dumazet
- Fix warnings on 32 bit

Changelog from v6:
- review comments by Daniel Walker addressed
- checkpatch cleanup
- fix build on 32 bit
- maintainers entry corrected

Changelog from v5:
- tun support
- backends with virtio net header support (enables GSO, checksum etc)
- 32 bit compat fixed
- support indirect buffers, tx exit mitigation,
  tx interrupt mitigation
- support write logging (allows migration without virtio ring code in userspace)

Changelog from v4:
- disable rx notification when have rx buffers
- addressed all comments from Rusty's review
- copy bugfixes from lguest commits:
	ebf9a5a99c1a464afe0b4dfa64416fc8b273bc5c
	e606490c440900e50ccf73a54f6fc6150ff40815

Changelog from v3:
- checkpatch fixes

Changelog from v2:
- Comments on RCU usage
- Compat ioctl support
- Make variable static
- Copied more idiomatic english from Rusty

Changes from v1:
- Move use_mm/unuse_mm from fs/aio.c to mm instead of copying.
- Reorder code to avoid need for forward declarations
- Kill a couple of debugging printks

Michael S. Tsirkin (3):
  tun: export underlying socket
  mm: export use_mm/unuse_mm to modules
  vhost_net: a kernel-level virtio server

 MAINTAINERS                |    9 +
 arch/x86/kvm/Kconfig       |    1 +
 drivers/Makefile           |    1 +
 drivers/net/tun.c          |  101 ++++-
 drivers/vhost/Kconfig      |   11 +
 drivers/vhost/Makefile     |    2 +
 drivers/vhost/net.c        |  633 +++++++++++++++++++++++++++++
 drivers/vhost/vhost.c      |  970 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h      |  158 +++++++
 include/linux/Kbuild       |    1 +
 include/linux/if_tun.h     |   14 +
 include/linux/miscdevice.h |    1 +
 include/linux/vhost.h      |  126 ++++++
 mm/mmu_context.c           |    3 +
 14 files changed, 2012 insertions(+), 19 deletions(-)
 create mode 100644 drivers/vhost/Kconfig
 create mode 100644 drivers/vhost/Makefile
 create mode 100644 drivers/vhost/net.c
 create mode 100644 drivers/vhost/vhost.c
 create mode 100644 drivers/vhost/vhost.h
 create mode 100644 include/linux/vhost.h
