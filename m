From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 19:26:44 +0300
Message-ID: <20090610162644.GJ28601__40075.8603624583$1244651764$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906101615.12956.paul@codesourcery.com>
	<20090610155238.GH28601@redhat.com>
	<200906101708.27815.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906101708.27815.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2009 at 05:08:15PM +0100, Paul Brook wrote:
> On Wednesday 10 June 2009, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2009 at 04:15:04PM +0100, Paul Brook wrote:
> > > > > That's seems just plain wrong to me.
> > > > > Loading a VM shouldn't not
> > > > > do anything that can't happen during normal operation.
> > > >
> > > > At least wrt pci, we are very far from this state: load just overwrites
> > > > all registers, readonly or not, which can never happen during normal
> > > > operation.
> > >
> > > IMO that code is wrong. We should only be loading things that the guest
> > > can change (directly or indirectly).
> >
> > Making it work this way will mean that minor changes to a device can
> > break backwards compatibility with old images, often in surprising ways.
> > What are the advantages?
> 
> If you can't create an identical machine from scratch then I don't consider 
> snapshot/migration to be a useful feature. i.e. as soon as you shutdown and 
> restart the guest it is liable to break anyway.

Why is liable to break?
Configuration does not change until you load another image.
Look here:

void msix_reset(PCIDevice *dev)
{
    if (!(dev->cap_present & QEMU_PCI_CAP_MSIX))
        return;

...
}

So once you load and image with MSIX capability off,
it will stay off across guest restarts.

> It may be that the snapshot/migration code wants to include a machine config, 
> and create a new machine from that. However this is a separate issue, and 
> arguably something your VM manager should be handling for you.
> 
> Paul

Since the image already has a necessary information, duplicating
it in a separate machine config will just lead to errors.

-- 
MST
