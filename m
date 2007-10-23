From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] lguest: paravirt boot code
Date: Mon, 22 Oct 2007 19:28:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710221927131.30120__3135.85044718838$1193151282$gmane$org@woody.linux-foundation.org>
References: <200710221237.14542.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710221237.14542.rusty@rustcorp.com.au>
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
Cc: lguest <lguest@ozlabs.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On Mon, 22 Oct 2007, Rusty Russell wrote:
> 
> 	First attempt at git, so please pull carefully.  I've just put the
> three i386 boot changes in the repo for the moment.  If this works I'll pile 
> on the 44 lguest patches.

Well, it looked ok, but I had already merged the same patches through 
Andrew, so when I pulled, I had no differences. So I ended up unpulling, 
but not because there was anything *wrong* with your tree, just because 
the pull didn't give me anything but a slightly more complex history ;)

		Linus
