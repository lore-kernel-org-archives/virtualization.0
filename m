From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Add support for >2 TB LUN in storage
 driver.
Date: Thu, 1 Sep 2011 13:59:08 -0700
Message-ID: <20110901205908.GA16638@suse.de>
References: <1314911512-1079-1-git-send-email-mike.sterling@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314911512-1079-1-git-send-email-mike.sterling@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Sterling <steelforce@gmail.com>
Cc: devel@linuxdriverproject.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Mike Sterling <mike.sterling@microsoft.com>, "K.Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 01, 2011 at 02:11:52PM -0700, Mike Sterling wrote:
> If a LUN larger than 2 TB is attached to a Linux VM on Hyper-V, we currently 
> report a maximum size of 2 TB. This patch resolves the issue in hv_storvsc. 
> Thanks to Robert Scheck <robert.scheck@etes.de> for reporting the issue.
> 
> Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>

As I'm guessing you want this to show up as being done by
mike.sterling@microsoft.com and not steelforce@gmail.com, can you please
resend this from your mike.sterling@microsoft.com account, or put the
proper "From:" line in the patch body as described in the file,
Documentation/SubmittingPatches so I can apply it correctly?

Also, please use the proper "Reported-by:" tag for the bug reporter.

Please resend.

greg k-h
