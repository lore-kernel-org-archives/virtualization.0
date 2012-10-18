From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: PCI device not properly reset after VFIO
Date: Thu, 18 Oct 2012 08:40:30 -0600
Message-ID: <1350571230.2112.344.camel__20672.3898918883$1350571254$gmane$org@bling.home>
References: <507FA602.9050801@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <507FA602.9050801@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: kvm-devel <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Hannes,

Thanks for testing vfio

On Thu, 2012-10-18 at 08:47 +0200, Hannes Reinecke wrote:
> Hi Alex,
> 
> I've been playing around with VFIO and megasas (of course).
> What I did now was switching between VFIO and 'normal' operation, ie 
> emulated access.
> 
> megasas is happily running under VFIO, but when I do an emergency 
> stop like killing the Qemu session the PCI device is not properly reset.
> IE when I load 'megaraid_sas' after unbinding the vfio_pci module
> the driver cannot initialize the card and waits forever for the 
> firmware state to change.
> 
> I need to do a proper pci reset via
> echo 1 > /sys/bus/pci/device/XXXX/reset
> to get it into a working state again.
> 
> Looking at vfio_pci_disable() pci reset is called before the config 
> state and BARs are restored.
> Seeing that vfio_pci_enable() calls pci reset right at the start, 
> too, before modifying anything I do wonder whether the pci reset is 
> at the correct location for disable.
> 
> I would have expected to call pci reset in vfio_pci_disable() 
> _after_ we have restored the configuration, to ensure a sane state 
> after reset.
> And, as experience show, we do need to call it there.
> 
> So what is the rationale for the pci reset?
> Can we move it to the end of vfio_pci_disable() or do we need to 
> call pci reset twice?

I believe the rationale was that by resetting the device before we
restore the state we stop anything that the device was doing.  Restoring
the saved state on a running device seems like it could cause problems,
so you may be right and we actually need to do reset, load, restore,
reset.  Does adding another call to pci_reset_function in the
pci_restore_state (as below) solve the problem?  Traditional KVM device
assignment has a nearly identical path, does it have this same bug?
Thanks,

Alex

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 6c11994..d07a45c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -107,9 +107,10 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
        pci_reset_function(vdev->pdev);
 
        if (pci_load_and_free_saved_state(vdev->pdev,
-                                         &vdev->pci_saved_state) == 0)
+                                         &vdev->pci_saved_state) == 0) {
                pci_restore_state(vdev->pdev);
-       else
+               pci_reset_function(vdev->pdev);
+       } else
                pr_info("%s: Couldn't reload %s saved state\n",
                        __func__, dev_name(&vdev->pdev->dev));
