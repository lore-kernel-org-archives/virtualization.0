From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/3] Staging: hv: mousevsc: cleanup the mouse driver
Date: Sat, 29 Oct 2011 06:49:52 +0200
Message-ID: <20111029044952.GA1061@kroah.com>
References: <1319839847-28959-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319839847-28959-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, jkosina@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 28, 2011 at 03:10:47PM -0700, K. Y. Srinivasan wrote:
> Further cleanup to move the mouse driver out of staging. 
> This patch-set addresses the comments I have  received from Jiri, Joe and Greg.
> Thank you for taking the time to review the code.

Please note, all of this work is too late for the 3.2 merge, as it
needed to be completed weeks ago for that to happen.  And, as we are in
the middle of the merge, our time allocated to reviewing new patches is
quite limited.

So you might have a lot better success in just waiting a few weeks so
that we then have the time to review and address all of these cleanup
patches and requests to move the hyperv drivers.

I know I'm not going to be accepting any such patches from anyone other
than pure-bugfixes for the next 2-3 weeks at the least.

thanks,

greg k-h
