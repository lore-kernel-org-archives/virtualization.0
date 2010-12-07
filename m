From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: [PATCH 2/3]: An implementation of HyperV KVP functionality
Date: Tue, 07 Dec 2010 16:19:03 -0700
Message-ID: <4CFE5E770200003000091778@novprvoes0310.provo.novell.com>
References: <4CFE5204020000300009174C@novprvoes0310.provo.novell.com>
	<20101207222933.GA10431@ioremap.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101207222933.GA10431@ioremap.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: devel@driverdev.osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>, Virtualization@lists.osdl.org, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org



>>> On 12/7/2010 at  5:29 PM, in message <20101207222933.GA10431@ioremap.net>,
Evgeniy Polyakov <zbr@ioremap.net> wrote: 
> On Tue, Dec 07, 2010 at 03:25:56PM -0700, Ky Srinivasan 
> (ksrinivasan@novell.com) wrote:
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
> This did not change since previous review and this is wrong.
> It is the right way to crash kernel.
> 
> I did not read further since this is a show-stopper imo.
Hank, do you want to respond to this comment.

Regards,

K. Y
