From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vsock: fix potential deadlock in
 transport->release()
Date: Thu, 27 Feb 2020 12:04:23 -0800 (PST)
Message-ID: <20200227.120423.2054408641031093845.davem@davemloft.net>
References: <20200226105818.36055-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200226105818.36055-1-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sgarzare@redhat.com
Cc: decui@microsoft.com, hdanton@sina.com, virtualization@lists.linux-foundation.org, kys@microsoft.com, kvm@vger.kernel.org, sthemmin@microsoft.com, syzbot+731710996d79d0d58fbc@syzkaller.appspotmail.com, netdev@vger.kernel.org, sashal@kernel.org, sunilmut@microsoft.com, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, kuba@kernel.org, haiyangz@microsoft.com, stefanha@redhat.com, jhansen@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 26 Feb 2020 11:58:18 +0100

> Some transports (hyperv, virtio) acquire the sock lock during the
> .release() callback.
> 
> In the vsock_stream_connect() we call vsock_assign_transport(); if
> the socket was previously assigned to another transport, the
> vsk->transport->release() is called, but the sock lock is already
> held in the vsock_stream_connect(), causing a deadlock reported by
> syzbot:
 ...
> To avoid this issue, this patch remove the lock acquiring in the
> .release() callback of hyperv and virtio transports, and it holds
> the lock when we call vsk->transport->release() in the vsock core.
> 
> Reported-by: syzbot+731710996d79d0d58fbc@syzkaller.appspotmail.com
> Fixes: 408624af4c89 ("vsock: use local transport when it is loaded")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Applied, thank you.
