From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: last minute bugfixes
Date: Sat, 23 Nov 2019 11:55:52 -0500
Message-ID: <20191123115552-mutt-send-email-mst@kernel.org>
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
Cc: lvivier@redhat.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, khazhy@google.com, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, mimu@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c9a6820fc0da2603be3054ee7590eb9f350508a7:

  virtio_balloon: fix shrinker count (2019-11-20 02:15:57 -0500)

----------------------------------------------------------------
virtio: last minute bugfixes

Minor bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Halil Pasic (1):
      virtio_ring: fix return code on DMA mapping fails

Laurent Vivier (1):
      virtio_console: allocate inbufs in add_port() only if it is needed

Michael S. Tsirkin (1):
      virtio_balloon: fix shrinker scan number of pages

Wei Wang (1):
      virtio_balloon: fix shrinker count

 drivers/char/virtio_console.c   | 28 +++++++++++++---------------
 drivers/virtio/virtio_balloon.c | 20 +++++++++++++-------
 drivers/virtio/virtio_ring.c    |  4 ++--
 3 files changed, 28 insertions(+), 24 deletions(-)
