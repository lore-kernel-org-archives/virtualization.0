From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH]: Staging: hv: Cleanup vmalloc calls
Date: Fri, 11 Feb 2011 14:53:31 -0800
Message-ID: <20110211225331.GA32412@suse.de>
References: <1297464525-23254-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1297464525-23254-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 11, 2011 at 02:48:45PM -0800, K. Y. Srinivasan wrote:
> The subject says it all. There is no need to
> specify different page protection bits based
> on the architecture.

Wonderful, thanks for doing this.  I'll queue it up after your previous
patches sometime next week.

thanks,

greg k-h
