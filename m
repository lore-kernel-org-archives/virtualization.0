From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] hv: Update MAINTAINERS
Date: Fri, 2 Dec 2011 14:38:30 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AA7B8D3@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1322778690-17381-1-git-send-email-kys@microsoft.com>
 <alpine.LNX.2.00.1112021531230.18207@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1112021531230.18207@pobox.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>, "joe@perches.com" <joe@perches.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jiri Kosina [mailto:jkosina@suse.cz]
> Sent: Friday, December 02, 2011 9:32 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com;
> joe@perches.com; dmitry.torokhov@gmail.com; Haiyang Zhang
> Subject: Re: [PATCH 1/1] hv: Update MAINTAINERS
> 
> On Thu, 1 Dec 2011, K. Y. Srinivasan wrote:
> 
> > Update the MAINTAINERS file to reflect the current state
> > of the Hyper-V drivers.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  MAINTAINERS |   16 ++++++++++------
> >  1 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3523ab0..809cad8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3197,6 +3197,16 @@ M:	William Irwin <wli@holomorphy.com>
> >  S:	Maintained
> >  F:	fs/hugetlbfs/
> >
> > +Hyper-V CORE AND DRIVERS
> > +M:	K. Y. Srinivasan <kys@microsoft.com>
> > +M:	Haiyang Zhang <haiyangz@microsoft.com>
> > +L:	devel@linuxdriverproject.org
> > +S:	Maintained
> > +F:	drivers/hv/
> > +F:	drivers/hid/hid-hyperv.c
> > +F:	drivers/net/hyperv/
> > +F:	drivers/staging/hv/
> > +
> 
> I will be taking this through trivial tree. Thanks,

Thank you!

K. Y
