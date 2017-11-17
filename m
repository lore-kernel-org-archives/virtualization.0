From: Joel Stanley <joel@jms.id.au>
Subject: [PATCH] virto_net: remove empty file 'virtio_net.'
Date: Fri, 17 Nov 2017 13:16:36 +1030
Message-ID: <20171117024636.15515-1-joel__5629.12426325983$1511414949$gmane$org@jms.id.au>
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
To: Jason Wang <jasowang@redhat.com>, "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Looks like this was mistakenly added to the tree as part of
commit 186b3c998c50 ("virtio-net: support XDP_REDIRECT").

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/net/virtio_net. | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 drivers/net/virtio_net.

diff --git a/drivers/net/virtio_net. b/drivers/net/virtio_net.
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.14.1
