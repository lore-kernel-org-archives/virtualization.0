From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: [PATCH 2/3]: An Implementation of HyperV KVP functionality
Date: Mon, 29 Nov 2010 11:26:17 -0700
Message-ID: <4CF38DD90200003000090F68@novprvoes0310.provo.novell.com>
References: <4CEA6FBE0200003000090BC0@novprvoes0310.provo.novell.com>
	<20101124145617.GA11133@ioremap.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20101124145617.GA11133@ioremap.net>
Content-Disposition: inline
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org



>>> On 11/24/2010 at  9:56 AM, in message <20101124145617.GA11133@ioremap.net>,
Evgeniy Polyakov <zbr@ioremap.net> wrote: 
> Hi.
> 
> I will ack connector part of course, but this hunk is actually quite
Thank you.
> bad.
> 
> 
>> +static void shutdown_onchannelcallback(void *context)
>> +{
>> +	struct vmbus_channel *channel = context;
>> +	u8 *buf;
>> +	u32 buflen, recvlen;
>> +	u64 requestid;
>> +	u8  execute_shutdown = false;
>> +
>> +	struct shutdown_msg_data *shutdown_msg;
>> +
>> +	struct icmsg_hdr *icmsghdrp;
>> +	struct icmsg_negotiate *negop = NULL;
>> +
>> +	buflen = PAGE_SIZE;
>> +	buf = kmalloc(buflen, GFP_ATOMIC);
>> +
>> +	vmbus_recvpacket(channel, buf, buflen, &recvlen, &requestid);
> 
> Boom. I did not read further, since this function returns void and thus
> can not propagate error, which is likely not a good idea.

Hank and Haiyang (both copied here) are the authors of this code. My contribution to this code (in this patch) has been to change the name of the file! I will let Hank and Haiyang comment on your feedback.

Regards,

K. Y 
