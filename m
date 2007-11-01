From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 11/16] turn priviled operation into a macro in head_64.S
Date: Thu, 01 Nov 2007 11:50:13 -0200
Message-ID: <4729D995.3030905__10503.2576401301$1193925091$gmane$org@redhat.com>
References: <1193858101367-git-send-email-gcosta@redhat.com>
	<11938581073775-git-send-email-gcosta@redhat.com>
	<11938581133479-git-send-email-gcosta@redhat.com>
	<1193858118284-git-send-email-gcosta@redhat.com>
	<11938581242810-git-send-email-gcosta@redhat.com>
	<1193858130443-git-send-email-gcosta@redhat.com>
	<11938581351064-git-send-email-gcosta@redhat.com>
	<11938581403478-git-send-email-gcosta@redhat.com>
	<11938581451804-git-send-email-gcosta@redhat.com>
	<11938581512730-git-send-email-gcosta@redhat.com>
	<11938581562552-git-send-email-gcosta@redhat.com>
	<11938581612389-git-send-email-gcosta@redhat.com>
	<47295B2A.3080200@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47295B2A.3080200@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy Fitzhardinge escreveu:
> Glauber de Oliveira Costa wrote:
>> under paravirt, read cr2 cannot be issued directly anymore.
>> So wrap it in a macro, defined to the operation itself in case
>> paravirt is off, but to something else if we have paravirt
>> in the game
>>   
> 
> Is this actually needed?  It's only used in the early fault handler in
> head_64.S.  Will we be taking that path in the paravirt case?  If so,
> should we disable the fault handler altogether, since the hypervisor can
> probably provide better diagnositcs.
> 

Well, as you told me earlier, xen won't use it. Neither does lguest.
None of us goes through the normal boot process anyway. But maybe some
other technology uses it?

Zach, how does it work for vmware?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHKdmVjYI8LaFUWXMRAgxkAKCQB+VtpGSlm+zuyRRWmi3h+k9NqQCgyfmD
cpPyQcfxo9hcSI0WaDFmpWg=
=Oa4v
-----END PGP SIGNATURE-----
