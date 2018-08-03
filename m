From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v3 0/2] virtio-balloon: some improvements
Date: Fri,  3 Aug 2018 16:32:24 +0800
Message-ID: <1533285146-25212-1-git-send-email-wei.w.wang__10537.1254649528$1533286720$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, penguin-kernel@I-love.SAKURA.ne.jp
List-Id: virtualization@lists.linuxfoundation.org

This series is split from the "Virtio-balloon: support free page
reporting" series to make some improvements.

ChangeLog:
v2->v3:
- shrink the balloon pages according to the amount requested by the
  claimer, instead of using a user specified number;
v1->v2:
- register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is
  negotiated.

Wei Wang (2):
  virtio-balloon: remove BUG() in init_vqs
  virtio_balloon: replace oom notifier with shrinker

 drivers/virtio/virtio_balloon.c | 121 ++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

-- 
2.7.4
