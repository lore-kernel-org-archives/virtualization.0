From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Date: Thu, 11 Apr 2019 07:03:22 +0200
Message-ID: <20190411050322.mfxo5mrwwzajlz3h__25056.0145753965$1554959030$gmane$org@sirius.home.kraxel.org>
References: <20190410114227.25846-1-kraxel@redhat.com>
	<20190410114227.25846-4-kraxel@redhat.com>
	<CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
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

> > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
> > +struct virtio_gpu_cmd_resource_create_v2 {
> > +       struct virtio_gpu_ctrl_hdr hdr;
> > +       __le32 resource_id;
> > +       __le32 format;
> > +       __le32 width;
> > +       __le32 height;
> > +       /* 3d only */
> > +       __le32 target;
> > +       __le32 bind;
> > +       __le32 depth;
> > +       __le32 array_size;
> > +       __le32 last_level;
> > +       __le32 nr_samples;
> > +       __le32 flags;
> > +};
> 
> 
> I assume this is always backed by some host side allocation, without any
> guest side pages associated with it?

No.  It is not backed at all yet.  Workflow would be like this:

  (1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2
  (2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)
  (3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch 2)

You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CREATE,
then go attach multiple resources to it.

> If so, do we want the option for the guest allocate?

Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE
(initially guest allocated only, i.e. what virtio-gpu supports today,
the plan is to add other allocation types later on).

> > +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
> > +struct virtio_gpu_resp_resource_info {
> > +       struct virtio_gpu_ctrl_hdr hdr;
> > +       __le32 stride[4];
> > +       __le32 size[4];
> > +};
> 
> offsets[4] needed too

That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...

cheers,
  Gerd
