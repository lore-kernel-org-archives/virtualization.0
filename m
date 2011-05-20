From: KY Srinivasan <kys@microsoft.com>
Subject: RE: vmbus driver
Date: Fri, 20 May 2011 13:36:53 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481FC2ED@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1305842785-30206-1-git-send-email-kys@microsoft.com>
	<20110520122649.GA550@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110520122649.GA550@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Friday, May 20, 2011 8:27 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: vmbus driver
> 
> On Thu, May 19, 2011 at 03:06:25PM -0700, K. Y. Srinivasan wrote:
> > A few days ago you applied all the outstanding patches for the Hyper-V
> > drivers. With these patches, I have addressed all of the known review
> > comments for the  vmbus driver (and a lot of comments/issues in other
> > drivers as well). I am still hoping I can address
> > whatever other issues/comments there might be with the intention to
> > get the vmbus driver out of staging in the current window. What is your
> > sense in terms of how feasible this is. From my side, I can assure you
> > that I will address all legitimate issues in a very timely manner and this
> > will not be dependent upon the location of the drivers (staging or
> > outside staging). Looking forward to hearing from you.
> 
> There's no point in merging it without a user.  Make sure either
> the network or storage driver is in a good enough shape to move with it,
> to make sure the APIs it exports are actually sanely usable.
> 
> On the other hand the HV clocksource looks mostly mergeable and doesn't
> depend on vmbus.  Send a patch to add it to drivers/clocksource to the
> maintainer and it should be mergeable with very little remaining
> cleanup.

I see maintainers for each of the clocksource drivers and I see John Stultz and
Thomas  Gleixner listed as the maintainers for Timekeeping. Who should sign-off
on the Hyper-V clocksource.

Regards,

K. Y
