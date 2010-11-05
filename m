From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 36/49] drivers/video: Use vzalloc
Date: Thu, 04 Nov 2010 22:31:22 -0700
Message-ID: <1288935082.18440.31.camel@Joe-Laptop>
References: <cover.1288925424.git.joe@perches.com>
	 <alpine.DEB.2.00.1011031108260.11625@router.home>
	 <a1c4c46381ac1867c4af3edb811e58a721957842.1288925425.git.joe@perches.com>
	 <AANLkTinpKni-pfEzo=OwZZePVHapafVHJOydDoDU268_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinpKni-pfEzo=OwZZePVHapafVHJOydDoDU268_@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2010-11-05 at 13:27 +0800, Dave Young wrote:
> On Fri, Nov 5, 2010 at 11:08 AM, Joe Perches <joe@perches.com> wrote:
> > diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
> > @@ -515,11 +515,10 @@ static int __devinit arcfb_probe(struct platform_device *dev)
> >
> >        /* We need a flat backing store for the Arc's
> >           less-flat actual paged framebuffer */
> > -       if (!(videomemory = vmalloc(videomemorysize)))
> > +       videomemory = vmalloc(videomemorysize);
> typo?

Yes. Thanks for catching that.
