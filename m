From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 17:47:39 +0300
Message-ID: <20090610144739.GA28601__4351.73797091029$1244645490$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906101507.39823.paul@codesourcery.com>
	<20090610142508.GA28409@redhat.com>
	<200906101539.12367.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906101539.12367.paul@codesourcery.com>
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

On Wed, Jun 10, 2009 at 03:39:05PM +0100, Paul Brook wrote:
> > > If we really need to avoid MSI-X capable devices then that should be done
> > > explicity per-device. i.e. you have a different virtio-net device that
> > > does not use MSI-X.
> > >
> > > Paul
> >
> > Why should it be done per-device?
> 
> 
> Because otherwise you end up with the horrible hacks that you're currently 
> tripping over: devices have to magically morph into a different device when 
> you load a VM.

No, the hacks are there so I that I can support loading and saving from
non-MSI setups in a backward-compatible way.

The flag we are discussing is set at qemu startup and can't change
across load/store.

> That's seems just plain wrong to me.
> Loading a VM shouldn't not 
> do anything that can't happen during normal operation.

At least wrt pci, we are very far from this state: load just overwrites
all registers, readonly or not, which can never happen during normal
operation. And if we "fix" it, and only edit BAR registers, the happy
result will be that we can't add functionality to PCI devices without
breaking guests and/or breaking loading from old images each time.

> Paul



-- 
MST
