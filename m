From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] vhost: remove the possible fruitless search on iotlb
	prefetch
Date: Mon, 21 Aug 2017 22:45:58 +0300
Message-ID: <20170821223039-mutt-send-email-mst__20286.4867671908$1503344830$gmane$org@kernel.org>
References: <20170819064114.27219-1-den@klaipeden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170819064114.27219-1-den@klaipeden.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Koichiro Den <den@klaipeden.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 19, 2017 at 03:41:14PM +0900, Koichiro Den wrote:
> Signed-off-by: Koichiro Den <den@klaipeden.com>
> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index e4613a3c362d..93e909afc1c3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1184,7 +1184,7 @@ static int iotlb_access_ok(struct vhost_virtqueue *vq,
>  	while (len > s) {
>  		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
>  							   addr,
> -							   addr + len - 1);
> +							   addr + len - s - 1);
>  		if (node == NULL || node->start > addr) {
>  			vhost_iotlb_miss(vq, addr, access);
>  			return false;

This works but it probably makes sense to just refactor the code to make end of
range a variable. I posted a patch like this, pls take a look.

> -- 
> 2.9.4
> 
