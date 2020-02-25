From: Dexuan Cui <decui@microsoft.com>
Subject: RE: INFO: task hung in lock_sock_nested (2)
Date: Tue, 25 Feb 2020 05:44:03 +0000
Message-ID: <HK0P153MB0148B4C74BA6A60E295A03D8BFED0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <0000000000004241ff059f2eb8a4@google.com>
 <20200223075025.9068-1-hdanton@sina.com>
 <20200224100853.wd67e7rqmtidfg7y@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200224100853.wd67e7rqmtidfg7y@steredhat>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>, Hillf Danton <hdanton@sina.com>, Jorgen Hansen <jhansen@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: syzbot <syzbot+731710996d79d0d58fbc@syzkaller.appspotmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Monday, February 24, 2020 2:09 AM
> ...
> > > syz-executor280 D27912  9768   9766 0x00000000
> > > Call Trace:
> > >  context_switch kernel/sched/core.c:3386 [inline]
> > >  __schedule+0x934/0x1f90 kernel/sched/core.c:4082
> > >  schedule+0xdc/0x2b0 kernel/sched/core.c:4156
> > >  __lock_sock+0x165/0x290 net/core/sock.c:2413
> > >  lock_sock_nested+0xfe/0x120 net/core/sock.c:2938
> > >  virtio_transport_release+0xc4/0xd60
> net/vmw_vsock/virtio_transport_common.c:832
> > >  vsock_assign_transport+0xf3/0x3b0 net/vmw_vsock/af_vsock.c:454
> > >  vsock_stream_connect+0x2b3/0xc70 net/vmw_vsock/af_vsock.c:1288
> > >  __sys_connect_file+0x161/0x1c0 net/socket.c:1857
> > >  __sys_connect+0x174/0x1b0 net/socket.c:1874
> > >  __do_sys_connect net/socket.c:1885 [inline]
> > >  __se_sys_connect net/socket.c:1882 [inline]
> > >  __x64_sys_connect+0x73/0xb0 net/socket.c:1882
> > >  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294

My understanding about the call trace is: in vsock_stream_connect()=20
after we call lock_sock(sk), we call vsock_assign_transport(), which may
call vsk->transport->release(vsk), i.e. virtio_transport_release(), and in
virtio_transport_release() we try to get the same lock and hang.

> > Seems like vsock needs a word to track lock owner in an attempt to
> > avoid trying to lock sock while the current is the lock owner.

I'm unfamilar with the g2h/h2g :-)=20
Here I'm wondering if it's acceptable to add an 'already_locked'
parameter like this:
  bool already_locked =3D true;
  vsk->transport->release(vsk, already_locked) ?
=20
> Thanks for this possible solution.
> What about using sock_owned_by_user()?
=20
> We should fix also hyperv_transport, because it could suffer from the sam=
e
> problem.

IIUC hyperv_transport doesn't supprot the h2g/g2h feature, so it should not
suffers from the deadlock issue here?

> At this point, it might be better to call vsk->transport->release(vsk)
> always with the lock taken and remove it in the transports as in the
> following patch.
>=20
> What do you think?
>=20
>=20
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9c5b2a91baad..a073d8efca33 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -753,20 +753,18 @@ static void __vsock_release(struct sock *sk, int
> level)
>  		vsk =3D vsock_sk(sk);
>  		pending =3D NULL;	/* Compiler warning. */
>=20
> -		/* The release call is supposed to use lock_sock_nested()
> -		 * rather than lock_sock(), if a sock lock should be acquired.
> -		 */
> -		if (vsk->transport)
> -			vsk->transport->release(vsk);
> -		else if (sk->sk_type =3D=3D SOCK_STREAM)
> -			vsock_remove_sock(vsk);
> -
>  		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>  		 * version to avoid the warning "possible recursive locking
>  		 * detected". When "level" is 0, lock_sock_nested(sk, level)
>  		 * is the same as lock_sock(sk).
>  		 */
>  		lock_sock_nested(sk, level);
> +
> +		if (vsk->transport)
> +			vsk->transport->release(vsk);
> +		else if (sk->sk_type =3D=3D SOCK_STREAM)
> +			vsock_remove_sock(vsk);
> +
>  		sock_orphan(sk);
>  		sk->sk_shutdown =3D SHUTDOWN_MASK;
>=20
> diff --git a/net/vmw_vsock/hyperv_transport.c
> b/net/vmw_vsock/hyperv_transport.c
> index 3492c021925f..510f25f4a856 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -529,9 +529,7 @@ static void hvs_release(struct vsock_sock *vsk)
>  	struct sock *sk =3D sk_vsock(vsk);
>  	bool remove_sock;
>=20
> -	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  	remove_sock =3D hvs_close_lock_held(vsk);
> -	release_sock(sk);
>  	if (remove_sock)
>  		vsock_remove_sock(vsk);
>  }

This looks good to me, but do we know why vsk->transport->release(vsk)
is called without holding the lock for 'sk' in the first place?

Thanks,
Dexuan
