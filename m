From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 44/46] Staging: hv: vmbus: Fix checkpatch warnings in
	connection.c
Date: Mon, 29 Aug 2011 11:09:34 -0700
Message-ID: <20110829180934.GB23618@kroah.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-44-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1314469905-7058-44-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 27, 2011 at 11:31:43AM -0700, K. Y. Srinivasan wrote:
> Fix checkpatch warnings in connection.c.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/connection.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
> index ca92ca3..9e99c04 100644
> --- a/drivers/staging/hv/connection.c
> +++ b/drivers/staging/hv/connection.c
> @@ -220,11 +220,11 @@ static void process_chn_event(u32 relid)
>  	channel = relid2channel(relid);
>  
>  	spin_lock_irqsave(&channel->inbound_lock, flags);
> -	if (channel && (channel->onchannel_callback != NULL)) {
> +	if (channel && (channel->onchannel_callback != NULL))
>  		channel->onchannel_callback(channel->channel_callback_context);
> -	} else {

I agree with Joe here, if channel really was NULL, you just oopsed.

I'll apply this one, but please send me a follow-on one fixing this bug.

greg k-h
