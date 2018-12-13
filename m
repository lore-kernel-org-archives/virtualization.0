From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: correct the related warning message
Date: Wed, 12 Dec 2018 21:03:01 -0500
Message-ID: <20181212210254-mutt-send-email-mst__43463.5114077993$1544666462$gmane$org@kernel.org>
References: <5C11B176.4040704@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5C11B176.4040704@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wangyan <wangyan122@huawei.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, piaojun <piaojun@huawei.com>, viro@zeniv.linux.org.uk, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 09:10:14AM +0800, wangyan wrote:
> Fixes: 'commit d588cf8f618d ("target: Fix se_tpg_tfo->tf_subsys regression + remove tf_subsystem")'
>        'commit cbbd26b8b1a6 ("[iov_iter] new primitives - copy_from_iter_full() and friends")'
> 
> Signed-off-by: Yan Wang <wangyan122@huawei.com>
> Reviewed-by: Jun Piao <piaojun@huawei.com>

Applied, thanks!

> ---
>  drivers/vhost/scsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 50dffe8..b459b69 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -889,7 +889,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
>  
>  	if (unlikely(!copy_from_iter_full(vc->req, vc->req_size,
>  					  &vc->out_iter))) {
> -		vq_err(vq, "Faulted on copy_from_iter\n");
> +		vq_err(vq, "Faulted on copy_from_iter_full\n");
>  	} else if (unlikely(*vc->lunp != 1)) {
>  		/* virtio-scsi spec requires byte 0 of the lun to be 1 */
>  		vq_err(vq, "Illegal virtio-scsi lun: %u\n", *vc->lunp);
> @@ -1441,7 +1441,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
>  			se_tpg = &tpg->se_tpg;
>  			ret = target_depend_item(&se_tpg->tpg_group.cg_item);
>  			if (ret) {
> -				pr_warn("configfs_depend_item() failed: %d\n", ret);
> +				pr_warn("target_depend_item() failed: %d\n", ret);
>  				kfree(vs_tpg);
>  				mutex_unlock(&tpg->tv_tpg_mutex);
>  				goto out;
> -- 
> 1.8.3.1
> 
