From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Question regarding Virtio Console and Remoteproc
Date: Tue, 5 Jun 2012 15:13:55 +0530
Message-ID: <20120605094355.GG18323@amit.redhat.com>
References: <81C3A93C17462B4BBD7E272753C10579232F4FB338@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <81C3A93C17462B4BBD7E272753C10579232F4FB338@EXDCVYMBSTM005.EQ1STM.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Sjur,

On (Fri) 01 Jun 2012 [09:31:30], Sjur BRENDELAND wrote:
> Hi Amit and Rusty,
> 
> I've been looking into the possibility of using the Virtio Console
> Driver together with the remoteproc framework to communicate with
> ST-Ericsson modem over shared memory.
> 
> It seems like Virtio Console would be a good fit, except for a issue
> with buffer allocation. Due to HW limitations the STE-Modem cannot
> access kernel memory (no IOMMU and limited address range). Instead
> we have a designated shared memory region used for IPC. 
> 
> Due to this I cannot use kmalloc() for buffer allocation, but I
> have to allocate buffers from the memory region shared with the
> modem.
> 
> In remoteproc this is solved by using dma_alloc_coherent() for all
> memory to be shared with the modem. This works fine for me, because
> I can pass the IPC memory region to dma_declare_coherent_memory() 
> so dma_alloc_coherent() will allocate from this memory region.
> 
> I think I can solve this issue in Virtio Console by changing calls
> to kmalloc() to something like:
> 
> 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_USE_DMA_MEM)) {
> 		dma_addr_t dma;
> 		buf = dma_alloc_coherent(dev, size, &dma, GFP_KERNEL);
> 	} else
> 		buf = kmalloc(count, GFP_KERNEL);
> 
> I'd like to get the opinion from you virtualization folks on this!
> If you think it looks reasonable I might start cooking some patches...

I don't have a problem with this.

Thanks,
		Amit
