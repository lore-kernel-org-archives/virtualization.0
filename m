From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Fri, 29 Apr 2011 14:26:13 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481DD5AA@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
	<20110426232843.GA31184@kroah.com>
	<6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
	<20110428002817.GE14294@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110428002817.GE14294@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <greg@kroah.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, April 27, 2011 8:28 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
> 
> On Wed, Apr 27, 2011 at 01:54:02AM +0000, KY Srinivasan wrote:
> > > After that, do you want another round of review of the code, or do
> > > you have more things you want to send in (like the name[64] removal?)
> >
> > I would prefer that we go through the  review process. What is the process for
> > this review?
> 
> The same as always, just ask.
> 
> > Is there a time window for people to respond.
> 
> No.  We don't have time limits here, this is a community, we don't have
> deadlines, you know that.

Perhaps I did not properly formulate my question here. The review
process itself may be open-ended, and that is fine - we will fix all legitimate
issues/concerns  in our drivers whether they are in the staging area or not. 
My question was specifically with regards to the review process that may gate exiting
staging. I am hoping to re-spin the remaining patches of the last patch-set and send it to
you by early next week and ask for a review. I fully intend to address whatever review 
comments I may get in a very timely manner. Assuming at some point in time after I ask
for this review there are no outstanding issues, would that be sufficient to exit staging?  

> 
> > I am hoping I will be able to address all the review comments well in
> > advance of the  next closing of the tree, with the hope of taking the
> > vmbus driver out of staging this go around (hope springs eternal in
> > the human breast ...)!
> 
> Yes, it would be nice, and I understand your the corporate pressures you
> are under to get this done, and I am doing my best to fit the patch
> review and apply cycle into my very-very-limited-at-the-moment spare
> time.

Greg, I do appreciate your ongoing  help here.

Regards,

K. Y 
