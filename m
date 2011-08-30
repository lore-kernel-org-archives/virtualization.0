From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 10/59] Staging: hv: util: Make hv_utils a vmbus device
	driver
Date: Tue, 30 Aug 2011 17:14:29 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B5342@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-10-git-send-email-kys@microsoft.com>
	<20110830155323.GT3705@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110830155323.GT3705@shale.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Dan Carpenter <error27@gmail.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:error27@gmail.com]
> Sent: Tuesday, August 30, 2011 11:53 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 10/59] Staging: hv: util: Make hv_utils a vmbus device driver
> 
> On Thu, Aug 25, 2011 at 09:48:36AM -0700, K. Y. Srinivasan wrote:
> > +	util_drv.driver.name = driver_name;
> > +
> > +	return vmbus_child_driver_register(&util_drv.driver);
> 
> We should free the allocations if vmbus_child_driver_register() fails.

Thanks Dan. I will take care of this.

Regards,

K. Y
