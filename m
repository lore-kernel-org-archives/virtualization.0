From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 2/4] Drivers: hv: Support the newly introduced KVP
	messages in the driver
Date: Sun, 11 Mar 2012 16:56:06 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481B75B403@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1331422300-4330-1-git-send-email-kys@microsoft.com>
	<1331422331-4381-1-git-send-email-kys@microsoft.com>
	<1331422331-4381-2-git-send-email-kys@microsoft.com>
	<20120311104230.GC3337@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120311104230.GC3337@mwanda>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Alan Stern <stern@rowland.harvard.edu>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Sunday, March 11, 2012 6:43 AM
> To: KY Srinivasan
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com;
> Alan Stern
> Subject: Re: [PATCH 2/4] Drivers: hv: Support the newly introduced KVP
> messages in the driver
> 
> On Sat, Mar 10, 2012 at 03:32:09PM -0800, K. Y. Srinivasan wrote:
> > +		switch (message->kvp_hdr.operation) {
> > +		case KVP_OP_SET:
> > +			switch (in_msg->body.kvp_set.data.value_type) {
> > +			case REG_SZ:
> > +				/*
> > +				 * The value is a string - utf16 encoding.
> > +				 */
> > +				message->body.kvp_set.data.value_size =
> > +				utf16s_to_utf8s(
> > +				(wchar_t *)
> > +				in_msg->body.kvp_set.data.value,
> > +				in_msg->body.kvp_set.data.value_size,
> > +				UTF16_LITTLE_ENDIAN,
> > +				message->body.kvp_set.data.value,
> > +				HV_KVP_EXCHANGE_MAX_VALUE_SIZE) + 1;
> > +				break;
> > +
> 
> This block of unreadable text is so nasty.
> 
> You could return directly if the msg = kmalloc() fails and pull
> everything in one indent level.  It's normally more readable to
> handle errors as soon as possible anyway.

True.

> 
> Probably that's not enough to make a difference and we'd need to
> introduce a new function.
> 
> Btw I don't know if utf16s_to_utf8s() counts the NUL char or not.
> It feels like maybe we could end up with ->value_size equal to
> HV_KVP_EXCHANGE_MAX_VALUE_SIZE + 1.

The MAX value is set to accommodate the maximum string that will ever
be handled including the string terminator. The function utf16s_to_utf8s()
returns the converted string length but the returned length does not 
include the string terminator (like strlen), hence the "+1".

Dan, I will see if there are other comments on these patches and will
accommodate your suggestion then. If there are no other comments,
would you mind if I addressed your comments here in a separate patch.  


Regards,

K. Y

> 
> regards,
> dan carpenter
