From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/2] Fix hot-unplug: device removal while port in use
Date: Fri, 11 Mar 2011 16:46:28 +0530
Message-ID: <20110311111628.GC8908@amit-x200.redhat.com>
References: <cover.1299054025.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1299054025.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: markmc@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 02 Mar 2011 [13:53:06], Amit Shah wrote:
> The second patch fixes a warning where the pci region is already
> freed.  I'm not sure what or how the region gets freed, any clues
> there will be helpful.

OK, so in the case where a virtio-console port is in use (opened by a
program) and a virtio-console device is removed, the port is kept
around but all the virtio-related state is assumed to be gone.

When the port is finally released (close() called), we call
device_destroy() on the port's device.  This results in the parent
device's structures to be freed as well.  This includes the PCI
regions for the virtio-console PCI device.

Once this is done, however, virtio_pci_release_dev() kicks in, as the
last ref to the virtio device is now gone, and attempts to do

     pci_iounmap(pci_dev, vp_dev->ioaddr);
     pci_release_regions(pci_dev);
     pci_disable_device(pci_dev);

which results in the double-free warning.

Ideally virtio_pci_release_dev() shouldn't be needed at all; all that
work can be moved to virtio_pci_remove().  virtio_pci_release_dev()
was added in 29f9f12e to curb a warning:

    virtio: add PCI device release() function
    
    Add a release() function for virtio_pci devices so as to avoid:
    
      Device 'virtio0' does not have a release() function, it is
      broken and must be fixed
    

So we could have an empty release() function that does nothing, and
all of the current functionality be moved to virtio_pci_remove(), as
it was earlier.  This should keep everyone happy.

Is that fine?

		Amit
