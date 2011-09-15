From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 06/20] Staging: hv: util: Properly handle util services
	in the util driver
Date: Thu, 15 Sep 2011 23:08:53 +0300
Message-ID: <20110915200853.GJ3789@shale.localdomain>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
	<1315936796-20662-1-git-send-email-kys@microsoft.com>
	<1315936796-20662-6-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1315936796-20662-6-git-send-email-kys@microsoft.com>
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

On Tue, Sep 13, 2011 at 10:59:42AM -0700, K. Y. Srinivasan wrote:
> @@ -403,31 +384,13 @@ static void vmbus_process_offer(struct work_struct *work)
>  		spin_unlock_irqrestore(&vmbus_connection.channel_lock, flags);
>  
>  		free_channel(newchannel);
> -	} else {
> +	} else
>  		/*
>  		 * This state is used to indicate a successful open
>  		 * so that when we do close the channel normally, we
>  		 * can cleanup properly
>  		 */
>  		newchannel->state = CHANNEL_OPEN_STATE;

It's not worth resending, but this should have kept the curly braces
for two style reasons.
1) If one side of the if else pair has braces the other side gets
braces too.
2) If it's more than one line, it gets braces even if it's not needed
for semantic reasons.

Sorry to email you these pedantic things, but if I don't then my OCD 
acts up and I feel all itchy for hours.  Also you have a similar
thing below as well.

regards,
dan carpenter
