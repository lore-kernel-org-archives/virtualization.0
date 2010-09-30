From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] staging: hv: Remove camel case variables in
	channel.c
Date: Thu, 30 Sep 2010 05:12:10 -0700
Message-ID: <20100930121210.GA14358@kroah.com>
References: <4CA4105E.80602@sailtheuniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CA4105E.80602@sailtheuniverse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@sailtheuniverse.com>
Cc: hjanssen@microsoft.com, Haiyang Zhang <haiyangz@microsoft.com>, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 29, 2010 at 09:21:50PM -0700, Hank Janssen wrote:
> 
> Rename camel case variables in channel.c and changed them to
> lowercase.
> 
> Sending this from my own accounts till we have a proper mail server
> set up that allows us to send out patches without issues.

This paragraph goes below the '---' line, it doesn't belong in the
change log, right?

> This patch was created by Haiyang Zhang.

Then put the proper "From:" line in the email body like the file,
Documentation/SubmittingPatches tells you to do so that git properly
credits the correct author.

Oh, you also forgot to cc: me so I know to pick the patch up :)

Care to try it again?

thanks,

greg k-h
