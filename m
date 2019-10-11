From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 2/2] vhost/vsock: don't allow half-closed socket in
	the host
Date: Fri, 11 Oct 2019 10:26:34 -0400
Message-ID: <20191011102246-mutt-send-email-mst__36847.4573873513$1570804482$gmane$org@kernel.org>
References: <20191011130758.22134-1-sgarzare@redhat.com>
	<20191011130758.22134-3-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191011130758.22134-3-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Adit Ranadive <aditr@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 11, 2019 at 03:07:58PM +0200, Stefano Garzarella wrote:
> vmci_transport never allowed half-closed socket on the host side.
> In order to provide the same behaviour, we changed the
> vhost_transport_stream_has_data() to return 0 (no data available)
> if the peer (guest) closed the connection.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

I don't think we should copy bugs like this.
Applications don't actually depend on this VMCI limitation, in fact
it looks like a working application can get broken by this.

So this looks like a userspace visible ABI change
which we can't really do.

If it turns out some application cares, it can always
fully close the connection. Or add an ioctl so the application
can find out whether half close works.

> ---
>  drivers/vhost/vsock.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9f57736fe15e..754120aa4478 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -58,6 +58,21 @@ static u32 vhost_transport_get_local_cid(void)
>  	return VHOST_VSOCK_DEFAULT_HOST_CID;
>  }
>  
> +static s64 vhost_transport_stream_has_data(struct vsock_sock *vsk)
> +{
> +	/* vmci_transport doesn't allow half-closed socket on the host side.
> +	 * recv() on the host side returns EOF when the guest closes a
> +	 * connection, also if some data is still in the receive queue.
> +	 *
> +	 * In order to provide the same behaviour, we always return 0
> +	 * (no data available) if the peer (guest) closed the connection.
> +	 */
> +	if (vsk->peer_shutdown == SHUTDOWN_MASK)
> +		return 0;
> +
> +	return virtio_transport_stream_has_data(vsk);
> +}
> +
>  /* Callers that dereference the return value must hold vhost_vsock_mutex or the
>   * RCU read lock.
>   */
> @@ -804,7 +819,7 @@ static struct virtio_transport vhost_transport = {
>  
>  		.stream_enqueue           = virtio_transport_stream_enqueue,
>  		.stream_dequeue           = virtio_transport_stream_dequeue,
> -		.stream_has_data          = virtio_transport_stream_has_data,
> +		.stream_has_data          = vhost_transport_stream_has_data,
>  		.stream_has_space         = virtio_transport_stream_has_space,
>  		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
>  		.stream_is_active         = virtio_transport_stream_is_active,
> -- 
> 2.21.0
