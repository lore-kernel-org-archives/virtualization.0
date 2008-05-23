From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Fwd: [PATCH]: Fix silly output for virtio devices in
	/proc/interrupts]
Date: Fri, 23 May 2008 12:43:10 +1000
Message-ID: <200805231243.10584.rusty__44451.7777571038$1211510732$gmane$org@rustcorp.com.au>
References: <48341FE1.4070305@redhat.com>
	<200805222238.58166.rusty@rustcorp.com.au>
	<4835EC94.8080508@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4835EC94.8080508@codemonkey.ws>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 23 May 2008 07:58:44 Anthony Liguori wrote:
> Rusty Russell wrote:
> > On Wednesday 21 May 2008 23:13:05 Chris Lalancette wrote:
> >> Author: Chris Lalancette <clalance@redhat.com>
> >> Date:   Thu May 15 09:04:55 2008 -0400
> >>
> >>     register_virtio_device was doing something silly, in that it was
> >> overwriting what the calling driver stuck into .bus_id" for the name. 
> >> This caused problems in the output of /proc/interrupts, since when you
> >> request_irq(), it doesn't actually copy the devname you pass in but just
> >> stores a pointer to the data.  The fix is to just not have
> >> register_virtio_device do anything with the bus_id, and assume the
> >> higher level driver set it up properly.
> >
> > OK, but only one higher-level driver will set it up properly: kvm. 
> > Neither lguest nor s/390 do this, and as a result, they fail to register
> > *any* devices.
> >
> > The following patch should fix it for s/390 (it's identical to the lguest
> > patch), but would prefer testing (S/390-ers cc'd).
>
> It may actually be better for virtio to set this up.  The problem is
> that if you have multiple transports that are registering virtio
> devices, it's impossible at the transport level to guarantee uniqueness
> while still using the "virtio%d" naming.  Except the current scheme is
> no good, we'd have to push the dev_index into virtio too.

That's true.  OK, let's hoist the index counter into common code instead.  The 
alternative is to use different busid namings for each transport, and that 
seems like too much confusion: sysfs will tell you where it comes from if you 
really need to know.

Patch series coming.

Thanks,
Rusty.
