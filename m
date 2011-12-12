From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 0000/0004] Drivers: hv: Fixes
Date: Mon, 12 Dec 2011 23:50:44 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AD80006@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1323710931-29616-1-git-send-email-kys@microsoft.com>
 <20111212222801.GA16054@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111212222801.GA16054@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, December 12, 2011 5:28 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com
> Subject: Re: [PATCH 0000/0004] Drivers: hv: Fixes
> 
> On Mon, Dec 12, 2011 at 09:28:51AM -0800, K. Y. Srinivasan wrote:
> > Some fixes to the vmbus driver:
> >
> > 	1. Fix a memory leak in a failure path.
> >
> > 	2. Make vmbus driver unloadable.
> >
> > 	3. Get rid of an unnecessary check in hv_init()
> > 	   in preparation for supporting kexec().
> >
> > 	4. Make it possible to build the vmbus driver as part of the
> > 	   kernel. This patch was submitted earlier, but seems to have been
> > 	   lost.
> 
> No, it was not lost, it was applied to my driver-core-next tree a while
> ago.  Because of this, I had to hand-edit patch 2 above and skip patch 4
> here.

Thanks Greg. I will check to see why I got some stale bits yesterday.

Regards,

K. Y
