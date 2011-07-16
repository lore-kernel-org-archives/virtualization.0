From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 088/117] Staging: hv: netvsc: Inline the code for
 free_net_device()
Date: Sat, 16 Jul 2011 13:09:45 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480817A4FB@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-88-git-send-email-kys@microsoft.com>
 <20110716103342.GJ18655@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110716103342.GJ18655@shale.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:error27@gmail.com]
> Sent: Saturday, July 16, 2011 6:34 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 088/117] Staging: hv: netvsc: Inline the code for
> free_net_device()
> 
> On Fri, Jul 15, 2011 at 10:47:16AM -0700, K. Y. Srinivasan wrote:
> > -static void free_net_device(struct netvsc_device *device)
> > -{
> > -	WARN_ON(atomic_read(&device->refcnt) != 0);
> > -	device->dev->ext = NULL;
> 
> device->dev->ext points to device.  We set it NULL here to prevent
> a use after free bug.  What prevents that in the new code?
> 
> > -	kfree(device);
> > -}
This function is called in only two places; a) during adding a device when we have a failure
(netvsc_device_add()) and during device removal (netvsc_device_remove()). I have handled
both these cases. In any event when we are freeing the containing object via kfree(), if somebody
is accessing the ext field via freed object, we have bigger problems to deal with.

Regards,

K. Y


> 
> regards,
> dan carpenter
> 
> 
