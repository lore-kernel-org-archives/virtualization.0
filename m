From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 1/3] tcm_vhost: Introduce tcm_vhost_check_feature()
Date: Thu, 18 Apr 2013 10:06:06 +0300
Message-ID: <20130418070606.GC13787__36538.6418569416$1366272304$gmane$org@redhat.com>
References: <20130417131726.GA26157@redhat.com>
	<1366247154-3136-2-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1366247154-3136-2-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 18, 2013 at 09:05:52AM +0800, Asias He wrote:
> This helper is useful to check if a feature is supported.
> 
> Signed-off-by: Asias He <asias@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Why do we need the locking here by the way?
It seems features don't change while vhost
is running.

> ---
>  drivers/vhost/tcm_vhost.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 957a0b9..88ebb79 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -99,6 +99,18 @@ static int iov_num_pages(struct iovec *iov)
>  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
>  }
>  
> +static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
> +{
> +	bool ret = false;
> +
> +	mutex_lock(&vs->dev.mutex);
> +	if (vhost_has_feature(&vs->dev, feature))
> +		ret = true;
> +	mutex_unlock(&vs->dev.mutex);
> +
> +	return ret;
> +}
> +
>  static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
>  {
>  	return 1;
> -- 
> 1.8.1.4
