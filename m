From: Greg KH <gregkh@suse.de>
Subject: Re: Hyper-V driver patches
Date: Fri, 12 Aug 2011 10:50:50 -0700
Message-ID: <20110812175050.GA14993@suse.de>
References: <1313107785-13318-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1313107785-13318-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 11, 2011 at 05:09:45PM -0700, K. Y. Srinivasan wrote:
> 
> Greg,
> 
> Some weeks ago, I had sent out a fairly large patch-set for your consideration.
> I know you are very busy;  however, I am getting a little nervous since I have
> not heard from you.

You sent those patches after the merge window closed, which was
publicly announced on the driverdevel mailing list, and the merge window
for 3.2-rc1 only opened up a scant few days ago, so not hearing from me
is to be expected, right?

If you note, I have not merged _any_ 3.2-rc1 patches into any of my
trees yet due to the above mentioned short time frame, and due to other
higher priority issues (i.e. my real job and bugfixes for 3.1).

> Please let me know if I should resend these patches.

No, they are all still in my queue to be applied when I get to them.
Realize that LinuxCon is next week so it might be a few weeks before I
get to any 3.2 patches which is fine, we still have lots of time.

> In addition to this one large patch-set, we have also sent a
> bunch of other patches as well. I just want to make sure that these 
> patches  are still in your queue.

You can always send more patches, I can handle them.

> On a different note, with these patches I have addressed all the review 
> comments that I have gotten from you, Christoph and others.
> I was wondering if you would have the time to let me
> know what else would have to be done to get the vmbus driver out of staging. 

After I apply them all, and the 3.2 work settles down, I'll be glad to
review them again, please be patient, I have:
	$ mdfrm -c ~/mail/todo/
	584 messages in /home/gregkh/mail/todo/
	$ mdfrm -c ~/mail/staging-todo/
	839 messages in /home/gregkh/mail/staging-todo/
to get through.

Your hyperv patches are at the bottom of the staging-todo pile for
various reasons that I'm sure you are aware of.

thanks,

greg k-h
