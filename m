From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: remove duplicated include from
	virtio_net.c
Date: Mon, 13 Aug 2018 12:42:57 +0300
Message-ID: <20180813124251-mutt-send-email-mst@kernel.org>
References: <20180813061315.9084-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180813061315.9084-1-yuehaibing@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 13, 2018 at 02:13:15PM +0800, YueHaibing wrote:
> Remove duplicated include linux/netdevice.h
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index eb00ae6..7659209 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -30,7 +30,6 @@
>  #include <linux/cpu.h>
>  #include <linux/average.h>
>  #include <linux/filter.h>
> -#include <linux/netdevice.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <net/route.h>
> -- 
> 2.7.0
> 
