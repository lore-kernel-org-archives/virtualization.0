From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0000/0006] drivers: hv
Date: Thu, 2 Feb 2012 15:31:45 -0800
Message-ID: <20120202233145.GA17516@kroah.com>
References: <1327708522-26914-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327708522-26914-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, zbr@ioremap.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 27, 2012 at 03:55:22PM -0800, K. Y. Srinivasan wrote:
> 
> This patch-set does some cleanup of the KVP component. Also included is a
> patch that will remove artificial limitation on the number of VCPUs that
> can be assigned to the Linux guest on Hyper-V.

I have applied the first 2, please fix patch 3, and resend the rest.

thanks,

greg k-h
