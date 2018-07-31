From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: last-minute fixes
Date: Tue, 31 Jul 2018 15:21:58 +0300
Message-ID: <20180731152158-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, huang.chong@zte.com.cn, jiang.biao2@zte.com.cn
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 89da619bc18d79bca5304724c11d4ba3b67ce2c6:

  virtio_balloon: fix another race between migration and ballooning (2018-07-30 16:45:33 +0300)

----------------------------------------------------------------
virtio: last-minute fixes

Some bugfixes that seem important and safe enough to merge at the last
minute.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jiang Biao (1):
      virtio_balloon: fix another race between migration and ballooning

Michael S. Tsirkin (2):
      tools/virtio: add dma barrier stubs
      tools/virtio: add kmalloc_array stub

 drivers/virtio/virtio_balloon.c | 2 ++
 tools/virtio/asm/barrier.h      | 4 ++--
 tools/virtio/linux/kernel.h     | 5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)
