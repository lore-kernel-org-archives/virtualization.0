From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 7/7] cleanup: make disable_acpi() valid w/o CONFIG_ACPI
Date: Tue, 13 Feb 2007 00:09:36 -0500
Message-ID: <200702130009.36987.lenb@kernel.org>
References: <1171251120.10409.2.camel@localhost.localdomain> <1171251471.10409.15.camel@localhost.localdomain> <1171251578.10409.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161025AbXBMFLE@vger.kernel.org>
In-Reply-To: <1171251578.10409.17.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Len Brown <len.brown@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Applied.

thanks,
-Len

On Sunday 11 February 2007 22:39, Rusty Russell wrote:
> Len Brown <lenb@kernel.org> said:
> > Okay, but better to use disable_acpi()
> > indeed, since this would be the first code not already inside CONFIG_ACPI
> > to invoke disable_acpi(), we could define the inline as empty and you could
> > then scratch the #ifdef too.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> ===================================================================
> --- a/include/asm-i386/acpi.h
> +++ b/include/asm-i386/acpi.h
> @@ -127,6 +127,7 @@ extern int acpi_irq_balance_set(char *st
>  #define acpi_ioapic 0
>  static inline void acpi_noirq_set(void) { }
>  static inline void acpi_disable_pci(void) { }
> +static inline void disable_acpi(void) { }
>  
>  #endif	/* !CONFIG_ACPI */
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
