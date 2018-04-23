From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio remoteproc device
Date: Mon, 23 Apr 2018 22:40:38 +0300
Message-ID: <20180423223717-mutt-send-email-mst@kernel.org>
References: <20180420194321-mutt-send-email-mst@kernel.org>
	<CAAhSdy2JncLrpc0WUoBtB4g+bnGtUWiFOS=sxnTF9fkw9a3UnQ@mail.gmail.com>
	<1d7df45a692b42bd9d70462e0af63ca9@SFHDAG7NODE2.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1d7df45a692b42bd9d70462e0af63ca9@SFHDAG7NODE2.st.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Loic PALLARDY <loic.pallardy@st.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Anup Patel <anup@brainfault.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 23, 2018 at 08:55:57AM +0000, Loic PALLARDY wrote:
> =

> =

> > -----Original Message-----
> > From: linux-remoteproc-owner@vger.kernel.org [mailto:linux-remoteproc-
> > owner@vger.kernel.org] On Behalf Of Anup Patel
> > Sent: Sunday, April 22, 2018 6:08 AM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: linux-remoteproc@vger.kernel.org; Ohad Ben-Cohen
> > <ohad@wizery.com>; Bjorn Andersson <bjorn.andersson@linaro.org>;
> > virtualization@lists.linux-foundation.org
> > Subject: Re: virtio remoteproc device
> > =

> > On Fri, Apr 20, 2018 at 10:23 PM, Michael S. Tsirkin <mst@redhat.com>
> > wrote:
> > > Hello!
> > > I note the following in the serial console:
> > >
> > >       if (is_rproc_serial(vdev)) {
> > >                 /*
> > >                  * Allocate DMA memory from ancestor. When a virtio
> > >                  * device is created by remoteproc, the DMA memory is
> > >                  * associated with the grandparent device:
> > >                  * vdev =3D> rproc =3D> platform-dev.
> > >                  */
> > >                 if (!vdev->dev.parent || !vdev->dev.parent->parent)
> > >                         goto free_buf;
> > >                 buf->dev =3D vdev->dev.parent->parent;
> > >
> > >                 /* Increase device refcnt to avoid freeing it */
> > >                 get_device(buf->dev);
> > >                 buf->buf =3D dma_alloc_coherent(buf->dev, buf_size, &=
buf->dma,
> > >                                               GFP_KERNEL);
> > >         }
> > >
> > > Added here:
> > >         commit 1b6370463e88b0c1c317de16d7b962acc1dab4f2
> > >         Author: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > >         Date:   Fri Dec 14 14:40:51 2012 +1030
> > >
> > >     virtio_console: Add support for remoteproc serial
> > >
> > >
> > > I am not familiar with rproc so I have a question:
> > > why is it required to use coherent memory here,
> > > and why through a grandparent device?
> > =

> > I faced similar issue when I tried VirtIO RPMSG bus over
> > VirtIO MMIO transport.
> > =

> > Here's my fix for VirtIO RPMSG bus driver:
> > https://patchwork.kernel.org/patch/10155145/
> =

> Hi Anup and Michael,
> =

> I pushed a series to modify virtio device allocation in remoteproc. Pleas=
e see [1].
> It allows to remove allocation based on "grand-parent" device in the case=
 of virtio device allocated by remoteproc.
> Virto_console patch missing, only virtio_rpmsg modification proposed. I c=
an add it in next version.
> =

> Regards,
> Loic
> =

> [1] https://lkml.org/lkml/2018/3/1/644
> =

> > =

> > Regards,
> > Anup
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-remotep=
roc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

So on top of your patches, can we just force use of DMA API
and drop special casting?
E.g. maybe something like the below - completely untested - patch?
Does it work for you?


diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2108551..6c6767c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -40,7 +40,8 @@
 #include <linux/dma-mapping.h>
 #include "../tty/hvc/hvc_console.h"
 =

-#define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
+//#define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
+#define is_rproc_enabled 0
 =

 /*
  * This is a global struct for storing common data for all the devices
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/re=
moteproc_virtio.c
index b0633fd..4a13ca2 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -199,7 +199,7 @@ static u64 rproc_virtio_get_features(struct virtio_devi=
ce *vdev)
 =

 	rsc =3D (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
 =

-	return rsc->dfeatures;
+	return rsc->dfeatures | (1ULL << VIRTIO_F_IOMMU_PLATFORM);
 }
 =

 static int rproc_virtio_finalize_features(struct virtio_device *vdev)
@@ -213,7 +213,7 @@ static int rproc_virtio_finalize_features(struct virtio=
_device *vdev)
 	vring_transport_features(vdev);
 =

 	/* Make sure we don't have any features > 32 bits! */
-	BUG_ON((u32)vdev->features !=3D vdev->features);
+	//BUG_ON((u32)vdev->features !=3D vdev->features);
 =

 	/*
 	 * Remember the finalized features of our vdev, and provide it
