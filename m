From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC/PATCH 02/15 v2] preparation: host memory management
	changes for s390 kvm
Date: Mon, 24 Mar 2008 14:52:09 -0700
Message-ID: <20080324145209.23920166.akpm__45502.4096220315$1206395701$gmane$org@linux-foundation.org>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206203560.7177.45.camel@cotte.boeblingen.de.ibm.com>
	<1206205359.7177.84.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206205359.7177.84.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: npiggin@suse.de, aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, borntraeger@de.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, schwidefsky@de.ibm.com, hugh@veritas.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, xiantao.zhang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 22 Mar 2008 18:02:39 +0100
Carsten Otte <cotte@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> This patch changes the s390 memory management defintions to use the pgste field
> for dirty and reference bit tracking of host and guest code. Usually on s390, 
> dirty and referenced are tracked in storage keys, which belong to the physical
> page. This changes with virtualization: The guest and host dirty/reference bits
> are defined to be the logical OR of the values for the mapping and the physical
> page. This patch implements the necessary changes in pgtable.h for s390.
> 
> 
> There is a common code change in mm/rmap.c, the call to page_test_and_clear_young
> must be moved. This is a no-op for all architecture but s390. page_referenced
> checks the referenced bits for the physiscal page and for all mappings:
> o The physical page is checked with page_test_and_clear_young.
> o The mappings are checked with ptep_test_and_clear_young and friends.
> 
> Without pgstes (the current implementation on Linux s390) the physical page
> check is implemented but the mapping callbacks are no-ops because dirty 
> and referenced are not tracked in the s390 page tables. The pgstes introduces 
> guest and host dirty and reference bits for s390 in the host mapping. These
> mapping must be checked before page_test_and_clear_young resets the reference
> bit. 
>
> ...
>
> --- linux-host.orig/mm/rmap.c
> +++ linux-host/mm/rmap.c
> @@ -413,9 +413,6 @@ int page_referenced(struct page *page, i
>  {
>  	int referenced = 0;
>  
> -	if (page_test_and_clear_young(page))
> -		referenced++;
> -
>  	if (TestClearPageReferenced(page))
>  		referenced++;
>  
> @@ -433,6 +430,10 @@ int page_referenced(struct page *page, i
>  			unlock_page(page);
>  		}
>  	}
> +
> +	if (page_test_and_clear_young(page))
> +		referenced++;
> +
>  	return referenced;
>  }

ack.
