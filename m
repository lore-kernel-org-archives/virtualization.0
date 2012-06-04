From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Question regarding Virtio Console and Remoteproc
Date: Mon, 04 Jun 2012 16:10:05 +1000
Message-ID: <1338790205.7150.66.camel@pasglop>
References: <81C3A93C17462B4BBD7E272753C10579232F4FB338@EXDCVYMBSTM005.EQ1STM.local>
	<CAK=WgbY9cXByKXEnpSvVr3dCecmKyumAQ6ffX8_2ghsAr2haEQ@mail.gmail.com>
	<87bokz1y8a.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bokz1y8a.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-06-04 at 14:15 +0930, Rusty Russell wrote:
> > Something along those lines is also needed for remote processors
> which
> > access memory via an IOMMU (e.g. OMAP4's M3 and DSP).
> > 
> > Allocating the memory via the DMA API will seamlessly configure the
> > relevant IOMMU as needed, and will make the buffers accessible to
> the
> > remote processors.
> > 
> > Thanks,
> > Ohad.
> 
> It seems quite sensible.  The formal definition in the spec would be
> good.  In particular, defining DMA_MEM in a generic (non-Linux) way
> will be interesting.

I think we could do a bit better...

We need to dbl check if all the archs we care about use the dma_ops
abstraction, but if they do, then we can remove the conditional and just
use the dma_* functions everywhere, and have virtio-pci itself tweak the
dma_ops pointer in struct device.

The default would be to swap the normal PCI one that the arch code has
put there with some "null" ops to match existing virtio, and we could
then use a negociated capability to avoid that behaviour.

It's important to keep in mind that for KVM, in most cases we want to
keep the bypass of the iommu, simply because it's always going to be
faster than emulating one & mapping/unmapping things to/from it.


Cheers,
Ben.
