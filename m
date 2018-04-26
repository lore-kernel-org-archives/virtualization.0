From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: fixups
Date: Thu, 26 Apr 2018 21:50:39 +0300
Message-ID: <20180426215039-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5c60300d68da32ca77f7f978039dc72bfc78b06b:

  virtio_console: reset on out of memory (2018-04-25 20:41:29 +0300)

----------------------------------------------------------------
virtio: fixups

Latest header update will break QEMU (if it's rebuilt with the new
header) - and it seems that the code there is so fragile that any change
in this header will break it.  Add a better interface so users do not
need to change their code every time that header changes.

Fix virtio console for spec compliance.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (7):
      virtio_balloon: add array of stat names
      virtio_console: don't tie bufs to a vq
      virtio: add ability to iterate over vqs
      virtio_console: free buffers after reset
      virtio_console: drop custom control queue cleanup
      virtio_console: move removal code
      virtio_console: reset on out of memory

 drivers/char/virtio_console.c       | 157 ++++++++++++++++--------------------
 include/linux/virtio.h              |   3 +
 include/uapi/linux/virtio_balloon.h |  15 ++++
 3 files changed, 89 insertions(+), 86 deletions(-)
