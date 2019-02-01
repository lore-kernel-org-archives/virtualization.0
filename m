From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 0/2] vsock/virtio: fix issues on device hot-unplug
Date: Fri,  1 Feb 2019 12:42:05 +0100
Message-ID: <20190201114207.97217-1-sgarzare__30251.0683586419$1555717091$gmane$org@redhat.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

These patches try to handle the hot-unplug of vsock virtio transport device in
a proper way.

Maybe move the vsock_core_init()/vsock_core_exit() functions in the module_init
and module_exit of vsock_virtio_transport module can't be the best way, but the
architecture of vsock_core forces us to this approach for now.

The vsock_core proto_ops expect a valid pointer to the transport device, so we
can't call vsock_core_exit() until there are open sockets.

v2 -> v3:
 - Rebased on master

v1 -> v2:
 - Fixed commit message of patch 1.
 - Added Reviewed-by, Acked-by tags by Stefan

Stefano Garzarella (2):
  vsock/virtio: fix kernel panic after device hot-unplug
  vsock/virtio: reset connected sockets on device removal

 net/vmw_vsock/virtio_transport.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.20.1
