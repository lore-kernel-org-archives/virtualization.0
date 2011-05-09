From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 077/206] Staging: hv: Get rid of call to cleanup()
Date: Mon, 9 May 2011 23:53:35 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481EEBA7@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-77-git-send-email-kys@microsoft.com>
 <20110509225328.GA2832@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110509225328.GA2832@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, May 09, 2011 6:53 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD); Hank Janssen
> Subject: Re: [PATCH 077/206] Staging: hv: Get rid of call to cleanup()
> 
> On Mon, May 09, 2011 at 02:55:59PM -0700, K. Y. Srinivasan wrote:
> > cleanup() is an empty function; get rid of it.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> > Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> > ---
> >  drivers/staging/hv/netvsc_drv.c |    4 ----
> 
> Just picking a random patch out of this series (which, I only received
> the first 132, not all 206).
> 
> You need to specify a better changelog entry as you didn't say what code
> you are changing in the Subject:.
> 
> How about:
> 	Staging: hv: netvsc_drv: Get rid of call to cleanup()
> 
> Otherwise I would think (and I did) that you got rid of a global
> function called cleanup() in all of the hv code.
> 
> Care to fix the names of your patches?

Good point; I will fix up the names.
> 
> Note, I wouldn't recommend sending that many patches to lkml, it's not
> needed, just stick to the devel@linuxdriverproject.org list as I really
> doubt anyone else cares about this code at the moment.

Agreed; I will do that. Shall I go ahead and fix the names and send the patches 
just to you or do you want me to send them to the devel list as well.

Regards,

K. Y
> 
> thanks,
> 
> greg k-h
