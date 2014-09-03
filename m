From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/3] virtio: simplify virtio_ring.
Date: Wed,  3 Sep 2014 13:59:13 +0930
Message-ID: <1409718556-3041-1-git-send-email-rusty__18160.9158441008$1409718652$gmane$org@rustcorp.com.au>
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
To: netdev <netdev@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@amacapital.net>
List-Id: virtualization@lists.linuxfoundation.org

I resurrected these patches after prompting from Andy Lutomirski's
recent patches.  I put them on the back-burner because vring_bench
had a 15% slowdown on my laptop: pktgen testing revealed a speedup,
if anything, so I've cleaned them up.

Rusty Russell (3):
  virtio_net: pass well-formed sgs to virtqueue_add_*()
  virtio_ring: assume sgs are always well-formed.
  virtio_ring: unify direct/indirect code paths.

 drivers/net/virtio_net.c     |   5 +-
 drivers/virtio/virtio_ring.c | 185 +++++++++++++++----------------------------
 2 files changed, 69 insertions(+), 121 deletions(-)

-- 
1.9.1
