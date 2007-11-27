From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 27 Nov 2007 08:30:57 +0000
Message-ID: <474BE3D1.76E4.0078.0@novell.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4744BB54.4040803@goop.org>
	<de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com><de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
	<474B15FC.4050901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <474B15FC.4050901@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Juan Quintela <juan.quintela@gmail.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

>> It breaks with:
>>
>> Intel machine check architecture supported.
>> (XEN) traps.c:1734:d0 Domain attempted WRMSR 00000404 from 00000000:0000=
0001 to
>> ffffffff:ffffffff.
>> Intel machine check reporting enabled on CPU#0.
>> general protection fault: 0000 [#1] SMP
>> Modules linked in:
>>  =20
>
>Hm.  Looks like Xen is getting upset about dom0 trying to disable
>caching.  No, wait: 0xffffffff:ffffffff?  That's strange; I wonder if
>its just misreporting the value, because the code doesn't look like its
>trying to write that.
>
>Either way, the fix is to implement xen_write_cr0, and mask off any bits
>that Xen won't want us to set/clear (or if it doesn't allow dom0 to
>change cr0, just ignore all updates).

Why do you think that's a CR0 write? The messages clearly indicate an
MSR write, and these writes are clearly visible in intel_p{4,6}_mcheck_init=
()
and amd_mcheck_init(). The question is why intel_p4_mcheck_init() doesn't
check CPUID bits before trying to touch any registers... (And similarly
amd_mcheck_init() is checking only the MCE bit, not the MCA one.)

But then I just noticed that Xen itself doesn't clear the MCE/MCA bits =
either
in emulate_forced_invalid_op(), apparently under the assumption that PV
guests wouldn't try to make use of this feature.

A simple workaround would be to force mce_disabled to 1 in early Xen
initialization.

Jan
