From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 03/13] qemu: add routines to manage PCI
	capabilities
Date: Wed, 10 Jun 2009 21:22:27 +0300
Message-ID: <20090610182227.GN28601__33494.488153565$1244658432$gmane$org@redhat.com>
References: <cover.1244192535.git.mst@redhat.com>
	<20090610145540.GI19375@poweredge.glommer>
	<20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090610174301.GC7416@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2009 at 06:43:02PM +0100, Jamie Lokier wrote:
> Paul Brook wrote:
> > > > caps can be anywhere, but we don't expect it to change during machine
> > > > execution lifetime.
> > > >
> > > > Or I am just confused by the name "pci_device_load" ?
> > >
> > > Right. So I want to load an image and it has capability X at offset Y.
> > > wmask has to match. I don't want to assume that we never change Y
> > > for the device without breaking old images, so I clear wmask here
> > > and set it up again after looking up capabilities that I loaded.
> > 
> > We should not be loading state into a different device (or a similar device 
> > with a different set of capabilities).
> > 
> > If you want to provide backwards compatibility then you should do that by 
> > creating a device that is the same as the original.  As I mentioned in my 
> > earlier mail, loading a snapshot should never do anything that can not be 
> > achieved through normal operation.
> 
> If you can create a machine be restoring a snapshot which you can't
> create by normally starting QEMU, then you'll soon have guests which
> work fine from their snapshots, but which cannot be booted without a
> snapshot because there's no way to boot the right machine for the guest.

Yes. This clearly isn't what I'm building here. You *can* create a guest
without msi-x support by passing an appropriate flag.

> Ssomeone might even have guests like that for years without noticing,
> because they always save and restore guest state using snapshots, then
> one day they simply want to boot the guest from it's disk image and
> find there's no way to do it with any QEMU which runs on their host
> platform.
> 
> I think the right long term answer to all this is a way to get QEMU to
> dump it's current machine configuration in glorious detail as a file
> which can be reloaded as a machine configuration.
> 
> -- Jamie

And then we'll have the same set of problems there.

-- 
MST
