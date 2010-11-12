From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Fri, 12 Nov 2010 11:22:15 -0800
Message-ID: <20101112192215.GA22084@kroah.com>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
	<20101111211904.GB31373@kroah.com>
	<4CDD253602000030000903C9@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CDD253602000030000903C9@novprvoes0310.provo.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 12, 2010 at 11:29:58AM -0700, Ky Srinivasan wrote:
> 
> 
> >>> On 11/11/2010 at  4:19 PM, in message <20101111211904.GB31373@kroah.com>, Greg
> KH <greg@kroah.com> wrote: 
> > On Thu, Nov 11, 2010 at 01:03:10PM -0700, Ky Srinivasan wrote:
> >> +/*
> >> + * Array of keys we support in Linux.
> > 
> > Not really, you can support "any" number of keys as the kernel shouldn't
> > care, or did I get it wrong?
> We currently support only the keys that have been specified in the KVP specification. I have a more detailed response on the core KVP protocol in response to your other email on this topic.
> > 
> >> + *
> >> + */
> >> +#define KVP_MAX_KEY	10
> >> +#define KVP_LIC_VERSION 1
> > 
> > Um, this is a nice magic number, care to explain it a bit more?
> As I noted in an earlier email, the KVP specification currently requires that we support 10 keys and it also specifies the ordering of these keys.  The information for the key "IntegrationServicesVersion", is only available in the kernel (one of the other LIC drivers defines  this information). 
> 
> >> +static char *kvp_keys[KVP_MAX_KEY] = {"FullyQualifiedDomainName",
> >> +				"IntegrationServicesVersion",
> > 
> > Looks like it matches up with this, right?  You might want to make that
> > a bit more "tied" together.
> > 
> Yes; I will fix this.
> >> +			case (KVP_LIC_VERSION):
> >> +				kvp_transaction_active = true;
> >> +				kvp_respond_to_host(kvp_data->index,
> >> +						HV_DRV_VERSION);
> > 
> > Why are you doing this in the kernel?  Why not do it from userspace like
> > all other messages?
> This information is only available in the kernel (defined by another LIC driver).

I thought it was exported through a modinfo parameter?  If not, you
could set the MODULE_VERSION field be the as this which then is exported
to userspace so you would not have to do any thing like this in the
kernel.

thanks,

greg k-h
