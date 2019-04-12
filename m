From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Date: Fri, 12 Apr 2019 16:34:20 -0700
Message-ID: <CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ__32493.0416930997$1555718213$gmane$org@mail.gmail.com>
References: <20190410114227.25846-1-kraxel@redhat.com>
	<20190410114227.25846-4-kraxel@redhat.com>
	<CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
	<20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
	<CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
	<20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3813039669284076910=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org>
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
Cc: virtio@lists.oasis-open.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@redhat.com>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============3813039669284076910==
Content-Type: multipart/alternative; boundary="0000000000009b3b7405865dbe7a"

--0000000000009b3b7405865dbe7a
Content-Type: text/plain; charset="UTF-8"

Hi,

I am still new to virgl, and missed the last round of discussion about
resource_create_v2.

From the discussion below, semantically resource_create_v2 creates a host
resource object _without_ any storage; memory_create creates a host memory
object which provides the storage.  Is that correct?

And this version of memory_create is probably the most special one among
its other potential variants, because it is the only(?) one who imports the
pre-allocated guest pages.

Do we expect these new commands to be supported by OpenGL, which does not
separate resources and memories?

On Thu, Apr 11, 2019 at 10:49 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Thu, Apr 11, 2019 at 06:36:15PM -0700, Gurchetan Singh wrote:
> > On Wed, Apr 10, 2019 at 10:03 PM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
> > >
> > > > > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
> > > > > +struct virtio_gpu_cmd_resource_create_v2 {
> > > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > > +       __le32 resource_id;
> > > > > +       __le32 format;
> > > > > +       __le32 width;
> > > > > +       __le32 height;
> > > > > +       /* 3d only */
> > > > > +       __le32 target;
> > > > > +       __le32 bind;
> > > > > +       __le32 depth;
> > > > > +       __le32 array_size;
> > > > > +       __le32 last_level;
> > > > > +       __le32 nr_samples;
> > > > > +       __le32 flags;
> > > > > +};
> > > >
> > > >
> > > > I assume this is always backed by some host side allocation, without
> any
> > > > guest side pages associated with it?
> > >
> > > No.  It is not backed at all yet.  Workflow would be like this:
> > >
> > >   (1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2
> > >   (2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)
> > >   (3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch 2)
> >
> > Thanks for the clarification.
> >
> > >
> > > You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CREATE,
> > > then go attach multiple resources to it.
> > >
> > > > If so, do we want the option for the guest allocate?
> > >
> > > Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE
> > > (initially guest allocated only, i.e. what virtio-gpu supports today,
> > > the plan is to add other allocation types later on).
> >
> > You want to cover Vulkan, host-allocated dma-bufs, and guest-allocated
> > dma-bufs with this, correct?  Let me know if it's a non-goal :-)
>
> Yes, even though it is not clear yet how we are going to handle
> host-allocated buffers in the vhost-user case ...

This might be another dumb question, but is this only an issue for
vhost-user(-gpu) case?  What mechanisms are used to map host dma-buf into
the guest address space?



>
> > If so, we might want to distinguish between memory types (kind of like
> > memoryTypeIndex in Vulkan). [Assuming memory_id is like resource_id]
>
> For the host-allocated buffers we surely want that, yes.
> For guest-allocated memory regions it isn't useful I think ...
>
Guest-allocated memory regions can be just another memory type.

But one needs to create the resource first to know which memory types can
be attached to it.  I think the metadata needs to be returned with
resource_create_v2.

>
> > 1) Vulkan seems the most straightforward
> >
> > virtio_gpu_cmd_memory_create --> create kernel data structure,
> > vkAllocateMemory on the host or import guest memory into Vulkan,
> > depending on the memory type
> > virtio_gpu_cmd_resource_create_v2 -->  vkCreateImage +
> > vkGetImageMemoryRequirements on host
> > virtio_gpu_cmd_resource_attach_memory -->  vkBindImageMemory on host
>
> Yes.
>
> Note 1: virtio_gpu_cmd_memory_create + virtio_gpu_cmd_resource_create_v2
> ordering doesn't matter, so you can virtio_gpu_cmd_resource_create_v2
> first to figure stride and size, then adjust memory size accordingly.
>
> Note 2: The old virtio_gpu_cmd_resource_create variants can be used
> too if you don't need the _v2 features.
>
> Note 3: If I understand things correctly it would be valid to create a
> memory pool (allocate one big chunk of memory) with vkAllocateMemory,
> then bind multiple images at different offsets to it.
>
> > 2) With a guest allocated dma-buf using some new allocation library,
> >
> > virtio_gpu_cmd_resource_create_v2 --> host returns metadata describing
> > optimal allocation
> > virtio_gpu_cmd_memory_create --> allocate guest memory pages since
> > it's guest memory type
> > virtio_gpu_cmd_resource_attach_memory --> associate guest pages with
> > resource in kernel, send iovecs to host for bookkeeping
>
> virtio_gpu_cmd_memory_create sends the iovecs.  Otherwise correct.
>
> > 3) With gbm it's a little trickier,
> >
> > virtio_gpu_cmd_resource_create_v2 --> gbm_bo_create_with_modifiers,
> > get metadata in return
>
> Only get metadata in return.
>
> > virtio_gpu_cmd_memory_create --> create kernel data structure, but
> > don't allocate pages, nothing on the host
>
> Memory allocation happens here.  Probably makes sense to have a
> virtio_gpu_cmd_memory_create_host command here, because the parameters
> we need are quite different from the guest-allocated case.
>
If we follow Vulkan, we only need the size and the memory type in most
cases.  The current version of memory_create is a special case because it
is an import operation and needs the guest mem_entry.  Perhaps
memory_create (for host) and memory_import_guest (to replace the current
version)?

