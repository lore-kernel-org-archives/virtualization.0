From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 44/46] Staging: hv: vmbus: Fix checkpatch warnings in
 connection.c
Date: Tue, 30 Aug 2011 17:11:57 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B5318@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-44-git-send-email-kys@microsoft.com>
 <20110829180934.GB23618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110829180934.GB23618@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, August 29, 2011 2:10 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 44/46] Staging: hv: vmbus: Fix checkpatch warnings in
> connection.c
> 
> On Sat, Aug 27, 2011 at 11:31:43AM -0700, K. Y. Srinivasan wrote:
> > Fix checkpatch warnings in connection.c.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/staging/hv/connection.c |   13 +++++++------
> >  1 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
> > index ca92ca3..9e99c04 100644
> > --- a/drivers/staging/hv/connection.c
> > +++ b/drivers/staging/hv/connection.c
> > @@ -220,11 +220,11 @@ static void process_chn_event(u32 relid)
> >  	channel = relid2channel(relid);
> >
> >  	spin_lock_irqsave(&channel->inbound_lock, flags);
> > -	if (channel && (channel->onchannel_callback != NULL)) {
> > +	if (channel && (channel->onchannel_callback != NULL))
> >  		channel->onchannel_callback(channel-
> >channel_callback_context);
> > -	} else {
> 
> I agree with Joe here, if channel really was NULL, you just oopsed.
> 
> I'll apply this one, but please send me a follow-on one fixing this bug.

Thanks Greg. I will fix this. I got these patches out just before Hurricane Irene
hit the east coast. While we were lucky that it was not as bad as was predicted,
we lost power and we still don't have power. I have come to a public library in
a nearby town to check my email.  So, my responses will be sporadic over the 
next couple of days (until we get power). I will try to address the issues you
have raised as quickly as possible.

Regards,

K. Y
