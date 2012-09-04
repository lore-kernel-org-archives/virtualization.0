From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Tue, 4 Sep 2012 16:50:22 +0300
Message-ID: <20120904135022.GI9805@redhat.com>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
	<20120903202737.GD6181@redhat.com>
	<CAJK669ZvnnG6fGOog-Z47B7xqyn9hcx5dAD7S--+2PSgE+hrLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJK669ZvnnG6fGOog-Z47B7xqyn9hcx5dAD7S--+2PSgE+hrLA@mail.gmail.com>
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

On Tue, Sep 04, 2012 at 01:28:36PM +0200, Sjur Br=E6ndeland wrote:
> Hi Michael,
> =

> >> If an architecture do not support DMA you will get
> >> a link error: "unknown symbol" for dma_alloc_coherent.
> >
> > Yes, it even seems intentional.
> > But I have a question: can the device work without DMA?
> =

> The main dependency is actually on the dma-allocation.
> In my case I do dma_declare_coherent_memory() with
> the memory area shared with the remote device as argument.
> Subsequent calls to dma_alloc_coherent() will then allocate
> from this memory area.
> =

> > Does not VIRTIO_CONSOLE_F_DMA_MEM mean dma api is required?
> =

> Yes.dma_alloc_coherent to work.
> =

> > If yes you should just fail load.
> =

> Agree, I'll check on VIRTIO_CONSOLE_HAS_DMA before adding
> VIRTIO_CONSOLE_F_DMA_MEM to the feature array.
> =

> > Also let's add a wrapper at top of file so ifdefs
> > do not litter the code like this. For example:
> >
> > #ifdef CONFIG_HAS_DMA
> > #define VIRTIO_CONSOLE_HAS_DMA (1)
> > #else
> > #define VIRTIO_CONSOLE_HAS_DMA (0)
> > #endif
> =

> OK, good point. Perhaps we could even exploit gcc's
> ability to remove dead code and do something like this:
> =

>        if (VIRTIO_CONSOLE_HAS_DMA &&
>            virtio_has_feature(vdev, VIRTIO_CONSOLE_F_DMA_MEM)) {
> ...
> =

> This does not give any linker warnings when compiling for UML (no DMA).
> =

> Regards,
> Sjur

Exactly. Though if we just fail load it will be much less code.

Generally, using a feature bit for this is a bit of a problem though:
normally driver is expected to be able to simply ignore
a feature bit. In this case driver is required to
do something so a feature bit is not a good fit.
I am not sure what the right thing to do is.

-- =

MST
