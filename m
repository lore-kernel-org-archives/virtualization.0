From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-pci new configuration proposal
Date: Thu, 3 Nov 2011 14:46:51 +0200
Message-ID: <20111103124651.GK18296@redhat.com>
References: <1320259767.22582.2.camel@lappy> <8762j2t19l.fsf@rustcorp.com.au>
	<1320309203.29407.1.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320309203.29407.1.camel@lappy>
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
Cc: Anthony Liguori <anthony@codemonkey.ws>, linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 03, 2011 at 10:33:23AM +0200, Sasha Levin wrote:
> On Thu, 2011-11-03 at 12:28 +1030, Rusty Russell wrote: 
> > On Wed, 02 Nov 2011 20:49:27 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> > > This is a proposal for a new layout of the virtio-pci config space.
> > > 
> > > We will separate the current configuration into two: A virtio-pci common
> > > configuration and a device specific configuration. This allows more flexibility
> > > with adding features and makes usage easier, specifically in cases like the
> > > ones in virtio-net where device specific configurations depend on device
> > > specific features.
> > 
> > Thanks for this Sasha.  Several general comments:
> > 
> > 1) How to we distinguish the two layouts?  In theory, we need to do this
> >    forever.  In practice we can deprecate the old layout in several
> >    years' time.
> 
> Old layouts won't have the new virtio-pci cap structure in their PCI
> config space.

What happens next time we want to change something?

> > 2) I don't think we want to turn the device-specific config into a
> >    linked list.  We haven't needed variable-length config (yet!), and
> >    it's (slightly) more complex.  That's also the part of the spec which
> >    is shared with non-PCI virtio implementations.
> 
> Variable length config wasn't used yet because space in the device
> specific space was reserved for a feature even if that feature wasn't
> used.

Not only that, also because it is messy to debug.  With fixed offsets
you just print the address/data and you know what it's doing.

> For example, the MAC feature reserved 6 bytes in the config space for
> the MAC even if VIRTIO_NET_F_MAC wasn't enabled. Here we can just avoid
> having it pollute the config space until it's enabled.
> 

This looks like overdesign to me. The only reason PCI spec
used capability list is
1. to save space
2. standard mechanism to discover features
You say explicitly space is not an issue, and you keep
feature bits around.

> I don't think it'll have any impact on non-PCI implementations since the
> "pointers" are simply offsets from the beginning of the config space,
> and are not PCI specific in any way.

The APIs use a single offset cookie to pass configuration.
If you want capabilities, that will have to be changed.

> > 3) If we're changing the queue layout, it's a chance to fix a
> >    longstanding bug: let the guest notify the host of preferred
> >    queue size and alignment.
> 
> Yup, we can do that.
> 
> -- 
> 
> Sasha.
> 
