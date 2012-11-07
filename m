From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] virtio-mmio: Fix irq parsing in the command line
Date: Thu, 08 Nov 2012 09:17:28 +1030
Message-ID: <878vad3u9r.fsf@rustcorp.com.au>
References: <1352120572-16256-1-git-send-email-pawel.moll@arm.com>
	<1352297892-27838-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1352297892-27838-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Pawel Moll <pawel.moll@arm.com> writes:

> On 64-bit machines resource_size_t is a 64-bit value, while
> sscanf() format for this argument was defined as "%u". Fixed
> by using an intermediate local value of a known length.

Actually, on 32-bit machines, too (eg. x86 with PAE).  Otherwise we'd
just change it to %lu.

> +	/* Get "@<base>:<irq>[:<id>]" chunks */
>  	processed = sscanf(str, "@%lli:%u%n:%d%n",
> -			&base, &resources[1].start, &consumed,
> +			&base, &irq, &consumed,
>  			&vm_cmdline_id, &consumed);
>  
> +	/*
> +	 * sscanf() processes 3 chunks if "<id>" is given, 2 if not;
> +	 * also there must be no extra characters after the last
> +	 * chunk, so str[consumed] should be '\0'
> +	 */
>  	if (processed < 2 || processed > 3 || str[consumed])
>  		return -EINVAL;

I would drop the > 3 case.  It's unnecessary, and you're assuming
consumed doesn't add to the count, which may be true but is a documented
sscanf weirdness so I don't like to rely on it.

Thanks,
Rusty.
