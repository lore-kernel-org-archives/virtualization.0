From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: cleanups and fixes
Date: Fri, 13 Dec 2019 09:35:19 -0500
Message-ID: <20191213093519-mutt-send-email-mst__44914.0404279873$1576247746$gmane$org@kernel.org>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: yuhuang@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, imammedo@redhat.com, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 63b9b80e9f5b2c463d98d6e550e0d0e3ace66033:

  virtio_balloon: divide/multiply instead of shifts (2019-12-11 08:14:07 -0500)

----------------------------------------------------------------
virtio: fixes, cleanups

Some fixes and cleanup patches.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      virtio-balloon: fix managed page counts when migrating pages between zones

Michael S. Tsirkin (2):
      virtio_balloon: name cleanups
      virtio_balloon: divide/multiply instead of shifts

 drivers/virtio/virtio_balloon.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)
