From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3] virtio_vsock: Fix race condition in
 virtio_transport_recv_pkt
Date: Sat, 30 May 2020 17:44:45 -0700 (PDT)
Message-ID: <20200530.174445.526346281814829960.davem@davemloft.net>
References: <20200530013828.59668-1-justin.he@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200530013828.59668-1-justin.he@arm.com>
Sender: netdev-owner@vger.kernel.org
To: justin.he@arm.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kaly.Xin@arm.com, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jia He <justin.he@arm.com>
Date: Sat, 30 May 2020 09:38:28 +0800

> When client on the host tries to connect(SOCK_STREAM, O_NONBLOCK) to the
> server on the guest, there will be a panic on a ThunderX2 (armv8a server):
 ...
> The race condition is as follows:
> Task1                                Task2
> =====                                =====
> __sock_release                       virtio_transport_recv_pkt
>   __vsock_release                      vsock_find_bound_socket (found sk)
>     lock_sock_nested
>     vsock_remove_sock
>     sock_orphan
>       sk_set_socket(sk, NULL)
>     sk->sk_shutdown = SHUTDOWN_MASK
>     ...
>     release_sock
>                                     lock_sock
>                                        virtio_transport_recv_connecting
>                                          sk->sk_socket->state (panic!)
> 
> The root cause is that vsock_find_bound_socket can't hold the lock_sock,
> so there is a small race window between vsock_find_bound_socket() and
> lock_sock(). If __vsock_release() is running in another task,
> sk->sk_socket will be set to NULL inadvertently.
> 
> This fixes it by checking sk->sk_shutdown(suggested by Stefano) after
> lock_sock since sk->sk_shutdown is set to SHUTDOWN_MASK under the
> protection of lock_sock_nested.
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Applied and queued up for -stable, thank you.
