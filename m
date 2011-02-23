From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/6] Staging: hv: vmbus_drv.c Replaced DPRINT with
	native pr_XXX
Date: Wed, 23 Feb 2011 16:58:10 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56233FAC60E@TK5EX14MBXC118.redmond.corp.microsoft.com>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
	<1298436685.26511.381.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1298436685.26511.381.camel@Joe-Laptop>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Joe Perches <joe@perches.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Tuesday, February 22, 2011 8:51 PM


> On Tue, 2011-02-22 at 15:32 -0800, Hank Janssen wrote:
> > This group of patches removes all DPRINT from hv_vmbus.ko.
> > It is divided in several patches due to size.
> []
> > -		DPRINT_ERR(VMBUS_DRV,
> > -			   "ERROR - Unable to register vmbus root device");
> > +		pr_err("%s: %s ERROR Unable to register vmbus root device",
> > +		       VMBUS_MOD, __func__);
> 
> All of the pr_<level> calls should probably have a terminating "\n"

I will correct them and resubmit.

> 
> Also, ff all the pr_<level>'s are using VMBUS_MOD,
> then perhaps it would look better to add
> 
> #define pr_fmt(fmt) "%s: " fmt, VMBUS_MOD
> or
> #define pr_fmt(fmt) "%s:%s " fmt, VMBUS_MOD, __func__
> (if you must)

I wrestled with that when I did the conversion, The reason I did not
Do that is when I check other drivers very few do it that way, most do
It the way I do it or actually hard code the module name to be printed.
And since the original objection was that DPRINT seems to implement it's
own logging I did not want to re-implement the pr_XXX calls with this layer
of indirection which almost looks like I am going down the path of DPRINT
again.

So what is the general consensus. The current way I implemented it seems
to be how other drivers use it to.

Hank.
