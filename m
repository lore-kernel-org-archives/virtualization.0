From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Tue, 8 Jan 2008 14:10:05 -0200
Message-ID: <20080108161005.GA22168__13325.5332978026$1199824994$gmane$org@dmt>
References: <20080108153356.GA21726@dmt> <478399D5.9030707@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <478399D5.9030707@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2008 at 09:42:13AM -0600, Anthony Liguori wrote:
> Marcelo Tosatti wrote:
> >Following patch introduces a KVM guest balloon driver. Communication
> >to/from the host is performed via virtio.
> >

I'll address the other comments.

> >+	virtballoon.dev = vdev;
> >+	init_waitqueue_head(&virtballoon.balloon_wait);
> >+	init_waitqueue_head(&virtballoon.rmmod_wait);
> >+	atomic_set(&virtballoon.inflight_bufs, 0);
> >+
> >+	err = request_irq(pvdev->pci_dev->irq, balloon_irq, IRQF_SHARED,
> >+			  pvdev->vdev.dev.bus_id, &virtballoon);
> >+	if (err)
> >+		goto out_free_vq;
> >  
> 
> Why is it taking over the irq?  This is very, very wrong.  A virtio 
> device cannot be dependent on being used on top of the virtio-pci backend.

A notification is necessary whenever the host changes the target value
in the config space. So right now this notification is sharing the
same IRQ as the main PCI device.

Do you have any suggestion on how to retrieve the IRQ of the virtio
device, or some other notification mechanism?
