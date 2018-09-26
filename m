From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/3] virtio: add vmap support for prime objects
Date: Wed, 26 Sep 2018 08:07:07 +0200
Message-ID: <20180926060707.2frz3wjvlz2zaozn__30091.3883060732$1537941909$gmane$org@sirius.home.kraxel.org>
References: <20180925161606.17980-1-ezequiel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180925161606.17980-1-ezequiel@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> Having the support for vmapping dmabuf's is required to share
> dmabufs to drivers that want CPU access. This is the case of
> a vivid to virtio-gpu pipeline, where the virtio-gpu driver
> exports dmabufs to the video4linux vivid driver.
> 
> The first patch adds virtio_gpu_object_kunmap() and calls
> it from the TTM object destroy path. This function will be
> used to unmap prime objects.
> 
> The second patch reworks virtio_gpu_object_kmap(), so it's
> balanced with virtio_gpu_object_kunmap.
> 
> Finally, the third patch uses virtio_gpu_object_k{map,unmap}
> to support prime v{map,unmap}.
> 
> Please review!

Pushed to drm-misc-next.

thanks,
  Gerd
