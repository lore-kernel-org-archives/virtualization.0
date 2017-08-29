From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH RFC 0/2] virtio-net: implement reset request
Date: Tue, 29 Aug 2017 16:07:57 -0400
Message-ID: <20170829200759.13975-1-willemdebruijn.kernel__15580.325263045$1504037364$gmane$org@gmail.com>
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
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Willem de Bruijn <willemb@google.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Willem de Bruijn <willemb@google.com>

Implement VIRTIO_CONFIG_S_NEEDS_RESET (patch 1) and
add a feature bit to signal support (patch 2)

Further details in the individual patches.

Willem de Bruijn (2):
  virtio_net: implement VIRTIO_CONFIG_S_NEEDS_RESET
  virtio_net: enable probing for NEEDS_RESET support

 drivers/net/virtio_net.c           | 71 +++++++++++++++++++++++++++++++++-----
 include/uapi/linux/virtio_config.h |  3 ++
 include/uapi/linux/virtio_net.h    |  4 +++
 3 files changed, 69 insertions(+), 9 deletions(-)

-- 
2.14.1.342.g6490525c54-goog
