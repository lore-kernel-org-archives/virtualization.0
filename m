From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 06/20] Staging: hv: util: Properly handle util services
 in the util driver
Date: Thu, 15 Sep 2011 20:24:26 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081E7311@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-6-git-send-email-kys@microsoft.com>
 <20110915200853.GJ3789@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110915200853.GJ3789@shale.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:error27@gmail.com]
> Sent: Thursday, September 15, 2011 4:09 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 06/20] Staging: hv: util: Properly handle util services in the
> util driver
> 
> On Tue, Sep 13, 2011 at 10:59:42AM -0700, K. Y. Srinivasan wrote:
> > @@ -403,31 +384,13 @@ static void vmbus_process_offer(struct work_struct
> *work)
> >  		spin_unlock_irqrestore(&vmbus_connection.channel_lock,
> flags);
> >
> >  		free_channel(newchannel);
> > -	} else {
> > +	} else
> >  		/*
> >  		 * This state is used to indicate a successful open
> >  		 * so that when we do close the channel normally, we
> >  		 * can cleanup properly
> >  		 */
> >  		newchannel->state = CHANNEL_OPEN_STATE;
> 
> It's not worth resending, but this should have kept the curly braces
> for two style reasons.
> 1) If one side of the if else pair has braces the other side gets
> braces too.
> 2) If it's more than one line, it gets braces even if it's not needed
> for semantic reasons.
> 
> Sorry to email you these pedantic things, but if I don't then my OCD
> acts up and I feel all itchy for hours.  Also you have a similar
> thing below as well.

Thanks Dan. I will wait for Greg's action here. Given that Kernel.org is still
down, we are all kind of flying in the dark here.

Regards,

K. Y
