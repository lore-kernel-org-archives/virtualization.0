From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: fixes
Date: Wed, 6 Feb 2019 14:32:56 -0500
Message-ID: <20190206143256-mutt-send-email-mst__40363.3244962961$1549481593$gmane$org@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 9c0644ee4aa8792f1e60a2b014b4710faaddafeb:

  virtio: drop internal struct from UAPI (2019-02-05 15:29:48 -0500)

----------------------------------------------------------------
virtio: fixes

A small fix for a uapi header, and a fix for VDPA for non-x86 guests.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      virtio: drop internal struct from UAPI

Tiwei Bie (1):
      virtio: support VIRTIO_F_ORDER_PLATFORM

 drivers/virtio/virtio_ring.c       | 15 ++++++++++++++-
 include/uapi/linux/virtio_config.h |  6 ++++++
 include/uapi/linux/virtio_ring.h   | 10 ----------
 3 files changed, 20 insertions(+), 11 deletions(-)
