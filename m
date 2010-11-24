From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 2/3]: An Implementation of HyperV KVP functionality
Date: Wed, 24 Nov 2010 17:56:17 +0300
Message-ID: <20101124145617.GA11133@ioremap.net>
References: <4CEA6FBE0200003000090BC0@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CEA6FBE0200003000090BC0@novprvoes0310.provo.novell.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>, Virtualization@lists.osdl.org, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi.

I will ack connector part of course, but this hunk is actually quite
bad.


> +static void shutdown_onchannelcallback(void *context)
> +{
> +	struct vmbus_channel *channel = context;
> +	u8 *buf;
> +	u32 buflen, recvlen;
> +	u64 requestid;
> +	u8  execute_shutdown = false;
> +
> +	struct shutdown_msg_data *shutdown_msg;
> +
> +	struct icmsg_hdr *icmsghdrp;
> +	struct icmsg_negotiate *negop = NULL;
> +
> +	buflen = PAGE_SIZE;
> +	buf = kmalloc(buflen, GFP_ATOMIC);
> +
> +	vmbus_recvpacket(channel, buf, buflen, &recvlen, &requestid);

Boom. I did not read further, since this function returns void and thus
can not propagate error, which is likely not a good idea.

-- 
	Evgeniy Polyakov
