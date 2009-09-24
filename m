From: Li Liang <liang.li@windriver.com>
Subject: Re: [Lguest] [PATCH 3/5] lguest: use PGDIR_SHIFT for PAE code to
	allow different PAGE_OFFSET
Date: Thu, 24 Sep 2009 09:34:19 +0800
Message-ID: <20090924013419.GA4122@localhost>
References: <20090921072352.10E17B7C82@ozlabs.org>
Reply-To: Li Liang <liang.li@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090921072352.10E17B7C82@ozlabs.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, lguest@ozlabs.org, Matias Zabaljauregui <zabaljauregui@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 21, 2009 at 04:52:21PM +0930, Rusty Russell wrote:
> 
> We still assume the Guest and Host have the same PAGE_OFFSET settings,
> but now we don't assume 0xC0000000.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Matias Zabaljauregui <zabaljauregui@gmail.com>
> ---
>  drivers/lguest/page_tables.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
> --- a/drivers/lguest/page_tables.c
> +++ b/drivers/lguest/page_tables.c
> @@ -996,11 +996,9 @@ static unsigned long setup_pagetables(st
>  	if (copy_to_user(&pgdir[0], &pgd, sizeof(pgd)) != 0)
>  		return -EFAULT;
>  	/*
> -	 * And the third PGD entry (ie. addresses 3G-4G).
> -	 *
> -	 * FIXME: This assumes that PAGE_OFFSET for the Guest is 0xC0000000.
> +	 * And the other PGD entry to make the linear mapping at PAGE_OFFSET
>  	 */
> -	if (copy_to_user(&pgdir[3], &pgd, sizeof(pgd)) != 0)
> +	if (copy_to_user(&pgdir[KERNEL_PGD_BOUNDARY], &pgd, sizeof(pgd)))

How about this:

+	if (!!copy_to_user(&pgdir[KERNEL_PGD_BOUNDARY], &pgd, sizeof(pgd)))

:)

Thanks,
-L

>  		return -EFAULT;
>  #else
>  	/*
> 
> _______________________________________________
> Lguest mailing list
> Lguest@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/lguest
