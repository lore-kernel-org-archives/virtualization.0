From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 4/4] xen kconfig: describe xen tmem in the config menu
Date: Mon, 23 Jan 2012 13:34:54 -0500
Message-ID: <20120123183454.GA12542@phenom.dumpdata.com>
References: <1325842991-4404-1-git-send-email-drjones@redhat.com>
	<1325842991-4404-5-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325842991-4404-5-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 06, 2012 at 10:43:11AM +0100, Andrew Jones wrote:
> Add a description to the config menu for xen tmem.

I am not sure what this patch gets us. If this is to minimize the
size of the module - so say it gets loaded, but tmem-enabled is 
not set nor cleancache and we just have it consuming memory - we can do it
via returning -ENODEV on the module load.

Like this (completley untested nor compiled tested):

From 45b49b5d565c52e4396dae036ddb4f4094d914ec Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 23 Jan 2012 13:32:17 -0500
Subject: [PATCH] xen/tmem: Return -ENODEV if the backends are not registered.

.. otherwise the driver might still reside in the memory consuming
memory (that is the theory at least).

CC: Dan Magenheimer <dan.magenheimer@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/tmem.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/tmem.c b/drivers/xen/tmem.c
index d369965..e61b5a3 100644
--- a/drivers/xen/tmem.c
+++ b/drivers/xen/tmem.c
@@ -377,8 +377,10 @@ static struct frontswap_ops tmem_frontswap_ops = {
 
 static int __init xen_tmem_init(void)
 {
+	bool loaded = false;
+
 	if (!xen_domain())
-		return 0;
+		return -ENODEV;
 #ifdef CONFIG_FRONTSWAP
 	if (tmem_enabled && use_frontswap) {
 		char *s = "";
@@ -390,6 +392,7 @@ static int __init xen_tmem_init(void)
 			s = " (WARNING: frontswap_ops overridden)";
 		printk(KERN_INFO "frontswap enabled, RAM provided by "
 				 "Xen Transcendent Memory\n");
+		loaded = true;
 	}
 #endif
 #ifdef CONFIG_CLEANCACHE
@@ -402,9 +405,10 @@ static int __init xen_tmem_init(void)
 			s = " (WARNING: cleancache_ops overridden)";
 		printk(KERN_INFO "cleancache enabled, RAM provided by "
 				 "Xen Transcendent Memory%s\n", s);
+		loaded = true;
 	}
 #endif
-	return 0;
+	return loaded ? 0 : -ENODEV;
 }
 
 module_init(xen_tmem_init)
-- 
1.7.7.5


> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  drivers/xen/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 1d24061..7e8d728 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -143,7 +143,7 @@ config SWIOTLB_XEN
>  	select SWIOTLB
>  
>  config XEN_TMEM
> -	bool
> +	bool "Xen Transcendent Memory (tmem)"
>  	default y if (CLEANCACHE || FRONTSWAP)
>  	help
>  	  Shim to interface in-kernel Transcendent Memory hooks
> -- 
> 1.7.7.5
