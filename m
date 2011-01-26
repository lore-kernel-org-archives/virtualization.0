From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 7/8] staging: hv: Convert camel cased struct fields in
 vmbus_packet_format.h to lower cases
Date: Wed, 26 Jan 2011 23:28:26 +0300
Message-ID: <20110126202826.GU2721@bicker>
References: <1296064206-11372-1-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-2-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-3-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-4-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-5-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-6-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-7-git-send-email-haiyangz@microsoft.com>
 <20110126180400.GS2721@bicker>
 <A1F3067C9B68744AA19F6802BAB8FFDC02482D@TK5EX14MBXC227.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A1F3067C9B68744AA19F6802BAB8FFDC02482D@TK5EX14MBXC227.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Hank Janssen <hjanssen@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 26, 2011 at 08:09:47PM +0000, Haiyang Zhang wrote:
> > 
> > 
> > These don't line up with the others.
> 
> I have corrected and resubmitted them.
> 

You could have just resubmitted the one.  Overall the patchset makes
things way better than before.  I didn't want to make more work for
you.  :/

If you're going to redo the set, it probably would have been better
to wait for a day in case anyone else says anything.  The patches
are pretty straight forward so it's doubtful that it needs changes but
it also doesn't hurt to wait.

Anyway, I diffed the two threads and it looks good.  Thanks for doing
that. 

regards,
dan carpenter
