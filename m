From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 16/25] Staging: hv: Make msg_dpc a global variable
Date: Tue, 26 Apr 2011 15:43:50 -0700
Message-ID: <20110426224350.GB31974@kroah.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-16-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1303834842-5022-16-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 26, 2011 at 09:20:33AM -0700, K. Y. Srinivasan wrote:
> In preparation for cleaning up (getting rid of) of the hv_bus structure,
> make msg_dpc a global variable.

It's "static".  Ah, you mean for the whole bus.  Yeah, that's true,
wierd choice of words I guess...

thanks,

greg k-h
