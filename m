From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 21:07:56 +0300
Message-ID: <20090610180756.GM28601__6225.35840743712$1244657508$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906101746.06740.paul@codesourcery.com>
	<20090610170306.GL28601@redhat.com>
	<200906101830.21537.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906101830.21537.paul@codesourcery.com>
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

On Wed, Jun 10, 2009 at 06:30:16PM +0100, Paul Brook wrote:
> On Wednesday 10 June 2009, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2009 at 05:46:03PM +0100, Paul Brook wrote:
> > > > > If you can't create an identical machine from scratch then I don't
> > > > > consider snapshot/migration to be a useful feature. i.e. as soon as
> > > > > you shutdown and restart the guest it is liable to break anyway.
> > > >
> > > > Why is liable to break?
> > >
> > > A VM booted on an old version of qemu and migrated to a new version will
> > > behave differently to a the same VM booted on a new version of qemu.
> >
> > It will behave identically. That's what the patch does: discover
> > how did the device behave on old qemu, and make it behave the same way
> > on new qemu.
> 
> You're missing the point.  After doing a live migration from old-qemu to new-
> qemu, there is no snapshot to load.  We need to be able to shutdown the guest, 
> kill qemu (without saving a snapshot), then start qemu with the exact same 
> hardware.

Yes, I see how this would sometimes be useful. So this feature request
would mean that we need a flag to disable msix in virtio net.

I think we can agree that hardware can change across reboots. It can
with real hardware and it happens without guest doing anything.

> If we can't start a new qemu with the same hardware configuration then we 
> should not be allowing migration or loading of snapshots.
> 
> Paul

OK, so I'll add an option in virtio-net to disable msi-x, and such
an option will be added in any device with msi-x support.
Will that address your concern?

-- 
MST