>
> Maybe we even need a virtio_gpu_cmd_memory_create_host_for_resource
> variant, given that gbm doesn't have raw memory buffers without any
> format attached to it.
>
And the memory will only be attachable to the given (or compatible)
resource, right?

Vulkan is much more explicit than any pre-existing API.  I guess we will
have to add this to cover APIs beyond Vulkan.


>
> > > > > +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
> > > > > +struct virtio_gpu_resp_resource_info {
> > > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > > +       __le32 stride[4];
> > > > > +       __le32 size[4];
> > > > > +};
> > > >
> > > > offsets[4] needed too
> > >
> > > That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...
> >
> > I assume the offsets aren't returned by
> > VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH.
>
> Yes, they are send by the guest.
>
Gurchetan probably means alignment[4].

>
> > How does the guest know at which offsets in memory will be compatible
> > to share with display, camera, etc?
>
> Is is good enough to align offsets to page boundaries?
>
That should be good enough.  But by returning alignments, we can minimize
the gaps when attaching multiple resources, especially when the resources
are only used by GPU.


>
> > Also, do you want to cover the case where the resource is backed by
> > three separate memory regions (VK_IMAGE_CREATE_DISJOINT_BIT)?
>
> Good point.  I guess we should make memory_id in
> virtio_gpu_cmd_resource_attach_memory an array then,
> so you can specify a different memory region for each plane.
>
> cheers,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--0000000000009b3b7405865dbe7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,</div><div><br></div><div>I am still new to v=
irgl, and missed the last round of discussion about resource_create_v2.</di=
v><div><br></div><div>From the discussion below, semantically resource_crea=
te_v2 creates a host resource object _without_ any storage; memory_create c=
reates a host memory object which provides the storage.=C2=A0 Is that corre=
ct?</div><div><br></div><div>And this version of memory_create is probably =
the most special one among its other potential variants, because it is the =
only(?) one who imports the pre-allocated guest pages.<br></div></div><div>=
<br></div><div>Do we expect these new commands to be supported by OpenGL, w=
hich does not separate resources and memories?</div><div><br></div><div>On =
Thu, Apr 11, 2019 at 10:49 PM Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@re=
dhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:<br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Thu, Apr 11, 2019 at 06:36:15PM -0700, Gurchetan Singh wrote:<br>
&gt; On Wed, Apr 10, 2019 at 10:03 PM Gerd Hoffmann &lt;<a href=3D"mailto:k=
raxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt; +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */<br>
&gt; &gt; &gt; &gt; +struct virtio_gpu_cmd_resource_create_v2 {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_hdr =
hdr;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 resource_id;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 format;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 width;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 height;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 3d only */<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 target;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 bind;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 depth;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 array_size;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 last_level;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 nr_samples;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 flags;<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I assume this is always backed by some host side allocation,=
 without any<br>
&gt; &gt; &gt; guest side pages associated with it?<br>
&gt; &gt;<br>
&gt; &gt; No.=C2=A0 It is not backed at all yet.=C2=A0 Workflow would be li=
ke this:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0(1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2<br>
&gt; &gt;=C2=A0 =C2=A0(2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)<br>
&gt; &gt;=C2=A0 =C2=A0(3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch =
2)<br>
&gt; <br>
&gt; Thanks for the clarification.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CR=
EATE,<br>
&gt; &gt; then go attach multiple resources to it.<br>
&gt; &gt;<br>
&gt; &gt; &gt; If so, do we want the option for the guest allocate?<br>
&gt; &gt;<br>
&gt; &gt; Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE<br=
>
&gt; &gt; (initially guest allocated only, i.e. what virtio-gpu supports to=
day,<br>
&gt; &gt; the plan is to add other allocation types later on).<br>
&gt; <br>
&gt; You want to cover Vulkan, host-allocated dma-bufs, and guest-allocated=
<br>
&gt; dma-bufs with this, correct?=C2=A0 Let me know if it&#39;s a non-goal =
:-)<br>
<br>
Yes, even though it is not clear yet how we are going to handle<br>
host-allocated buffers in the vhost-user case ...</blockquote><div>This mig=
ht be another dumb question, but is this only an issue for vhost-user(-gpu)=
 case?=C2=A0 What mechanisms are used to map host dma-buf into the guest ad=
dress space?</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; If so, we might want to distinguish between memory types (kind of like=
<br>
&gt; memoryTypeIndex in Vulkan). [Assuming memory_id is like resource_id]<b=
r>
<br>
For the host-allocated buffers we surely want that, yes.<br>
For guest-allocated memory regions it isn&#39;t useful I think ...<br></blo=
ckquote><div>Guest-allocated memory regions can be just another memory type=
.</div><div><br></div><div>But one needs to create the resource first to kn=
ow which memory types can be attached to it.=C2=A0 I think the metadata nee=
ds to be returned with resource_create_v2.</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
&gt; 1) Vulkan seems the most straightforward<br>
&gt; <br>
&gt; virtio_gpu_cmd_memory_create --&gt; create kernel data structure,<br>
&gt; vkAllocateMemory on the host or import guest memory into Vulkan,<br>
&gt; depending on the memory type<br>
&gt; virtio_gpu_cmd_resource_create_v2 --&gt;=C2=A0 vkCreateImage +<br>
&gt; vkGetImageMemoryRequirements on host<br>
&gt; virtio_gpu_cmd_resource_attach_memory --&gt;=C2=A0 vkBindImageMemory o=
n host<br>
<br>
Yes.<br>
<br>
Note 1: virtio_gpu_cmd_memory_create + virtio_gpu_cmd_resource_create_v2<br=
>
ordering doesn&#39;t matter, so you can virtio_gpu_cmd_resource_create_v2<b=
r>
first to figure stride and size, then adjust memory size accordingly.<br>
<br>
Note 2: The old virtio_gpu_cmd_resource_create variants can be used<br>
too if you don&#39;t need the _v2 features.<br>
<br>
Note 3: If I understand things correctly it would be valid to create a<br>
memory pool (allocate one big chunk of memory) with vkAllocateMemory,<br>
then bind multiple images at different offsets to it.<br>
<br>
&gt; 2) With a guest allocated dma-buf using some new allocation library,<b=
r>
&gt; <br>
&gt; virtio_gpu_cmd_resource_create_v2 --&gt; host returns metadata describ=
ing<br>
&gt; optimal allocation<br>
&gt; virtio_gpu_cmd_memory_create --&gt; allocate guest memory pages since<=
br>
&gt; it&#39;s guest memory type<br>
&gt; virtio_gpu_cmd_resource_attach_memory --&gt; associate guest pages wit=
h<br>
&gt; resource in kernel, send iovecs to host for bookkeeping<br>
<br>
virtio_gpu_cmd_memory_create sends the iovecs.=C2=A0 Otherwise correct.<br>
<br>
&gt; 3) With gbm it&#39;s a little trickier,<br>
&gt; <br>
&gt; virtio_gpu_cmd_resource_create_v2 --&gt; gbm_bo_create_with_modifiers,=
<br>
&gt; get metadata in return<br>
<br>
Only get metadata in return.<br>
<br>
&gt; virtio_gpu_cmd_memory_create --&gt; create kernel data structure, but<=
br>
&gt; don&#39;t allocate pages, nothing on the host<br>
<br>
Memory allocation happens here.=C2=A0 Probably makes sense to have a<br>
virtio_gpu_cmd_memory_create_host command here, because the parameters<br>
we need are quite different from the guest-allocated case.<br></blockquote>=
<div>If we follow Vulkan, we only need the size and the memory type in most=
 cases.=C2=A0 The current version of memory_create is a special case becaus=
