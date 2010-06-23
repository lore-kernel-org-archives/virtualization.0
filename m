From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio fixes
Date: Wed, 23 Jun 2010 22:50:24 +0930
Message-ID: <201006232250.25564.rusty__12965.7158781358$1277299345$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

(There are two net fixes which depend on this which will go via DaveM, so
 please pull soon).

The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:
  Linus Torvalds (1):
        Linux 2.6.35-rc3

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6.git virtio

Michael S. Tsirkin (2):
      virtio: return ENOMEM on out of memory
      virtio-pci: disable msi at startup

 drivers/pci/pci.c            |    1 +
 drivers/virtio/virtio_pci.c  |    3 +++
 drivers/virtio/virtio_ring.c |    2 +-
 3 files changed, 5 insertions(+), 1 deletions(-)

commit 686d363786a53ed28ee875b84ef24e6d5126ef6f
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Thu Jun 10 18:16:11 2010 +0300

    virtio: return ENOMEM on out of memory
    
    add_buf returns ring size on out of memory,
    this is not what devices expect.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Acked-by: Amit Shah <amit.shah@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
    Cc: stable@kernel.org # .34.x

 drivers/virtio/virtio_ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit b03214d559471359e2a85ae256686381d0672f29
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Wed Jun 23 22:49:06 2010 -0600

    virtio-pci: disable msi at startup
    
    virtio-pci resets the device at startup by writing to the status
    register, but this does not clear the pci config space,
    specifically msi enable status which affects register
    layout.
    
    This breaks things like kdump when they try to use e.g. virtio-blk.
    
    Fix by forcing msi off at startup. Since pci.c already has
    a routine to do this, we export and use it instead of duplicating code.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Tested-by: Vivek Goyal <vgoyal@redhat.com>
    Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
    Cc: linux-pci@vger.kernel.org
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
    Cc: stable@kernel.org

 drivers/pci/pci.c           |    1 +
 drivers/virtio/virtio_pci.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)
