From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH/RFC 3/4]Introduce "account modifiers" mechanism
Date: Fri, 17 Aug 2007 08:39:15 +1000
Message-ID: <1187303955.6449.7.camel__16789.6549254239$1187304139$gmane$org@localhost.localdomain>
References: <46C4719A.2060308@bull.net> <46C4720F.7030304@bull.net>
	<46C4725A.4070607@bull.net>  <46C4740F.2050701@bull.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C4740F.2050701@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-08-16 at 17:58 +0200, Laurent Vivier wrote:
> [PATCH 3/3] introduce "account modifiers" mechanism in the kernel allowing a
> module to modify the collected accounting for a given task. This implementation
> is based on the "preempt_notifier". "account_system_time()" and
> "account_user_time()" can call functions registered by a module to modify the
> cputime value.
> 
> Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>


Hi Laurent,

	This seems a little like overkill.  Why not just add an
"account_guest_time" which subtracts the given amount of time from
system time (if available) and adds it to guest time?  Then kvm (and
lguest) should just need to call this at the right times.

Am I missing something?
Rusty.
