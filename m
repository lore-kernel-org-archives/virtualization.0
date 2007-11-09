From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/24] mm/sparse-vmemmap.c: make sure init_mm is included
Date: Fri, 09 Nov 2007 15:00:48 -0800
Message-ID: <4734E6A0.6070508__20389.3034290106$1194649407$gmane$org@goop.org>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11946337933104-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, mingo@elte.hu, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> mm/sparse-vmemmap.c uses init_mm in some places.  However, it is not
> present in any of the headers currently included in the file.
>
> init_mm is defined as extern in sched.h, so we add it to the headers list
>
> Up to now, this problem was masked by the fact that functions like
> set_pte_at() and pmd_populate_kernel() are usually macros that expand to
> simpler variants that does not use the first parameter at all.
>
> Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  mm/sparse-vmemmap.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index d3b718b..22620f6 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
> +#include <linux/sched.h>
>   

This is already in git.

    J
