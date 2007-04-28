From: Andi Kleen <ak@suse.de>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 11:37:52 +0200
Message-ID: <200704281137.52460.ak@suse.de>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<200704281042.48440.ak@suse.de>
	<m1k5vwg8qy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1k5vwg8qy.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James.Bottomley@hansenpartnership.com, virtualization@lists.osdl.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 28 April 2007 11:15:33 Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Saturday 28 April 2007 09:52:30 Jeremy Fitzhardinge wrote:
> >> Well, not really. The problem with the subarch mechanism is that it
> >> promotes a lot of copied code with small modifications, and so making
> >> changes is the inherently non-general activity of trying to find all the
> >> various copies, work out what subtle differences they have, and try to
> >> make the appropriate changes in each case. This was one of the major
> >> objections to the original Xen-as-subarch patches, and it is the problem
> >> with Voyager. The mass of preprocessor tricks doesn't help either.
> >
> > Yes I agree. Current i386 subarch is a mess and I hope to slowly phase
> > it out. mach-{es7000,summit} should just be folded into mach-generic
> > always (like x86-64) and I'm somewhat hoping that mach-voyager and 
> > perhaps mach-visws too will just go away at some point.
> 
> There is a possibility, that arch/i386 will seen renewed life as an
> embedded architecture.  At which point things like mach-visws may
> start proliferating.

Scary thought. But I don't see why people using embedded x86s should suddenly
design new interrupt controllers etc. - after all the main value of using x86s
embedded is some degree of compatibility to PC software.  Ok, we'll see what
happens.
 
> So I think it makes a lot of sense to see if we can fold mach-visws
> and mach-voyager into appropriate pluggable interfaces.

For voyager and NUMAQ i think it's fine to just wait until the last machine dies
(James, how many do you have left? @] iirc the number of NUMAQs still in operation
is also slowly decreasing) 
 
-Andi
