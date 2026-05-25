Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2C3F7A84
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729012; cv=none; b=mYuVzKN+SX59uuZStJOn/cWKeQjNYWelA/QNx8mHBNX/xNDsi2o8CoRkXTiaVC11jZCmQzwV+955JXEScnBIIX/fD2xg8MQvRDg38D5xB+iFiVejrl3eNdUp3KzEOo3KsAlW+V5DbG8Qz9VELxHOX9TIxbErXHJXY9lXtPHrucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729012; c=relaxed/simple;
	bh=PTNg3RyBjtWL4NnI8O0q7hXUoY8uPF4RaVnZMbEInR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pt5Vimhru+oCr2PqElf24QZt053RiHn/tAESZYVQNh/elPA8DdnPQvAYeYRLzjcIZ7MXCucuL5UyoyJOObhlHYowmlTCoh4BVIjhY3+3zVVA3AmJCCFtnjl/adT9lX/efI18xmw79j3fFVPtWLB4J/9QrpsBzCdk1a0tBg5fwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GB89YC1B; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GB89YC1B"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so61593435e9.1
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779729007; x=1780333807; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=GB89YC1BgHozljhjmDSczuuiphe2yizBLDRPCbL6CF5xVLJ4FQDvhJgzgJfTK9J0VO
         jVGDMuQbos2DBBQ1g9JjnP8nuKtGiV4EUkTY2NN56+RZ2XRemLHLW9xIAgLjALjoV2uV
         AyxTupEqZVpFoawz3Ax67oLM28KkKMI5Ry57xeT6yQscVmYuYfoRt6PYHR/LAhDRdycQ
         1Od0Czy/tTdYoXcDoX1BtFCeQ1Iks/M+9QSQKJzfjmHmlMAqUUx0QTbfjvM2I0sQI1dI
         GhpnpaW4BKLY1x+xNHjjRZjXRfWUFvsbOJBKoOxkplaUPId80746/aFi2C8pOMS7uSfS
         1MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729007; x=1780333807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izugkSqOYsBmSyQ8jfD9m1SVj73YG14U78pRBc6Lai0=;
        b=LaR2BDVLjZ+Luu5ox2C54idOf76O4AY0USFR/JHvyo76D1q8D1kYHtXb47esjRBG3y
         qZGpKhFV4nofIrDSVafWQUfmjk3iP82+TtQRKdQe/aZk99SX7HopPUV+8fL3hwFNlCoG
         yvEyuXI/ED4p1WKmEz+h619OiTVNAU6O8Ge21rzU3097WZ24mB+k7dNe8mubhfXQCXap
         jm2uHNbyY7UPwZJLqR+zYnYGZu2y7mkSCOtXpVP0KhMn+of64UwXwcVxMGMc9x+j3PWF
         cNDL+zXEmkrwIhw47q0KgimQz5Cz7Re/gIrU9o802De7diV9xTZiDkUBPysBZq7+LKTw
         PAFw==
X-Forwarded-Encrypted: i=1; AFNElJ8dp9URcWOjHKwYy+NDpwRq3vhpqyCnYzVEs+XcOvgz2NUNdgTidlr1/x3cgF2xdoyK9J1yX8qXbADhymYneA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUKyzLWRvePQaPIOXNV6gNOyAhMEAs9P8cKJgC8ZbvT1AiF4wo
	A8LiJGwDDNPQjHhCnhkJgyezY1WGe/zKWL/JR02BBRVTRNNRgAq/25Cbq2N0towCtJY=
X-Gm-Gg: Acq92OE8l64xnVACjsr+ViHuq+CA4aAcCQF4IvmndvV7IS8MzxlQ+Sm6F6p67+UShGq
	Tj64d15yyBAlS7Ct5oqce/rWwjv43V6iFJLznvt823zho+n7dGddu9f10PNzc+u1Y54zxKGrcPf
	QqQutcbzql5VrkaCTq7LtCdktcL7jDjg2zQintEXOVjrJkWK1rew6H3/WO1usfg5yapXQxki+qy
	TYG0sxNwXWeTrXSmhYYUhXjXXX+UPZ1TG5IbsuhkqsZDgOLHjkMaeiX1eSxNin3RHGOEfvI5zZQ
	OVg4insW8FT5A/42w3rWipu2YPdLye80MpatC9AyGjNc5ejfjj4M/pn3aKdhW/kCBfnhB9zWpDf
	pG60t7Sfcdrx81GH5DKxNSsJTE8vMBbxqtRtlBaLuO6wkYX6zD7mMPKKqvMQc2ZATEFNmraz2lL
	iE59SSAVbqSTN8ROBkugMpbmbzXrZbRYUPhlesx5MQ9OCXjP0UZm1dPR//NVuZLrGodlc+4QmtM
	l6EdDgXqlKp2OeYg690Fj3Mutn4SU7MQ45r9GeSCI2mDLRqEQWM41vn6ik/Fe3FMn0TelATER3F
	bYZYwjEWE/sBtJA=
