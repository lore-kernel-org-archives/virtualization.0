From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Fri, 12 Nov 2010 10:47:53 -0800
Message-ID: <20101112184753.GA20893@kroah.com>
References: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
	<20101111211548.GA31373@kroah.com>
	<4CDD1FAA02000030000903B8@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CDD1FAA02000030000903B8@novprvoes0310.provo.novell.com>
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

On Fri, Nov 12, 2010 at 11:06:18AM -0700, Ky Srinivasan wrote:
> >> +typedef struct kvp_msg {
> >> +	__u32 kvp_key; /* Key */
> >> +	__u8  kvp_value[0]; /* Corresponding value */
> >> +} kvp_msg_t;
> > 
> > I thought that kvp_value was really KVP_VALUE_SIZE?
> 
> kvp_value is typed information and KVP_VALUE_SIZE specifies the
> maximum size of the supported value. For instance if kvp_value is a
> string (which is the case for all the values currently supported),
> KVP_VALUE_SIZE specifies the maximum size of the string that will be
> supported.

So it's a variable length structure?  How do you konw how long the
structure is, does that depend on the key?

> > And no typedefs, you did run your code through checkpatch.pl, right?
> > Why ignore the stuff it spits back at you?
> I will fix this.
> > 
> > 
> >> +static char *kvp_keys[KVP_MAX_KEY] = {"FullyQualifiedDomainName",
> >> +				"IntegrationServicesVersion",
> >> +				"NetworkAddressIPv4",
> >> +				"NetworkAddressIPv6",
> >> +				"OSBuildNumber",
> >> +				"OSName",
> >> +				"OSMajorVersion",
> >> +				"OSMinorVersion",
> >> +				"OSVersion",
> >> +				"ProcessorArchitecture",
> >> +				};
> > 
> > Why list these at all, as more might come in the future, and the kernel
> > really doesn't care about them, right?
> The core HyperV KVP protocol is such that the host iterates through an
> index (starting with 0); the guest is free to associate a key with the
> index and return the associated value. The host side iteration is
> stopped when the guest returns a failure on an index. MSFT has
> specified the keys and their ordinal value in their KVP specification.
> The array you see above is part of that specification.

So you match on the string name of the key?  I'm confused, as I didn't
think I saw you matching on the string name, only the key value.

Also, as the kernel isn't handling the key type (with one exception),
why even list these in the kernel at all?  I'm all for documenting
stuff, but don't use code memory for documentation :)

> >> --- linux.trees.git.orig/include/linux/connector.h	2010-11-09 17:22:15.000000000 
> > -0500
> >> +++ linux.trees.git/include/linux/connector.h	2010-11-11 13:14:52.000000000 
> > -0500
> >> @@ -42,8 +42,9 @@
> >>  #define CN_VAL_DM_USERSPACE_LOG		0x1
> >>  #define CN_IDX_DRBD			0x8
> >>  #define CN_VAL_DRBD			0x1
> >> +#define CN_KVP_IDX			0x9     /* MSFT KVP functionality */
> > 
> > Did you reserve this number with anyone?  Who?
> 
> I sent an email to	Evgeniy Polyakov  (Johnpol@2ka.mipt). The mail
> bounced back. I was hoping you would help me register this index.
> Would it make sense to have a separate patch to deal with registering
> this index?

Yes, as I can not modify non-staging code without an ack from that
maintainer.  And I'm pretty sure that Evgeniy's address has just
changed, use "Evgeniy Polyakov <zbr@ioremap.net>" instead.

thanks,

greg k-h
