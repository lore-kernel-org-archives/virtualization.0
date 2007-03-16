From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] make CONFIG_PARAVIRT require NO_HZ
Date: Thu, 15 Mar 2007 21:56:16 -0800
Message-ID: <45FA3180.40909@vmware.com>
References: <20070316054746.GD10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070316054746.GD10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> Given all the discussion, let's just require NO_HZ when
> CONFIG_PARAVIRT.  Anyone object?
>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>
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
>   =


Thanks Chris!

Acked-by: Zachary Amsden <zach@vmware.com>
Acked-by: Zachary Amsden <zach@vmware.com>
Acked-by: Zachary Amsden <zach@vmware.com>

Sorry, I got excited.

Zach
