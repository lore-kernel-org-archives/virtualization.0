From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 3/6] drivers: hv: Cleanup the kvp related state in
 hyperv.h
Date: Thu, 2 Feb 2012 23:41:29 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481B70927D@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1327708522-26914-1-git-send-email-kys@microsoft.com>
 <1327708562-26964-1-git-send-email-kys@microsoft.com>
 <1327708562-26964-3-git-send-email-kys@microsoft.com>
 <20120202232936.GA9614@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120202232936.GA9614@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>, "zbr@ioremap.net" <zbr@ioremap.net>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, February 02, 2012 6:30 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com;
> zbr@ioremap.net; Haiyang Zhang
> Subject: Re: [PATCH 3/6] drivers: hv: Cleanup the kvp related state in hyperv.h
> 
> On Fri, Jan 27, 2012 at 03:55:59PM -0800, K. Y. Srinivasan wrote:
> > Now cleanup the hyperv.h with regards to KVP definitions.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> >  include/linux/hyperv.h |   32 +++++++++++++++++++-------------
> >  1 files changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 7332b3f..802ece8 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -137,7 +137,6 @@ struct hv_ku_msg {
> >
> >
> >
> > -#ifdef __KERNEL__
> >
> >  /*
> >   * Registry value types.
> > @@ -162,29 +161,36 @@ enum hv_kvp_exchg_pool {
> >  	KVP_POOL_COUNT /* Number of pools, must be last. */
> >  };
> >
> > +#ifndef __packed
> > +#define __packed __attribute__((packed))
> > +#endif
> 
> Why do this?
> 
> If you are so worried about this in userspace, then just change the
> values below to __attribute__((packed)), like all of the other public .h
> files do.

Greg,

When I ran the checkpatch script against these patches I got a warning that the
preferred directive was to use "__packed".  So, for the header file that will be
consumed in the kernel, I chose to go with the __packed. For inclusion of this
header file in the user space daemon, I put in this definition here. So rather
than having numerous warnings, I now have a single warning. If you prefer,
I can move this definition to the daemon code where it is really needed.

Regards,

K. Y 
