From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/1] staging: hv: Add Time Sync feature to hv_utils
 module
Date: Thu, 6 May 2010 01:42:01 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF72662A6F52@TK5EX14MBXC130.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF72662A6D3B@TK5EX14MBXC130.redmond.corp.microsoft.com>,<1273107494.1735.87.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273107494.1735.87.camel@Joe-Laptop.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "gregkh@suse.de" <gregkh@suse.de>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> Why a maximum of 50 samples?
After reboot the flag ICTIMESYNCFLAG_SYNC is included in the 
first time message after the timesync channel is opened. Since the 
hv_utils module is loaded after hv_vmbus, the first message is usually
missed. The other thing is, systime is automatically set to emulated 
hardware clock which may not be UTC time or the same time 
zone. So, to override these effects, we use the first 50 time samples 
for initial system time setting.

> It might be better to do something like this
> so the ns_to_timespec isn't performe when unnecessary.
Thanks for the optimization, I will put it into the code.

- Haiyang