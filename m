From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 11/14] vsock: add multi-transports support
Date: Wed, 23 Oct 2019 17:08:01 +0200
Message-ID: <CAGxU2F7n48kBy_y2GB=mcvraK=mw_2Jn8=2hvQnEOWqWuT9OjA__24977.0214244322$1571843301$gmane$org@mail.gmail.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-12-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191023095554.11340-12-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 23, 2019 at 11:59 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> This patch adds the support of multiple transports in the
> VSOCK core.
>
> With the multi-transports support, we can use vsock with nested VMs
> (using also different hypervisors) loading both guest->host and
> host->guest transports at the same time.
>
> Major changes:
> - vsock core module can be loaded regardless of the transports
> - vsock_core_init() and vsock_core_exit() are renamed to
>   vsock_core_register() and vsock_core_unregister()
> - vsock_core_register() has a feature parameter (H2G, G2H, DGRAM)
>   to identify which directions the transport can handle and if it's
>   support DGRAM (only vmci)
> - each stream socket is assigned to a transport when the remote CID
>   is set (during the connect() or when we receive a connection request
>   on a listener socket).
>   The remote CID is used to decide which transport to use:
>   - remote CID > VMADDR_CID_HOST will use host->guest transport
>   - remote CID <= VMADDR_CID_HOST will use guest->host transport
> - listener sockets are not bound to any transports since no transport
>   operations are done on it. In this way we can create a listener
>   socket, also if the transports are not loaded or with VMADDR_CID_ANY
>   to listen on all transports.
> - DGRAM sockets are handled as before, since only the vmci_transport
>   provides this feature.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> RFC -> v1:
> - documented VSOCK_TRANSPORT_F_* flags
> - fixed vsock_assign_transport() when the socket is already assigned
>   (e.g connection failed)
> - moved features outside of struct vsock_transport, and used as
>   parameter of vsock_core_register()
> ---
>  drivers/vhost/vsock.c                   |   5 +-
>  include/net/af_vsock.h                  |  17 +-
>  net/vmw_vsock/af_vsock.c                | 237 ++++++++++++++++++------
>  net/vmw_vsock/hyperv_transport.c        |  26 ++-
>  net/vmw_vsock/virtio_transport.c        |   7 +-
>  net/vmw_vsock/virtio_transport_common.c |  28 ++-
>  net/vmw_vsock/vmci_transport.c          |  31 +++-
>  7 files changed, 270 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 6d7e4f022748..b235f4bbe8ea 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -831,7 +831,8 @@ static int __init vhost_vsock_init(void)
>  {
>         int ret;
>
> -       ret = vsock_core_init(&vhost_transport.transport);
> +       ret = vsock_core_register(&vhost_transport.transport,
> +                                 VSOCK_TRANSPORT_F_H2G);
>         if (ret < 0)
>                 return ret;
>         return misc_register(&vhost_vsock_misc);
> @@ -840,7 +841,7 @@ static int __init vhost_vsock_init(void)
>  static void __exit vhost_vsock_exit(void)
>  {
>         misc_deregister(&vhost_vsock_misc);
> -       vsock_core_exit();
> +       vsock_core_unregister(&vhost_transport.transport);
>  };
>
>  module_init(vhost_vsock_init);
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index fa1570dc9f5c..27a3463e4892 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -91,6 +91,14 @@ struct vsock_transport_send_notify_data {
>         u64 data2; /* Transport-defined. */
>  };
>
> +/* Transport features flags */
> +/* Transport provides host->guest communication */
> +#define VSOCK_TRANSPORT_F_H2G          0x00000001
> +/* Transport provides guest->host communication */
> +#define VSOCK_TRANSPORT_F_G2H          0x00000002
> +/* Transport provides DGRAM communication */
> +#define VSOCK_TRANSPORT_F_DGRAM                0x00000004
> +
>  struct vsock_transport {
>         /* Initialize/tear-down socket. */
>         int (*init)(struct vsock_sock *, struct vsock_sock *);
> @@ -154,12 +162,8 @@ struct vsock_transport {
>
>  /**** CORE ****/
>
> -int __vsock_core_init(const struct vsock_transport *t, struct module *owner);
> -static inline int vsock_core_init(const struct vsock_transport *t)
> -{
> -       return __vsock_core_init(t, THIS_MODULE);
> -}
> -void vsock_core_exit(void);
> +int vsock_core_register(const struct vsock_transport *t, int features);
> +void vsock_core_unregister(const struct vsock_transport *t);
>
>  /* The transport may downcast this to access transport-specific functions */
>  const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk);
> @@ -190,6 +194,7 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>                                          struct sockaddr_vm *dst);
>  void vsock_remove_sock(struct vsock_sock *vsk);
>  void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
> +int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
>
>  /**** TAP ****/
>
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index d89381166028..dddd85d9a147 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -130,7 +130,12 @@ static struct proto vsock_proto = {
>  #define VSOCK_DEFAULT_BUFFER_MAX_SIZE (1024 * 256)
>  #define VSOCK_DEFAULT_BUFFER_MIN_SIZE 128
>
> -static const struct vsock_transport *transport_single;
> +/* Transport used for host->guest communication */
> +static const struct vsock_transport *transport_h2g;
> +/* Transport used for guest->host communication */
> +static const struct vsock_transport *transport_g2h;
> +/* Transport used for DGRAM communication */
> +static const struct vsock_transport *transport_dgram;
>  static DEFINE_MUTEX(vsock_register_mutex);
>
>  /**** UTILS ****/
> @@ -182,7 +187,7 @@ static int vsock_auto_bind(struct vsock_sock *vsk)
>         return __vsock_bind(sk, &local_addr);
>  }
>
> -static int __init vsock_init_tables(void)
> +static void vsock_init_tables(void)
>  {
>         int i;
>
> @@ -191,7 +196,6 @@ static int __init vsock_init_tables(void)
>
>         for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++)
>                 INIT_LIST_HEAD(&vsock_connected_table[i]);
> -       return 0;
>  }
>
>  static void __vsock_insert_bound(struct list_head *list,
> @@ -376,6 +380,62 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>  }
>  EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>
> +/* Assign a transport to a socket and call the .init transport callback.
> + *
> + * Note: for stream socket this must be called when vsk->remote_addr is set
> + * (e.g. during the connect() or when a connection request on a listener
> + * socket is received).
> + * The vsk->remote_addr is used to decide which transport to use:
> + *  - remote CID > VMADDR_CID_HOST will use host->guest transport
> + *  - remote CID <= VMADDR_CID_HOST will use guest->host transport
> + */
> +int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> +{
> +       const struct vsock_transport *new_transport;
> +       struct sock *sk = sk_vsock(vsk);
> +
> +       switch (sk->sk_type) {
> +       case SOCK_DGRAM:
> +               new_transport = transport_dgram;
> +               break;
> +       case SOCK_STREAM:
> +               if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
> +                       new_transport = transport_h2g;
> +               else
> +                       new_transport = transport_g2h;

I just noticed that this break the loopback in the guest.
As a fix, we should use 'transport_g2h' when remote_cid <= VMADDR_CID_HOST
or remote_cid is the id of 'transport_g2h'.

To do that we also need to avoid that L2 guests can have the same CID of L1.
For vhost_vsock I can call vsock_find_cid() in vhost_vsock_set_cid()

@Jorgen: for vmci we need to do the same? or it is guaranteed, since
it's already support nested VMs, that a L2 guests cannot have the
same CID as the L1.

I'll send a v2 with this fix, but I'll wait a bit for other comments.

Thanks,
Stefano
