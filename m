From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/5] tcm_vhost: Introduce tcm_vhost_check_feature()
Date: Wed, 6 Mar 2013 10:06:20 +0100
Message-ID: <20130306090620.GA32480@stefanha-thinkpad.muc.redhat.com>
References: <1362550590-3534-1-git-send-email-asias@redhat.com>
	<1362550590-3534-3-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1362550590-3534-3-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 06, 2013 at 02:16:27PM +0800, Asias He wrote:
> This helper is useful to check if a feature is supported.
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>  drivers/vhost/tcm_vhost.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index b3e50d7..fdbf986 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -91,6 +91,20 @@ static int iov_num_pages(struct iovec *iov)
>  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
>  }
>  
> +static bool tcm_vhost_check_feature(struct vhost_scsi *vs, u64 feature)
> +{
> +	u64 acked_features;
> +	bool ret = false;
> +
> +	mutex_lock(&vs->dev.mutex);
> +	acked_features = vs->dev.acked_features;
> +	if (acked_features & 1ULL << feature)
> +		ret = true;
> +	mutex_unlock(&vs->dev.mutex);
> +
> +	return ret;
> +}

This is like vhost_has_feature() except it acquires dev.mutex?

In any case it isn't tcm_vhost-specific and could be in vhost.c.

Stefan
