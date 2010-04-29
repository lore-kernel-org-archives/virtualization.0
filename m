From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/1] hv: Added new hv_utils driver to hyper-v
Date: Thu, 29 Apr 2010 00:20:51 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5621AFEC88E@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <8AFC7968D54FB448A30D8F38F259C5621AFEC6F3@TK5EX14MBXC114.redmond.corp.microsoft.com>,<20100428222810.GA18247@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100428222810.GA18247@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, Ky Srinivasan <ksrinivasan@novell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org


> And Greg spoke these words......
>>On Wed, Apr 28, 2010 at 10:11:02PM +0000, Hank Janssen wrote:
>>
>> Addition of new driver for Hyper-V called hv_utils.
>> This driver is intended to support things like KVP, Timesync, Heartbeat etc.
>
>Does this duplicate functionality in KY's clocksource driver?  Or is it
>a separate thing?

This is a separate thing, timesync registers itself with the vmbus so it receives
a time sync message from Hyper-V on cold boot and restore from saved state. 
With this we set the clock on the current VM. (Human readable time basically)

What KY submitted it a driver that connects to the Hyper-V stable timesource.
There are no messages from Hyper-V for that, you have to read that directly 
from the hypervisor page.

>> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
>> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
>I did not sign off on this, I've never even seen this patch before, why
>would you add my name?  That is not ok at all!

I got ahead of myself. Just trying to make your workload easier :)

I will resend right away with the line removed.

Hank.
