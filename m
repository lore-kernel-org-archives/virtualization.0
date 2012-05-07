From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio message framing
Date: Mon, 07 May 2012 12:42:15 +0930
Message-ID: <878vh4hegg.fsf@rustcorp.com.au>
References: <CAJSP0QWPih2NmRvF3D-HXEH72t3pvvywoes-_wv2dAjHKg8Fjg@mail.gmail.com>
	<4F884AC2.9030202@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F884AC2.9030202@us.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 13 Apr 2012 10:48:18 -0500, Anthony Liguori <aliguori@us.ibm.com> wrote:
> On 04/13/2012 09:50 AM, Stefan Hajnoczi wrote:
> > The virtio specification says:
> >
> > "The descriptors used for a buffer should not effect the semantics
> > of the message,
> > except for the total length of the buffer"
> >
> > and
> >
> > "In particular, no implementation should use the descriptor boundaries
> > to determine the size of any header in a request"
> 
> This was the noble intention but all of the implementations actually rely on 
> boundary sizes.
> 
> Both QEMU and lguest rely on boundary sizes.  We've removed some of it in 
> virtio-net in QEMU but it still looks like it's there for virtio-blk.

I will fix lguest.  It's a poor excuse to say that lguest doens't have
an ABI, so it can take these shortcuts; it's also the exemplar.

> kvm tool also makes this assumption.
> 
> > Why should descriptor layout not be specified?
> >
> > It seems that implementing arbitrary descriptor layout support (e.g.
> > 1-byte descriptors) requires more code and makes input validation
> > harder.
> >
> > Why bother with the flexibility of unspecified descriptor layouts?  As
> > long as the layout is specified clearly it makes everyone's lives
> > easier to use a strict descriptor layout.
> 
> I hate to just change the spec here but I don't see a better option.

For example, in the net code, we could often pack the virtio_net header
into the skb and save a descriptor.

We didn't do this because it would break qemu.

Added to TODO list: a new DEBUG config option which breaks up virtio
descriptors.

Thanks,
Rusty.
