From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 03/10] staging: hv: Convert camel cased struct fields	in
 hv.h to lower cases
Date: Mon, 1 Nov 2010 18:27:04 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF728BA19E86@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1288630429-12330-1-git-send-email-haiyangz@linuxonhyperv.com>
 <20101101174310.GA12632@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101101174310.GA12632@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Hank Janssen <hjanssen@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Monday, November 01, 2010 1:43 PM
> Why did I get two different copies of some of these patches?  Are they
> different?

They are the same.
Initially, I sent all 10 patches out at the same time, but I only saw 5 of them in my mail box. So I re-sent the 5 missing ones. Half hour later, I found the 5 previous missing emails were not lost, and received again at a later time.

> >  /* The one and only */
> > -struct hv_context gHvContext = {
> > -	.SynICInitialized	= false,
> > -	.HypercallPage		= NULL,
> > -	.SignalEventParam	= NULL,
> > -	.SignalEventBuffer	= NULL,
> > +struct hv_context g_hv_context = {
> 
> What is the "g_" for?  Why are you keeping the unneeded, and unwanted
> hungarian notation around?  Please don't do that.

The "g_" was used for global variables. I also saw some other global variables with the hungarian notation. Since this notation is not related to camel case conversion, how about we remove the hungarian notations in a separate patch?

Thanks,

- Haiyang
