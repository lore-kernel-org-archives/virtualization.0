From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH v2 3/3] tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
Date: Tue, 29 Jan 2013 10:53:33 -0800
Message-ID: <1359485613.23290.1389.camel@haakon2.linux-iscsi.org>
References: <1358824827-16169-1-git-send-email-asias@redhat.com>
	<1358824827-16169-4-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358824827-16169-4-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-01-22 at 11:20 +0800, Asias He wrote:
> We can get all the pages in one time instead of calling
> gup N times.
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---

Everything looks fine after initial testing, so also applied to
target-pending/for-next.

Nice optimization.  :)

--nab

>  drivers/vhost/tcm_vhost.c | 54 ++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 796a6b0..c994f00 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -430,40 +430,47 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
>   * Returns the number of scatterlist entries used or -errno on error.
>   */
>  static int vhost_scsi_map_to_sgl(struct scatterlist *sgl,
> -	unsigned int sgl_count, void __user *ptr, size_t len, int write)
> +	unsigned int sgl_count, struct iovec *iov, int write)
>  {
> +	unsigned int npages = 0, pages_nr, offset, nbytes;
>  	struct scatterlist *sg = sgl;
> -	unsigned int npages = 0;
> -	int ret;
> +	void __user *ptr = iov->iov_base;
> +	size_t len = iov->iov_len;
> +	struct page **pages;
> +	int ret, i;
>  
> -	while (len > 0) {
> -		struct page *page;
> -		unsigned int offset = (uintptr_t)ptr & ~PAGE_MASK;
> -		unsigned int nbytes = min_t(unsigned int,
> -				PAGE_SIZE - offset, len);
> +	pages_nr = iov_num_pages(iov);
> +	if (pages_nr > sgl_count)
> +		return -ENOBUFS;
>  
> -		if (npages == sgl_count) {
> -			ret = -ENOBUFS;
> -			goto err;
> -		}
> +	pages = kmalloc(pages_nr * sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
>  
> -		ret = get_user_pages_fast((unsigned long)ptr, 1, write, &page);
> -		BUG_ON(ret == 0); /* we should either get our page or fail */
> -		if (ret < 0)
> -			goto err;
> +	ret = get_user_pages_fast((unsigned long)ptr, pages_nr, write, pages);
> +	/* No pages were pinned */
> +	if (ret < 0)
> +		goto out;
> +	/* Less pages pinned than wanted */
> +	if (ret != pages_nr) {
> +		for (i = 0; i < ret; i++)
> +			put_page(pages[i]);
> +		ret = -EFAULT;
> +		goto out;
> +	}
>  
> -		sg_set_page(sg, page, nbytes, offset);
> +	while (len > 0) {
> +		offset = (uintptr_t)ptr & ~PAGE_MASK;
> +		nbytes = min_t(unsigned int, PAGE_SIZE - offset, len);
> +		sg_set_page(sg, pages[npages], nbytes, offset);
>  		ptr += nbytes;
>  		len -= nbytes;
>  		sg++;
>  		npages++;
>  	}
> -	return npages;
>  
> -err:
> -	/* Put pages that we hold */
> -	for (sg = sgl; sg != &sgl[npages]; sg++)
> -		put_page(sg_page(sg));
> +out:
> +	kfree(pages);
>  	return ret;
>  }
>  
> @@ -496,8 +503,7 @@ static int vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
>  
>  	pr_debug("Mapping %u iovecs for %u pages\n", niov, sgl_count);
>  	for (i = 0; i < niov; i++) {
> -		ret = vhost_scsi_map_to_sgl(sg, sgl_count, iov[i].iov_base,
> -					iov[i].iov_len, write);
> +		ret = vhost_scsi_map_to_sgl(sg, sgl_count, &iov[i], write);
>  		if (ret < 0) {
>  			for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
>  				put_page(sg_page(&tv_cmd->tvc_sgl[i]));
