From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Date: Fri, 12 Apr 2019 07:49:24 +0200
Message-ID: <20190412054924.dvh6bfxfrbgvezxr__38817.2775086545$1555048181$gmane$org@sirius.home.kraxel.org>
References: <20190410114227.25846-1-kraxel@redhat.com>
	<20190410114227.25846-4-kraxel@redhat.com>
	<CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
	<20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
	<CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, David Airlie <airlied@redhat.com>, virtio@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 11, 2019 at 06:36:15PM -0700, Gurchetan Singh wrote:
> On Wed, Apr 10, 2019 at 10:03 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > > > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
> > > > +struct virtio_gpu_cmd_resource_create_v2 {
> > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > +       __le32 resource_id;
> > > > +       __le32 format;
> > > > +       __le32 width;
> > > > +       __le32 height;
> > > > +       /* 3d only */
> > > > +       __le32 target;
> > > > +       __le32 bind;
> > > > +       __le32 depth;
> > > > +       __le32 array_size;
> > > > +       __le32 last_level;
> > > > +       __le32 nr_samples;
> > > > +       __le32 flags;
> > > > +};
> > >
> > >
> > > I assume this is always backed by some host side allocation, without any
> > > guest side pages associated with it?
> >
> > No.  It is not backed at all yet.  Workflow would be like this:
> >
> >   (1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2
> >   (2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)
> >   (3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch 2)
> 
> Thanks for the clarification.
> 
> >
> > You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CREATE,
> > then go attach multiple resources to it.
> >
> > > If so, do we want the option for the guest allocate?
> >
> > Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE
> > (initially guest allocated only, i.e. what virtio-gpu supports today,
> > the plan is to add other allocation types later on).
> 
> You want to cover Vulkan, host-allocated dma-bufs, and guest-allocated
> dma-bufs with this, correct?  Let me know if it's a non-goal :-)

Yes, even though it is not clear yet how we are going to handle
host-allocated buffers in the vhost-user case ...
 
> If so, we might want to distinguish between memory types (kind of like
> memoryTypeIndex in Vulkan). [Assuming memory_id is like resource_id]

For the host-allocated buffers we surely want that, yes.
For guest-allocated memory regions it isn't useful I think ...

> 1) Vulkan seems the most straightforward
> 
> virtio_gpu_cmd_memory_create --> create kernel data structure,
> vkAllocateMemory on the host or import guest memory into Vulkan,
> depending on the memory type
> virtio_gpu_cmd_resource_create_v2 -->  vkCreateImage +
> vkGetImageMemoryRequirements on host
> virtio_gpu_cmd_resource_attach_memory -->  vkBindImageMemory on host

Yes.

Note 1: virtio_gpu_cmd_memory_create + virtio_gpu_cmd_resource_create_v2
ordering doesn't matter, so you can virtio_gpu_cmd_resource_create_v2
first to figure stride and size, then adjust memory size accordingly.

Note 2: The old virtio_gpu_cmd_resource_create variants can be used
too if you don't need the _v2 features.

Note 3: If I understand things correctly it would be valid to create a
memory pool (allocate one big chunk of memory) with vkAllocateMemory,
then bind multiple images at different offsets to it.

> 2) With a guest allocated dma-buf using some new allocation library,
> 
> virtio_gpu_cmd_resource_create_v2 --> host returns metadata describing
> optimal allocation
> virtio_gpu_cmd_memory_create --> allocate guest memory pages since
> it's guest memory type
> virtio_gpu_cmd_resource_attach_memory --> associate guest pages with
> resource in kernel, send iovecs to host for bookkeeping

virtio_gpu_cmd_memory_create sends the iovecs.  Otherwise correct.

> 3) With gbm it's a little trickier,
> 
> virtio_gpu_cmd_resource_create_v2 --> gbm_bo_create_with_modifiers,
> get metadata in return

Only get metadata in return.

> virtio_gpu_cmd_memory_create --> create kernel data structure, but
> don't allocate pages, nothing on the host

Memory allocation happens here.  Probably makes sense to have a
virtio_gpu_cmd_memory_create_host command here, because the parameters
we need are quite different from the guest-allocated case.

Maybe we even need a virtio_gpu_cmd_memory_create_host_for_resource
variant, given that gbm doesn't have raw memory buffers without any
format attached to it.

> > > > +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
> > > > +struct virtio_gpu_resp_resource_info {
> > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > +       __le32 stride[4];
> > > > +       __le32 size[4];
> > > > +};
> > >
> > > offsets[4] needed too
> >
> > That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...
> 
> I assume the offsets aren't returned by
> VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH.

Yes, they are send by the guest.

> How does the guest know at which offsets in memory will be compatible
> to share with display, camera, etc?

Is is good enough to align offsets to page boundaries?

> Also, do you want to cover the case where the resource is backed by
> three separate memory regions (VK_IMAGE_CREATE_DISJOINT_BIT)?

Good point.  I guess we should make memory_id in
virtio_gpu_cmd_resource_attach_memory an array then,
so you can specify a different memory region for each plane.

cheers,
  Gerd
