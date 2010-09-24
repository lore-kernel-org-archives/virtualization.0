From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] Rename camel case variables in channel.c  (updated
 again)
Date: Fri, 24 Sep 2010 10:29:48 -0700
Message-ID: <1285349388.11616.117.camel@Joe-Laptop>
References: <1FB5E1D5CA062146B38059374562DF7289ED89CF@TK5EX14MBXC130.redmond.corp.microsoft.com>
	 <1FB5E1D5CA062146B38059374562DF7289EDBC9E@TK5EX14MBXC130.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7289EDBC9E@TK5EX14MBXC130.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'gregkh@suse.de'" <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2010-09-24 at 16:06 +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> -		set_bit(Channel->MonitorBit,
> -			(unsigned long *)&monitorPage->TriggerGroup
> -					[Channel->MonitorGroup].Pending);
> +		set_bit(channel->MonitorBit,
> +			(unsigned long *)&monitorpage->TriggerGroup
> +					[channel->MonitorGroup].Pending);

Unrelated to the camelcase conversion, this casting of
a (u32 *) to an (unsigned long *) to set a bit seems
like a bad idea and an error waiting to happen.

Does it really need to be atomic?

Perhaps it'd be better to write something like:

	monitorpage->TriggerGroup[channel->MonitorGroup].Pending |=
		(1 << channel->MonitorBit);

Maybe like the other 2 uses of set_bit in hv, it
should be set_bit(channel->MonitorBit & 31, ...
