From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: [PATCH 2/4] Rename the file hv_utils.c
Date: Wed, 08 Dec 2010 16:32:20 -0700
Message-ID: <4CFFB3140200003000091923@novprvoes0310.provo.novell.com>
References: <4CFFA39202000030000918CC@novprvoes0310.provo.novell.com>
	<20101208225524.GA11869@ioremap.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101208225524.GA11869@ioremap.net>
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
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org



>>> On 12/8/2010 at  5:55 PM, in message <20101208225524.GA11869@ioremap.net>,
Evgeniy Polyakov <zbr@ioremap.net> wrote: 
> You must be kidding.
> The same in hv_kvp_onchannelcallback() and probably anywhere else.

Hank, if it is ok with you, I will fix this issue across the board and submit that as part of  this patch set.

Regards,

K. Y 
> 
> On Wed, Dec 08, 2010 at 03:26:10PM -0700, Ky Srinivasan 
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
>> +
> 
>> +static void timesync_onchannelcallback(void *context)
>> +{
>> +	struct vmbus_channel *channel = context;
>> +	u8 *buf;
>> +	u32 buflen, recvlen;
>> +	u64 requestid;
>> +	struct icmsg_hdr *icmsghdrp;
>> +	struct ictimesync_data *timedatap;
>> +
>> +	buflen = PAGE_SIZE;
>> +	buf = kmalloc(buflen, GFP_ATOMIC);
>> +
>> +	vmbus_recvpacket(channel, buf, buflen, &recvlen, &requestid);
> 
>> +static void heartbeat_onchannelcallback(void *context)
>> +{
>> +	struct vmbus_channel *channel = context;
>> +	u8 *buf;
>> +	u32 buflen, recvlen;
>> +	u64 requestid;
>> +	struct icmsg_hdr *icmsghdrp;
>> +	struct heartbeat_msg_data *heartbeat_msg;
>> +
>> +	buflen = PAGE_SIZE;
>> +	buf = kmalloc(buflen, GFP_ATOMIC);
>> +
>> +	vmbus_recvpacket(channel, buf, buflen, &recvlen, &requestid);
