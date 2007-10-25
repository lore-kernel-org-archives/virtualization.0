From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] lguest: paravirt boot code
Date: Thu, 25 Oct 2007 15:41:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251538590.30120__42886.2851499163$1193352229$gmane$org@woody.linux-foundation.org>
References: <200710221237.14542.rusty@rustcorp.com.au>
	<200710231603.21620.rusty@rustcorp.com.au>
	<alpine.LFD.0.999.0710230903330.30120@woody.linux-foundation.org>
	<200710251519.05641.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710251519.05641.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On Thu, 25 Oct 2007, Rusty Russell wrote:
> >
> > 	git diff -M --stat --summary
> 
> Thanks, that is much better.  I was just happy to locate git diff in the 133 
> git commands on my system; finding options 4, 8 and 22 was beyond my skill.

Hey, we give you the power. Actually realizing it all and getting used to 
it may take some time. In the meantime, you can use the pre-canned helper 
functions and just cut-and-paste from emails ;)

One of the 133 git commands is actually "git request-pull" that does this 
all for you. I always forget it, because I don't use it myself, and quite 
frankly, it's just a shell-script helper to do this all for you. But if 
you're into that kind of thing, you can actually read that shell-script 
(and others) and learn more that way ;)

		Linus
