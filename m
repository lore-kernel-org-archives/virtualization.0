From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Fix missing functions for
 net_device_ops
Date: Mon, 2 Aug 2010 17:41:46 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7280E8553D@TK5EX14MBXC121.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7280E8547C@TK5EX14MBXC121.redmond.corp.microsoft.com>
 <20100802171754.GA8213@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100802171754.GA8213@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Monday, August 02, 2010 1:18 PM
>
> So what kernel versions are affected by this?
> 
> Please don't attach a patch and put it inline, it forces me to edit it
> by hand.
> 
> Care to provide the above information and resend it so I can apply it?

It affects kernel 2.6.32 and later, which are all versions contain Hyper-V drivers.
I will send out an email with the inline patch only.

Thanks,

- Haiyang
