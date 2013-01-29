From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH v2 2/3] tcm_vhost: Use iov_num_pages to calculate sgl_count
Date: Tue, 29 Jan 2013 10:52:26 -0800
Message-ID: <1359485546.23290.1386.camel@haakon2.linux-iscsi.org>
References: <1358824827-16169-1-git-send-email-asias@redhat.com>
	<1358824827-16169-3-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358824827-16169-3-git-send-email-asias@redhat.com>
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
> Signed-off-by: Asias He <asias@redhat.com>
> ---

Applied to target-pending/for-next.

Thanks!

--nab

>  drivers/vhost/tcm_vhost.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index ca35c16..796a6b0 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -479,11 +479,9 @@ static int vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
>  	 * Find out how long sglist needs to be
>  	 */
>  	sgl_count = 0;
> -	for (i = 0; i < niov; i++) {
> -		sgl_count += (((uintptr_t)iov[i].iov_base + iov[i].iov_len +
> -				PAGE_SIZE - 1) >> PAGE_SHIFT) -
> -				((uintptr_t)iov[i].iov_base >> PAGE_SHIFT);
> -	}
> +	for (i = 0; i < niov; i++)
> +		sgl_count += iov_num_pages(&iov[i]);
> +
>  	/* TODO overflow checking */
>  
>  	sg = kmalloc(sizeof(tv_cmd->tvc_sgl[0]) * sgl_count, GFP_ATOMIC);
