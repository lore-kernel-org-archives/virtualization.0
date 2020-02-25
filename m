From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: INFO: task hung in lock_sock_nested (2)
Date: Tue, 25 Feb 2020 10:07:32 +0100
Message-ID: <20200225090732.kge6bdf46ji6mbb5@steredhat>
References: <0000000000004241ff059f2eb8a4@google.com>
 <20200223075025.9068-1-hdanton@sina.com>
 <20200224134428.12256-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224134428.12256-1-hdanton@sina.com>
Sender: kvm-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>
Cc: Dexuan Cui <decui@microsoft.com>, Jorgen Hansen <jhansen@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>, syzbot <syzbot+731710996d79d0d58fbc@syzkaller.appspotmail.com>, davem@davemloft.net, kuba@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 24, 2020 at 09:44:28PM +0800, Hillf Danton wrote:
> 
> On Mon, 24 Feb 2020 11:08:53 +0100 Stefano Garzarella wrote:
> > On Sun, Feb 23, 2020 at 03:50:25PM +0800, Hillf Danton wrote:
> > > 
> > > Seems like vsock needs a word to track lock owner in an attempt to
> > > avoid trying to lock sock while the current is the lock owner.
> > 
> > Thanks for this possible solution.
> > What about using sock_owned_by_user()?
> > 
> No chance for vsock_locked() if it works.
> 
> > We should fix also hyperv_transport, because it could suffer from the same
> > problem.
> > 
> You're right. My diff is at most for introducing vsk's lock owner.

Sure, thanks for this!

> 
> > At this point, it might be better to call vsk->transport->release(vsk)
> > always with the lock taken and remove it in the transports as in the
> > following patch.
> > 
> > What do you think?
> > 
> Yes and ... please take a look at the output of grep
> 
> 	grep -n lock_sock linux/net/vmw_vsock/af_vsock.c
> 
> as it drove me mad.

:-) I'll go in this direction and I'll check all the cases.

We should avoid to take lock_sock in the transports when it is possible.

Thanks for the help,
Stefano
