From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 3/6] staging: hv: Fixed the value of the 64bit-hole
 inside ring buffer
Date: Tue, 3 Aug 2010 10:44:06 -0700
Message-ID: <20100803174405.GF1455@suse.de>
References: <8AFC7968D54FB448A30D8F38F259C56223FD1D45@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FD1D45@TK5EX14MBXC114.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 03, 2010 at 05:31:57PM +0000, Hank Janssen wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Fixed the value of the 64bit-hole inside ring buffer, this caused a problem on Hyper-V when running checked Windows builds.

What was the problem, and why would this fix it?  Was it a bug in this
code, by virtue that the code was incorrect in the client and the
checked builds properly warned of this, or something else?

thanks,

greg k-h
