From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 11:48:31 +0200
Message-ID: <1177753711.7646.61.camel@localhost.localdomain>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<200704281042.48440.ak@suse.de>
	<1177751601.7646.58.camel@localhost.localdomain>
	<200704281139.24959.ak@suse.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281139.24959.ak@suse.de>
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

On Sat, 2007-04-28 at 11:39 +0200, Andi Kleen wrote:
> > Last test was 2.6.21-rc7, where I fixed the non-WP thing. The
> > FP-emulator seems to work.
> > 
> > Which kind of breakage is new ?
> 
> Nothing known so far, but there were a lot of changes recently. It would be good
> if you could retest mainline on that box once the x86 tree is merged up.

I added that box to my auto test farm of bizarre hardware already, so I
will notice breakage quite fast.

	tglx
