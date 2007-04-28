From: Andi Kleen <ak@suse.de>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 10:42:48 +0200
Message-ID: <200704281042.48440.ak@suse.de>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com> <4632FD3E.401@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4632FD3E.401@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: James.Bottomley@hansenpartnership.com, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 28 April 2007 09:52:30 Jeremy Fitzhardinge wrote:
> Eric W. Biederman wrote:
> > Next time I'm in a really tormenting mood I will fire up my 
> > my ibm ps2 with it's 16Mhz 386 and 6MB and verify that all is working
> > well there.
> >   
> 
> Well, that would be interesting. From a subarch perspective, it would
> just be the normal default, and in theory it should work fine. But I
> suspect the fpu emulator is probably broken, and non-WP is likely to
> have rotted, 

AFAIK it's been tested occasionally on some embedded 386 systems
(e.g. by Thomas Gleixner). Probably not with the recent changes though. 

> and lots of other things. Is that an MCA machine? 

Yes should be.
 
> > I really don't think it is ok to be cavalier about anything
> > that we actually support.  Usually if we can handle the general
> > case it makes for better more maintainable code.
> >
> > So far the paravirt class of machines seems every bit as much a subarch
> > as voyager and every bit as interesting.
> >   
> Well, not really. The problem with the subarch mechanism is that it
> promotes a lot of copied code with small modifications, and so making
> changes is the inherently non-general activity of trying to find all the
> various copies, work out what subtle differences they have, and try to
> make the appropriate changes in each case. This was one of the major
> objections to the original Xen-as-subarch patches, and it is the problem
> with Voyager. The mass of preprocessor tricks doesn't help either.

Yes I agree. Current i386 subarch is a mess and I hope to slowly phase
it out. mach-{es7000,summit} should just be folded into mach-generic
always (like x86-64) and I'm somewhat hoping that mach-voyager and 
perhaps mach-visws too will just go away at some point.

The future direction are focussed pluggable interfaces like genapic, smp_ops etc.

-Andi
