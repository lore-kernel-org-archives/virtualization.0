From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio
Date: Sun, 7 Mar 2010 12:42:52 +0200
Message-ID: <20100307104252.GA19926@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Shirley Ma <mashirle@us.ibm.com>, Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Linus,
Please pull another virtio fix: this one fixes hotplug and
was supposed to be applied by Rusty already
(http://lkml.org/lkml/2009/11/30/451), but apparently got lost,
somehow.

Thanks!

The following changes since commit 3119815912a220bdac943dfbdfee640414c0c611:
  Michael S. Tsirkin (1):
        virtio: fix out of range array access

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git for-linus

Michael S. Tsirkin (1):
      virtio: set pci bus master enable bit

 drivers/virtio/virtio_pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
