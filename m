From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH -next] vhost-blk: remove unused variable
Date: Mon, 11 Mar 2013 16:44:55 +0200
Message-ID: <20130311144455.GA27441__37044.3287575201$1363013107$gmane$org@redhat.com>
References: <CAPgLHd-eRBB2xCP7-ZswjfEKXPY29G1Nv71DzGo_-=TVym8MNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-eRBB2xCP7-ZswjfEKXPY29G1Nv71DzGo_-=TVym8MNQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: netdev@vger.kernel.org, yongjun_wei@trendmicro.com.cn, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 11, 2013 at 10:39:27PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The variable vq is initialized but never used
> otherwise, so remove the unused variable.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Which branch does this target?

> ---
>  drivers/vhost/blk.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/vhost/blk.c b/drivers/vhost/blk.c
> index 658c5f9..d9b245b 100644
> --- a/drivers/vhost/blk.c
> +++ b/drivers/vhost/blk.c
> @@ -419,8 +419,6 @@ static void vhost_blk_handle_guest_kick(struct vhost_work *work)
>  /* Host kick us for I/O completion */
>  static void vhost_blk_handle_host_kick(struct vhost_work *work)
>  {
> -
> -	struct vhost_virtqueue *vq;
>  	struct vhost_blk_req *req;
>  	struct llist_node *llnode;
>  	struct vhost_blk *blk;
> @@ -429,7 +427,6 @@ static void vhost_blk_handle_host_kick(struct vhost_work *work)
>  	int ret;
>  
>  	blk = container_of(work, struct vhost_blk, work);
> -	vq = &blk->vq;
>  
>  	llnode = llist_del_all(&blk->llhead);
>  	added = false;
