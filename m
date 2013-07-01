From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio-next
Date: Mon, 01 Jul 2013 10:25:01 +0930
Message-ID: <87ip0vt7yy.fsf@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Baluta <dbaluta@ixiacom.com>, Anup Patel <anup.patel@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Jonghwan Choi <jhbird.choi@samsung.com>, Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit d5fe85af85367d5892e4308f596de4e2a5fb9017:

  Merge tag 'pm+acpi-3.10-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2013-05-16 15:12:34 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git tags/virtio-next-for-linus

for you to fetch changes up to b3087e48ce20be784fae1dbabc2e42e2ad0f21bc:

  virtio: remove virtqueue_add_buf(). (2013-05-20 12:16:01 +0930)

----------------------------------------------------------------
Was away, but it's all trivial and been sitting in linux-next.  So if you don't
pull, no electrons will be harmed.

Thanks,
Rusty.

----------------------------------------------------------------
Daniel Baluta (1):
      lguest: rename i386_head.S

Jonghwan Choi (1):
      virtio_blk: Add missing 'static' qualifiers

Michael S. Tsirkin (1):
      virtio_pci: better macro exported in uapi

Pranavkumar Sawargaonkar (1):
      virtio: console: Add emergency writeonly register to config space

Rusty Russell (1):
      virtio: remove virtqueue_add_buf().

 arch/x86/lguest/Makefile                   |  2 +-
 arch/x86/lguest/{i386_head.S => head_32.S} |  0
 drivers/block/virtio_blk.c                 |  2 +-
 drivers/virtio/virtio_ring.c               | 37 +++---------------------------
 include/linux/virtio.h                     |  7 ------
 include/uapi/linux/virtio_console.h        |  3 +++
 include/uapi/linux/virtio_pci.h            |  4 +++-
 7 files changed, 11 insertions(+), 44 deletions(-)
 rename arch/x86/lguest/{i386_head.S => head_32.S} (100%)
