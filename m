From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next] vhost_net: disable zerocopy by default
Date: Mon, 17 Jun 2019 10:43:12 -0400
Message-ID: <20190617104301-mutt-send-email-mst__36509.9408126966$1560782605$gmane$org@kernel.org>
References: <20190617092054.12299-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190617092054.12299-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, huhai@kylinos.cn, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 17, 2019 at 05:20:54AM -0400, Jason Wang wrote:
> Vhost_net was known to suffer from HOL[1] issues which is not easy to
> fix. Several downstream disable the feature by default. What's more,
> the datapath was split and datacopy path got the support of batching
> and XDP support recently which makes it faster than zerocopy part for
> small packets transmission.
> 
> It looks to me that disable zerocopy by default is more
> appropriate. It cold be enabled by default again in the future if we
> fix the above issues.
> 
> [1] https://patchwork.kernel.org/patch/3787671/
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 2d9df786a9d3..21e0805e5e60 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -36,7 +36,7 @@
>  
>  #include "vhost.h"
>  
> -static int experimental_zcopytx = 1;
> +static int experimental_zcopytx = 0;
>  module_param(experimental_zcopytx, int, 0444);
>  MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
>  		                       " 1 -Enable; 0 - Disable");
> -- 
> 2.18.1
