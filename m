From: Hannes Reinecke <hare@suse.de>
Subject: PCI device not properly reset after VFIO
Date: Thu, 18 Oct 2012 08:47:30 +0200
Message-ID: <507FA602.9050801@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: kvm-devel <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Alex,

I've been playing around with VFIO and megasas (of course).
What I did now was switching between VFIO and 'normal' operation, ie =

emulated access.

megasas is happily running under VFIO, but when I do an emergency =

stop like killing the Qemu session the PCI device is not properly reset.
IE when I load 'megaraid_sas' after unbinding the vfio_pci module
the driver cannot initialize the card and waits forever for the =

firmware state to change.

I need to do a proper pci reset via
echo 1 > /sys/bus/pci/device/XXXX/reset
to get it into a working state again.

Looking at vfio_pci_disable() pci reset is called before the config =

state and BARs are restored.
Seeing that vfio_pci_enable() calls pci reset right at the start, =

too, before modifying anything I do wonder whether the pci reset is =

at the correct location for disable.

I would have expected to call pci reset in vfio_pci_disable() =

_after_ we have restored the configuration, to ensure a sane state =

after reset.
And, as experience show, we do need to call it there.

So what is the rationale for the pci reset?
Can we move it to the end of vfio_pci_disable() or do we need to =

call pci reset twice?

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
