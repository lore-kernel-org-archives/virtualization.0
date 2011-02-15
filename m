From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/3]: Staging: hv: Use native wait primitives
Date: Tue, 15 Feb 2011 10:20:37 +0100
Message-ID: <4D5A4565.5030501@gmail.com>
References: <1297447183-21807-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297447183-21807-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/11/2011 06:59 PM, K. Y. Srinivasan wrote:
> In preperation for getting rid of the osd layer; change
> the code to use native wait interfaces. As part of this,
> fixed the buggy implementation in the osd_wait_primitive
> where the condition was cleared potentially after the 
> condition was signalled.
...
> @@ -566,7 +567,11 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
>  
>  		}
>  	}
> -	osd_waitevent_wait(msginfo->waitevent);
> +	wait_event_timeout(msginfo->waitevent,
> +				msginfo->wait_condition,
> +				msecs_to_jiffies(1000));
> +	BUG_ON(msginfo->wait_condition == 0);

The added BUG_ONs all over the code look scary. These shouldn't be
BUG_ONs at all. You should maybe warn and bail out, but not kill the
whole machine.

And looking at the code, more appropriate would be completion instead of
wait events.

And msecs_to_jiffies(1000) == HZ.

> @@ -689,7 +693,8 @@ static void vmbus_ongpadl_torndown(
>  				memcpy(&msginfo->response.gpadl_torndown,
>  				       gpadl_torndown,
>  				       sizeof(struct vmbus_channel_gpadl_torndown));
> -				osd_waitevent_set(msginfo->waitevent);
> +				msginfo->wait_condition = 1;
> +				wake_up(&msginfo->waitevent);
>  				break;
>  			}
>  		}
> @@ -730,7 +735,8 @@ static void vmbus_onversion_response(
>  			memcpy(&msginfo->response.version_response,
>  			      version_response,
>  			      sizeof(struct vmbus_channel_version_response));
> -			osd_waitevent_set(msginfo->waitevent);
> +			msginfo->wait_condition = 1;
> +			wake_up(&msginfo->waitevent);
>  		}
>  	}
>  	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);

regards,
-- 
js
