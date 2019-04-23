From: Gurchetan Singh <gurchetansingh@chromium.org>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Date: Mon, 22 Apr 2019 17:12:26 -0700
Message-ID: <CAAfnVBkmpQ5VcUtbiqsZQSv7bmejjOHj3MkG2Cjah9Q4DOTv-Q__26358.3741312445$1555978374$gmane$org@mail.gmail.com>
References: <20190410114227.25846-1-kraxel@redhat.com>
	<20190410114227.25846-4-kraxel@redhat.com>
	<CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
	<20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
	<CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
	<20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org>
	<CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ@mail.gmail.com>
	<20190417095750.lre3xrg4dlgskfjg@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190417095750.lre3xrg4dlgskfjg@sirius.home.kraxel.org>
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
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@redhat.com>, virtio@lists.oasis-open.org, Chia-I Wu <olvaffe@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 17, 2019 at 2:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Apr 12, 2019 at 04:34:20PM -0700, Chia-I Wu wrote:
> > Hi,
> >
> > I am still new to virgl, and missed the last round of discussion about
> > resource_create_v2.
> >
> > From the discussion below, semantically resource_create_v2 creates a host
> > resource object _without_ any storage; memory_create creates a host memory
> > object which provides the storage.  Is that correct?
>
> Right now all resource_create_* variants create a resource object with
> host storage.  memory_create creates guest storage, and
> resource_attach_memory binds things together.  Then you have to transfer
> the data.
>
> Hmm, maybe we need a flag indicating that host storage is not needed,
> for resources where we want establish some kind of shared mapping later
> on.
>
> > Do we expect these new commands to be supported by OpenGL, which does not
> > separate resources and memories?
>
> Well, for opengl you need a 1:1 relationship between memory region and
> resource.
>
> > > Yes, even though it is not clear yet how we are going to handle
> > > host-allocated buffers in the vhost-user case ...
> >
> > This might be another dumb question, but is this only an issue for
> > vhost-user(-gpu) case?  What mechanisms are used to map host dma-buf into
> > the guest address space?
>
> qemu can change the address space, that includes mmap()ing stuff there.
> An external vhost-user process can't do this, it can only read the
> address space layout, and read/write from/to guest memory.
>
> > But one needs to create the resource first to know which memory types can
> > be attached to it.  I think the metadata needs to be returned with
> > resource_create_v2.
>
> There is a resource_info reply for that.

The memory type should probably be in resource_create_v2, not in the
reply.  The metadata will be different based on the memory heap it's
allocated from.

Also, not all heaps need to be exposed to the guest kernel.  For
example, device local memory in Vulkan could be un-mappable.  In fact,
for resources that are not host visible we might be better off
sidestepping the kernel altogether and tracking allocation in guest
userspace.

Here is an example of memory types the guest kernel may be interested
in (based on i965):

Type 0 --> DEVICE_LOCAL_BIT | HOST_VISIBLE_BIT | HOST_COHERENT_BIT |
HOST_CACHED_BIT | RENDERER_ALLOCATED (Vulkan)
Type 1 --> HOST_VISIBLE_BIT | HOST_COHERENT_BIT | EXTERNAL_ALLOCATED
(gbm write combine)
Type 2 --> HOST_VISIBLE_BIT | HOST_COHERENT_BIT | GUEST_ALLOCATED
(guest allocated memory, which I assume is also write combine)
Type 3 --> HOST_VISIBLE_BIT | HOST_CACHED | EXTERNAL_ALLOCATED (gbm
cached memory)



>
> > That should be good enough.  But by returning alignments, we can minimize
> > the gaps when attaching multiple resources, especially when the resources
> > are only used by GPU.
>
> We can add alignments to the resource_info reply.
>
> cheers,
>   Gerd
>
