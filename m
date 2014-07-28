From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] x86, paravirt: BUG_ON on {rd,wr}msr exceptions
Date: Mon, 28 Jul 2014 17:39:55 -0300
Message-ID: <20140728203955.GA4611@thinpad.lan.raisama.net>
References: <1406574278-23946-1-git-send-email-ehabkost@redhat.com>
	<53D6A1F2.5070404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53D6A1F2.5070404@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 28, 2014 at 12:18:10PM -0700, H. Peter Anvin wrote:
> On 07/28/2014 12:04 PM, Eduardo Habkost wrote:
> > When CONFIG_PARAVIRT is enabled, the kernel is ignoring exceptions on
> > the {rd,wr}msr instructions. This makes serious issues (either on the
> > guest kernel, or on the host) be silently ignored, and is different from
> > the native MSR code (which does not ignore the exceptions).
> > 
> > As paravirt.h already includes linux/bug.h, I don't see what was the
> > original issue preventing BUG_ON from being used.
> > 
> > Change rdmsr(), wrmsr(), and rdmsrl() to BUG_ON() on errors.
> 
> How much does this bloat the kernel?

It seems to add 8 bytes to each {wr,rd}msr() call (4 extra instructions:
test, jmp, ud2, jmp).

allyesconfig, paravirt enabled, before:

  text    data     bss     dec     hex filename
108368312       23500872        55705600        187574784       b2e2a00 vmlinux

allyesconfig, paravirt enabled, after:

   text    data     bss     dec     hex filename
108384438       23500904        55717888        187603230       b2e991e vmlinux

allyesconfig vmlinux is 28446 bytes larger.

An alternative is to add read_msr_unsafe() & write_msr_unsafe() fields
to pv_cpu_ops, pointing to native_read_msr() & native_write_msr().

-- 
Eduardo
