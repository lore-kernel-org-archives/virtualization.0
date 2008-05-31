From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] virtio: fix virtio_net xmit of freed skb bug
Date: Fri, 30 May 2008 22:12:40 -0400
Message-ID: <4840B418.5060607__3281.86607589505$1212200087$gmane$org@garzik.org>
References: <200805261742.43215.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805261742.43215.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> If we fail to transmit a packet, we assume the queue is full and put
> the skb into last_xmit_skb.  However, if more space frees up before we
> xmit it, we loop, and the result can be transmitting the same skb twice.
> 
> Fix is simple: set skb to NULL if we've used it in some way, and check
> before sending.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/net/virtio_net.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

applied 1-2 (#3 was already applied)
