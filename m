From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v2] vsock: Fix a lockdep warning in __vsock_release()
Date: Thu, 26 Sep 2019 09:47:49 +0200
Message-ID: <20190926074749.sltehhkcgfduu7n2__48184.8797340476$1569484087$gmane$org@steredhat.homenet.telecomitalia.it>
References: <1569460241-57800-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1569460241-57800-1-git-send-email-decui@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ytht.net@gmail.com" <ytht.net@gmail.com>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "jhansen@vmware.com" <jhansen@vmware.com>, Michael Kelley <mikelley@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Dexuan,

On Thu, Sep 26, 2019 at 01:11:27AM +0000, Dexuan Cui wrote:
> Lockdep is unhappy if two locks from the same class are held.
> 
> Fix the below warning for hyperv and virtio sockets (vmci socket code
> doesn't have the issue) by using lock_sock_nested() when __vsock_release()
> is called recursively:
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.3.0+ #1 Not tainted
> --------------------------------------------
> server/1795 is trying to acquire lock:
> ffff8880c5158990 (sk_lock-AF_VSOCK){+.+.}, at: hvs_release+0x10/0x120 [hv_sock]
> 
> but task is already holding lock:
> ffff8880c5158150 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x2e/0xf0 [vsock]
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(sk_lock-AF_VSOCK);
>   lock(sk_lock-AF_VSOCK);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by server/1795:
>  #0: ffff8880c5d05ff8 (&sb->s_type->i_mutex_key#10){+.+.}, at: __sock_release+0x2d/0xa0
>  #1: ffff8880c5158150 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x2e/0xf0 [vsock]
> 
> stack backtrace:
> CPU: 5 PID: 1795 Comm: server Not tainted 5.3.0+ #1
> Call Trace:
>  dump_stack+0x67/0x90
>  __lock_acquire.cold.67+0xd2/0x20b
>  lock_acquire+0xb5/0x1c0
>  lock_sock_nested+0x6d/0x90
>  hvs_release+0x10/0x120 [hv_sock]
>  __vsock_release+0x24/0xf0 [vsock]
>  __vsock_release+0xa0/0xf0 [vsock]
>  vsock_release+0x12/0x30 [vsock]
>  __sock_release+0x37/0xa0
>  sock_close+0x14/0x20
>  __fput+0xc1/0x250
>  task_work_run+0x98/0xc0
>  do_exit+0x344/0xc60
>  do_group_exit+0x47/0xb0
>  get_signal+0x15c/0xc50
>  do_signal+0x30/0x720
>  exit_to_usermode_loop+0x50/0xa0
>  do_syscall_64+0x24e/0x270
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f4184e85f31
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> NOTE: I only tested the code on Hyper-V. I can not test the code for
> virtio socket, as I don't have a KVM host. :-( Sorry.
> 
> @Stefan, @Stefano: please review & test the patch for virtio socket,
> and let me know if the patch breaks anything. Thanks!

Comment below, I'll test it ASAP!

> 
> Changes in v2:
>   Avoid the duplication of code in v1: https://lkml.org/lkml/2019/8/19/1361
>   Also fix virtio socket code.
> 
>  net/vmw_vsock/af_vsock.c                | 19 +++++++++++++++----
>  net/vmw_vsock/hyperv_transport.c        |  2 +-
>  net/vmw_vsock/virtio_transport_common.c |  2 +-
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index ab47bf3ab66e..dbae4373cbab 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -638,8 +638,10 @@ struct sock *__vsock_create(struct net *net,
>  }
>  EXPORT_SYMBOL_GPL(__vsock_create);
>  
> -static void __vsock_release(struct sock *sk)
> +static void __vsock_release(struct sock *sk, int level)
>  {
> +	WARN_ON(level != 1 && level != 2);
> +
>  	if (sk) {
>  		struct sk_buff *skb;
>  		struct sock *pending;
> @@ -648,9 +650,18 @@ static void __vsock_release(struct sock *sk)
>  		vsk = vsock_sk(sk);
>  		pending = NULL;	/* Compiler warning. */
>  
> +		/* The release call is supposed to use lock_sock_nested()
> +		 * rather than lock_sock(), if a sock lock should be acquired.
> +		 */
>  		transport->release(vsk);
>  
> -		lock_sock(sk);
> +		/* When "level" is 2, use the nested version to avoid the
> +		 * warning "possible recursive locking detected".
> +		 */
> +		if (level == 1)
> +			lock_sock(sk);

Since lock_sock() calls lock_sock_nested(sk, 0), could we use directly
lock_sock_nested(sk, level) with level = 0 in vsock_release() and
level = SINGLE_DEPTH_NESTING here in the while loop?

> +		else
> +			lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  		sock_orphan(sk);
>  		sk->sk_shutdown = SHUTDOWN_MASK;
>  
> @@ -659,7 +670,7 @@ static void __vsock_release(struct sock *sk)
>  
>  		/* Clean up any sockets that never were accepted. */
>  		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
> -			__vsock_release(pending);
> +			__vsock_release(pending, 2);
>  			sock_put(pending);
>  		}
>  
> @@ -708,7 +719,7 @@ EXPORT_SYMBOL_GPL(vsock_stream_has_space);
>  
>  static int vsock_release(struct socket *sock)
>  {
> -	__vsock_release(sock->sk);
> +	__vsock_release(sock->sk, 1);
>  	sock->sk = NULL;
>  	sock->state = SS_FREE;
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 261521d286d6..c443db7af8d4 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -559,7 +559,7 @@ static void hvs_release(struct vsock_sock *vsk)
>  	struct sock *sk = sk_vsock(vsk);
>  	bool remove_sock;
>  
> -	lock_sock(sk);
> +	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  	remove_sock = hvs_close_lock_held(vsk);
>  	release_sock(sk);
>  	if (remove_sock)
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 5bb70c692b1e..a666ef8fc54e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -820,7 +820,7 @@ void virtio_transport_release(struct vsock_sock *vsk)
>  	struct sock *sk = &vsk->sk;
>  	bool remove_sock = true;
>  
> -	lock_sock(sk);
> +	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>  	if (sk->sk_type == SOCK_STREAM)
>  		remove_sock = virtio_transport_close(vsk);
>  

Thanks,
Stefano
