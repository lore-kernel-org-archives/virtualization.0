From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] i386: modified CONFIG_PHYSICAL_ALIGN
Date: Tue, 14 Aug 2007 13:17:28 +1000
Message-ID: <1187061448.11093.63.camel@localhost.localdomain>
References: <5AC7DE0DDBA7B1ichiyanagi.yoshimi@lab.ntt.co.jp>
	<20070814032903.GB3903@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070814032903.GB3903@bingen.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: zippel@linux-m68k.org, moriai.satoshi@lab.ntt.co.jp, Yoshimi Ichiyanagi <ichiyanagi.yoshimi@lab.ntt.co.jp>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-14 at 05:29 +0200, Andi Kleen wrote:
> On Tue, Aug 14, 2007 at 09:55:50AM +0900, Yoshimi Ichiyanagi wrote:
> 
> How is this related to virtualization?
> 
> > The problem is, if you compile x86_64 kernel, the value of 
> > CONFIG_PHYSICAL_ALIGN will be fixed, and the next time you compile i386 
> > kernel, previous CONFIG_PHYSICAL_ALIGN value of x86_64(default: 2MB) will 
> > be used by default.
> 
> 2/4MB is better for i386 too for PAE/non PAE because
> it will use less TLB entries. I guess it's better to just change
> the defaults.
> 
> Anyways, both values should work, or did you see 
> failures?

I had this problem too: Lguest assumes 1MB when loading bzImages, and
the only time that gets changed is when building from an x86-64 config.
I considered it purely an lguest issue.

The correct fix is to have lguest run bzImages rather than trying to
unpack them itself, but that requires a bootloader change, and the
proposals to do that got lost in a flurry of far more ambitious patches.

Jeremy would know the status of that work...
Rusty.
