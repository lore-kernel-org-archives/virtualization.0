From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 02/14] vsock: remove vm_sockets_get_local_cid()
Date: Wed, 30 Oct 2019 14:55:49 +0000
Message-ID: <MWHPR05MB3376D6FBAC3940FE757CE578DA600__39090.4994261049$1572447599$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-3-sgarzare@redhat.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-3-sgarzare@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Stefano Garzarella' <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> -----Original Message-----
> From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> Sent: Wednesday, October 23, 2019 11:56 AM
> To: netdev@vger.kernel.org
> Subject: [PATCH net-next 02/14] vsock: remove vm_sockets_get_local_cid()
> 
> vm_sockets_get_local_cid() is only used in virtio_transport_common.c.
> We can replace it calling the virtio_transport_get_ops() and using the
> get_local_cid() callback registered by the transport.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/vm_sockets.h              |  2 --
>  net/vmw_vsock/af_vsock.c                | 10 ----------
>  net/vmw_vsock/virtio_transport_common.c |  2 +-
>  3 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/include/linux/vm_sockets.h b/include/linux/vm_sockets.h index
> 33f1a2ecd905..7dd899ccb920 100644
> --- a/include/linux/vm_sockets.h
> +++ b/include/linux/vm_sockets.h
> @@ -10,6 +10,4 @@
> 
>  #include <uapi/linux/vm_sockets.h>
> 
> -int vm_sockets_get_local_cid(void);
> -
>  #endif /* _VM_SOCKETS_H */
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c index
> 2ab43b2bba31..2f2582fb7fdd 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -129,16 +129,6 @@ static struct proto vsock_proto = {  static const struct
> vsock_transport *transport;  static DEFINE_MUTEX(vsock_register_mutex);
> 
> -/**** EXPORTS ****/
> -
> -/* Get the ID of the local context.  This is transport dependent. */
> -
> -int vm_sockets_get_local_cid(void)
> -{
> -	return transport->get_local_cid();
> -}
> -EXPORT_SYMBOL_GPL(vm_sockets_get_local_cid);
> -
>  /**** UTILS ****/
> 
>  /* Each bound VSocket is stored in the bind hash table and each connected
> diff --git a/net/vmw_vsock/virtio_transport_common.c
> b/net/vmw_vsock/virtio_transport_common.c
> index d02c9b41a768..b1cd16ed66ea 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -168,7 +168,7 @@ static int virtio_transport_send_pkt_info(struct
> vsock_sock *vsk,
>  	struct virtio_vsock_pkt *pkt;
>  	u32 pkt_len = info->pkt_len;
> 
> -	src_cid = vm_sockets_get_local_cid();
> +	src_cid = virtio_transport_get_ops()->transport.get_local_cid();
>  	src_port = vsk->local_addr.svm_port;
>  	if (!info->remote_cid) {
>  		dst_cid	= vsk->remote_addr.svm_cid;
> --
> 2.21.0

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
