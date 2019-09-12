From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: last minute bugfixes
Date: Thu, 12 Sep 2019 05:22:24 -0400
Message-ID: <20190912052224-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, ruippan@tencent.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, yongduan@tencent.com, matthias.lange@kernkonzept.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 02fa5d7b17a761f53ef1eedfc254e1f33bd226b0:

  mm/balloon_compaction: suppress allocation warnings (2019-09-04 07:42:01 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 060423bfdee3f8bc6e2c1bac97de24d5415e2bc4:

  vhost: make sure log_num < in_num (2019-09-11 15:15:26 -0400)

----------------------------------------------------------------
virtio: last minute bugfixes

A couple of security things.

And an error handling bugfix that is never encountered by most people,
but that also makes it kind of safe to push at the last minute, and it
helps push the fix to stable a bit sooner.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Matthias Lange (1):
      virtio_ring: fix unmap of indirect descriptors

Michael S. Tsirkin (1):
      vhost: block speculation of translated descriptors

yongduan (1):
      vhost: make sure log_num < in_num

 drivers/vhost/vhost.c        | 10 ++++++----
 drivers/virtio/virtio_ring.c |  8 ++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)
