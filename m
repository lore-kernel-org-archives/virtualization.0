From: Greg KH <greg@kroah.com>
Subject: Re: Ringbuffer usage in Linux Hyper-V drivers
Date: Wed, 3 Mar 2010 15:39:58 -0800
Message-ID: <20100303233958.GA16513@kroah.com>
References: <1FB5E1D5CA062146B38059374562DF725A908A11@TK5EX14MBXC126.redmond.corp.microsoft.com>
 <20100217235223.GG12197@kroah.com>
 <8AFC7968D54FB448A30D8F38F259C56212EE39C0@TK5EX14MBXC116.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56212EE39C0@TK5EX14MBXC116.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hashir Abdi <habdi@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 03, 2010 at 04:42:27PM +0000, Hank Janssen wrote:
> The ring buffer in the Hyper-V Linux drivers is used to communicate with the 
> parent partition running Server 2008 Hyper-V. The ring buffer functionality on 
> the Hyper-V Linux drivers is written to be functionally compatible with" the 
> ring buffer functionality on the Hyper-V Server. Consequently, it is not 
> possible to make any changes that might break the compatibility with server 
> side ring buffer implementation.  

Ok, that makes sense, feel free to remove that TODO item.

thanks for looking into this.

greg k-h
