From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 12/12] VMCI: Some header and config files.
Date: Mon, 29 Oct 2012 22:22:34 -0700
Message-ID: <20121030052234.GH32055@dtor-ws.eng.vmware.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030010533.17788.79417.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030023255.GJ1920@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030023255.GJ1920@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2012 at 07:32:55PM -0700, Greg KH wrote:
> On Mon, Oct 29, 2012 at 06:05:38PM -0700, George Zhang wrote:
> > --- /dev/null
> > +++ b/drivers/misc/vmw_vmci/Makefile
> > @@ -0,0 +1,43 @@
> > +################################################################################
> > +#
> > +# Linux driver for VMware's VMCI device.
> > +#
> > +# Copyright (C) 2007-2012, VMware, Inc. All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or modify it
> > +# under the terms of the GNU General Public License as published by the
> > +# Free Software Foundation; version 2 of the License and no later version.
> > +#
> > +# This program is distributed in the hope that it will be useful, but
> > +# WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> > +# NON INFRINGEMENT.  See the GNU General Public License for more
> > +# details.
> > +#
> > +# Maintained by: Andrew Stiegmann <pv-drivers@vmware.com>
> > +#
> > +################################################################################
> 
> That's a big boiler-plate for a makefile :)
> 
> Wait, what's Andrew's name doing here, and yet it isn't on any of the
> signed-off-by: or From: lines of the driver?  Surely you aren't the only
> contributor here?
> 
> > +#
> > +# Makefile for the VMware VMCI
> > +#
> 
> That's the only needed comment for this file, if even that.
> 
> > +
> > +obj-$(CONFIG_VMWARE_VMCI) += vmw_vmci.o
> > +
> > +vmw_vmci-y += vmci_context.o
> > +vmw_vmci-y += vmci_datagram.o
> > +vmw_vmci-y += vmci_doorbell.o
> > +vmw_vmci-y += vmci_driver.o
> > +vmw_vmci-y += vmci_event.o
> > +vmw_vmci-y += vmci_guest.o
> > +vmw_vmci-y += vmci_handle_array.o
> > +vmw_vmci-y += vmci_host.o
> > +vmw_vmci-y += vmci_queue_pair.o
> > +vmw_vmci-y += vmci_resource.o
> > +vmw_vmci-y += vmci_route.o
> 
> You can do this cleaner with multiple .o objects on the same line...
> 
> > +vmci:
> > +	$(MAKE) -C ../../.. SUBDIRS=$$PWD CONFIG_VMWARE_VMCI=m modules
> > +
> > +clean:
> > +	$(MAKE) -C ../../.. SUBDIRS=$$PWD CONFIG_VMWARE_VMCI=m clean
> 
> What are these two last targets for?  I'm guessing this is from when you
> ported it from a stand-along module?  Please remove them.

We'll clean it all up.

Thanks for going over the code.

-- 
Dmitry
