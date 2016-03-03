From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL for-4.5] virtio/vhost: minor fixes
Date: Thu, 3 Mar 2016 15:08:07 +0200
Message-ID: <20160303150807-mutt-send-email-mst__22412.9263814122$1457010513$gmane$org@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, lprosek@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to e1f33be9186363da7955bcb5f0b03e6685544c50:

  vhost: fix error path in vhost_init_used() (2016-03-02 17:01:49 +0200)

----------------------------------------------------------------
virtio/vhost: minor fixes

This fixes two minor bugs: error handling in vhost,
and capability processing in virtio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Greg Kurz (1):
      vhost: fix error path in vhost_init_used()

Ladi Prosek (1):
      virtio-pci: read the right virtio_pci_notify_cap field

 drivers/vhost/vhost.c              | 15 +++++++++++----
 drivers/virtio/virtio_pci_modern.c |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)
