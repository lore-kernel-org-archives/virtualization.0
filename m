From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/2] staging: hv: Fix race condition in hv_utils module
 initialization.
Date: Wed, 19 May 2010 20:30:25 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7266B894B0@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7266B8930E@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100519161011.GA20266@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100519161011.GA20266@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> > +	/* Wait until all IC channels are initialized */
> > +	while (atomic_read(&hv_utils_initcnt) < MAX_MSG_TYPES)
> > +		msleep(100);
> 
> No, don't do this here, do something in your hv_vmbus core to handle
> registering sub-drivers properly.  Perhaps you need to sleep there
> before you can succeed on a initialization.

Thanks for the recommendation. I will put the sleep into vmbus_init to 
ensure all channels are ready before the vmbus_init function exits.

> >  	hv_cb_utils[HV_SHUTDOWN_MSG].channel->OnChannelCallback =
> >  		&shutdown_onchannelcallback;
> 
> The problem is that you just have a bunch of callbacks you are setting
> up, it's not a "real" function call.  Please change it over to a
> function call, like all other subsystems have.  Then, you can handle
> any
> "sleep until we are set up properly" issues in the vmbus code, not in
> each and every individual bus driver.

Actually, we already assign a default callback function, chn_cb_negotiate(),
when the channels are opened in vmbus module. It's a real function and can 
handle common negotiation messages.
I will move the sleep into vmbus module as well.

Thanks,

- Haiyang
