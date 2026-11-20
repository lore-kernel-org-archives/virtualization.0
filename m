Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165837;
	b=zgePx2/X+JK2X2jTNMg8ao8+Ofrl8wAJYKG92SvXWTy7LV//F80xgy/UCBBCVibtgD86
	 CEFhhzuQgTemg5/i/CCM9mlvVjrvrfoHvOxZXweJ9y07pnAWVZKHQ3EbWgTXLC+uyP9FN
	 Gi5UNm19sESyb7RZ1iRBpdA43ahVr23PSfIfUpBvLF6nzggwCHOm97ZV/k2kc527yeN3b
	 RJbG623GqyUTue3hGIc22usNUJO6O6joEOkbBd+yAldP9lao4PbHewI7srPKlPaYv6629
	 BEXgDCjL/1bGt2WPDO05kIEtsDDVNjPLk19hWUpgvsk4r9RPVMu+IlIYMKwMCEX8Ebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DSSS9+Kfoc3mBii8TnSdmAyAnW6IkpsziMrkIvRl8EY=;
	b=TJyelgxQ10KdqN46AYzfUvljSrQmO9bLfMSsXibV5x3p7Prb1pskdonPYlLVbLqg9eJC
	 IblDCUGJCNf/ZhR16d2KNskb6pYm3+2xH3aWmF+8LeRyeb0nVlIMQMJBokbTR4rjJKjcK
	 oQms7CkL8QaBZqEw/6IhBqMlpfxR0qwuRjJflj7j6fLj2os/Vr7IOJ7lOtnyXnzVXMaYE
	 elkZLdXvT+/pkAjIQvqQiVIzKEOTs/8YDltLx7d1UiSHcii/MmCsg5j6a6WWSWikI25gQ
	 6jllJ0mFXvCuv3EMUztv9hiyKAFGDDakNTXeB1ljj2FOqHsOilYgEbbz7sC50/yvrnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZnKOvj2X;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55839606A325
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 09:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55839606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZnKOvj2X
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so492123f8f.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795165836; x=1795770636; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DSSS9+Kfoc3mBii8TnSdmAyAnW6IkpsziMrkIvRl8EY=;
        b=ZnKOvj2XO8u8OYoq6UeFH5Nk2YnogBIhUUJpVHG1SwSj0tPae40LBCPDQ9O3SrNFsu
         YpMHDRSo2tij+2oE72lx5OOanRk85PGJrEZNNrAU+a2vkok4RtL8cjE72nK0Z1pZPYEm
         zzuq5XvVUQTj1sEroi/qvwuFWwM09BBKHj1+ukjTLQvKTniiB7E/a4cTQQP5pfPrqaKc
         eC3c6ib5lNmshxWJe/WS1QJ8I3kWLHLaCmVrOTKrtFwRMu/xZObZKWEFMYDg4YGaKaV7
         vL6NcM6YS2BFh1nUGbRPh+tGPSq+WuW5DgtwZNHGq8FSRUB3qrtqRkp3rDdBJS4RPr8k
         EJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795165836; x=1795770636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSSS9+Kfoc3mBii8TnSdmAyAnW6IkpsziMrkIvRl8EY=;
        b=ABsVyifDB0BYs23WX7iFRO7j77VPyq4QzuWDX0Cf5BpO6+XJh/BTWy8SfqgM/9Tegn
         6pP3u3EZRsm1f3/IpIjCSulls1Gge1qk36d+sjUABPEUn0OyBLFos2t8Km3Ce9G9hbRs
         XUX2RAnU5pMs70dsHQrm7Xk1Xzl4C7alYy6/3suQk3Ude0/nr5E55u+svEWsFkZssMXp
         F9/FDxrMKsqY+pyAUJSbMY7r7LsVPVOgLmu/0NoGgThRpL3vHun/fSTsbfhvHpf+8AHu
         5LdwYxvVvTxvcjCtL/czkQpjvG6+QAHlHX9HlU1LoNF6ZkHPX8uubOdIMkwufrsJx65n
         xLgA==
X-Forwarded-Encrypted: i=1; AL+hErHvQi9BRZGJN73jr2M4yDK36yJPVTVE/F8tb+bQd3HNJ54lWmI5N62nQdBcEqtyz2YtLNOV5KOLoYtThq+adA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9gBeJuuxc1ZK/VhmXFdJAq/lPD8vd39BWArCwGQQ5XsXcch89Y
	lBHE3o8gWhpUOwYc8lxY8rfsECmA7awzYX8G/g0k1NEoebZsbI6iLqKUqPa5N4NYEkY=
