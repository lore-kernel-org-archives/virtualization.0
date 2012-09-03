From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Mon, 3 Sep 2012 16:57:45 +0200
Message-ID: <CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120903143018.GA5353@redhat.com>
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

> How does access to descriptors work in this setup?

When the ring is setup by remoteproc the descriptors are
also allocated using dma_alloc_coherent().

>> -static void free_buf(struct port_buffer *buf)
>> +/* Allcoate data buffer from DMA memory if requested */
>
> typo

Thanks.

>> +static inline void *
>> +alloc_databuf(struct virtio_device *vdev, size_t size, dma_addr_t *dma_handle,
>> +                gfp_t flag)
>>  {
>> -     kfree(buf->buf);
>> +#ifdef CONFIG_HAS_DMA
>> +     if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_DMA_MEM)) {
>> +             struct device *dev = &vdev->dev;
>> +             /*
>> +              * Allocate DMA memory from ancestors. Finding the ancestor
>> +              * is a bit quirky when DMA_MEMORY_INCLUDES_CHILDREN is not
>> +              * implemented.
>> +              */
>> +             dev = dev->parent ? dev->parent : dev;
>> +             dev = dev->parent ? dev->parent : dev;
>> +             return dma_alloc_coherent(dev, size, dma_handle, flag);
>> +     }
>> +#endif
>
> Are these ifdefs really needed? If DMA_MEM is set,
> can't we use dma_alloc_coherent
> unconditionally?

If an architecture do not support DMA you will get
a link error: "unknown symbol" for dma_alloc_coherent.

Regards,
Sjur
