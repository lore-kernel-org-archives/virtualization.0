From: Joe Perches <joe@perches.com>
Subject: RE: [PATCH 1/6] Staging: hv: vmbus_drv.c Replaced DPRINT with
	native pr_XXX
Date: Wed, 23 Feb 2011 09:09:58 -0800
Message-ID: <1298480998.32283.8.camel@Joe-Laptop>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
	<1298436685.26511.381.camel@Joe-Laptop>
	<8AFC7968D54FB448A30D8F38F259C56233FAC60E@TK5EX14MBXC118.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56233FAC60E@TK5EX14MBXC118.redmond.corp.microsoft.com>
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
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-02-23 at 16:58 +0000, Hank Janssen wrote:
> > #define pr_fmt(fmt) "%s: " fmt, VMBUS_MOD
> > or
> > #define pr_fmt(fmt) "%s:%s " fmt, VMBUS_MOD, __func__
> > (if you must)
> I wrestled with that when I did the conversion, The reason I did not
> Do that is when I check other drivers very few do it that way, most do
> It the way I do it or actually hard code the module name to be printed.

My preference would have been to use the KBUILD_MODNAME that
almost every other driver/module uses.

> So what is the general consensus. The current way I implemented it seems
> to be how other drivers use it to.

Your code, your choices.

cheers, Joe
