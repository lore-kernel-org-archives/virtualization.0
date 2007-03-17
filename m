From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] make CONFIG_PARAVIRT require NO_HZ
Date: Fri, 16 Mar 2007 16:18:54 -0800
Message-ID: <20070316161854.9de1c784.akpm@linux-foundation.org>
References: <20070316054746.GD10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070316054746.GD10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Mar 2007 22:47:46 -0700 Chris Wright <chrisw@sous-sol.org> wrote:

> Given all the discussion, let's just require NO_HZ when
> CONFIG_PARAVIRT.  Anyone object?
> =

> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
> =

> --- a/arch/i386/Kconfig	Mon Mar 12 11:07:45 2007 -0700
> +++ b/arch/i386/Kconfig	Mon Mar 12 16:53:14 2007 -0700
> @@ -208,7 +208,7 @@ endchoice
>  =

>  config PARAVIRT
>  	bool "Paravirtualization support (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL
> +	depends on EXPERIMENTAL && NO_HZ
>  	depends on !(X86_VISWS || X86_VOYAGER)
>  	help
>  	  Paravirtualization is a way of running multiple instances of

Apart from all the other fun, it seems that we need to merge
kconfig-abort-configuration-with-recursive-dependencies.patch, because

scripts/kconfig/conf -m arch/i386/Kconfig
Error: Found recursive dependency: PARAVIRT NO_HZ PARAVIRT
make[1]: *** [allmodconfig] Error 1
make: *** [allmodconfig] Error 2

This is due to your patch interacting with
make-config_paravirt-require-no_hz.patch:


From: Chris Wright <chrisw@sous-sol.org>

Require NO_HZ when CONFIG_PARAVIRT.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Acked-by: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/i386/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/Kconfig~make-config_paravirt-require-no_hz arch/i386/Kc=
onfig
--- a/arch/i386/Kconfig~make-config_paravirt-require-no_hz
+++ a/arch/i386/Kconfig
@@ -208,7 +208,7 @@ endchoice
 =

 config PARAVIRT
 	bool "Paravirtualization support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && NO_HZ
 	depends on !(X86_VISWS || X86_VOYAGER)
 	select NO_HZ
 	help
_


I'll drop both of them while you guys sort it all out.
