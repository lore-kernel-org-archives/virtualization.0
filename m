From: Yu Zhao <yu.zhao@intel.com>
Subject: Re: [PATCH 15/16 v6] PCI: document the SR-IOV sysfs entries
Date: Mon, 17 Nov 2008 16:09:49 +0800
Message-ID: <20081117080949.GA5247__10316.6625871838$1226912976$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084515.GO3773@yzhao12-linux.sh.intel.com>
	<20081106043318.GB30292@kroah.com>
	<20081106044613.GA30397@kroah.com> <4913AF89.2050504@intel.com>
	<20081107031837.GB30003@kroah.com>
	<20081113065024.GA3038@yzhao12-linux.sh.intel.com>
	<20081114005538.GA21161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081114005538.GA21161@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 14, 2008 at 08:55:38AM +0800, Greg KH wrote:
> On Thu, Nov 13, 2008 at 02:50:24PM +0800, Yu Zhao wrote:
> > On Fri, Nov 07, 2008 at 11:18:37AM +0800, Greg KH wrote:
> > > On Fri, Nov 07, 2008 at 11:01:29AM +0800, Zhao, Yu wrote:
> > > > Currently PCI subsystem has /sys/.../{vendor,device,...} bundled to the 
> > > > main PCI device (I suppose this means the entries are created by 
> > > > 'device_add')
> > > >
> > > > And after the PCI device is announced, 
> > > > /sys/.../{config,resourceX,rom,vpd,iov,...} get created depending on if 
> > > > these features are supported.
> > > 
> > > And that's a bug.  Let's not continue to make the same bug here as well.
> > > 
> > > > Making dynamic entries tie to the main PCI device would require PCI 
> > > > subsystem to allocate different 'bus_type' for the devices, right?
> > > 
> > > No, it would just mean they need to be all added before the device is
> > > fully registered with the driver core.
> > 
> > I looked into the PCI and driver core code again, but didn't figured out how
> > to do it.
> > 
> > A 'pci_dev' is added by pci_bus_add_device() via device_add(), which creates
> > sysfs entries according to 'dev_attrs' in the 'pci_bus_type'. If we want those
> > dynamic entries to appear before the uevent is triggered, we have to bundle
> > them into the 'dev_attrs'. Is this right way for the dynamic entries? Or I
> > missed something?
> 
> Yes, that is correct.
> 
> Or you can add attributes before device_add() is called to the device,
> which is probably much easier to do, right?
> 
> There are also "conditional" attributes, which get only displayed if
> some kind of condition is met, I think you want to use those.

The problem is the sysfs directory of the PCI device is created by the
kobject_add() in the device_add() as follows. And the static entries
bundled with the 'pci_bus_type' are created by the bus_add_device().
Between the kobject_add() and the kobject_uevent(), we don't have any
other choice to add the dynamic entries.

In device_add():

	error = kobject_add(&dev->kobj, dev->kobj.parent, "%s", dev->bus_id);
	...
	error = bus_add_device(dev);
	...
	kobject_uevent(&dev->kobj, KOBJ_ADD);


So looks like the only way is to make the dynamic entries bundled with
the 'pci_bus_type', which means they would become static no matter the
device supports the entries (i.e. corresponding capabilities) or not.

Thanks,
Yu
