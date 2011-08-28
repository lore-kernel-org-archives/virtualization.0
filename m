From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 44/46] Staging: hv: vmbus: Fix checkpatch warnings in
	connection.c
Date: Sat, 27 Aug 2011 23:56:52 -0700
Message-ID: <1314514612.6852.11.camel@Joe-Laptop>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-44-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1314469905-7058-44-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2011-08-27 at 11:31 -0700, K. Y. Srinivasan wrote:
> Fix checkpatch warnings in connection.c.
[]
> diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
[]
> @@ -220,11 +220,11 @@ static void process_chn_event(u32 relid)
>  	channel = relid2channel(relid);
>  
>  	spin_lock_irqsave(&channel->inbound_lock, flags);
> -	if (channel && (channel->onchannel_callback != NULL)) {
> +	if (channel && (channel->onchannel_callback != NULL))

Useless test for channel or bad placement for spin_lock.
channel has already been dereferenced by the spin_lock.
