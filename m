From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] tcm_vhost: Introduce tcm_vhost_check_endpoint()
Date: Tue, 12 Mar 2013 09:26:18 +0100
Message-ID: <513EE6AA.3030306@redhat.com>
References: <1363056171-5854-1-git-send-email-asias@redhat.com>
	<1363056171-5854-3-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363056171-5854-3-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 12/03/2013 03:42, Asias He ha scritto:
> This helper is useful to check if vs->vs_endpoint is setup by
> vhost_scsi_set_endpoint()
> 
> Signed-off-by: Asias He <asias@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/vhost/tcm_vhost.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index b3e50d7..29612bc 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -91,6 +91,18 @@ static int iov_num_pages(struct iovec *iov)
>  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
>  }
>  
> +static bool tcm_vhost_check_endpoint(struct vhost_scsi *vs)
> +{
> +	bool ret = false;
> +
> +	mutex_lock(&vs->dev.mutex);
> +	if (vs->vs_endpoint)
> +		ret = true;
> +	mutex_unlock(&vs->dev.mutex);

The return value is invalid as soon as mutex_unlock is called, i.e.
before tcm_vhost_check_endpoint returns.  Instead, check vs->vs_endpoint
in the caller while the mutex is taken.

Paolo

> +	return ret;
> +}
> +
>  static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
>  {
>  	return 1;
> 
