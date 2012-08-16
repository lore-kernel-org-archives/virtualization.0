From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: hv: Explicitly size elements of protocol
 structures
Date: Thu, 16 Aug 2012 19:52:00 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9236C17D1@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1345130600-2862-1-git-send-email-kys@microsoft.com>
 <20120816193537.GA14719@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120816193537.GA14719@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jagrelo@cisco.com" <jagrelo@cisco.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, August 16, 2012 3:36 PM
> To: KY Srinivasan
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; olaf@aepfle.de; apw@canonical.com;
> jagrelo@cisco.com
> Subject: Re: [PATCH 1/1] Drivers: hv: Explicitly size elements of protocol
> structures
> 
> On Thu, Aug 16, 2012 at 08:23:20AM -0700, K. Y. Srinivasan wrote:
> > Use explicitly sized types in data structures defining the host/guest
> > protocol. I would like to thank Juan Sanchez-Agrelo  <jagrelo@cisco.com>
> > for reporting this.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> If someone reports a problem, mark it as:
> 	Reported-by: Juan Sanchez-Agrelo <jagrelo@cisco.com>
> in the signed-off-by: area of the patch.

Will do. 
> 
> Does this need to go into 3.6, and possibly older kernels?  Or can it
> wait for 3.7?

Given the "stable kernel rules",  I don't think this needs to go into older kernels.
This can wait for 3.7.

Thanks,

K. Y
 
