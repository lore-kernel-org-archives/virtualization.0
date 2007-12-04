From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 0/10] Integrate msr.h
Date: Tue, 04 Dec 2007 13:47:44 -0200
Message-ID: <475576A0.5020601__21740.1195820004$1196784132$gmane$org@redhat.com>
References: <11967666042130-git-send-email-gcosta@redhat.com>
	<20071204140939.GA16328@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071204140939.GA16328@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar escreveu:
> * Glauber de Oliveira Costa <gcosta@redhat.com> wrote:
> 
>> Hello,
>>
>> This series of patches integrates msr.h header. What it really does, 
>> is a series of steps to allow us to get rid of duplicate code between 
>> i386 and x86_64 versions
>>
>> With this done, achieving paravirt for x86_64 gets really easy, just a 
>> couple of extra code.
> 
> thanks, the patches look certainly sane and i've picked them up into 
> x86.git. A quick build & boot test was successful on both 64-bit and 
> 32-bit, with paravirt on/off. I've pushed out the latest tree into the 
> 'mm' branch of:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-x86.git
> 
> minor nit: some of your patches had scripts/checkpatch.pl failures, 
> could you try to fix them up? (If possible then as a follow-up second 
> patch series.) Thanks!
Sure. I'll resend them.

> [ btw., how far away are you from having Kconfig selectable 64-bit
>   paravirt support? Just curious :-) ]
> 
Not too much. Jeremy is handling the page table code, and I'm basically
taking care of the rest. I don't go to far in integration in other
areas, so the patches are the same that were already previously sent
some days ago. I'll just rebase and send again.

The only rebase I'm expecting to be troublesome is the paravirt.c /
paravirt.h files. So I'd say we're close.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHVXagjYI8LaFUWXMRAhHjAKDVDesU/iRyDXDgQB6Pxx23PTizyQCgzzcU
rZsECAdjqaGeZqAxWY2lhro=
=qrHF
-----END PGP SIGNATURE-----
