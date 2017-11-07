From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: last minute bugfix
Date: Tue, 7 Nov 2017 17:28:01 +0200
Message-ID: <20171107172801-mutt-send-email-mst@kernel.org>
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
Cc: mhocko@suse.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We had a lot of trouble agreeing on a fix, but apparently there's
finally a consensus.

The following changes since commit 39dae59d66acd86d1de24294bd2f343fd5e7a625:

  Linux 4.14-rc8 (2017-11-05 13:05:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 823b45b4f154384941d57e124ed726847e293b36:

  virtio_balloon: fix deadlock on OOM (2017-11-07 17:24:59 +0200)

----------------------------------------------------------------
virtio: bugfix

Fixes a deadlock encountered with the virtio balloon.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      virtio_balloon: fix deadlock on OOM

 drivers/virtio/virtio_balloon.c    | 30 ++++++++++++++++++++++--------
 include/linux/balloon_compaction.h | 38 +++++++++++++++++++++++++++++++++++++-
 mm/balloon_compaction.c            | 27 +++++++++++++++++++++------
 3 files changed, 80 insertions(+), 15 deletions(-)
