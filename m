From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-pci new configuration proposal
Date: Wed, 2 Nov 2011 21:14:05 +0200
Message-ID: <20111102191405.GA13998@redhat.com>
References: <1320259767.22582.2.camel@lappy>
	<20111102190804.GA13914@redhat.com>
	<1320260832.22582.3.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320260832.22582.3.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 02, 2011 at 09:07:12PM +0200, Sasha Levin wrote:
> On Wed, 2011-11-02 at 21:08 +0200, Michael S. Tsirkin wrote:
> > On Wed, Nov 02, 2011 at 08:49:27PM +0200, Sasha Levin wrote:
> > > This is a proposal for a new layout of the virtio-pci config space.
> > > 
> > > We will separate the current configuration into two: A virtio-pci common
> > > configuration and a device specific configuration. This allows more flexibility
> > > with adding features and makes usage easier, specifically in cases like the
> > > ones in virtio-net where device specific configurations depend on device
> > > specific features.
> > > 
> > > The preferred location of the configuration will be a MMIO BAR, therefore
> > > several size optimizations such as the queue selector which were useful
> > > on a PIO BAR were removed and linked lists were introduced to add
> > > flexibility to existing structures in attempt to keep their size and
> > > offsets constant and not dependent on features.
> > > 
> > > While this is not a complete specification, it describes all the main
> > > structures and should be enough to make sure the idea is solid before
> > > going into implementation specifics.
> > > 
> > > A new virtio-pci capability structure will be introduced. This structure
> > > will be used to describe the basics of a virtio-pci device. The
> > > structure is actually a PCI capability structure which wraps the new virtio-pci
> > > capability structure:
> > > 
> > > +------------++------------+------------+------------+--------------+-----------------
> > > | Bits       || 8          | 8          | 8          | 8            | Cap specific
> > > +------------++------------+------------+------------+--------------+-----------------
> > > | Read/Write || R          | R          | R          | R            | Cap specific
> > > +------------++------------+------------+------------+--------------+-----------------
> > > | Purpose    || Capability | Capability | virtio-pci | virtio-pci   | Cap specific
> > > |            || ID         | Next PTR   | Cap ID     | Next Cap PTR |
> > > +------------++------------+------------+------------+--------------+-----------------
> > > 
> > > Currently, only one virtio-pci capability is defined, and is the one that defines
> > > the layout of the virtio-pci config space.
> > > 
> > > VIRTIO_PCI_C_LAYOUT:
> > > 
> > > +------------++---------------+---------------+-----------------+-----------------+
> > > | Bits       || 29            | 3             | 29              | 3               |
> > > +------------++---------------+---------------+-----------------+-----------------+
> > > | Read/Write || R             | R             | R               | R               |
> > > +------------++---------------+---------------+-----------------+-----------------+
> > > | Purpose    || Common config | Common config | Device specific | Device specific |
> > > |            || Offset        | BIR           | Offset          | BIR             |
> > > +------------++---------------+---------------+-----------------+-----------------+
> > 
> > I'm implementing a different layout, with
> > separate capabilities for common and device specific
> > fields.
> 
> Which is what I have here, no?

No :) Give me a couple of hours I'll send an RFC patch so you can see
what I mean.

> -- 
> 
> Sasha.
