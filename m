From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 24/24] make vsmp a paravirt client
Date: Tue, 13 Nov 2007 09:36:42 -0200
Message-ID: <47398C4A.40806__25487.7231469893$1194953895$gmane$org@redhat.com>
References: <11946338683305-git-send-email-gcosta@redhat.com>
	<1194633873306-git-send-email-gcosta@redhat.com>
	<1194633878886-git-send-email-gcosta@redhat.com>
	<11946338832681-git-send-email-gcosta@redhat.com>
	<1194633888761-git-send-email-gco!sta@redhat.com>
	<11946338932611-git-send-email-gcosta@redhat.com>
	<1194633898545-git-send-email-gcosta@redhat.com>
	<11946339033567-git-send-email-gcosta@redhat.com>
	<11946339082711-git-send-email-gcosta@redhat.com>
	<11946339142999-git-send-email-gcosta@redhat.com>
	<20071111180709.GG22277@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071111180709.GG22277@bingen.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, kiran@scalemp.com, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen escreveu:
> On Fri, Nov 09, 2007 at 04:43:05PM -0200, Glauber de Oliveira Costa wrote:
>> This patch makes vsmp a paravirt client. It now uses the whole
>> infrastructure provided by pvops. When we detect we're running
>> a vsmp box, we change the irq-related paravirt operations (and so,
>> it have to happen quite early), and the patching function
> 
> The PARAVIRT ifdefs look wrong. Surely you don't need them at all
> because it cannot work at all without paravirt.

The vsmp_64.c file is now compiled unconditionally, according to which
me and kiran agreed to. The detection code is always run, but will only
trigger when a suitable box is found. Accordingly, the paravirt structs
are only touched when PARAVIRT is on. Otherwise, we don't even have the
symbols.

> Also you got some white space damage.

Thanks, will fix.

> And the "EM64T based comment" is wrong because there are AMD based 
> vSMPs too.
Just got it as-is from the old Kconfig. Do you think it should be fixed
as well?

> -Andi

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHOYxKjYI8LaFUWXMRApS3AJwJSYjW4Lw3dnPR4yMNfXABnMoQQQCcDMnf
3wBQoPjGO/8HO1Os4Y21vIU=
=S+KO
-----END PGP SIGNATURE-----
