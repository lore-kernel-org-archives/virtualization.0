From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 1/24] mm/sparse-vmemmap.c: make sure init_mm is included
Date: Fri, 09 Nov 2007 23:26:59 -0200
Message-ID: <473508E3.1050903__42667.371480684$1194658082$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<4734E6A0.6070508@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4734E6A0.6070508@goop.org>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, mingo@elte.hu, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy Fitzhardinge escreveu:
> Glauber de Oliveira Costa wrote:
>> mm/sparse-vmemmap.c uses init_mm in some places.  However, it is not
>> present in any of the headers currently included in the file.
>>
>> init_mm is defined as extern in sched.h, so we add it to the headers list
>>
>> Up to now, this problem was masked by the fact that functions like
>> set_pte_at() and pmd_populate_kernel() are usually macros that expand to
>> simpler variants that does not use the first parameter at all.
>>
>> Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> ---
>>  mm/sparse-vmemmap.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index d3b718b..22620f6 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/module.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/vmalloc.h>
>> +#include <linux/sched.h>
>>   
> 
> This is already in git.
> 
>     J
As I told in the 0th message, yes, I'm aware.
Just it does not seem to be in tglx's , so if people are willing to try
this out, they'll needed. Thus it's included in the series.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHNQjijYI8LaFUWXMRAn+UAJ48V1EyWoXkWu1+J0Y0ze59H7ZG2QCcDdgW
4qVJgJcQDfJrvZk8TSo901s=
=RwdO
-----END PGP SIGNATURE-----
