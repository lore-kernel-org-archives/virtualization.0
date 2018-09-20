From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Date: Thu, 20 Sep 2018 08:32:01 +0200
Message-ID: <20180920063201.nt7kw555s4clshzr__15294.0099979334$1537425001$gmane$org@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
	<20180829122026.27012-3-kraxel@redhat.com>
	<CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
	<9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
	<20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
	<5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
	<20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
	<d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
	<20180919113807.6mwqxkdg6f55h6fg@sirius.home.kraxel.org>
	<bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <bb7b8676-cf39-3144-2de1-389f4b0a70b3@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiandi An <jiandi@amd.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, "Lendacky,
	Thomas" <Thomas.Lendacky@amd.com>, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>                                         uint32_t resource_id, uint64_t offset,
> ...
>      struct virtio_gpu_fbdev *vgfbdev = vgdev->vgfbdev;
>      struct virtio_gpu_framebuffer *fb = &vgfbdev->vgfb;
>      struct virtio_gpu_object *obj = gem_to_virtio_gpu_obj(fb->base.obj[0]);

Ah, right.  Should have noticed this on review.  You sync the fbcon
framebuffer unconfitionally ...

> Is there better way to get to the virtio_gpu_object created in the
> virtio_gpu_mode_dumb_create() path from virtio_gpu_device or somehow from drm_file
> via gem_handle down at the layer of virtio_gpu_cmd_transfer_to_host()?

Just pass it down, the call sites all know it (see patch just sent).

cheers,
  Gerd
