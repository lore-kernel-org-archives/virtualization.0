From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/6] VSOCK: revert virtio-vsock until device spec is finalized
Date: Tue,  8 Dec 2015 19:57:30 +0800
Message-ID: <1449575856-28507-1-git-send-email-stefanha__356.42043590105$1449575875$gmane$org@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Matt Benjamin <mbenjamin@redhat.com>, "David S. Miller" <davem@davemloft.net>, Christoffer Dall <christoffer.dall@linaro.org>, matt.ma@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

The virtio-vsock device specification is not finalized yet.  Michael Tsirkin
voiced concerned about merging this code when the hardware interface (and
possibly the userspace interface) could still change.

Please revert for now.

I am working to finalize the virtio-vsock device specification and at that
point the interfaces will be stable.

Stefan Hajnoczi (6):
  Revert "VSOCK: fix returnvar.cocci warnings"
  Revert "VSOCK: Add Makefile and Kconfig"
  Revert "VSOCK: Introduce vhost-vsock.ko"
  Revert "VSOCK: Introduce virtio-vsock.ko"
  Revert "VSOCK: Introduce virtio-vsock-common.ko"
  Revert "VSOCK: Introduce vsock_find_unbound_socket and
    vsock_bind_dgram_generic"

 drivers/vhost/Kconfig                   |    4 -
 drivers/vhost/Kconfig.vsock             |    7 -
 drivers/vhost/Makefile                  |    4 -
 drivers/vhost/vsock.c                   |  630 ---------------
 drivers/vhost/vsock.h                   |    4 -
 include/linux/virtio_vsock.h            |  209 -----
 include/net/af_vsock.h                  |    2 -
 include/uapi/linux/virtio_ids.h         |    1 -
 include/uapi/linux/virtio_vsock.h       |   89 ---
 net/vmw_vsock/Kconfig                   |   18 -
 net/vmw_vsock/Makefile                  |    2 -
 net/vmw_vsock/af_vsock.c                |   70 --
 net/vmw_vsock/virtio_transport.c        |  466 -----------
 net/vmw_vsock/virtio_transport_common.c | 1272 -------------------------------
 14 files changed, 2778 deletions(-)
 delete mode 100644 drivers/vhost/Kconfig.vsock
 delete mode 100644 drivers/vhost/vsock.c
 delete mode 100644 drivers/vhost/vsock.h
 delete mode 100644 include/linux/virtio_vsock.h
 delete mode 100644 include/uapi/linux/virtio_vsock.h
 delete mode 100644 net/vmw_vsock/virtio_transport.c
 delete mode 100644 net/vmw_vsock/virtio_transport_common.c

-- 
2.5.0
