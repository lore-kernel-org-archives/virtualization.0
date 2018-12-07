From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio/vhost: last minute fixes
Date: Fri, 7 Dec 2018 16:53:51 -0500
Message-ID: <20181207165351-mutt-send-email-mst@kernel.org>
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
Cc: graham.whaley@gmail.com, kvm@vger.kernel.org, mst@redhat.com, riemensberger@cadami.net, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com, stefanha@redhat.com, syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com, colin.king@canonical.com, syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 834e772c8db0c6a275d75315d90aba4ebbb1e249:

  vhost/vsock: fix use-after-free in network stack callers (2018-12-06 14:28:38 -0500)

----------------------------------------------------------------
virtio fixes

A couple of last-minute fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Halil Pasic (2):
      virtio/s390: avoid race on vcdev->config
      virtio/s390: fix race in ccw_io_helper()

Stefan Hajnoczi (2):
      vhost/vsock: fix reset orphans race with close timeout
      vhost/vsock: fix use-after-free in network stack callers

 drivers/s390/virtio/virtio_ccw.c | 17 +++++++--
 drivers/vhost/vsock.c            | 79 ++++++++++++++++++++++++----------------
 2 files changed, 62 insertions(+), 34 deletions(-)
