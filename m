From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/6] drivers: hv: Cleanup the kvp related state in
 hyperv.h
Date: Thu, 2 Feb 2012 15:48:48 -0800
Message-ID: <20120202234848.GA26647@kroah.com>
References: <1327708522-26914-1-git-send-email-kys@microsoft.com>
 <1327708562-26964-1-git-send-email-kys@microsoft.com>
 <1327708562-26964-3-git-send-email-kys@microsoft.com>
 <20120202232936.GA9614@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481B70927D@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481B70927D@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>, "zbr@ioremap.net" <zbr@ioremap.net>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 02, 2012 at 11:41:29PM +0000, KY Srinivasan wrote:
> > > +#ifndef __packed
> > > +#define __packed __attribute__((packed))
> > > +#endif
> > 
> > Why do this?
> > 
> > If you are so worried about this in userspace, then just change the
> > values below to __attribute__((packed)), like all of the other public .h
> > files do.
> 
> Greg,
> 
> When I ran the checkpatch script against these patches I got a warning that the
> preferred directive was to use "__packed".

Well, checkpatch is stupid sometimes.

> So, for the header file that will be
> consumed in the kernel, I chose to go with the __packed. For inclusion of this
> header file in the user space daemon, I put in this definition here. So rather
> than having numerous warnings, I now have a single warning. If you prefer,
> I can move this definition to the daemon code where it is really needed.

Please do it like all other public kernel header files do.

greg k-h
