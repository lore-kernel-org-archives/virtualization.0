From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] driver, virtio: Modify the err hanlding logic
Date: Wed, 27 Apr 2011 14:34:44 +0930
Message-ID: <87liywl1xv.fsf__35538.365544244$1303892636$gmane$org@rustcorp.com.au>
References: <1303305719-4475-1-git-send-email-namei.unix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1303305719-4475-1-git-send-email-namei.unix@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liu Yuan <namei.unix@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Apr 2011 21:21:59 +0800, Liu Yuan <namei.unix@gmail.com> wrote:
> From: Liu Yuan <tailai.ly@taobao.com>
> 
> In the function vp_request_msix_vectors(), when
> pci_enable_msix() returns 0, there will be
> redundant double checks for 'err'. This patch
> fixes it to avoid the unnecessary check.
> 
> Signed-off-by: Liu Yuan <tailai.ly@taobao.com>
> ---
>  drivers/virtio/virtio_pci.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 4fb5b2b..2c05376 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -298,10 +298,11 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  
>  	/* pci_enable_msix returns positive if we can't get this many. */
>  	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
> -	if (err > 0)
> -		err = -ENOSPC;
> -	if (err)
> +	if (err) {
> +		if (err > 0)
> +			err = -ENOSPC;
>  		goto error;
> +	}
>  	vp_dev->msix_vectors = nvectors;
>  	vp_dev->msix_enabled = 1;

This patch is extremely marginal.  It theoretically improves efficiency,
but it's in a case we don't care about.  The code is quite clear.

My general policy for such marginal improvements is to only accept them
from the maintainer him/herself, so I won't be taking this patch.

Of course, if you produce a series of fixes to the driver with such a
patch as a cleaner, I'm lazy enough that I'd take them all at once :)

Thanks,
Rusty.
