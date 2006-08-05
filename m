From: Zachary Amsden <zach@vmware.com>
Subject: Re: A proposal - binary
Date: Fri, 04 Aug 2006 21:33:33 -0700
Message-ID: <44D41F9D.8030409@vmware.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>	
	<44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>	
	<20060804183448.GE11244@sequoia.sous-sol.org>
	<44D3B0F0.2010409@vmware.com>
	<1154741408.3683.171.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1154741408.3683.171.camel@mulgrave.il.steeleye.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xensource.com, Jack Lo <jlo@vmware.com>, Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, pazke@donpac.ru
List-Id: virtualization@lists.linuxfoundation.org

James Bottomley wrote:
> Well ... I agree that in principle it's possible to have a kernel that
> would run on both voyager and a generic x86 system and, I'll admit, I
> tried to go that route before creating the subarchitectures.  However,
> in practice, I think the cost really becomes too high ... for voyager,
> it becomes necessary really to intercept almost the entirety of the the
> SMP API.  The purpose of the subarchitecture interface wasn't to
> eventually have some API description that would allow voyager to
> co-exist with more normal x86 systems.  It was to allow voyager to make
> use of generic x86 while being completely different at the x86 SMP
> level.  I really don't think there'll ever be another x86 machine that's
> as different from the APIC approach as the voyager VIC/QIC is.  thus, I
> think the actual x86 interface is much better described by mach-generic,
> which abstracts out the interfaces necessary to the more standard APIC
> based SMP systems.
>   

This is quite true today.  But it is entirely possible that support in 
Linux for Xen may want to rip out the APIC / IO-APIC entirely, replace 
that with event channels, and use different SMP shootdown mechanisms, as 
well as having their own special NMI delivery hook.  We're also going to 
have to make certain parts of the interface extremely efficient, and 
we've already got several schemes to remove the penalty of indirection 
by being rid of indirect branches - which could be a more broadly used 
technique if it proves unintrusive and reliable enough.  In that case, 
you could basically support Voyager without a subarch, plus or minus one 
special hook or two ;)

Zach
