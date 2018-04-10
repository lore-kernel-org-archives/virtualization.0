From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/2] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 10 Apr 2018 13:26:28 +0800
Message-ID: <20180410052630.11270-1-stefanha__42196.3346460418$1523337923$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

v2:
 * Rewrote the conditional to make the vq access check clearer [Linus]
 * Added Patch 2 to make the return type consistent and harder to misuse [Linus]

The first patch fixes the vhost virtqueue access check which was recently
broken.  The second patch replaces the int return type with bool to prevent
future bugs.

Stefan Hajnoczi (2):
  vhost: fix vhost_vq_access_ok() log check
  vhost: return bool from *_access_ok() functions

 drivers/vhost/vhost.h |  4 +--
 drivers/vhost/vhost.c | 70 ++++++++++++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

-- 
2.14.3
