From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 46/46] Staging: hv: Update the TODO file
Date: Mon, 29 Aug 2011 11:12:06 -0700
Message-ID: <20110829181206.GB19668@kroah.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-46-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314469905-7058-46-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 27, 2011 at 11:31:45AM -0700, K. Y. Srinivasan wrote:
> Update the TODO file.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/TODO |   24 ++++++++++++++++++++----
>  1 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
> index 582fd4a..23c74ed 100644
> --- a/drivers/staging/hv/TODO
> +++ b/drivers/staging/hv/TODO
> @@ -1,14 +1,30 @@
>  TODO:
> -	- fix remaining checkpatch warnings and errors
>  	- audit the vmbus to verify it is working properly with the
>  	  driver model
> -	- see if the vmbus can be merged with the other virtual busses
> -	  in the kernel
> +
> +		STATUS (July 19, 2011):
> +		All outstanding issues (known to us)  with regards
> +		to conforming to Linux Driver Model have been addressed.

The TODO file is not a place to have a "conversation" about what is and
is not completed by having status reports.

Let's discuss this through email, and if we all agree, then the TODO
entries can be removed.

greg k-h
