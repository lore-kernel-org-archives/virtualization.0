From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 005/206] Staging: hv: Rename the device type variable
Date: Tue, 10 May 2011 05:13:10 -0700
Message-ID: <20110510121310.GA27396@suse.de>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-5-git-send-email-kys@microsoft.com>
 <4DC90F37.6010000@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DC90F37.6010000@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 10, 2011 at 11:11:03AM +0100, Jonathan Cameron wrote:
> On 05/09/11 22:54, K. Y. Srinivasan wrote:
> > Rename the variable g_blk_device_type.
> Why?

Because "g_blk_device_type" is in Hungarian notation, which isn't needed
in the kernel.

thanks,

greg k-h
