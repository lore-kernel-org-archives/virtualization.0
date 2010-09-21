From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 2/2] staging: hv: Remove camel cases from vmbus channel
 functions
Date: Tue, 21 Sep 2010 15:10:50 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7289E6554F@TK5EX14MBXC121.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7289E499E4@TK5EX14MBXC121.redmond.corp.microsoft.com>
 <20100920232921.GA31204@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100920232921.GA31204@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'gregkh@suse.de'" <gregkh@suse.de>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, September 20, 2010 7:29 PM
> Function name changes are one thing.
> 
> Variable names are another thing.
> 
> Again, one patch per thing please.
> 
> It's easier to read and verify that everything is sane.
> 
> Please try this one again.

I will separate the variable names and function names into two patches,
And, incorporate your suggestions like - naming the functions as vmbus_*
instead of vmbus_channel_*, updating the comments, and etc..

Thanks,

- Haiyang
