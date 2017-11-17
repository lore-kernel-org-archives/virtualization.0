From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virto_net: remove empty file 'virtio_net.'
Date: Fri, 17 Nov 2017 06:15:18 +0200
Message-ID: <20171117061508-mutt-send-email-mst@kernel.org>
References: <20171117024636.15515-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171117024636.15515-1-joel@jms.id.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joel Stanley <joel@jms.id.au>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 17, 2017 at 01:16:36PM +1030, Joel Stanley wrote:
> Looks like this was mistakenly added to the tree as part of
> commit 186b3c998c50 ("virtio-net: support XDP_REDIRECT").
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net. | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 drivers/net/virtio_net.
> 
> diff --git a/drivers/net/virtio_net. b/drivers/net/virtio_net.
> deleted file mode 100644
> index e69de29bb2d1..000000000000
> -- 
> 2.14.1
