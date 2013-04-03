From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Wed, 3 Apr 2013 14:22:17 +0300
Message-ID: <20130403112216.GB19122@redhat.com>
References: <87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com>
	<8738vjer43.fsf@rustcorp.com.au>
	<20130326193911.GA19251@redhat.com>
	<87ip4d4sef.fsf@rustcorp.com.au>
	<20130327112535.GE24243@redhat.com> <5153CC2E.3090908@zytor.com>
	<878v554lsr.fsf@rustcorp.com.au> <515B610C.9000802@zytor.com>
	<8738v85elm.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8738v85elm.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 03, 2013 at 04:40:29PM +1030, Rusty Russell wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> > On 03/29/2013 08:19 PM, Rusty Russell wrote:
> >>>
> >>> Shift count?
> >> 
> >> You can only have 2^16 vqs per device.  Is it verboten to write 16-bit
> >> values to odd offsets?  If so, we've just dropped it to 2^15 before you
> >> have to do some decoding to do.  Hard to care...
> >> 
> >> I dislike saying "multiply offset by 2" because implementations will get
> >> it wrong.  That's because 0 will work either way, and that's going to be
> >> the common case.
> >> 
> >
> > The main reason to use a shift count is that it lets the guest driver
> > assume that the spacing is a power of two, requiring only shift, as
> > opposed to an arbitrary number, requiring a multiply.  It seems unlikely
> > that there would be a legitimate reason for a non-power-of-two spacing
> > between the VQ notifiers.
> >
> > The other reason is that if a particular host implementation needs
> > separate pages for each notifier, that can be a pretty large number.
> 
> Ah, sorry, we're talking across each other a bit.
> 
> Current proposal is a 16 bit 'offset' field in the queue data for each
> queue, ie.
>         addr = dev->notify_base + vq->notify_off;
> 
> You propose a per-device 'shift' field:
>         addr = dev->notify_base + (vq->index << dev->notify_shift);
> 
> Which allows greater offsets, but insists on a unique offset per queue.
> Might be a fair trade-off...
> 
> Cheers,
> Rusty.

Or even
         addr = dev->notify_base + (vq->notify_off << dev->notify_shift);

since notify_base is per capability, shift can be per capability too.
And for IO we can allow it to be 32 to mean "always use base".

This is a bit more elegant than just saying "no offsets for IO".

-- 
MST
