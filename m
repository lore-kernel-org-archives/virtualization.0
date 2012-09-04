From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Tue, 4 Sep 2012 13:28:36 +0200
Message-ID: <CAJK669ZvnnG6fGOog-Z47B7xqyn9hcx5dAD7S--+2PSgE+hrLA@mail.gmail.com>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
	<20120903202737.GD6181@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120903202737.GD6181@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

>> If an architecture do not support DMA you will get
>> a link error: "unknown symbol" for dma_alloc_coherent.
>
> Yes, it even seems intentional.
> But I have a question: can the device work without DMA?

The main dependency is actually on the dma-allocation.
In my case I do dma_declare_coherent_memory() with
the memory area shared with the remote device as argument.
Subsequent calls to dma_alloc_coherent() will then allocate
from this memory area.

> Does not VIRTIO_CONSOLE_F_DMA_MEM mean dma api is required?

Yes.dma_alloc_coherent to work.

> If yes you should just fail load.

Agree, I'll check on VIRTIO_CONSOLE_HAS_DMA before adding
VIRTIO_CONSOLE_F_DMA_MEM to the feature array.

> Also let's add a wrapper at top of file so ifdefs
> do not litter the code like this. For example:
>
> #ifdef CONFIG_HAS_DMA
> #define VIRTIO_CONSOLE_HAS_DMA (1)
> #else
> #define VIRTIO_CONSOLE_HAS_DMA (0)
> #endif

OK, good point. Perhaps we could even exploit gcc's
ability to remove dead code and do something like this:

       if (VIRTIO_CONSOLE_HAS_DMA &&
           virtio_has_feature(vdev, VIRTIO_CONSOLE_F_DMA_MEM)) {
...

This does not give any linker warnings when compiling for UML (no DMA).

Regards,
Sjur
