From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio interace
Date: Fri, 21 Sep 2007 22:45:36 +1000
Message-ID: <1190378736.27805.54.camel__2375.0384957113$1190378889$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<200709211405.32116.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211405.32116.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-09-21 at 14:05 +0200, Arnd Bergmann wrote:
> On Thursday 20 September 2007, Rusty Russell wrote:
> > +int register_virtio_driver(struct virtio_driver *drv);
> > +void unregister_virtio_driver(struct virtio_driver *drv);
> > +
> > +/* The particular virtio backend supplies these. */
> > +struct virtio_backend_ops {
> > +       int (*register_driver)(struct virtio_driver *drv);
> > +       void (*unregister_driver)(struct virtio_driver *drv);
> > +};
> > +extern struct virtio_backend_ops virtio_backend_ops;
> 
> This still seems a little awkward. From what I understand, you register
> a virtio_driver, which leads to a pci_driver (or whatever you are based on)
> to be registered behind the covers, so that the pci_device can be used
> directly as the virtio device.

Hi Arnd,

	Yes, and I dislike it too. 

> I think there should instead be a pci_driver that automatically binds
> to all PCI based virtio imlpementations and creates a child device for
> the actual virtio_device.

I'm not sure I understand.  For PCI probing to work, you want to have
identified yourself as a driver for each PCI id claimed by a virtio
device.

Hmm, I guess we could have a PCI driver which claims all VIRTIO vendor
devices.  Then it can call virtio_find_driver() (?) at the top of its
probe function to find if there's a matching virtio driver.  This PCI
driver would have to be initialized after all the virtio drivers are
registered, but that's easy.

The virtio layer would simply maintain a linked list of drivers and
implement the virtio_find_driver() matching function.

And since we've suppressed normal PCI driver request_module (since it
always finds "the driver") then we can implement that in
virtio_find_driver(), and not use a PCI MODULE_DEVICE_TABLE.  Then we
don't need (full) PCI ids at all.

OK, I have some coding to do now...
Rusty.
