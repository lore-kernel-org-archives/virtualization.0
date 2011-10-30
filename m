From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 0/3] Staging: hv: mousevsc: cleanup the mouse driver
Date: Sun, 30 Oct 2011 16:16:48 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AA544DF@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1319839847-28959-1-git-send-email-kys@microsoft.com>
 <20111029044952.GA1061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111029044952.GA1061@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>, "joe@perches.com" <joe@perches.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jkosina@suse.cz" <jkosina@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Saturday, October 29, 2011 12:50 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com;
> joe@perches.com; dmitry.torokhov@gmail.com; jkosina@suse.cz
> Subject: Re: [PATCH 0/3] Staging: hv: mousevsc: cleanup the mouse driver
> 
> On Fri, Oct 28, 2011 at 03:10:47PM -0700, K. Y. Srinivasan wrote:
> > Further cleanup to move the mouse driver out of staging.
> > This patch-set addresses the comments I have  received from Jiri, Joe and Greg.
> > Thank you for taking the time to review the code.
> 
> Please note, all of this work is too late for the 3.2 merge, as it
> needed to be completed weeks ago for that to happen.  And, as we are in
> the middle of the merge, our time allocated to reviewing new patches is
> quite limited.
> 
> So you might have a lot better success in just waiting a few weeks so
> that we then have the time to review and address all of these cleanup
> patches and requests to move the hyperv drivers.
> 
> I know I'm not going to be accepting any such patches from anyone other
> than pure-bugfixes for the next 2-3 weeks at the least.

Thanks Greg. I want to be close to being  "first in line" when you are ready to accept patches!
These patches really have addressed the issues Jiri, you and other found as part
of the review process. I am hoping Jiri will be able to pick up the patch to move the 
driver out of staging.

Regards,

K. Y
