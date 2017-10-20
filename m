From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 0/3] Virtio-balloon Improvement
Date: Fri, 20 Oct 2017 19:54:23 +0800
Message-ID: <1508500466-21165-1-git-send-email-wei.w.wang__31750.8779386573$1508501337$gmane$org@intel.com>
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
To: mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, mhocko@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch series intends to summarize the recent contributions made by
Michael S. Tsirkin, Tetsuo Handa, Michal Hocko etc. via reporting and
discussing the related deadlock issues on the mailinglist. Please check
each patch for details.

From a high-level point of view, this patch series achieves:
1) eliminate the deadlock issue fundamentally caused by the inability
to run leak_balloon and fill_balloon concurrently;
2) enable OOM to release more than 256 inflated pages; and
3) stop inflating when the guest is under severe memory pressure
(i.e. OOM).

Here is an example of the benefit brought by this patch series:
The guest sets virtio_balloon.oom_pages=100000. When the host requests
to inflate 7.9G of an 8G idle guest, the guest can still run normally
since OOM can guarantee at least 100000 pages (400MB) for the guest.
Without the above patches, the guest will kill all the killable
processes and fall into kernel panic finally.

Wei Wang (3):
  virtio-balloon: replace the coarse-grained balloon_lock
  virtio-balloon: deflate up to oom_pages on OOM
  virtio-balloon: stop inflating when OOM occurs

 drivers/virtio/virtio_balloon.c | 149 ++++++++++++++++++++++++----------------
 1 file changed, 91 insertions(+), 58 deletions(-)

-- 
2.7.4
