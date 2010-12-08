From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: [PATCH 1/4] Add a connector Index to support HyperV KVP
	functionality
Date: Wed, 08 Dec 2010 15:45:02 -0700
Message-ID: <4CFFA7FE020000300009190A@novprvoes0310.provo.novell.com>
References: <4CFFA25B02000030000918BE@novprvoes0310.provo.novell.com>
	<20101208223259.GA6714@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20101208223259.GA6714@suse.de>
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
To: Greg KH <gregkh@suse.de>
Cc: Zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <shemminger@vyatta.com>, Virtualization@lists.osdl.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org



>>> On 12/8/2010 at  5:32 PM, in message <20101208223259.GA6714@suse.de>, Greg KH
<gregkh@suse.de> wrote: 
> Please make your subject a bit more descriptive, for this one, it would
> be:
> 	Subject: [PATCH 1/4] Connector: add index to support HyperV
> 
> And what is a "KVP"?
> 
> On Wed, Dec 08, 2010 at 03:20:59PM -0700, Ky Srinivasan wrote:
>> >From 5b7c16baf2f310a1e7e119c3df8fd976ca0e2f57 Mon Sep 17 00:00:00 2001
>> From: ksrinivasan <ksrinivasan@novell.com>
> 
> I doubt that's your full name you want as the changelog author
> information :)
> 
>> Date: Wed, 8 Dec 2010 09:35:13 -0700
> 
> Why is this in the body of your message?
> 
>> 
>> Added a connector index to support key value/pair (KVP) functionality
>> for Linux guests hosted on a HyperV platform. All KVP related
>> data gathering will be done in a user-level daemon. The kernel 
>> component of KVP communicates with the data gathering daemon using this
>> connector index.
>> 
>> 
>> Signed-off-by: ksrinivasan <ksrinivasan@novell.com>
> 
> Same error here with your name :(
> 
> Third time's a charm?
I hope so! I will resend all the patches.

Thanks,

K. Y
> 
> greg k-h
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
