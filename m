From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] virtio-mmio: Reject invalid IRQ 0 command line
 argument
Date: Tue, 21 Jul 2020 17:12:51 -0500
Message-ID: <20200721221251.GA1164301@bjorn-Precision-5520>
References: <032d0424-4876-6322-76d2-d733db28addb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <032d0424-4876-6322-76d2-d733db28addb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 02, 2020 at 11:06:11AM +0800, Jason Wang wrote:
> On 2020/7/2 上午6:10, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The "virtio_mmio.device=" command line argument allows a user to specify
> > the size, address, and IRQ of a virtio device.  Previously the only
> > requirement for the IRQ was that it be an unsigned integer.
> > 
> > Zero is an unsigned integer but an invalid IRQ number, and after
> > a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid"),
> > attempts to use IRQ 0 cause warnings.
> > 
> > If the user specifies IRQ 0, return failure instead of registering a device
> > with IRQ 0.
> > 
> > Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > ---
> >   drivers/virtio/virtio_mmio.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 9d16aaffca9d..627ac0487494 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -641,11 +641,11 @@ static int vm_cmdline_set(const char *device,
> >   			&vm_cmdline_id, &consumed);
> >   	/*
> > -	 * sscanf() must processes at least 2 chunks; also there
> > +	 * sscanf() must process at least 2 chunks; also there
> >   	 * must be no extra characters after the last chunk, so
> >   	 * str[consumed] must be '\0'
> >   	 */
> > -	if (processed < 2 || str[consumed])
> > +	if (processed < 2 || str[consumed] || irq == 0)
> >   		return -EINVAL;
> >   	resources[0].flags = IORESOURCE_MEM;
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Thanks, I applied this to my for-linus branch for v5.8.
