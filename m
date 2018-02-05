From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Date: Mon, 5 Feb 2018 13:20:17 +0100
Message-ID: <20180205122017.4vb5nlpodkq2uhxa__48756.6734002486$1517833139$gmane$org@sirius.home.kraxel.org>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
	<20180126135803.29781-2-tomeu.vizoso@collabora.com>
	<20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
	<49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Zach Reizner <zachr@google.com>, kernel@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > Why not use virtio-vsock to run the wayland protocol? I don't like
> > the idea to duplicate something with very simliar functionality in
> > virtio-gpu.
> 
> The reason for abandoning that approach was the type of objects that
> could be shared via virtio-vsock would be extremely limited. Besides
> that being potentially confusing to users, it would mean from the
> implementation side that either virtio-vsock would gain a dependency on
> the drm subsystem, or an appropriate abstraction for shareable buffers
> would need to be added for little gain.

Well, no.  The idea is that virtio-vsock and virtio-gpu are used largely
as-is, without knowing about each other.  The guest wayland proxy which
does the buffer management talks to both devices.

> > If you have a guest proxy anyway using virtio-sock for the protocol
> > stream and virtio-gpu for buffer sharing (and some day 3d rendering
> > too) should work fine I think.
> 
> If I understand correctly your proposal, virtio-gpu would be used for
> creating buffers that could be shared across domains, but something
> equivalent to SCM_RIGHTS would still be needed in virtio-vsock?

Yes, the proxy would send a reference to the buffer over virtio-vsock.
I was more thinking about a struct specifying something like
"ressource-id 42 on virtio-gpu-pci device in slot 1:23.0" instead of
using SCM_RIGHTS.

> If the mechanics of passing presentation data were very complex, I think
> this approach would have more merit. But as you can see from the code,
> it isn't that bad.

Well, the devil is in the details.  If you have multiple connections you
don't want one being able to stall the others for example.  There are
reasons took quite a while to bring virtio-vsock to the state where it
is today.

> > What is the plan for the host side? I see basically two options. Either
> > implement the host wayland proxy directly in qemu. Or
> > implement it as separate process, which then needs some help from
> > qemu to get access to the buffers. The later would allow qemu running
> > independant from the desktop session.
> 
> Regarding synchronizing buffers, this will stop becoming needed in
> subsequent commits as all shared memory is allocated in the host and
> mapped to the guest via KVM_SET_USER_MEMORY_REGION.

--verbose please.  The qemu patches linked from the cover letter not
exactly helpful in understanding how all this is supposed to work.

> This is already the case for buffers passed from the compositor to the
> clients (see patch 2/2), and I'm working on the equivalent for buffers
> from the guest to the host (clients still have to create buffers with
> DRM_VIRTGPU_RESOURCE_CREATE but they will be only backend by host memory
> so no calls to DRM_VIRTGPU_TRANSFER_TO_HOST are needed).

Same here.  --verbose please.

cheers,
  Gerd
