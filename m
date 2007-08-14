From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: modified CONFIG_PHYSICAL_ALIGN
Date: Tue, 14 Aug 2007 05:29:03 +0200
Message-ID: <20070814032903.GB3903@bingen.suse.de>
References: <5AC7DE0DDBA7B1ichiyanagi.yoshimi@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5AC7DE0DDBA7B1ichiyanagi.yoshimi@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yoshimi Ichiyanagi <ichiyanagi.yoshimi@lab.ntt.co.jp>
Cc: zippel@linux-m68k.org, moriai.satoshi@lab.ntt.co.jp, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2007 at 09:55:50AM +0900, Yoshimi Ichiyanagi wrote:

How is this related to virtualization?

> The problem is, if you compile x86_64 kernel, the value of 
> CONFIG_PHYSICAL_ALIGN will be fixed, and the next time you compile i386 
> kernel, previous CONFIG_PHYSICAL_ALIGN value of x86_64(default: 2MB) will 
> be used by default.

2/4MB is better for i386 too for PAE/non PAE because
it will use less TLB entries. I guess it's better to just change
the defaults.

Anyways, both values should work, or did you see 
failures?

> The follwing patch will fix this problem. With this patch, either 
> CONFIG_RELOCATABLE's option or CONFIG_EMNBEDDED's option is set "Y", 
> you can configure the value of CONFIG_PHYSICAL_ALIGN.

How does that change anything?

iirc what you want cannot be really expressed in Kconfig :- what
you would really want is a flag for the number that says
"this came from a default value and user hasn't changed it"
and then Kconfig knowing that if the new default is different
change it to new default. But I'm not sure such complexity would be really
a good idea. Probably it's not.

-Andi
