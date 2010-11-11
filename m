From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Thu, 11 Nov 2010 13:19:04 -0800
Message-ID: <20101111211904.GB31373@kroah.com>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
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
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 11, 2010 at 01:03:10PM -0700, Ky Srinivasan wrote:
> +/*
> + * Array of keys we support in Linux.

Not really, you can support "any" number of keys as the kernel shouldn't
care, or did I get it wrong?

> + *
> + */
> +#define KVP_MAX_KEY	10
> +#define KVP_LIC_VERSION 1

Um, this is a nice magic number, care to explain it a bit more?

> +static char *kvp_keys[KVP_MAX_KEY] = {"FullyQualifiedDomainName",
> +				"IntegrationServicesVersion",

Looks like it matches up with this, right?  You might want to make that
a bit more "tied" together.

> +			case (KVP_LIC_VERSION):
> +				kvp_transaction_active = true;
> +				kvp_respond_to_host(kvp_data->index,
> +						HV_DRV_VERSION);

Why are you doing this in the kernel?  Why not do it from userspace like
all other messages?

thanks,

greg k-h
