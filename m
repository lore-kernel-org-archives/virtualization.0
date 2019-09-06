From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost, virtio: last minute fixes
Date: Fri, 6 Sep 2019 09:41:03 -0400
Message-ID: <20190906094103-mutt-send-email-mst__8171.70545212633$1567777278$gmane$org@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, jiangkidd@hotmail.com, linux-kernel@vger.kernel.org, linyunsheng@huawei.com, namit@vmware.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hope this can still make it.
I was not sure about virtio-net change but it seems that it prevents
livelocks for some people.

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 02fa5d7b17a761f53ef1eedfc254e1f33bd226b0:

  mm/balloon_compaction: suppress allocation warnings (2019-09-04 07:42:01 -0400)

----------------------------------------------------------------
virtio, vhost, balloon: bugfixes

A couple of last minute bugfixes. And a revert of a failed attempt at
metadata access optimization - we'll try again in the next cycle.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
? jiang (1):
      virtio-net: lower min ring num_free for efficiency

Michael S. Tsirkin (1):
      Revert "vhost: access vq metadata through kernel virtual address"

Nadav Amit (1):
      mm/balloon_compaction: suppress allocation warnings

Tiwei Bie (2):
      vhost/test: fix build for vhost test
      vhost/test: fix build for vhost test

Yunsheng Lin (1):
      vhost: Remove unnecessary variable

 drivers/net/virtio_net.c |   2 +-
 drivers/vhost/test.c     |  13 +-
 drivers/vhost/vhost.c    | 520 +----------------------------------------------
 drivers/vhost/vhost.h    |  41 ----
 mm/balloon_compaction.c  |   3 +-
 5 files changed, 17 insertions(+), 562 deletions(-)
