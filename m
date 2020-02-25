From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: INFO: task hung in lock_sock_nested (2)
Date: Tue, 25 Feb 2020 09:30:58 +0100
Message-ID: <20200225083058.nfrrvsdgjxj3zcmw@steredhat>
References: <0000000000004241ff059f2eb8a4@google.com>
 <20200223075025.9068-1-hdanton@sina.com>
 <20200224100853.wd67e7rqmtidfg7y@steredhat>
 <HK0P153MB0148B4C74BA6A60E295A03D8BFED0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HK0P153MB0148B4C74BA6A60E295A03D8BFED0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Sender: kvm-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: Hillf Danton <hdanton@sina.com>, Jorgen Hansen <jhansen@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>, syzbot <syzbot+731710996d79d0d58fbc@syzkaller.appspotmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 25, 2020 at 05:44:03AM +0000, Dexuan Cui wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Sent: Monday, February 24, 2020 2:09 AM
> > ...
> > > > syz-executor280 D27912  9768   9766 0x00000000
> > > > Call Trace:
> > > >  context_switch kernel/sched/core.c:3386 [inline]
> > > >  __schedule+0x934/0x1f90 kernel/sched/core.c:4082
> > > >  schedule+0xdc/0x2b0 kernel/sched/core.c:4156
> > > >  __lock_sock+0x165/0x290 net/core/sock.c:2413
> > > >  lock_sock_nested+0xfe/0x120 net/core/sock.c:2938
> > > >  virtio_transport_release+0xc4/0xd60
> > net/vmw_vsock/virtio_transport_common.c:832
> > > >  vsock_assign_transport+0xf3/0x3b0 net/vmw_vsock/af_vsock.c:454
> > > >  vsock_stream_connect+0x2b3/0xc70 net/vmw_vsock/af_vsock.c:1288
> > > >  __sys_connect_file+0x161/0x1c0 net/socket.c:1857
> > > >  __sys_connect+0x174/0x1b0 net/socket.c:1874
> > > >  __do_sys_connect net/socket.c:1885 [inline]
> > > >  __se_sys_connect net/socket.c:1882 [inline]
> > > >  __x64_sys_connect+0x73/0xb0 net/socket.c:1882
> > > >  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> 
> My understanding about the call trace is: in vsock_stream_connect() 
> after we call lock_sock(sk), we call vsock_assign_transport(), which may
> call vsk->transport->release(vsk), i.e. virtio_transport_release(), and in
> virtio_transport_release() we try to get the same lock and hang.

Yes, that's what I got.

> 
> > > Seems like vsock needs a word to track lock owner in an attempt to
> > > avoid trying to lock sock while the current is the lock owner.
> 
> I'm unfamilar with the g2h/h2g :-) 
> Here I'm wondering if it's acceptable to add an 'already_locked'
> parameter like this:
>   bool already_locked = true;
>   vsk->transport->release(vsk, already_locked) ?

Could be acceptable, but I prefer to avoid.

>  
> > Thanks for this possible solution.
> > What about using sock_owned_by_user()?
>  
> > We should fix also hyperv_transport, because it could suffer from the same
> > problem.
> 
> IIUC hyperv_transport doesn't supprot the h2g/g2h feature, so it should not
> suffers from the deadlock issue here?

The h2g/g2h is in the vsock core, and the hyperv_transport is one of the g2h
transports available.

If we have a L1 VM with hyperv_transport (G2H) to communicate with L0 and a
nested KVM VM (L2) we need to load also vhost_transport (H2G). If the
user creates a socket and it tries the following:
    connect(fd, <2,1234>) - socket assigned to hyperv_transport (because
                            the user wants to reach the host using CID_HOST)
        fails

    connect(fd, <3,1234>) - socket must be reassigned to vhost_transport
                            (because the user wants to reach a nested guest)

So, I think in this case we can have the deadlock.

> 
> > At this point, it might be better to call vsk->transport->release(vsk)
> > always with the lock taken and remove it in the transports as in the
> > following patch.
> > 
> > What do you think?
> > 
> > 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 9c5b2a91baad..a073d8efca33 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -753,20 +753,18 @@ static void __vsock_release(struct sock *sk, int
> > level)
> >  		vsk = vsock_sk(sk);
> >  		pending = NULL;	/* Compiler warning. */
> > 
> > -		/* The release call is supposed to use lock_sock_nested()
> > -		 * rather than lock_sock(), if a sock lock should be acquired.
> > -		 */
> > -		if (vsk->transport)
> > -			vsk->transport->release(vsk);
> > -		else if (sk->sk_type == SOCK_STREAM)
> > -			vsock_remove_sock(vsk);
> > -
> >  		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
> >  		 * version to avoid the warning "possible recursive locking
> >  		 * detected". When "level" is 0, lock_sock_nested(sk, level)
> >  		 * is the same as lock_sock(sk).
> >  		 */
> >  		lock_sock_nested(sk, level);
> > +
> > +		if (vsk->transport)
> > +			vsk->transport->release(vsk);
> > +		else if (sk->sk_type == SOCK_STREAM)
> > +			vsock_remove_sock(vsk);
> > +
> >  		sock_orphan(sk);
> >  		sk->sk_shutdown = SHUTDOWN_MASK;
> > 
> > diff --git a/net/vmw_vsock/hyperv_transport.c
> > b/net/vmw_vsock/hyperv_transport.c
> > index 3492c021925f..510f25f4a856 100644
> > --- a/net/vmw_vsock/hyperv_transport.c
> > +++ b/net/vmw_vsock/hyperv_transport.c
> > @@ -529,9 +529,7 @@ static void hvs_release(struct vsock_sock *vsk)
> >  	struct sock *sk = sk_vsock(vsk);
> >  	bool remove_sock;
> > 
> > -	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> >  	remove_sock = hvs_close_lock_held(vsk);
> > -	release_sock(sk);
> >  	if (remove_sock)
> >  		vsock_remove_sock(vsk);
> >  }
> 
> This looks good to me, but do we know why vsk->transport->release(vsk)
> is called without holding the lock for 'sk' in the first place?

Maybe because vmci_transport (the first transport implemented) doesn't
require holding lock during the release.

Okay, so I'll test this patch and then I'll send it out for reviews.

Thanks for the feedback,
Stefano
