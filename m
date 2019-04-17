From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Date: Wed, 17 Apr 2019 11:57:50 +0200
Message-ID: <20190417095750.lre3xrg4dlgskfjg__26247.9792394274$1555495087$gmane$org@sirius.home.kraxel.org>
References: <20190410114227.25846-1-kraxel@redhat.com>
	<20190410114227.25846-4-kraxel@redhat.com>
	<CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
	<20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
	<CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
	<20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org>
	<CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: virtio@lists.oasis-open.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@redhat.com>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 12, 2019 at 04:34:20PM -0700, Chia-I Wu wrote:
> Hi,
> 
> I am still new to virgl, and missed the last round of discussion about
> resource_create_v2.
> 
> From the discussion below, semantically resource_create_v2 creates a host
> resource object _without_ any storage; memory_create creates a host memory
> object which provides the storage.  Is that correct?

Right now all resource_create_* variants create a resource object with
host storage.  memory_create creates guest storage, and
resource_attach_memory binds things together.  Then you have to transfer
the data.

Hmm, maybe we need a flag indicating that host storage is not needed,
for resources where we want establish some kind of shared mapping later
on.

> Do we expect these new commands to be supported by OpenGL, which does not
> separate resources and memories?

Well, for opengl you need a 1:1 relationship between memory region and
resource.

> > Yes, even though it is not clear yet how we are going to handle
> > host-allocated buffers in the vhost-user case ...
> 
> This might be another dumb question, but is this only an issue for
> vhost-user(-gpu) case?  What mechanisms are used to map host dma-buf into
> the guest address space?

qemu can change the address space, that includes mmap()ing stuff there.
An external vhost-user process can't do this, it can only read the
address space layout, and read/write from/to guest memory.

> But one needs to create the resource first to know which memory types can
> be attached to it.  I think the metadata needs to be returned with
> resource_create_v2.

There is a resource_info reply for that.

> That should be good enough.  But by returning alignments, we can minimize
> the gaps when attaching multiple resources, especially when the resources
> are only used by GPU.

We can add alignments to the resource_info reply.

cheers,
  Gerd
