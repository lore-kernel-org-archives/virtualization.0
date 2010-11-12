From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Fri, 12 Nov 2010 11:29:58 -0700
Message-ID: <4CDD253602000030000903C9@novprvoes0310.provo.novell.com>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
	<20101111211904.GB31373@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20101111211904.GB31373@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



>>> On 11/11/2010 at  4:19 PM, in message <20101111211904.GB31373@kroah.com>, Greg
KH <greg@kroah.com> wrote: 
> On Thu, Nov 11, 2010 at 01:03:10PM -0700, Ky Srinivasan wrote:
>> +/*
>> + * Array of keys we support in Linux.
> 
> Not really, you can support "any" number of keys as the kernel shouldn't
> care, or did I get it wrong?
We currently support only the keys that have been specified in the KVP specification. I have a more detailed response on the core KVP protocol in response to your other email on this topic.
> 
>> + *
>> + */
>> +#define KVP_MAX_KEY	10
>> +#define KVP_LIC_VERSION 1
> 
> Um, this is a nice magic number, care to explain it a bit more?
As I noted in an earlier email, the KVP specification currently requires that we support 10 keys and it also specifies the ordering of these keys.  The information for the key "IntegrationServicesVersion", is only available in the kernel (one of the other LIC drivers defines  this information). 

>> +static char *kvp_keys[KVP_MAX_KEY] = {"FullyQualifiedDomainName",
>> +				"IntegrationServicesVersion",
> 
> Looks like it matches up with this, right?  You might want to make that
> a bit more "tied" together.
> 
Yes; I will fix this.
>> +			case (KVP_LIC_VERSION):
>> +				kvp_transaction_active = true;
>> +				kvp_respond_to_host(kvp_data->index,
>> +						HV_DRV_VERSION);
> 
> Why are you doing this in the kernel?  Why not do it from userspace like
> all other messages?
This information is only available in the kernel (defined by another LIC driver).

Regards,

K. Y
> 
> thanks,
> 
> greg k-h
