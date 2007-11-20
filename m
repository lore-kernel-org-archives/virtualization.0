From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 7/24] consolidate msr.h
Date: Tue, 20 Nov 2007 01:16:45 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711200114580.4062__5220.49920768968$1195539580$gmane$org@gandalf.stny.rr.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
	<20071119222151.GA11178@wavehammer.waldi.eu.org>
	<Pine.LNX.4.58.0711191734270.32296@gandalf.stny.rr.com>
	<20071120055113.GC20436@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071120055113.GC20436@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Bastian Blank <bastian@waldi.eu.org>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


On Tue, 20 Nov 2007, Ingo Molnar wrote:
>
> i dont think there's ever any true need (and good cause) to force
> integer type casts like that at the callee site.

Unless you mean we should do something like this:

static inline void __wrmsrl(unsigned int msr, unsigned long long val);
#define wrmsr(msr, val) __wrmsrl(msr, (unsigned long long)var)

-- Steve
