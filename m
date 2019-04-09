From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vhost: reject zero size iova range
Date: Tue, 9 Apr 2019 08:50:54 -0400
Message-ID: <20190409085041-mutt-send-email-mst__14490.5405862787$1554814273$gmane$org@kernel.org>
References: <20190409041025.20922-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190409041025.20922-1-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 09, 2019 at 12:10:25PM +0800, Jason Wang wrote:
> We used to accept zero size iova range which will lead a infinite loop
> in translate_desc(). Fixing this by failing the request in this case.
> 
> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Seems appropriate for stable.

> ---
>  drivers/vhost/vhost.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5ace833de746..351af88231ad 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -911,8 +911,12 @@ static int vhost_new_umem_range(struct vhost_umem *umem,
>  				u64 start, u64 size, u64 end,
>  				u64 userspace_addr, int perm)
>  {
> -	struct vhost_umem_node *tmp, *node = kmalloc(sizeof(*node), GFP_ATOMIC);
> +	struct vhost_umem_node *tmp, *node;
>  
> +	if (!size)
> +		return -EFAULT;
> +
> +	node = kmalloc(sizeof(*node), GFP_ATOMIC);
>  	if (!node)
>  		return -ENOMEM;
>  
> -- 
> 2.19.1
