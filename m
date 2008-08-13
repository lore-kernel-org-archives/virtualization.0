From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] stop_machine: wean Xen off stop_machine_run
Date: Tue, 12 Aug 2008 22:57:33 -0700
Message-ID: <48A277CD.3060300__15015.9129560508$1218607233$gmane$org@goop.org>
References: <200808131552.18942.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200808131552.18942.rusty@rustcorp.com.au>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> This is the last use of (the deprecated) stop_machine_run in the tree.
>   

OK, thanks.

> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>   
Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

> diff -r 332ec042cb4d drivers/xen/manage.c
> --- a/drivers/xen/manage.c	Wed Aug 13 10:48:27 2008 +1000
> +++ b/drivers/xen/manage.c	Wed Aug 13 15:50:02 2008 +1000
> @@ -102,7 +102,7 @@ static void do_suspend(void)
>  	/* XXX use normal device tree? */
>  	xenbus_suspend();
>  
> -	err = stop_machine_run(xen_suspend, &cancelled, 0);
> +	err = stop_machine(xen_suspend, &cancelled, &cpumask_of_cpu(0));
>  	if (err) {
>  		printk(KERN_ERR "failed to start xen_suspend: %d\n", err);
>  		goto out;
>   
