From: corbet@lwn.net (Jonathan Corbet)
Subject: Re: [PATCH 1/7] lguest: documentation pt I: Preparation
Date: Tue, 24 Jul 2007 09:13:14 -0600
Message-ID: <5659.1185289994__5975.66892761296$1185290954$gmane$org@lwn.net>
References: <20070723171238.1a832b31.akpm@linux-foundation.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: Your message of "Mon, 23 Jul 2007 17:12:38 PDT."
	<20070723171238.1a832b31.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Rob Landley <rob@landley.net>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> Items for consideration would be:
> 
> - if this stuff is good, shouldn't other code be using it?  If so, is
>   this new infrastructure in the correct place?
> 
> - if, otoh, this infrastructure is _not_ suitable for other code, well,
>   what was wrong with it?
> 
> - if the requirement is good, perhaps alternative implementations should
>   be explored (dunno what).

Well, we could just rewrite the whole kernel in Web and judge all future
patches on how literate they are...

Seriously, though, even if the (small) infrastructure is not going to
take over the driver tree anytime soon, it's hard to imagine why we
would not want to incorporate this sort of documentation.  It's good
stuff, something which can really help people get a sense for how this
whole virtualization thing works.  And it makes the code fun to read.

jon

P.S. I am currently considering a no-limericks policy for the LWN quote
of the week.
