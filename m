From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_pci: Prevent double-free of pci regions after
	device hot-unplug
Date: Wed, 16 Mar 2011 14:34:58 +1030
Message-ID: <871v27iuc5.fsf@rustcorp.com.au>
References: <f3e00b6450ee110e9dbe794d42ae058758e64d07.1300104900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f3e00b6450ee110e9dbe794d42ae058758e64d07.1300104900.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Mark McLoughlin <markmc@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 14 Mar 2011 17:45:02 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> In the case where a virtio-console port is in use (opened by a program)
> and a virtio-console device is removed, the port is kept around but all
> the virtio-related state is assumed to be gone.
> 
> When the port is finally released (close() called), we call
> device_destroy() on the port's device.  This results in the parent
> device's structures to be freed as well.  This includes the PCI regions
> for the virtio-console PCI device.
> 
> Once this is done, however, virtio_pci_release_dev() kicks in, as the
> last ref to the virtio device is now gone, and attempts to do
> 
>      pci_iounmap(pci_dev, vp_dev->ioaddr);
>      pci_release_regions(pci_dev);
>      pci_disable_device(pci_dev);
> 
> which results in a double-free warning.
> 
> Move the code that releases regions, etc., to the virtio_pci_remove()
> function, and all that's now left in release_dev is the final freeing of
> the vp_dev.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Applied.

Thanks,
Rusty.
