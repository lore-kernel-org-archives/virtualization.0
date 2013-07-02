From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: binding/unbinding devices to vfio-pci
Date: Tue, 2 Jul 2013 14:15:20 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503632FA9__43733.1550325782$1372778051$gmane$org@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

Alex,

I'm trying to think through how binding/unbinding of devices will
work with VFIO for platform devices and have a couple of questions
about how vfio-pci works.

When you bind a device to vfio-pci, e.g.:
# echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id

...I understand that the echo into 'new_id' tells the
vfio pci driver that it now handles the specified PCI ID.

But now there are 2 drivers that handle that PCI ID,
the original host driver and vfio-pci.   Say that
you hotplug a PCI device that matches that ID.   Which of
the 2 drivers are going to get bound to the device?

Also, if you unbind a device from vfio-pci and want to
bind it again to the normal host driver you would just
echo the full device info into the 'bind' sysfs file
for the host driver, right?

    echo 0000:06:0d.0 > /sys/bus/pci/drivers/...

Thanks,
Stuart
