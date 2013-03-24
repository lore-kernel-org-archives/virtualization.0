From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Sun, 24 Mar 2013 15:14:08 +0200
Message-ID: <20130324131408.GD6601@redhat.com>
References: <20130321161143.GC1925@redhat.com> <514B3213.8070002@zytor.com>
	<20130321162636.GF1925@redhat.com> <514B3606.2090503@zytor.com>
	<20130321170706.GB2994@redhat.com> <514B3EAE.8000707@zytor.com>
	<20130321171319.GD2994@redhat.com>
	<20130321174912.GA4161@redhat.com> <514B4957.1070003@zytor.com>
	<8738vofdyg.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8738vofdyg.fsf@rustcorp.com.au>
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

On Fri, Mar 22, 2013 at 11:27:59AM +1030, Rusty Russell wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> > On 03/21/2013 10:49 AM, Michael S. Tsirkin wrote:
> >> 
> >> Just to clarify, I expect BIOS to use it *for config access*.
> >> Notification will support IO anyway because it's
> >> faster on KVM, so BIOS can use it directly.
> >> 
> >
> > Ah, yes, of course.
> >
> > Quite frankly, I don't see any reason to support *anything else* for
> > configuration, does anyone else?
> >
> > I thought we were talking about the doorbell/notification/kicker
> > register.  For I/O space especially it is highly desirable if that can
> > be in a minimal BAR (4 bytes).
> 
> The takeaway from this seems to be that:
> 1) For the notification, device can supply both.
> 2) Since only device will know which is faster, driver should use the
>    first one it finds which it supports.
> 
> My patch implied that the ISR, device config and notification could be
> either.  I think only the notification makes sense, as noted here.
> 
> Have I got this right?
> Rusty.

Peter is also saying we need a way to
do configuration/ISR without memory accesses.

-- 
MST
