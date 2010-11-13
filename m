From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 06/20] x86/ticketlock: make __ticket_spin_trylock common
Date: Sat, 13 Nov 2010 18:17:32 +0800
Message-ID: <20101113101732.GH3837__25299.0479152233$1289837766$gmane$org@hack>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<4cea7b0804de5a2c1249034fc5c4840ade043ff4.1288794124.git.jeremy.fitzhardinge@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4cea7b0804de5a2c1249034fc5c4840ade043ff4.1288794124.git.jeremy.fitzhardinge@citrix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 03, 2010 at 10:59:47AM -0400, Jeremy Fitzhardinge wrote:

>+	union {
>+		struct __raw_tickets tickets;
>+		__ticketpair_t slock;
>+	} tmp, new;
>+	int ret;
>+
>+	tmp.tickets = ACCESS_ONCE(lock->tickets);
>+	if (tmp.tickets.head != tmp.tickets.tail)
>+		return 0;
>+
>+	new.slock = tmp.slock + (1 << TICKET_SHIFT);
>+
>+	ret = cmpxchg(&lock->ticketpair, tmp.slock, new.slock) == tmp.slock;
>+	barrier();		/* just make nothing creeps before lock is claimed */

This one should be smp_wmb(), right? No CONFIG_X86_OOSTORE protected.
