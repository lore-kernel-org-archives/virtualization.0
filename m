From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vsock/virtio: fix sock refcnt holding during the shutdown
Date: Fri, 08 Nov 2019 12:19:46 -0800 (PST)
Message-ID: <20191108.121946.1084660860645163442.davem@davemloft.net>
References: <20191108160850.51278-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191108160850.51278-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sgarzare@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri,  8 Nov 2019 17:08:50 +0100

> The "42f5cda5eaf4" commit rightly set SOCK_DONE on peer shutdown,
> but there is an issue if we receive the SHUTDOWN(RDWR) while the
> virtio_transport_close_timeout() is scheduled.
> In this case, when the timeout fires, the SOCK_DONE is already
> set and the virtio_transport_close_timeout() will not call
> virtio_transport_reset() and virtio_transport_do_close().
> This causes that both sockets remain open and will never be released,
> preventing the unloading of [virtio|vhost]_transport modules.
> 
> This patch fixes this issue, calling virtio_transport_reset() and
> virtio_transport_do_close() when we receive the SHUTDOWN(RDWR)
> and there is nothing left to read.
> 
> Fixes: 42f5cda5eaf4 ("vsock/virtio: set SOCK_DONE on peer shutdown")
> Cc: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Applied and queued up for -stable, thanks.
