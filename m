From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: feature pull
Date: Wed, 11 Apr 2018 22:10:17 +0300
Message-ID: <20180411212644-mutt-send-email-mst__29175.0121898533$1523473705$gmane$org@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit dc32bb678e103afbcfa4d814489af0566307f528:

  vhost: add vsock compat ioctl (2018-03-20 03:17:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6c64fe7f2adcee21d7c4247f1ec021fd18428fc4:

  virtio_balloon: export hugetlb page allocation counts (2018-04-10 21:23:55 +0300)

----------------------------------------------------------------
virtio: feature

This adds reporting hugepage stats to virtio-balloon.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jonathan Helman (1):
      virtio_balloon: export hugetlb page allocation counts

 drivers/virtio/virtio_balloon.c     | 6 ++++++
 include/uapi/linux/virtio_balloon.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)
