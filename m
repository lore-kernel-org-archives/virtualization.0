From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/6] Staging: hv: vmbus_drv.c Replaced DPRINT with
	native pr_XXX
Date: Tue, 22 Feb 2011 20:51:25 -0800
Message-ID: <1298436685.26511.381.camel@Joe-Laptop>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: devel@linuxdriverproject.org, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-02-22 at 15:32 -0800, Hank Janssen wrote:
> This group of patches removes all DPRINT from hv_vmbus.ko.
> It is divided in several patches due to size.
[]
> -		DPRINT_ERR(VMBUS_DRV,
> -			   "ERROR - Unable to register vmbus root device");
> +		pr_err("%s: %s ERROR Unable to register vmbus root device",
> +		       VMBUS_MOD, __func__);

All of the pr_<level> calls should probably have a terminating "\n"

Also, ff all the pr_<level>'s are using VMBUS_MOD,
then perhaps it would look better to add

#define pr_fmt(fmt) "%s: " fmt, VMBUS_MOD
or
#define pr_fmt(fmt) "%s:%s " fmt, VMBUS_MOD, __func__
(if you must)

and then use:

	pr_err("ERROR Unable to register vmbus root device\n");
