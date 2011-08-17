From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 2/8] Staging: hv: vmbus: Invoke vmbus_on_msg_dpc()
 directly
Date: Wed, 17 Aug 2011 18:43:24 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E04808194C66@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1313446210-10611-1-git-send-email-kys@microsoft.com>
	 <1313446327-10650-1-git-send-email-kys@microsoft.com>
	 <1313446327-10650-2-git-send-email-kys@microsoft.com>
 <1313585267.15004.3.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313585267.15004.3.camel@lappy>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Sasha Levin [mailto:levinsasha928@gmail.com]
> Sent: Wednesday, August 17, 2011 8:48 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 2/8] Staging: hv: vmbus: Invoke vmbus_on_msg_dpc()
> directly
> 
> On Mon, 2011-08-15 at 15:12 -0700, K. Y. Srinivasan wrote:
> > The message processing function needs to execute on the same CPU where
> > the interrupt was taken. tasklets cannot gurantee this; so, invoke the
> > function directly.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> 
> tasklets are guaranteed to run on the same CPU as the function that
> scheduled them.
> 
> Unless I'm missing something?

I too was under this impression until I stumbled upon this comment in
include/Linux/interrupt.h where I see that there is no guarantee that
tasklet would run on the same CPU that it was scheduled on
(look at the first listed property):

/* Tasklets --- multithreaded analogue of BHs.

   Main feature differing them of generic softirqs: tasklet
   is running only on one CPU simultaneously.

   Main feature differing them of BHs: different tasklets
   may be run simultaneously on different CPUs.

   Properties:
   * If tasklet_schedule() is called, then tasklet is guaranteed
     to be executed on some cpu at least once after this.
.
.
*/

Given this comment here, I felt that safest thing to do would be to just
not use the tasklet in this scenario.

Regards,

K. Y
