From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] drm/virtio: move drm_connector_update_edid_property() call
Date: Wed, 26 Jun 2019 09:51:46 +0200
Message-ID: <20190626095146.2731a2dc.cohuck__9495.62450857542$1561535535$gmane$org@redhat.com>
References: <20190405044602.2334-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190405044602.2334-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, jcmvbkbc@gmail.com, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Fri,  5 Apr 2019 06:46:02 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> drm_connector_update_edid_property can sleep, we must not
> call it while holding a spinlock.  Move the callsize.

s/callsize/callsite/

> 
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index e62fe24b1a2e..5bb0f0a084e9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -619,11 +619,11 @@ static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
>  	output = vgdev->outputs + scanout;
>  
>  	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
> +	drm_connector_update_edid_property(&output->conn, new_edid);
>  
>  	spin_lock(&vgdev->display_info_lock);
>  	old_edid = output->edid;
>  	output->edid = new_edid;
> -	drm_connector_update_edid_property(&output->conn, output->edid);
>  	spin_unlock(&vgdev->display_info_lock);
>  
>  	kfree(old_edid);

This gets rid of the sleeping while atomic traces I've been seeing with
an s390x guest (both virtio-gpu-pci and virtio-gpu-ccw).

Tested-by: Cornelia Huck <cohuck@redhat.com>

I have also looked at the code a bit, but don't feel confident enough
to give an R-b.

Acked-by: Cornelia Huck <cohuck@redhat.com>
