From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Sat, 26 May 2007 20:18:11 +1000
Message-ID: <1180174691.650.8.camel@localhost.localdomain>
References: <4656FB8F.4090604@goop.org>
	 <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759400AbXEZKSl@vger.kernel.org>
In-Reply-To: <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-05-25 at 10:46 -0600, Eric W. Biederman wrote:
> Most of that though is just packaging.  The meat of the issue
> is how do we upgrade the bootloader data.  Do the changes
> below sound like everything we need?
> 
>  Field name:	loadflags
>  Type:		modify (obligatory)
>  Offset/size:	0x211/1
>  Protocol:	2.00+
>  
>    This field is a bitmask.
>  
>    Bit 0 (read):	LOADED_HIGH
>  	- If 0, the protected-mode code is loaded at 0x10000.
>  	- If 1, the protected-mode code is loaded at 0x100000.
> 
> +  Bit 6 (write): KEEP_SEGMENTS
> +	Protocol: 2.07+
> +	- if 0, reload the segment registers in the 32bit entry point.
> +	- if 1, do not reload the segment registers in the 32bit entry point.
> +		Assume that %cs %ds %ss %es are all set to flat segments with
> +		a base of 0 (or the equivalent for their environment).

You also want to skip the cli: perhaps a separate flag for this is
appropriate though.

Rest looks fine from an lguest POV.  We don't need the platform data
field either, since we use the first hypercall to get that).

Cheers,
Rusty.
