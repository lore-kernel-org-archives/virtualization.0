From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 0/2] virtio-balloon: some improvements
Date: Fri, 27 Jul 2018 17:24:53 +0800
Message-ID: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
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
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This series is split from the "Virtio-balloon: support free page
reporting" series to make some improvements.

v1->v2 ChangeLog:
- register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is negotiated.

Wei Wang (2):
  virtio-balloon: remove BUG() in init_vqs
  virtio_balloon: replace oom notifier with shrinker

 drivers/virtio/virtio_balloon.c | 125 +++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 53 deletions(-)

-- 
2.7.4
