From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 1/1] hv: Update MAINTAINERS
Date: Fri, 02 Dec 2011 16:38:13 +0200
Message-ID: <1322836693.3780.7.camel@lappy>
References: <1322778690-17381-1-git-send-email-kys@microsoft.com>
	 <alpine.LNX.2.00.1112021531230.18207@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1112021531230.18207@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2011-12-02 at 15:31 +0100, Jiri Kosina wrote:
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

It should probably be 'S: Supported' though, right?

-- 

Sasha.
