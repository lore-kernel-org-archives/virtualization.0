From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 1/1] staging: hv: Remove camel case variables in
 channel.c
Date: Tue, 5 Oct 2010 09:23:19 +0200
Message-ID: <20101005092319.7ae2ba86@schatten.dmk.lab>
References: <4CA4105E.80602@sailtheuniverse.com>
	<20100930121210.GA14358@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100930121210.GA14358@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Hank Janssen <hjanssen@sailtheuniverse.com>, hjanssen@microsoft.com, Haiyang Zhang <haiyangz@microsoft.com>, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 30 Sep 2010 05:12:10 -0700
Greg KH <greg@kroah.com> wrote:

> On Wed, Sep 29, 2010 at 09:21:50PM -0700, Hank Janssen wrote:
> > 
> > Rename camel case variables in channel.c and changed them to
> > lowercase.
> > 
> > Sending this from my own accounts till we have a proper mail server
> > set up that allows us to send out patches without issues.
> 
> This paragraph goes below the '---' line, it doesn't belong in the
> change log, right?


I recently read something about 'scissor lines' which allow more
natural reading flow with patches by git automatically skipping
everything above a scissor-line:
'A line that mainly consists of scissors (either ">8" or "8<") and 
perforation (dash "-") marks is called a scissors line'

man git-mailinfo
git-am -c

:-)

Cheers,
Flo
