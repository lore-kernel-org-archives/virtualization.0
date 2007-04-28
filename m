From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 11:13:21 +0200
Message-ID: <1177751601.7646.58.camel@localhost.localdomain>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com> <4632FD3E.401@goop.org>
	<200704281042.48440.ak@suse.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281042.48440.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: James.Bottomley@hansenpartnership.com, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-04-28 at 10:42 +0200, Andi Kleen wrote:
> On Saturday 28 April 2007 09:52:30 Jeremy Fitzhardinge wrote:
> > Eric W. Biederman wrote:
> > > Next time I'm in a really tormenting mood I will fire up my 
> > > my ibm ps2 with it's 16Mhz 386 and 6MB and verify that all is working
> > > well there.
> > >   
> > 
> > Well, that would be interesting. From a subarch perspective, it would
> > just be the normal default, and in theory it should work fine. But I
> > suspect the fpu emulator is probably broken, and non-WP is likely to
> > have rotted, 
> 
> AFAIK it's been tested occasionally on some embedded 386 systems
> (e.g. by Thomas Gleixner). Probably not with the recent changes though. 

Last test was 2.6.21-rc7, where I fixed the non-WP thing. The
FP-emulator seems to work.

Which kind of breakage is new ?

	tglx
