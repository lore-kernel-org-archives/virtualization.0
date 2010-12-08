From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 2/3]: An implementation of HyperV KVP functionality
Date: Wed, 8 Dec 2010 18:09:14 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5622C0B8D75@TK5EX14MBXC116.redmond.corp.microsoft.com>
References: <4CFE5204020000300009174C@novprvoes0310.provo.novell.com>
	<20101207222933.GA10431@ioremap.net>
	<4CFE5E770200003000091778@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <4CFE5E770200003000091778@novprvoes0310.provo.novell.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ky Srinivasan <ksrinivasan@novell.com>, Evgeniy Polyakov <zbr@ioremap.net>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Virtualization@lists.osdl.org" <Virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org


> From: Ky Srinivasan [mailto:ksrinivasan@novell.com]
> Sent: Tuesday, December 07, 2010 3:19 PM
> >>> On 12/7/2010 at  5:29 PM, in message
> <20101207222933.GA10431@ioremap.net>,
> Evgeniy Polyakov <zbr@ioremap.net> wrote:
> > On Tue, Dec 07, 2010 at 03:25:56PM -0700, Ky Srinivasan
> > (ksrinivasan@novell.com) wrote:
> >> +static void shutdown_onchannelcallback(void *context)
> >> +{
> >> +	struct vmbus_channel *channel = context;
> >> +	u8 *buf;
> >> +	u32 buflen, recvlen;
> >> +	u64 requestid;
> >> +	u8  execute_shutdown = false;
> >> +
> >> +	struct shutdown_msg_data *shutdown_msg;
> >> +
> >> +	struct icmsg_hdr *icmsghdrp;
> >> +	struct icmsg_negotiate *negop = NULL;
> >> +
> >> +	buflen = PAGE_SIZE;
> >> +	buf = kmalloc(buflen, GFP_ATOMIC);
> >> +
> >> +	vmbus_recvpacket(channel, buf, buflen, &recvlen, &requestid);
> >
> > This did not change since previous review and this is wrong.
> > It is the right way to crash kernel.
> >
> > I did not read further since this is a show-stopper imo.
> Hank, do you want to respond to this comment.
> 

I will submit a patch for hv_utils.c to check the return value from
kmalloc and vmbus_recvpacket and return if either one of them fail.

The function is a void because they are treated here as fire and
Forget. But it comment about what would happen if kmalloc or 
Vmbus_recvpacket fails is correct. We could cause a crash.

So I will correct that part.

Hank.
