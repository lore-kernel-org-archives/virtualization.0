From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Thu, 03 May 2007 09:00:48 +1000
Message-ID: <1178146848.23670.6.camel__39317.5989891917$1178149389$gmane$org@localhost.localdomain>
References: <1178117028.19815.14.camel@localhost.localdomain>
	<20070502193303.GA1502@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070502193303.GA1502@localhost.localdomain>
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

On Thu, 2007-05-03 at 03:33 +0800, WANG Cong wrote:
> Hi Rusty!
> 
> I found you forgot to check the return value of copy_from_user, and
> here is the fix for drivers/lguest/interrupts_and_traps.c.
> 
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

Hi Wang!

	Thanks for the patch.  This omission (in several places) was
deliberate.  We can't really do anything sensible if the user unmapped
the page.  I assume you saw a gcc warning from this code?

	We could also use lgread() in these places which does this check and
kills the guest if something goes wrong.  I'll check the benchmarks to
make sure the (slight) extra overhead doesn't cause a regression...

Thanks!
Rusty.
