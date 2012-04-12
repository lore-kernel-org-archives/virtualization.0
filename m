From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] virtio_balloon: Fix endian bug
Date: Thu, 12 Apr 2012 11:30:50 +0300
Message-ID: <20120412083049.GA13053@redhat.com>
References: <1334208995-29985-1-git-send-email-david@gibson.dropbear.id.au>
	<1334208995-29985-3-git-send-email-david@gibson.dropbear.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1334208995-29985-3-git-send-email-david@gibson.dropbear.id.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, paulus@samba.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 12, 2012 at 03:36:34PM +1000, David Gibson wrote:
> Although virtio config space fields are usually in guest-native endian,
> the spec for the virtio balloon device explicitly states that both fields
> in its config space are little-endian.
> 
> However, the current virtio_balloon driver does not have a suitable endian
> swap for the 'num_pages' field, although it does have one for the 'actual'
> field.  This patch corrects the bug, adding sparse annotation while we're
> at it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Indeed. And qemu byte-swaps according to the spec, too.
Applied for 3.4, thanks.

> ---
>  drivers/virtio/virtio_balloon.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 6c07793..553cc1f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -238,11 +238,14 @@ static void virtballoon_changed(struct virtio_device *vdev)
>  
>  static inline s64 towards_target(struct virtio_balloon *vb)
>  {
> -	u32 v;
> +	__le32 v;
> +	s64 target;
> +
>  	vb->vdev->config->get(vb->vdev,
>  			      offsetof(struct virtio_balloon_config, num_pages),
>  			      &v, sizeof(v));
> -	return (s64)v - vb->num_pages;
> +	target = le32_to_cpu(v);
> +	return target - vb->num_pages;
>  }
>  
>  static void update_balloon_size(struct virtio_balloon *vb)
> -- 
> 1.7.9.5
