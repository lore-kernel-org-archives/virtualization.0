From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Thu, 03 May 2007 14:20:32 +1000
Message-ID: <1178166032.23670.16.camel__28102.5366195992$1178166090$gmane$org@localhost.localdomain>
References: <1178117028.19815.14.camel@localhost.localdomain>
	<20070502193303.GA1502@localhost.localdomain>
	<1178146848.23670.6.camel@localhost.localdomain>
	<20070503035749.GC2295@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070503035749.GC2295@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-05-03 at 11:57 +0800, WANG Cong wrote:
> On Thu, May 03, 2007 at 09:00:48AM +1000, Rusty Russell wrote:
> >	Thanks for the patch.  This omission (in several places) was
> >deliberate.  We can't really do anything sensible if the user unmapped
> >the page.  I assume you saw a gcc warning from this code?
> 
> Yes. In fact, I got two warnings, another one is in drivers/lguest/hypercalls.c.
> 
> If I understand you correctly, you mean we can do nothing useful to fix it?

We can, but we can ignore those warnings for the moment; they're
harmless.

> I have sent a mail which described the errors I got when comipling
> Documentation/lguest/lguest.c. But it seems that you didn't receive it
> (it didn't appear in lkml.org neither!).

Hmm, no, I didn't get it here either 8(

>  It is that, I have already made my .config as you suggested, but I
> still can't compile Documentation/lguest/lguest.c, errors are:
> 
> lguest.c: In function 'add_to_bridge':
> lguest.c:779: error: 'SIOCBRADDIF' undeclared (first use in this function)
> lguest.c:779: error: (Each undeclared identifier is reported only once
> lguest.c:779: error: for each function it appears in.)

Ah, perhaps older libc headers?  Can you try adding this to the top of
Documentation/lguest/lguest.c after the #define BRIDGE_PFX "bridge:"

#ifndef SIOCBRADDIF
#define SIOCBRADDIF	0x89a2		/* add interface to bridge      */
#endif

Thanks,
Rusty.
