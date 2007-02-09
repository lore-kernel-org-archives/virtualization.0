From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 6c/10] lguest: the guest code
Date: Fri, 9 Feb 2007 12:14:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702091212360.9007@d.namei>
References: <1171012296.2718.26.camel@localhost.localdomain>
 <1171018590.2718.60.camel@localhost.localdomain> <1171018674.2718.63.camel@localhost.localdomain>
 <200702091206.31797.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="537530981-931463441-1171041245=:9007"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946640AbXBIROK@vger.kernel.org>
In-Reply-To: <200702091206.31797.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--537530981-931463441-1171041245=:9007
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 9 Feb 2007, Len Brown wrote:

> On Friday 09 February 2007 05:57, Rusty Russell wrote:
> 
> > +#ifdef CONFIG_ACPI
> > +       acpi_disabled = 1;
> > +       acpi_ht = 0;
> > +#endif
> 
> If this is hard-coded to have ACPI disabled, why isn't it enforced at build-time?

This is being disabled in the guest kernel only.  The host and guest 
kernels are expected to be the same build.



- James
-- 
James Morris
<jmorris@namei.org>
--537530981-931463441-1171041245=:9007--
