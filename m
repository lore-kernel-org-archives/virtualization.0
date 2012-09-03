From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Mon, 3 Sep 2012 23:27:37 +0300
Message-ID: <20120903202737.GD6181@redhat.com>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjurbren@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 03, 2012 at 04:57:45PM +0200, Sjur Br=E6ndeland wrote:
> Hi Michael,
> =

> > How does access to descriptors work in this setup?
> =

> When the ring is setup by remoteproc the descriptors are
> also allocated using dma_alloc_coherent().
> =

> >> -static void free_buf(struct port_buffer *buf)
> >> +/* Allcoate data buffer from DMA memory if requested */
> >
> > typo
> =

> Thanks.
> =

> >> +static inline void *
> >> +alloc_databuf(struct virtio_device *vdev, size_t size, dma_addr_t *dm=
a_handle,
> >> +                gfp_t flag)
> >>  {
> >> -     kfree(buf->buf);
> >> +#ifdef CONFIG_HAS_DMA
> >> +     if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_DMA_MEM)) {
> >> +             struct device *dev =3D &vdev->dev;
> >> +             /*
> >> +              * Allocate DMA memory from ancestors. Finding the ances=
tor
> >> +              * is a bit quirky when DMA_MEMORY_INCLUDES_CHILDREN is =
not
> >> +              * implemented.
> >> +              */
> >> +             dev =3D dev->parent ? dev->parent : dev;
> >> +             dev =3D dev->parent ? dev->parent : dev;
> >> +             return dma_alloc_coherent(dev, size, dma_handle, flag);
> >> +     }
> >> +#endif
> >
> > Are these ifdefs really needed? If DMA_MEM is set,
> > can't we use dma_alloc_coherent
> > unconditionally?
> =

> If an architecture do not support DMA you will get
> a link error: "unknown symbol" for dma_alloc_coherent.
> =

> Regards,
> Sjur

Yes, it even seems intentional.
But I have a question: can the device work without DMA?
Does not VIRTIO_CONSOLE_F_DMA_MEM mean dma api is required?
If yes you should just fail load.

Also let's add a wrapper at top of file so ifdefs
do not litter the code like this. For example:

#ifdef CONFIG_HAS_DMA
#define VIRTIO_CONSOLE_HAS_DMA (1)
#else
#define VIRTIO_CONSOLE_HAS_DMA (0)
#endif

Now use if instead of ifdef.

-- =

MST
