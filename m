From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 1/2] vsock: add half-closed socket details in the
	implementation notes
Date: Fri, 11 Oct 2019 10:22:30 -0400
Message-ID: <20191011101936-mutt-send-email-mst__32890.2176742972$1570804467$gmane$org@kernel.org>
References: <20191011130758.22134-1-sgarzare@redhat.com>
	<20191011130758.22134-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191011130758.22134-2-sgarzare@redhat.com>
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

On Fri, Oct 11, 2019 at 03:07:57PM +0200, Stefano Garzarella wrote:
> vmci_transport never allowed half-closed socket on the host side.
> Since we want to have the same behaviour across all transports, we
> add a section in the "Implementation notes".
> 
> Cc: Jorgen Hansen <jhansen@vmware.com>
> Cc: Adit Ranadive <aditr@vmware.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ab43b2bba31..27df57c2024b 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -83,6 +83,10 @@
>   *   TCP_ESTABLISHED - connected
>   *   TCP_CLOSING - disconnecting
>   *   TCP_LISTEN - listening
> + *
> + * - Half-closed socket is supported only on the guest side. recv() on the host
> + * side should return EOF when the guest closes a connection, also if some
> + * data is still in the receive queue.
>   */
>  
>  #include <linux/types.h>

That's a great way to lose data in a way that's hard to debug.

VMCI sockets connect to a hypervisor so there's tight control
of what the hypervisor can do.

But vhost vsocks connect to a fully fledged Linux, so
you can't assume this is safe. And application authors do not read
kernel source.

> -- 
> 2.21.0
