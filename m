From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0000/0020] Staging: hv: Driver cleanup
Date: Fri, 16 Sep 2011 20:07:08 +0200
Message-ID: <20110916180708.GA32174@kroah.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315936759-20623-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 13, 2011 at 10:59:19AM -0700, K. Y. Srinivasan wrote:
> Address Greg's VmBus audit comments:
> 
> 	1) Leverage driver_data field in struct hv_vmbus_device_id to
> 	   simplify driver code.
> 
> 	2) Make the util driver conform to the Linux Driver Model.
> 
> 	3) Get rid of the ext field in struct hv_device by using the
> 	   driver specific data functionality.
> 
> 	4) Implement vmbus specific wrapper functions for setting and getting
> 	   driver specific data..
> 
> 	5) Other general cleanup.

I applied 17 of these (i.e. the ones I didn't comment on.)

greg k-h
