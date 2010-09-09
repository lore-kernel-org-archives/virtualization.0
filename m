From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Convert vmbus driver interface
 function pointer table to constant
Date: Thu, 9 Sep 2010 14:53:03 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF72854C94CE@TK5EX14MBXC130.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Wednesday, September 08, 2010 6:44 PM
> > Convert vmbus driver interface function pointer table to constant
> > The vmbus interface functions are assigned to a constant - vmbus_ops.
> 
> You also remove a function pointer in this patch, why?  Please break up
> the patch into logical parts, one patch, one thing.
> 
> This looks like it should be 2 patches, right?

Because the vmbus interface function pointer table is converted to a
constant variable -- vmbus_ops, the function GetChannelInterface(),
VmbusGetChannelInterface() and pointer GetChannelInterface are no longer
in use. The deprecated function's work is done by the initialization of
the newly added constant variable vmbus_ops.

I created the new constant variable vmbus_ops and removed the deprecated
function pointer GetChannelInterface in one patch.

Thanks,

- Haiyang
