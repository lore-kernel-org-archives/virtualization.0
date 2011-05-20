From: Christoph Hellwig <hch@infradead.org>
Subject: Re: vmbus driver
Date: Fri, 20 May 2011 08:26:49 -0400
Message-ID: <20110520122649.GA550@infradead.org>
References: <1305842785-30206-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305842785-30206-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 19, 2011 at 03:06:25PM -0700, K. Y. Srinivasan wrote:
> A few days ago you applied all the outstanding patches for the Hyper-V
> drivers. With these patches, I have addressed all of the known review 
> comments for the  vmbus driver (and a lot of comments/issues in other
> drivers as well). I am still hoping I can address 
> whatever other issues/comments there might be with the intention to 
> get the vmbus driver out of staging in the current window. What is your 
> sense in terms of how feasible this is. From my side, I can assure you 
> that I will address all legitimate issues in a very timely manner and this
> will not be dependent upon the location of the drivers (staging or 
> outside staging). Looking forward to hearing from you.

There's no point in merging it without a user.  Make sure either
the network or storage driver is in a good enough shape to move with it,
to make sure the APIs it exports are actually sanely usable.

On the other hand the HV clocksource looks mostly mergeable and doesn't
depend on vmbus.  Send a patch to add it to drivers/clocksource to the
maintainer and it should be mergeable with very little remaining
cleanup.
