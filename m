From: "Eric Van Hensbergen" <ericvh@gmail.com>
Subject: Re: lguest over qemu
Date: Sat, 25 Aug 2007 18:33:00 -0500
Message-ID: <a4e6962a0708251633m40635091n2fcf24ad41cdcd37@mail.gmail.com>
References: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
	<1184210340.6005.723.camel@localhost.localdomain>
	<a4e6962a0708250848v6315a54ag4b314896f7c60807@mail.gmail.com>
	<1188076749.20041.106.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1188076749.20041.106.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 8/25/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Sat, 2007-08-25 at 10:48 -0500, Eric Van Hensbergen wrote:
>
> Interesting.  Enabling them here gives the expected messages:
>
>         WDT driver for Advantech single board computer initialising.
>         advantechwdt: I/O address 0x0443 already in use
>         advantechwdt: probe of advantechwdt failed with error -5
>         alim7101_wdt: Steve Hill <steve@navaho.co.uk>.
>         alim7101_wdt: ALi M7101 PMU not present - WDT not set
>
> But it boots fine.
>
> Perhaps it's a hardware difference (we do expose some of the host CPU
> capabilities to the guest), or perhaps some other config difference
> which is masking the problem?
>

Okay, I am running this on a quad opteron - although I'm using a i386
qemu.  Still - its strange that disabling the watchdog allows my
kernel to boot fine...

              -eric
