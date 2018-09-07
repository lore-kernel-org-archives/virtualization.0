From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH -next] drm/virtio: Remove set but not used variable 'bo'
Date: Fri, 7 Sep 2018 09:34:02 +0200
Message-ID: <20180907073402.2h37cmvc4i5dz3uz__31724.3372709074$1536305526$gmane$org@sirius.home.kraxel.org>
References: <1536285837-150460-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1536285837-150460-1-git-send-email-yuehaibing@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 07, 2018 at 02:03:57AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/virtio/virtgpu_display.c: In function 'virtio_gpu_framebuffer_init':
> drivers/gpu/drm/virtio/virtgpu_display.c:78:28: warning:
>  variable 'bo' set but not used [-Wunused-but-set-variable]
>   struct virtio_gpu_object *bo;
>                             ^

Patch queued.

thanks,
  Gerd
