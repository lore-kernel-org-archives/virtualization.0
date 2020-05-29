From: Justin He <Justin.He@arm.com>
Subject: RE: [PATCH] virtio_vsock: Fix race condition in
 virtio_transport_recv_pkt
Date: Fri, 29 May 2020 15:11:25 +0000
Message-ID: <AM6PR08MB4069FC4405535635177ACC6DF78F0@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200529133123.195610-1-justin.he@arm.com>
 <20200529141033.iqtmu3giph6dekuj@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200529141033.iqtmu3giph6dekuj@steredhat>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kaly Xin <Kaly.Xin@arm.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Stefano

> -----Original Message-----
> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Friday, May 29, 2020 10:11 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>;
> kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Kaly Xin
> <Kaly.Xin@arm.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] virtio_vsock: Fix race condition in
> virtio_transport_recv_pkt
>
> Hi Jia,
> thanks for the patch! I have some comments.
>
> On Fri, May 29, 2020 at 09:31:23PM +0800, Jia He wrote:
> > When client tries to connect(SOCK_STREAM) the server in the guest with
> NONBLOCK
> > mode, there will be a panic on a ThunderX2 (armv8a server):
> > [  463.718844][ T5040] Unable to handle kernel NULL pointer dereference=
 at
> virtual address 0000000000000000
> > [  463.718848][ T5040] Mem abort info:
> > [  463.718849][ T5040]   ESR =3D 0x96000044
> > [  463.718852][ T5040]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [  463.718853][ T5040]   SET =3D 0, FnV =3D 0
> > [  463.718854][ T5040]   EA =3D 0, S1PTW =3D 0
> > [  463.718855][ T5040] Data abort info:
> > [  463.718856][ T5040]   ISV =3D 0, ISS =3D 0x00000044
> > [  463.718857][ T5040]   CM =3D 0, WnR =3D 1
> > [  463.718859][ T5040] user pgtable: 4k pages, 48-bit VAs,
> pgdp=3D0000008f6f6e9000
> > [  463.718861][ T5040] [0000000000000000] pgd=3D0000000000000000
> > [  463.718866][ T5040] Internal error: Oops: 96000044 [#1] SMP
> > [...]
> > [  463.718977][ T5040] CPU: 213 PID: 5040 Comm: vhost-5032 Tainted: G
> O      5.7.0-rc7+ #139
> > [  463.718980][ T5040] Hardware name: GIGABYTE R281-T91-00/MT91-FS1-00,
> BIOS F06 09/25/2018
> > [  463.718982][ T5040] pstate: 60400009 (nZCv daif +PAN -UAO)
> > [  463.718995][ T5040] pc : virtio_transport_recv_pkt+0x4c8/0xd40
> [vmw_vsock_virtio_transport_common]
> > [  463.718999][ T5040] lr : virtio_transport_recv_pkt+0x1fc/0xd40
> [vmw_vsock_virtio_transport_common]
> > [  463.719000][ T5040] sp : ffff80002dbe3c40
> > [...]
> > [  463.719025][ T5040] Call trace:
> > [  463.719030][ T5040]  virtio_transport_recv_pkt+0x4c8/0xd40
> [vmw_vsock_virtio_transport_common]
> > [  463.719034][ T5040]  vhost_vsock_handle_tx_kick+0x360/0x408
> [vhost_vsock]
> > [  463.719041][ T5040]  vhost_worker+0x100/0x1a0 [vhost]
> > [  463.719048][ T5040]  kthread+0x128/0x130
> > [  463.719052][ T5040]  ret_from_fork+0x10/0x18
> >
> > The race condition as follows:
> > Task1                            Task2
> > =3D=3D=3D=3D=3D                            =3D=3D=3D=3D=3D
> > __sock_release                   virtio_transport_recv_pkt
> >   __vsock_release                  vsock_find_bound_socket (found)
> >     lock_sock_nested
> >     vsock_remove_sock
> >     sock_orphan
> >       sk_set_socket(sk, NULL)
> >     ...
> >     release_sock
> >                                 lock_sock
> >                                    virtio_transport_recv_connecting
> >                                      sk->sk_socket->state (panic)
> >
> > This fixes it by checking vsk again whether it is in bound/connected ta=
ble.
> >
> > Signed-off-by: Jia He <justin.he@arm.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c
> b/net/vmw_vsock/virtio_transport_common.c
> > index 69efc891885f..0dbd6a45f0ed 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1132,6 +1132,17 @@ void virtio_transport_recv_pkt(struct
> virtio_transport *t,
> >
> >  lock_sock(sk);
> >
> > +/* Check it again if vsk is removed by vsock_remove_sock */
> > +spin_lock_bh(&vsock_table_lock);
> > +if (!__vsock_in_bound_table(vsk)
> && !__vsock_in_connected_table(vsk)) {
> > +spin_unlock_bh(&vsock_table_lock);
> > +(void)virtio_transport_reset_no_sock(t, pkt);
> > +release_sock(sk);
> > +sock_put(sk);
> > +goto free_pkt;
> > +}
> > +spin_unlock_bh(&vsock_table_lock);
> > +
>
> As an a simpler alternative, can we check the sk_shutdown or the socket
> state without check again both bound and connected tables?
>
> This is a data path, so we should take it faster.
>
> I mean something like this:
>
> if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
> ...
> }
>
Thanks for the suggestion, I verified it worked fine. And it
is a more lightweight checking than mine.

I will send v2 with above change
