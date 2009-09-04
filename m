From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 2/2] virtio-console: Add interface for generic
	guest-host communication
Date: Fri, 4 Sep 2009 14:07:49 +0530
Message-ID: <20090904083749.GA22230__8210.49004230208$1252053649$gmane$org@amit-x200.redhat.com>
References: <1251982412-11870-1-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-2-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-3-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-4-git-send-email-amit.shah@redhat.com>
	<m3ab1c9l6p.fsf@neno.mitica>
	<20090903142605.GB8613@amit-x200.redhat.com>
	<20090903144255.GB13361@amit-x200.redhat.com>
	<m3my5c6omr.fsf@neno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m3my5c6omr.fsf@neno.mitica>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juan Quintela <quintela@trasno.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Sep 03 2009 [17:20:44], Juan Quintela wrote:
> Amit Shah <amit.shah@redhat.com> wrote:
> 
> Hi
> 
> >> > > +static void virtio_console_set_port_active(uint32_t idx)
> >> > > +{
> >> > > +    int i = 0;
> >> > > +
> >> > > +    while (idx / 32) {
> >> > > +        i++;
> >> > > +        idx -= 32;
> >> > > +    }
> >> > 
> >> > It is just me, or you are doing a division + modulus in a very strange way?
> >> > 
> >> >    i = idx / 32;
> >> >    idx = idx % 32;
> >> > 
> >> > ???
> >
> > Er, sorry I left this out.
> >
> > That won't work for MAX_PORTS > 32.
> 
> Why not?

After a good night's sleep, I see that I was wrong :-)

You're right and I don't remember why I did it this way instead of just
using % from the start. Maybe I had a different way of storing it back
then; it's been a long time.

I also saw that I was wrong about the casts:

> > > +/* Readiness of the guest to accept data on a port */
> > > +static int vcon_can_read(void *opaque)
> > > +{
> > > +    VirtIOConsolePort *port = (VirtIOConsolePort *) opaque;
> > 
> > Cast is not needed here.

> This is original code that I've not modified (just moved around).

> But you're right; I could do that in this patch itself.

These were indeed introduced by me (and are now corrected).

Thanks!

		Amit
