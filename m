From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 00/11] qemu: towards virtio-1 host support
Date: Thu, 30 Oct 2014 17:52:51 +0100
Message-ID: <20141030175251.4f28d2a8.cornelia.huck@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141023214158.GA29716@redhat.com>
	<20141024103839.7162b93f.cornelia.huck@de.ibm.com>
	<20141028044329.GA18689@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141028044329.GA18689@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 28 Oct 2014 06:43:29 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Oct 24, 2014 at 10:38:39AM +0200, Cornelia Huck wrote:
> > On Fri, 24 Oct 2014 00:42:20 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Tue, Oct 07, 2014 at 04:39:56PM +0200, Cornelia Huck wrote:
> > > > This patchset aims to get us some way to implement virtio-1 compliant
> > > > and transitional devices in qemu. Branch available at
> > > > 
> > > > git://github.com/cohuck/qemu virtio-1
> > > > 
> > > > I've mainly focused on:
> > > > - endianness handling
> > > > - extended feature bits
> > > > - virtio-ccw new/changed commands
> > > 
> > > So issues identified so far:
> > 
> > Thanks for taking a look.
> > 
> > > - devices not converted yet should not advertize 1.0
> > 
> > Neither should an uncoverted transport. So we either can
> > - have transport set the bit and rely on devices ->get_features
> >   callback to mask it out
> >   (virtio-ccw has to change the calling order for get_features, btw.)
> > - have device set the bit and the transport mask it out later. Feels a
> >   bit weird, as virtio-1 is a transport feature bit.
> 
> 
> I thought more about it, I think the right thing
> would be for unconverted transports to clear
> high bits on ack and get features.

This should work out of the box with my patches (virtio-pci and
virtio-mmio return 0 for high feature bits).

> 
> So bit 32 is set, but not exposed to guests.
> In fact at least for PCI, we have a 32 bit field for
> features in 0.9 so it's automatic.
> Didn't check mmio yet.

We still to make sure the bit is not set for unconverted devices,
though. But you're probably right that having the device set the bit is
less error-prone.
