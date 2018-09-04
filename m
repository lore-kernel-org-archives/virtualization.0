From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request
	definition
Date: Mon, 3 Sep 2018 22:22:37 -0400
Message-ID: <20180903222127-mutt-send-email-mst@kernel.org>
References: <20180903175906.GA11529@glebfm.cloud.tilaa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180903175906.GA11529@glebfm.cloud.tilaa.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 03, 2018 at 08:59:13PM +0300, Gleb Fotengauer-Malinovskiy wrote:
> The _IOC_READ flag fits this ioctl request more because this request
> actually only writes to, but doesn't read from userspace.
> See NOTEs in include/uapi/asm-generic/ioctl.h for more information.
> 
> Fixes: 429711aec282 ("vhost: switch to use new message format")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>

Hmm it does make sense, and it's not too late to fix this up.
Jason, what's your take on this? Was _IOW intentional?


> ---
>  include/uapi/linux/vhost.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b1e22c40c4b6..84c3de89696a 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -176,7 +176,7 @@ struct vhost_memory {
>  #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
>  
>  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
> -#define VHOST_GET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x26, __u64)
> +#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
>  
>  /* VHOST_NET specific defines */
>  
> 
> -- 
> glebfm
