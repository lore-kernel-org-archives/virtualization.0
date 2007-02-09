From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6c/10] lguest: the guest code
Date: Fri, 9 Feb 2007 12:06:31 -0500
Message-ID: <200702091206.31797.lenb@kernel.org>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171018590.2718.60.camel@localhost.localdomain> <1171018674.2718.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992436AbXBIRIG@vger.kernel.org>
In-Reply-To: <1171018674.2718.63.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 09 February 2007 05:57, Rusty Russell wrote:

> +#ifdef CONFIG_ACPI
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_disabled =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_ht =3D 0;
> +#endif

If this is hard-coded to have ACPI disabled, why isn't it enforced at b=
uild-time?

thanks,
-Len
