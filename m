From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 11 Jan 2012 19:08:59 +0200
Message-ID: <20120111170859.GA22310@redhat.com>
References: <878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au> <4F0D8EFA.3010503@codemonkey.ws>
	<20120111151230.GA20570@redhat.com>
	<4F0DA7A5.7050600@codemonkey.ws>
	<20120111152129.GB20570@redhat.com>
	<4F0DAA9B.7060703@codemonkey.ws>
	<20120111154515.GD20570@redhat.com>
	<4F0DB2AB.8030506@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F0DB2AB.8030506@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Pawel Moll <pawel.moll@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2012 at 10:02:51AM -0600, Anthony Liguori wrote:
> On 01/11/2012 09:45 AM, Michael S. Tsirkin wrote:
> >On Wed, Jan 11, 2012 at 09:28:27AM -0600, Anthony Liguori wrote:
> >>On 01/11/2012 09:21 AM, Michael S. Tsirkin wrote:
> >>>On Wed, Jan 11, 2012 at 09:15:49AM -0600, Anthony Liguori wrote:
> >>>>>This is similar to what we have now. But it's still buggy: e.g. if guest
> >>>>>updates MAC byte by byte, we have no way to know when it's done doing
> >>>>>so.
> >>>>
> >>>>This is no different than a normal network card.  You have to use a
> >>>>secondary register to trigger an update.
> >>>>
> >>>>Regards,
> >>>>
> >>>>Anthony Liguori
> >>>
> >>>Possible but doesn't let us layer nicely to allow unchanged drivers
> >>>that work with all transports (new pci, old pci, non pci).
> >>
> >>If we declare config space LE, then we have to touch all drivers.
> >>There's no way around it because the virtio API is byte-based, not
> >>word based.
> >
> >Fine but don't we want to be compatible with old hypervisors?
> 
> We can modify the drivers to work either with a virtio1 or virtio2
> transport. If the only difference is that we move to word access
> instead of byte access for the config space, it's a nop because
> drivers don't rely on sub-word access today.
> 
> >>This is why I'm suggesting making the virtio API (and then the
> >>virtio-pci ABI) word based.  It gives us the flexibility to make
> >>endianness a property of the transport and not a property of the
> >>devices.
> >>
> >>Regards,
> >>
> >>Anthony Liguori
> >
> >Some fields are 64 bit, this is still tricky to do atomically.
> >What's the objection to using a config VQ?
> 
> Then we move very far away from something that looks like a PCI
> device.  The problem we're having here is specifically where we've
> deviated from what a normal PCI device would do.  Fixing that by
> deviating even further seems counter intuitive to me.
> 
> Regards,
> 
> Anthony Liguori


Not sure what you mean. Using VQ is DMA which is pretty common for PCI.

> >
