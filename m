From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [GIT PULL] vhost/vdpa: minor fixes
Date: Thu, 21 May 2020 14:08:35 -0400
Message-ID: <20200521140835-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jasowang@redhat.com, lkp@intel.com, mst@redhat.com, yuehaibing@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 0b841030625cde5f784dd62aec72d6a766faae70:

  vhost: vsock: kick send_pkt worker once device is started (2020-05-02 10:28:21 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1b0be99f1a426d9f17ced95c4118c6641a2ff13d:

  vhost: missing __user tags (2020-05-15 11:36:31 -0400)

----------------------------------------------------------------
virtio: build warning fixes

Fix a couple of build warnings.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      vhost: missing __user tags

YueHaibing (1):
      vdpasim: remove unused variable 'ret'

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 15 +++++++--------
 drivers/vhost/vhost.c            |  4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)
