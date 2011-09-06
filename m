From: Mike Sterling <Mike.Sterling@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Add support for >2 TB LUN in storage
	driver.
Date: Tue, 6 Sep 2011 19:14:01 +0000
Message-ID: <A19259D4D4D02A429E578F34E2857F9D4D217013@TK5EX14MBXC203.redmond.corp.microsoft.com>
References: <1314915069-1796-1-git-send-email-mike.sterling@microsoft.com>
	<20110906190615.GA31897@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110906190615.GA31897@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday, September 06, 2011 12:06 PM, Greg KH wrote:
>On Thu, Sep 01, 2011 at 03:11:09PM -0700, Mike Sterling wrote:
>> If a LUN larger than 2 TB is attached to a Linux VM on Hyper-V, we 
>> currently report a maximum size of 2 TB. This patch resolves the issue in hv_storvsc.
>> Thanks to Robert Scheck <robert.scheck@etes.de> for reporting the issue.
>> 
>> Reported-by: Robert Scheck <robert.scheck@etes.de>
>> Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
>> Signed-off-by: K.Y. Srinivasan <kys@microsoft.com>
>> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>> ---
>>  drivers/staging/hv/hyperv_storage.h |    1 +
>
>This file is no longer in the latest kernel tree (linux-next or staging-next).  What tree did you generate this patch against?  And >how come Haiyang and KY didn't catch such a basic mistake in their review...
>
>I'm guessing that this patch was not even tested :(
>
>Please fix this and resend.

Greg,

This patch was reviewed by both Ky and Haiyang. However, it looks like I built the patch against an older tree that didn't have Ky's changes. The "how" is still unclear, even after reviewing my steps with Ky. I've discussed this with Ky, I'm rebuilding the patch today, and will resubmit once we confirm.

-Mike
