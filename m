From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio
Date: Sun, 28 Feb 2010 20:43:42 +0200
Message-ID: <20100228184341.GA32395__9460.66445108063$1267382888$gmane$org@redhat.com>
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
Rusty asked me to resolve any issues with virtio and lguest that
surface, so here comes.

Thanks!

The following changes since commit 847f9c606cad121cebf984639e3eeee1c4db82f8:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../geert/linux-m68k

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git for-linus

Michael S. Tsirkin (1):
      virtio: fix out of range array access

 drivers/virtio/virtio_pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
MST