X-Received: by 2002:a05:600c:35cf:b0:490:44eb:c1e5 with SMTP id 5b1f17b1804b1-49044ebc257mr277307095e9.31.1779729006482;
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm456877405e9.1.2026.05.25.10.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 10:10:06 -0700 (PDT)
Message-ID: <a192eb5c-5d16-483d-862e-d937fa1b8269@suse.com>
Date: Mon, 25 May 2026 19:10:03 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] params: Convert generic kernel_param_ops .get
 helpers to seq_buf
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-8-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-8-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Convert the generic struct kernel_param_ops .get helpers in
> kernel/params.c directly to the seq_buf signature, drop their legacy
> "char *" form, and refresh prototypes in <linux/moduleparam.h>:
> 
>   param_get_byte/short/ushort/int/uint/long/ulong/ullong/hexint
>   param_get_charp/bool/invbool/string
>   param_array_get
> 
> The STANDARD_PARAM_DEF() macro expands to a seq_buf body for every
> numeric helper. param_array_get() now writes element output directly
> into the parent seq_buf when the element ops provide .get; it only
> allocates the per-call PAGE_SIZE bounce buffer when the element ops
> still use the legacy .get_str path. The common "rewrite the prior
> element's trailing newline as a comma" step lives outside both
> branches so the two paths share it.
> 
> The non-core changes in this commit (arch/x86/kvm, mm/kfence,
> drivers/dma/dmatest, security/apparmor) are the small set of callers that
> directly invoke one of the converted generic helpers from their own .get
> callback (e.g. an apparmor wrapper that adds a capability check and then
> delegates to param_get_bool()). Because the helpers' signature changes
> here, these wrappers must move in lockstep. Each of them is updated
> to take "struct seq_buf *" and pass it through; param_get_debug() in
> apparmor also pulls aa_print_debug_params() (and its val_mask_to_str()
> helper, in security/apparmor/lib.c) over to seq_buf, since that is the
> only consumer. No other behavioural change is intended.
> 
> Custom .get callbacks that do not delegate to a generic helper (and
> therefore still match the .get_str signature) are routed automatically
> to the .get_str field by the DEFINE_KERNEL_PARAM_OPS _Generic dispatcher
> and are deliberately left alone here, to be changed separately within
> their respective subsystems.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> [...]
> @@ -453,36 +457,46 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  			   arr->num ?: &temp_num);
>  }
>  
> -static int param_array_get(char *buffer, const struct kernel_param *kp)
> +static int param_array_get(struct seq_buf *s, const struct kernel_param *kp)
>  {
> -	int i, off, ret;
> -	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
> +	char *elem_buf = NULL;
> +	int i, ret = 0;
>  
> -	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!elem_buf)
> -		return -ENOMEM;
> +	for (i = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> +		size_t before = s->len;
>  
> -	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get_str(elem_buf, &p);
> -		if (ret < 0)
> -			goto out;
> -		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> -		if (!ret)
> +
> +		if (arr->ops->get) {
> +			ret = arr->ops->get(s, &p);
> +			if (ret < 0)
> +				goto out;
> +		} else {
> +			if (!elem_buf) {
> +				elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +				if (!elem_buf) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +			}
> +			ret = arr->ops->get_str(elem_buf, &p);
> +			if (ret < 0)
> +				goto out;
> +			seq_buf_putmem(s, elem_buf, ret);
> +		}
> +
> +		/* Nothing got written (e.g. overflow) — stop. */
> +		if (s->len == before)
>  			break;
> +
>  		/* Replace the previous element's trailing newline with a comma. */
> -		if (i)
> -			buffer[off - 1] = ',';
> -		memcpy(buffer + off, elem_buf, ret);
> -		off += ret;
> -		if (off == PAGE_SIZE - 1)
> -			break;
> +		if (i && s->buffer[before - 1] == '\n')
> +			s->buffer[before - 1] = ',';
>  	}
> -	buffer[off] = '\0';
> -	ret = off;
> +	ret = 0;
>  out:
>  	kfree(elem_buf);
>  	return ret;

Since you're almost completely rewriting the logic in param_array_get(),
I suggest tightening it up a bit. The function could warn or return an
error when a kernel_param_ops::get/get_str() call adds a string that
doesn't terminate with '\n', specifically, when the call adds either
a zero-length string or a non-zero-length string that ends with
a different character (unless an overflow occurred).

The updated code silently stops the loop when a get call returns
a zero-length string. Similarly, handling of a string not terminated by
'\n' is halfway there because of the added check
"s->buffer[before - 1] == '\n'".

-- 
Thanks,
Petr
