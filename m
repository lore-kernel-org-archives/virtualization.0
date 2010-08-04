From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 6/6] staging: hv: Gracefully handle SCSI resets
Date: Wed, 4 Aug 2010 04:28:17 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56223FE7AE9@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <8AFC7968D54FB448A30D8F38F259C56223FD1D3C@TK5EX14MBXC114.redmond.corp.microsoft.com>
 <20100803174722.GG1455@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100803174722.GG1455@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

And then Greg spoke;
>>On Tue, Aug 03, 2010 at 05:31:56PM +0000, Hank Janssen wrote:
>> From: Hank Janssen <hjanssen@microsoft.com>
>> 
>> If we get a SCSI host bus reset we now gracefully handle it, and we take the device offline. 
>> This before sometimes caused hangs.
>
>Is this a problem for all older versions as well?  If so, should it be backported to the -stable kernel releases?

Yes, this should be backported to all stable kernel releases that have the Hyper-V drivers
In them.  This fixes a VM freeze.

All patches I submitted in the batch of 6 (Except for the TODO patch) fix bugs. This one
Fixes the worst one.

Thanks,

Hank.