X-Gm-Gg: AYBFou3567GggmbEK1xEfXqXxR7S+9VfFplF9XXT81HbTDGwpTlrprSUBeaxUtWfdU5
	Dct/dDlzqknrYqqGOKbBR8yM+ZWB2upZyqoEuf6acIT49gy4tC9b+hF+7+O/v0umvqLZiWw17gf
	ah+SjaqAf7iF6lq6hTLHN6GwfIFcgO81TlKjytTL0lettFyZO1cMcWmQpwgfAjBTI3BAi7Hnpw9
	5W4dtNWmNWTcpbUCCLU/gmC3F+C5rNi6Q3AmfIuUwk4ZzjoGxbj7osmEAR0le7+C/ouFmyNZdPk
	+1S/Tb/whG9NGeMcrl8MIhFZqUyNAqLbnm104YGLQYdrT2Ny2odR8dXQM+r5i6hRlP2X+AXW2n8
	JxIATYCeDuU2YWbjPjYb3RxW8noq17ZfM0jqwMQxRV3GckAy7zVMAtK+cXxhzGWb8Y5wWGC+xfk
	467JvVeoH5MiCm8jr+UdsldZAfBmnXtygl77keCNc6EmDluO+TFBW47T3iq0Jv9vr9vTy1J+dbg
	l8pNPXJCX9JGWmnfBrNNWWlpk6LqMpt8TiD1gOxImv3Sw+AwLxKXuURcKMIVxPHp8GKiCyaGIX3
	vAZ5efmFX2FhN4XAfYLI
X-Received: by 2002:a05:600c:4755:b0:4bb:7033:de79 with SMTP id 5b1f17b1804b1-4bb8881dd02mr49732185e9.35.1795165835650;
        Fri, 20 Nov 2026 01:10:35 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm114241355e9.11.2026.11.20.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:10:35 -0800 (PST)
Date: Fri, 20 Nov 2026 10:10:31 +0100
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v4 2/4] x86/vmware: Add a bounded panic log sender
Message-ID: <awAOhyq48jRfcVWd@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>

On Wed 2026-11-18 01:01:49, Zack Rusin wrote:
> A VMware guest may be unable to save its own logs after a crash. Copy
> the newest kernel log records to the host's vmware.log before kdump,
> so they remain available if the capture kernel fails.
> 
> Register the sender on the platform panic notifier list and send the
> log through the low-bandwidth register interface. Allocate a fixed
> 8 KiB buffer during early init; 4 KiB can lose useful stack-trace
> context. The callback allocates no memory and emits no printk
> messages. Limit the transfer to the buffer size and make at most three
> attempts, retrying only if a VM checkpoint interrupts the transfer.
> 
> Enable logging by default only in guests without memory encryption;
> encrypted guests should send their log to the host only when an
> administrator opts in. The copy is best-effort diagnostics; kdump does
> not depend on it succeeding.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN6PR02MB4157.namprd02.prod.outlook.com
> Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

I made just a quick review of the string manipulation and
kmsg_dump_get_buffer() API use. And it looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Note that I am not familiar with the vmware hypercalls so that
I did not check this part.

Some nits below.

> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -52,6 +57,23 @@
> +#define VMWARE_LOG_BUF_SIZE		SZ_8K
> +#define VMWARE_LOG_ATTEMPTS		3
> +#define VMWARE_LOG_PREFIX		"log "
> +#define VMWARE_LOG_PREFIX_LEN		(sizeof(VMWARE_LOG_PREFIX) - 1)

[...]

> +static int vmware_log_send_once(const struct vmware_rpc_channel *channel,
> +				const char *buffer, size_t length)
> +{
> +	u32 info;
> +
> +	vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDSIZE, length,
> +			  (u32)channel->id << 16, channel->cookie_high,
> +			  channel->cookie_low, &info);
> +	if (!(info & VMWARE_MSG_STATUS_SUCCESS))
> +		return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
> +
> +	while (length) {
> +		size_t bytes = min_t(size_t, length, sizeof(u32));
> +		u32 word = 0;
> +
> +		memcpy(&word, buffer, bytes);
> +		vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDPAYLOAD,
> +				  word, (u32)channel->id << 16,
> +				  channel->cookie_high, channel->cookie_low,
> +				  &info);
> +		if (!(info & VMWARE_MSG_STATUS_SUCCESS))
> +			return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
> +
> +		buffer += bytes;
> +		length -= bytes;
> +	}
> +
> +	return 0;
> +}

[...]

> +static int vmware_panic_log_notify(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct kmsg_dump_iter iter;
> +	char *buffer = page_address(vmware_panic_page);
> +	size_t length = 0;

I would add:

	BUILD_BUG_ON(VMWARE_LOG_PREFIX_LEN > VMWARE_LOG_BUF_SIZE);

just to be on the safe side.

> +
> +	if (!READ_ONCE(vmware_record_panic_msg))
> +		return NOTIFY_DONE;
> +
> +	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);

I would feel more comfortable when the trailing '\0' gets copied as
well, e.g.

	strscpy(buffer, VMWARE_LOG_PREFIX);

It is not strictly needed because the length is counted
explicitly, strlen() is not used. Also vmware_log_rpc() does
not send the trailing '\0'.

So, it is a rather a defensive programming. The buffer might be handled
another way in the future, e.g. printed by some debug code, tracing, ...

> +	kmsg_dump_rewind(&iter);
> +	(void)kmsg_dump_get_buffer(&iter, true,
> +				   buffer + VMWARE_LOG_PREFIX_LEN,
> +				   VMWARE_LOG_BUF_SIZE - VMWARE_LOG_PREFIX_LEN,
> +				   &length);
> +	(void)vmware_log_rpc(buffer, length + VMWARE_LOG_PREFIX_LEN);
> +
> +	return NOTIFY_DONE;
> +}

Best Regards,
Petr
