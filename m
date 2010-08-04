From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 3/6] staging: hv: Fixed the value of the 64bit-hole
 inside ring buffer
Date: Wed, 4 Aug 2010 10:05:24 -0700
Message-ID: <20100804170524.GC28217@suse.de>
References: <8AFC7968D54FB448A30D8F38F259C56223FD1D45@TK5EX14MBXC114.redmond.corp.microsoft.com>
 <20100803174405.GF1455@suse.de>
 <8AFC7968D54FB448A30D8F38F259C56223FE7ADB@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FE7ADB@TK5EX14MBXC114.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 04, 2010 at 04:25:40AM +0000, Hank Janssen wrote:
> 
> >>On Tue, Aug 03, 2010 at 05:31:57PM +0000, Hank Janssen wrote:
> >> From: Haiyang Zhang <haiyangz@microsoft.com>
> >> 
> >> Fixed the value of the 64bit-hole inside ring buffer, this caused a problem on Hyper-V 
> >>when running checked Windows builds.
> >
> >What was the problem, and why would this fix it?  Was it a bug in this code, 
> >by virtue that the code was incorrect in the client and the checked builds properly warned
> >of this, or something else?
> 
> Checked builds of Windows are used internally and given to external system builders at times.
> They are builds that for example that all elements in a structure follow the definition of that 
> Structure. The bug this fixed was for a field that we did not fill in at all (Because we do
> Not use it on the Linux side), and the checked build of windows gives errors on it internally 
> to the Windows logs.
> 
> This fixes that error.

Wonderful, please provide this information in the changelog comment.

thanks,

greg k-h
