From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 7/24] consolidate msr.h
Date: Tue, 20 Nov 2007 21:43:12 +1100
Message-ID: <200711202143.13460.rusty__24560.6244927787$1195555688$gmane$org@rustcorp.com.au>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<20071120055113.GC20436@elte.hu>
	<Pine.LNX.4.58.0711200114580.4062@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.58.0711200114580.4062@gandalf.stny.rr.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Bastian Blank <bastian@waldi.eu.org>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, Ingo Molnar <mingo@elte.hu>, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 20 November 2007 17:16:45 Steven Rostedt wrote:
> On Tue, 20 Nov 2007, Ingo Molnar wrote:
> > i dont think there's ever any true need (and good cause) to force
> > integer type casts like that at the callee site.
>
> Unless you mean we should do something like this:
>
> static inline void __wrmsrl(unsigned int msr, unsigned long long val);
> #define wrmsr(msr, val) __wrmsrl(msr, (unsigned long long)var)

Heh:

union ptr_or_val {
	void *ptr;
	unsigned long long val;
};

static inline void __wrmsrl(unsigned int msr, union ptr_or_val pv);
#define wrmsr(msr, v) __wrmsrl(msr, (union ptr_or_val)v)

Ok, maybe not...
Rusty.
