From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 6/6 v3] PCI: document the change
Date: Wed, 1 Oct 2008 10:07:07 -0600
Message-ID: <20081001160706.GI13822__29195.5855479047$1222877436$gmane$org@parisc-linux.org>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Sep 27, 2008 at 04:28:45PM +0800, Zhao, Yu wrote:
> +++ b/Documentation/DocBook/kernel-api.tmpl
> @@ -239,6 +239,7 @@ X!Ekernel/module.c
>       </sect1>
> 
>       <sect1><title>PCI Support Library</title>
> +!Iinclude/linux/pci.h

Why do you need to do this?  Thus far, all the documentation has been
with the implementation, not in the header file.

> +1.2 What is ARI
> +
> +Alternative Routing-ID Interpretation (ARI) allows a PCI Express Endpoint
> +to use its device number field as part of function number. Traditionally,
> +an Endpoint can only have 8 functions, and the device number of all
> +Endpoints is zero. With ARI enabled, an Endpoint can have up to 256
> +functions by using device number in conjunction with function number to
> +indicate a function in the device. This is almost transparent to the Linux
> +kernel because the Linux kernel still can use 8-bit bus number field plus
> +8-bit devfn number field to locate a function. ARI is managed via the ARI
> +Forwarding bit in the Device Capabilities 2 register of the PCI Express
> +Capability on the Root Port or the Downstream Port and a new ARI Capability
> +on the Endpoint.

I don't think this section actually helps a software developer use
SR-IOV, does it?

> +2. User Guide
> +
> +2.1 How can I manage SR-IOV
> +
> +If a device supports SR-IOV, then there should be some entries under
> +Physical Function's PCI device directory. These entries are in directory:
> +       - /sys/bus/pci/devices/BB:DD.F/iov/
> +               (BB:DD:F is bus:dev:fun)

The 'domain:' prefix has been there for a long time now.

> +and
> +       - /sys/bus/pci/devices/BB:DD.F/iov/N
> +               (N is VF number from 0 to initialvfs-1)
> +
> +To enable or disable SR-IOV:
> +       - /sys/bus/pci/devices/BB:DD.F/iov/enable
> +               (writing 1/0 means enable/disable VFs, state change will
> +                notify PF driver)
> +
> +To change number of Virtual Functions:
> +       - /sys/bus/pci/devices/BB:DD.F/iov/numvfs
> +               (writing positive integer to this file will change NumVFs)
> +
> +The total and initial number of VFs can get from:
> +       - /sys/bus/pci/devices/BB:DD.F/iov/totalvfs
> +       - /sys/bus/pci/devices/BB:DD.F/iov/initialvfs
> +
> +The identifier of a VF that belongs to this PF can get from:
> +       - /sys/bus/pci/devices/BB:DD.F/iov/N/rid
> +               (for all class of devices)

Wouldn't it be more useful to have the iov/N directories be a symlink to
the actual pci_dev used by the virtual function?

> +For network device, there are:
> +       - /sys/bus/pci/devices/BB:DD.F/iov/N/mac
> +       - /sys/bus/pci/devices/BB:DD.F/iov/N/vlan
> +               (value update will notify PF driver)

We already have tools to set the MAC and VLAN parameters for network
devices.

> +To register SR-IOV service, Physical Function device driver needs to call:
> +       int pci_iov_register(struct pci_dev *dev,
> +               int (*notify)(struct pci_dev *, u32), char **entries)

I think a better interface would put the 'notify' into the struct
pci_driver.  That would make 'notify' a bad name .... how about
'virtual'?  There's also no documentation for the second parameter to
'notify'.

> +Note: entries could be NULL if PF driver doesn't want to create new entries
> +under /sys/bus/pci/devices/BB:DD.F/iov/N/.

So 'entries' is a list of names to create sysfs entries for?

> +To enable SR-IOV, Physical Function device driver needs to call:
> +       int pci_iov_enable(struct pci_dev *dev, int numvfs)
> +
> +To disable SR-IOV, Physical Function device driver needs to call:
> +       void pci_iov_disable(struct pci_dev *dev)

I'm not 100% convinced about this API.  The assumption here is that the
driver will do it, but I think it should probably be in the core.  The
driver probably wants to be notified that the PCI core is going to
create a virtual function, and would it please prepare to do so, but I'm
not convinced this should be triggered by the driver.  How would the
driver decide to create a new virtual function?

> +To read or write VFs configuration:
> +       - int pci_iov_read_config(struct pci_dev *dev, int id,
> +                       char *entry, char *buf, int size);
> +       - int pci_iov_write_config(struct pci_dev *dev, int id,
> +                       char *entry, char *buf);

I think we'd be better off having the driver create its own sysfs
entries if it really needs to.

> +3.2 Usage example
> +
> +Following piece of code illustrates the usage of APIs above.
> +
[...]
> +static struct pci_driver dev_driver = {
> +       .name =         "SR-IOV Physical Function driver",
> +       .id_table =     dev_id_table,
> +       .probe =        dev_probe,
> +       .remove =       __devexit_p(dev_remove),
> +#ifdef CONFIG_PM
> +       .suspend =      dev_suspend,
> +       .resume =       dev_resume,
> +#endif
> +};

From my reading of the SR-IOV spec, this isn't how it's supposed to
work.  The device is supposed to be a fully functional PCI device that
on demand can start peeling off virtual functions; it's not supposed to
boot up and initialise all its virtual functions at once.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
