From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: binding/unbinding devices to vfio-pci
Date: Tue, 2 Jul 2013 15:13:27 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15036330AE@039-SN1MPN1-004.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E1503632FA9@039-SN1MPN1-004.039d.mgd.msft.net>
	<1372776365.30572.874.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1372776365.30572.874.camel@ul30vt.home>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "a.motakis@virtualopensystems.com" <a.motakis@virtualopensystems.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, July 02, 2013 9:46 AM
> To: Yoder Stuart-B08248
> Cc: kvm@vger.kernel.org list; Alexander Graf; Bhushan Bharat-R65777; a.motakis@virtualopensystems.com;
> virtualization@lists.linux-foundation.org
> Subject: Re: binding/unbinding devices to vfio-pci
> 
> On Tue, 2013-07-02 at 14:15 +0000, Yoder Stuart-B08248 wrote:
> > Alex,
> >
> > I'm trying to think through how binding/unbinding of devices will
> > work with VFIO for platform devices and have a couple of questions
> > about how vfio-pci works.
> >
> > When you bind a device to vfio-pci, e.g.:
> > # echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
> >
> > ...I understand that the echo into 'new_id' tells the
> > vfio pci driver that it now handles the specified PCI ID.
> >
> > But now there are 2 drivers that handle that PCI ID,
> > the original host driver and vfio-pci.   Say that
> > you hotplug a PCI device that matches that ID.   Which of
> > the 2 drivers are going to get bound to the device?
> >
> > Also, if you unbind a device from vfio-pci and want to
> > bind it again to the normal host driver you would just
> > echo the full device info into the 'bind' sysfs file
> > for the host driver, right?
> >
> >     echo 0000:06:0d.0 > /sys/bus/pci/drivers/...
> 
> Hi Stuart,
> 
> The driver binding interface is far from perfect.  In your scenario
> where you've added the ID for one device, then hotplug another device
> with the same ID, the results are indeterminate.  Both vfio-pci and the
> host driver, assuming it's still loaded, can claim the device, it's just
> a matter of which gets probed first.
> 
> Generally that window should be very short though.  To bind a device,
> the user should do:
> 
> 1) echo ssss:bb:dd.f > /sys/bus/pci/devices/ssss:bb:dd.f/driver/unbind
> 2) echo vvvv dddd > /sys/bus/pci/drivers/vfio-pci/new_id
> 3) echo ssss:bb:dd.f > /sys/bus/pci/drivers/vfio-pci/bind
> 4) echo vvvv dddd > /sys/bus/pci/drivers/vfio-pci/remove_id
> 
> There are actually a number of ways you can do this and the default
> autoprobe behavior really makes step 3) unnecessary as the driver core
> will probe any unbound devices as soon as a new_id is added to vfio-pci.
> That can be changed by:
> 
> # echo 0 > /sys/bus/pci/drivers_autoprobe
> 
> But then we have to worry about races from any devices that might have
> been hotplugged in the interim.

But, even apart from hot-plugged devices, what about the device
we just unbound?  There are now 2 host drivers that can handle the
device when the autoprobe happens.  Is it just luck that vfio-pci
is the one that gets the device?

Stuart
