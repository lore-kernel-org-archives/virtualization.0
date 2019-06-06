From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/4] drm/virtio: Add memory barriers for capset cache.
Date: Thu, 6 Jun 2019 09:41:22 +0200
Message-ID: <20190606074122.csocqu6g3in7dgbj__28442.8975124442$1559806893$gmane$org@sirius.home.kraxel.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
	<20190605234423.11348-4-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190605234423.11348-4-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: davidriley@chromium.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 05, 2019 at 04:44:23PM -0700, davidriley@chromium.org wrote:
> From: David Riley <davidriley@chromium.org>
> 
> After data is copied to the cache entry, atomic_set is used indicate
> that the data is the entry is valid without appropriate memory barriers.
> Similarly the read side was missing the same memory barries.
> 
> Signed-off-by: David Riley <davidriley@chromium.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 88c1ed57a3c5..502f5f7c2298 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -542,6 +542,9 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
>  	if (!ret)
>  		return -EBUSY;
>  
> +	/* is_valid check must proceed before copy of the cache entry. */
> +	virt_rmb();

I don't think you need virt_rmb() here.  This isn't guest <=> host
communication, so a normal barrier should do.

The other three fixes are queued up for drm-misc-next.

cheers,
  Gerd
