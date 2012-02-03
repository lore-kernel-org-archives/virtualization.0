From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/6] drivers: hv: Cleanup the kvp related state in
 hyperv.h
Date: Thu, 02 Feb 2012 18:39:38 -0800
Message-ID: <1328236778.18641.75.camel@joe2Laptop>
References: <1327708522-26914-1-git-send-email-kys@microsoft.com>
	 <1327708562-26964-1-git-send-email-kys@microsoft.com>
	 <1327708562-26964-3-git-send-email-kys@microsoft.com>
	 <20120202232936.GA9614@kroah.com>
	 <6E21E5352C11B742B20C142EB499E0481B70927D@TK5EX14MBXC128.redmond.corp.microsoft.com>
	 <20120202234848.GA26647@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120202234848.GA26647@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "zbr@ioremap.net" <zbr@ioremap.net>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-02-02 at 15:48 -0800, Greg KH wrote:
> On Thu, Feb 02, 2012 at 11:41:29PM +0000, KY Srinivasan wrote:
> > > > +#define __packed __attribute__((packed))
[]
> > When I ran the checkpatch script against these patches I got a warning that the
> > preferred directive was to use "__packed".
> Well, checkpatch is stupid sometimes.

True.

I suppose checkpatch warning could be improved to
say that it's preferred for "kernel only" files
and should be ignored for public/user cases.
