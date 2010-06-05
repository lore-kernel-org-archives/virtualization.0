From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv3 1/2] virtio: support layout with avail ring before idx
Date: Sat, 5 Jun 2010 13:40:26 +0930
Message-ID: <201006051340.27194.rusty__3420.88985858044$1275711071$gmane$org@rustcorp.com.au>
References: <cover.1275403477.git.mst@redhat.com>
	<201006042046.49872.rusty@rustcorp.com.au>
	<20100604114205.GA22599@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100604114205.GA22599@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 4 Jun 2010 09:12:05 pm Michael S. Tsirkin wrote:
> On Fri, Jun 04, 2010 at 08:46:49PM +0930, Rusty Russell wrote:
> > I'm uncomfortable with moving a field.
> > 
> > We haven't done that before and I wonder what will break with old code.
> 
> With e.g. my patch, We only do this conditionally when bit is negotitated.

Of course, but see this change:

commit ef688e151c00e5d529703be9a04fd506df8bc54e
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Fri Jun 12 22:16:35 2009 -0600

    virtio: meet virtio spec by finalizing features before using device
    
    Virtio devices are supposed to negotiate features before they start using
    the device, but the current code doesn't do this.  This is because the
    driver's probe() function invariably has to add buffers to a virtqueue,
    or probe the disk (virtio_blk).
    
    This currently doesn't matter since no existing backend is strict about
    the feature negotiation.  But it's possible to imagine a future feature
    which completely changes how a device operates: in this case, we'd need
    to acknowledge it before using the device.
    
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Now, this isn't impossible to overcome: we know that if they use the ring
before completing feature negotiation then they don't understand the new
format.

But we have to be aware of that on the qemu side.  Are we?

> > Should we instead just abandon the flags field and use last_used only?
> > Or, more radically, put flags == last_used when the feature is on?
> > 
> > Thoughts?
> > Rusty.
> 
> Hmm, e.g. with TX and virtio net, we almost never want interrupts,
> whatever the index value.

Good point.  OK, I give in, I'll take your patch which moves the fields
to the end.  Is that your preference?

Please be careful with the qemu side though...

It's not inconceivable that I'll write that virtio cacheline simulator this
(coming) week, too...

Thanks.
Rusty.
