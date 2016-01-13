From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] uapi: use __u8 from linux/types.h
Date: Wed, 13 Jan 2016 18:25:53 +0200
Message-ID: <20160113182546-mutt-send-email-mst__29746.3835486726$1452702376$gmane$org@redhat.com>
References: <20160113160958.GA29108@glebfm.cloud.tilaa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160113160958.GA29108@glebfm.cloud.tilaa.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: David Airlie <airlied@linux.ie>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 13, 2016 at 07:10:15PM +0300, Gleb Fotengauer-Malinovskiy wrote:
> Kernel headers should use linux/types.h based definitions.
> 
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/uapi/linux/virtio_gpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index 7a63faa..4b04ead 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -287,7 +287,7 @@ struct virtio_gpu_get_capset {
>  /* VIRTIO_GPU_RESP_OK_CAPSET */
>  struct virtio_gpu_resp_capset {
>  	struct virtio_gpu_ctrl_hdr hdr;
> -	uint8_t capset_data[];
> +	__u8 capset_data[];
>  };
>  
>  #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
> -- 
> glebfm