e it is an import operation and needs the guest mem_entry.=C2=A0 Perhaps me=
mory_create (for host) and memory_import_guest (to replace the current vers=
ion)?</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Maybe we even need a virtio_gpu_cmd_memory_create_host_for_resource<br>
variant, given that gbm doesn&#39;t have raw memory buffers without any<br>
format attached to it.<br></blockquote><div>And the memory will only be att=
achable to the given (or compatible) resource, right?</div><div><br></div><=
div>Vulkan is much more explicit than any pre-existing API.=C2=A0 I guess w=
e will have to add this to cover APIs beyond Vulkan.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; &gt; &gt; &gt; +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */<br>
&gt; &gt; &gt; &gt; +struct virtio_gpu_resp_resource_info {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_hdr =
hdr;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 stride[4];<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 size[4];<br>
&gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; offsets[4] needed too<br>
&gt; &gt;<br>
&gt; &gt; That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...<br>
&gt; <br>
&gt; I assume the offsets aren&#39;t returned by<br>
&gt; VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH.<br>
<br>
Yes, they are send by the guest.<br></blockquote><div>Gurchetan probably me=
ans alignment[4].</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; How does the guest know at which offsets in memory will be compatible<=
br>
&gt; to share with display, camera, etc?<br>
<br>
Is is good enough to align offsets to page boundaries?<br></blockquote><div=
>That should be good enough.=C2=A0 But by returning alignments, we can mini=
mize the gaps when attaching multiple resources, especially when the resour=
ces are only used by GPU.</div><div>=C2=A0<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt; Also, do you want to cover the case where the resource is backed by<br=
>
&gt; three separate memory regions (VK_IMAGE_CREATE_DISJOINT_BIT)?<br>
<br>
Good point.=C2=A0 I guess we should make memory_id in<br>
virtio_gpu_cmd_resource_attach_memory an array then,<br>
so you can specify a different memory region for each plane.<br>
<br>
cheers,<br>
=C2=A0 Gerd<br>
<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a></blockquote></div></div>

--0000000000009b3b7405865dbe7a--

--===============3813039669284076910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3813039669284076910==--
