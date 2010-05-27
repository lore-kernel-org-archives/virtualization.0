From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] staging: hv: Fix race condition on IC channel initialization
 (modified)
Date: Thu, 27 May 2010 08:16:55 +0200
Message-ID: <4BFE0E57.7050306@gmail.com>
References: <1FB5E1D5CA062146B38059374562DF7266B8C4AC@TK5EX14MBXC128.redmond.corp.microsoft.com>	<20100526205134.GC7343@suse.de> <1FB5E1D5CA062146B38059374562DF7266B8C72B@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7266B8C72B@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Greg KH <gregkh@suse.de>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 05/26/2010 11:25 PM, Haiyang Zhang wrote:
>> From: Greg KH [mailto:gregkh@suse.de]
>>> +			    VmbusChannelOpen(newChannel, 2 * PAGE_SIZE,
>>> +					     2 * PAGE_SIZE, NULL, 0,
>>> +					     hv_cb_utils[cnt].callback,
>>> +					     newChannel) == 0) {
>>> +				hv_cb_utils[cnt].channel = newChannel;
>>> +				mb();
>>
>> What is the mb() call for?  Why is it necessary?  (hint, if you need it,
>> something else is really wrong...)
> 
> It ensures the channel assignment happens before the wakeup call: 
> osd_WaitEventSet(ic_channel_ready), if the compiler optimization re-arrange 
> the execution order. 

wake_up() is a barrier, you don't need the mb() there.

BTW osd_WaitEventSet et al. can be easily converted to completion.

-- 
js
