From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Thu, 3 May 2007 11:57:49 +0800
Message-ID: <20070503035749.GC2295__21168.8247546137$1178164743$gmane$org@localhost.localdomain>
References: <1178117028.19815.14.camel@localhost.localdomain>
	<20070502193303.GA1502@localhost.localdomain>
	<1178146848.23670.6.camel@localhost.localdomain>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178146848.23670.6.camel@localhost.localdomain>
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 03, 2007 at 09:00:48AM +1000, Rusty Russell wrote:
>On Thu, 2007-05-03 at 03:33 +0800, WANG Cong wrote:
>> Hi Rusty!
>> 
>> I found you forgot to check the return value of copy_from_user, and
>> here is the fix for drivers/lguest/interrupts_and_traps.c.
>> 
>> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
>
>Hi Wang!
>
>	Thanks for the patch.  This omission (in several places) was
>deliberate.  We can't really do anything sensible if the user unmapped
>the page.  I assume you saw a gcc warning from this code?

Yes. In fact, I got two warnings, another one is in drivers/lguest/hypercalls.c.

If I understand you correctly, you mean we can do nothing useful to fix it?

>
>	We could also use lgread() in these places which does this check and
>kills the guest if something goes wrong.  I'll check the benchmarks to
>make sure the (slight) extra overhead doesn't cause a regression...
>
>Thanks!
>Rusty.

I have sent a mail which described the errors I got when comipling Documentation/lguest/lguest.c. But it seems that you didn't receive it (it didn't appear in lkml.org neither!). It is that, I have already made my .config as you suggested, but I still can't compile Documentation/lguest/lguest.c, errors are:

lguest.c: In function 'add_to_bridge':
lguest.c:779: error: 'SIOCBRADDIF' undeclared (first use in this function)
lguest.c:779: error: (Each undeclared identifier is reported only once
lguest.c:779: error: for each function it appears in.)

Can you help me out?

Thanks!
