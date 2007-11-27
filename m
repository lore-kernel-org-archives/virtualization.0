From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 27 Nov 2007 09:00:13 -0800
Message-ID: <474C4D1D.9020700@goop.org>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4744BB54.4040803@goop.org>
	<de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com><de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
	<474B15FC.4050901@goop.org> <474BE3D1.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <474BE3D1.76E4.0078.0@novell.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jan Beulich <jbeulich@novell.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Juan Quintela <juan.quintela@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Jan Beulich wrote:
>>> It breaks with:
>>>
>>> Intel machine check architecture supported.
>>> (XEN) traps.c:1734:d0 Domain attempted WRMSR 00000404 from 00000000:00000001 to
>>> ffffffff:ffffffff.
>>> Intel machine check reporting enabled on CPU#0.
>>> general protection fault: 0000 [#1] SMP
>>> Modules linked in:
>>>   
>>>       
>> Hm.  Looks like Xen is getting upset about dom0 trying to disable
>> caching.  No, wait: 0xffffffff:ffffffff?  That's strange; I wonder if
>> its just misreporting the value, because the code doesn't look like its
>> trying to write that.
>>
>> Either way, the fix is to implement xen_write_cr0, and mask off any bits
>> that Xen won't want us to set/clear (or if it doesn't allow dom0 to
>> change cr0, just ignore all updates).
>>     
>
> Why do you think that's a CR0 write? 

Well, the oops says "EIP is at native_write_cr0+0x0/0x4", and the caller
is prepare_set(), which does:

	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
	cr0 = read_cr0() | X86_CR0_CD;
	write_cr0(cr0);
	wbinvd();

This is in preparation to setting up the MTRRs, which needs to be all
skipped anyway.

> The messages clearly indicate an
> MSR write, and these writes are clearly visible in intel_p{4,6}_mcheck_init()
> and amd_mcheck_init(). The question is why intel_p4_mcheck_init() doesn't
> check CPUID bits before trying to touch any registers... (And similarly
> amd_mcheck_init() is checking only the MCE bit, not the MCA one.)
>   

The oops and backtrace doesn't suggest it's an MSR write.  Does a crX
write take the same path through the emulator as an MSR write?

> A simple workaround would be to force mce_disabled to 1 in early Xen
> initialization.
>   

That's probably necessary too.

    J
