From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Fri, 04 May 2007 13:39:06 +1000
Message-ID: <1178249946.23670.40.camel__27542.5330772579$1178250028$gmane$org@localhost.localdomain>
References: <1178117028.19815.14.camel@localhost.localdomain>
	<20070503160201.GR11166@waste.org>
	<1178237603.23670.26.camel@localhost.localdomain>
	<1178239389.23670.33.camel@localhost.localdomain>
	<20070504032043.GT11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070504032043.GT11115@waste.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matt Mackall <mpm@selenic.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-05-03 at 22:20 -0500, Matt Mackall wrote:
> I take it both sides of the virtual device drivers are turned on by
> the lguest option?

Yeah, to quote the code in drivers/lguest/lguest_bus.c:

/* At the moment we build all the drivers into the kernel because they're so
 * simple: 8144 bytes for all three of them as I type this.  And as the console
 * really needs to be built in, it's actually only 3527 bytes for the network
 * and block drivers.

> For the purposes of kernel hacking, I'd want to boot into one build
> and repeatedly launch another build as a guest, thereby getting
> faster hack/build/test cycles than either qemu or full reboot.
> How tightly coupled are things here?

I do that all the time, too.  The main issue is that we provide no ABI
for lguest (at least, not yet), so if you actually change guest/host
kernel version, you're on your own...

Thanks!
Rusty.
