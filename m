From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
Date: Sun, 30 Oct 2011 16:16:47 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AA544DA@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1319645321-9770-1-git-send-email-kys@microsoft.com>
 <alpine.LNX.2.00.1110282026360.3541@pobox.suse.cz>
 <6E21E5352C11B742B20C142EB499E0481AA531D4@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20111028200315.GA30918@suse.de>
 <6E21E5352C11B742B20C142EB499E0481AA53219@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <alpine.LNX.2.00.1110291904190.3541@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1110291904190.3541@pobox.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jiri Kosina [mailto:jkosina@suse.cz]
> Sent: Saturday, October 29, 2011 1:05 PM
> To: KY Srinivasan
> Cc: Greg KH; linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; ohering@suse.com; Dmitry Torokhov
> Subject: RE: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
> 
> On Fri, 28 Oct 2011, KY Srinivasan wrote:
> 
> > > > > >  obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
> > > > > >  obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
> > > > > >  obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
> > > > > > +obj-$(CONFIG_HYPERV_MOUSE)	+= hv_mouse.o
> > > > >
> > > > > I'd prefer a bit to follow the current naming of the drivers in
> > > > > drivers/hid directory ... all the device-specific (vendor-specific)
> > > > > drivers currently are called hid-<vendor> or similar.
> > > > >
> > > > > We could talk about changing this naming scheme, but before we reach
> any
> > > > > conclusion on this, I'd prefer this to stay for all drivers if possible.
> > > >
> > > > Do you want the driver module to conform to the naming scheme you
> have?
> > > > Greg, in the past has resisted changing driver names, but I have no
> objection
> > > > to conforming to the naming convention you have.
> > >
> > > I recommend following the proper naming scheme.  As this driver is
> > > auto-loaded when the virtual hardware is seen, the name really doesn't
> > > matter at all.
> > >
> > > So, how about 'hid-hyperv' or 'hid-hv'?
> >
> > I will go with hid-hv  if there are no objections.
> 
> OK by me, thanks.

I am sorry I changed my mind and named it hid-hyperv. The patch I sent out
has this name. I hope it is ok with you.

Regards,

K. Y
