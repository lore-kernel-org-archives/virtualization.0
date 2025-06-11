Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4B2BE7AD
	for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651663; cv=none; b=c5SVbA9wY8kwDHIUMxCdNnr2F7EH68FCW2EnFykT4xJrMa8tE8WncRU1mrE/mS8krxFiFwpb64j1eiBhZqP/5ZhAGUdacuygnyifs3WjhUBgdCgp2xJ8n2BFhDEZ3iyRpdExy3uEuCyo2RYak1L77xvAfZCtC6fk8FU3+rkLWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651663; c=relaxed/simple;
	bh=tEXibwohiKNHCWkX7JniiQ7ZfUXlGD/79RnMkx3tqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ne4StUKWPN0Ho2eEyIzfUBVVNsskn6oSSIq6slARLGYltTaOMvaRSWonyklULBI/a9WpovtflOmZbYDYjexiSzE3sU660GWWVRFaCUTckqz63d4SvefWcHaufTwcwZ73cTH/KOylJS1yDpIY1AOMzoxjoWf79W8t2sPd2a/SYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKz08fY7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKz08fY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749651660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/ntzkpVyIcXdzoQL5rgGpdL1A4Z+ur0N0W3VcmJOj4=;
	b=jKz08fY7l7yn87BouONxurXxR7YC3/ITwil9BUxPEL8Cw3audfZkvKvedmwBAdVaCZEUVT
	Vrli+sVNhUxIqENiAyNpjwIVW+CujzRPIllHjaKHR0l6Way8N2e/LBDDk7x++wB925MntS
	TuwdRsS5koEcCW7MlDbcEB5vJVkEZ7s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-SFCokmH5MImVAYoset_0Kw-1; Wed, 11 Jun 2025 10:20:58 -0400
X-MC-Unique: SFCokmH5MImVAYoset_0Kw-1
X-Mimecast-MFC-AGG-ID: SFCokmH5MImVAYoset_0Kw_1749651658
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fac45de153so100112866d6.2
        for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 07:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651658; x=1750256458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/ntzkpVyIcXdzoQL5rgGpdL1A4Z+ur0N0W3VcmJOj4=;
        b=G41cLVtwg4cZ7bdbaDSnNFnmN+i5o7XBZPHbEJqvZlVatkGbztwYzwIE5jCSZ+2D+d
         /+mD6Pbt8MKqe8EPCb3KTHyxXFTi7ivmkQF0r9hnmiL6Gc4R1oMiubHztaywT6/PeiHV
         12WcqO/v1vuUNPsqzeueqXK0ZmuAPVO22MAZLvRzx7AawaM7GHHVmBn+tdTz9h0vLCAT
         sPDYclAVmbKvQgMDk0OaqJ1Y/VD6XiABN7o/ep+twkdEW7gy5IxNT7IfRar2BOxYaJY5
         hnHrEY1pQSHhsNzDX2TKjboufgIaA/yw45chDkcCN6PxAvbZ/vBUwrXSGYbGjHh41pR4
         9mHw==
X-Gm-Message-State: AOJu0Yzoj0SflUz8Ta/1GjaLswG6YcmANBPxYjNCO+SHYfwajSep9avY
	APsvSTtIgpGnCq8XpQFbFvPxZmvAOznuicmJP0qoU1Dpskpmwupk9qCVXq/mfc4nRRehGPtrCeu
	hOozjXUktcpGyF8A5s4dJM8G5B7TbJ9ei7GqMZFe/4XqsbwuXIYA/Jb8hdeop7EzwG7VZ
X-Gm-Gg: ASbGncubwBe/iNvuyleSZAGfQPLMFhP7dIS948AxeoVbMLb1X7lFHkcOnV8KsCrrN8M
	I2dR3yFOqY9lmqN3gWjUngcO7MGt7SSCkkR02hf7cYTzuAApZjgKP3DgCXfgbn0uMowKiFFKEs7
	2y3lsPonPoJf+NiICkJbFQ6b38JAL97t06YdWWcKpSrlFayVjx/CnQ6NMVbaKOD33VaTx/+NqP/
	jGzlOa+iFtwr0NysqCEeDrhDwdEDDMgNn1tx8YAAuJrwufTEIlEfh9K6+R5U5ghAhPGOXcFULKA
	sP8eIp1TZxnk2JpPExeYhsFEGceQ
X-Received: by 2002:a05:6214:e87:b0:6f4:cb2e:25cc with SMTP id 6a1803df08f44-6fb2c375cbcmr53864576d6.32.1749651657760;
        Wed, 11 Jun 2025 07:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQt/g4HB23CjbIbHN4akFe9MRSdw7e8RgKDMJzNZJ6k+6aUqN0eqJB/UJ1rAQJhrsDdwLVxA==
X-Received: by 2002:a05:6214:e87:b0:6f4:cb2e:25cc with SMTP id 6a1803df08f44-6fb2c375cbcmr53864296d6.32.1749651657123;
        Wed, 11 Jun 2025 07:20:57 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b2a1fasm82526736d6.93.2025.06.11.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:20:56 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:20:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/3] vsock/test: Introduce
 get_transports()
Message-ID: <lvduahetdnmshgo7tus7kezq6ddps5wjouefkmfwxkw7ckbhpg@nvjhai4xt5kl>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>
 <wzbyv7fvzgpf4ta775of6k4ozypnfe6szysvnz4odd3363ipsp@2v3h5w77cr7a>
 <b4f3bc0d-9ff5-4271-be28-bbace27927bd@rbox.co>
 <hxnugz3xrrn3ze2arcvjumvjqekvjfsrvd32wi7e3zgdagdaqb@cm3y6fipqdf3>
 <adae2539-2a48-45c3-a340-e9ab3776941f@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <adae2539-2a48-45c3-a340-e9ab3776941f@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -pmzmqPDYRx7k9xPcbRGU2xn7xDrjdnmHB4gvnvDM6w_1749651658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 06, 2025 at 09:51:29AM +0200, Michal Luczaj wrote:
>On 6/5/25 12:46, Stefano Garzarella wrote:
>> On Wed, Jun 04, 2025 at 09:10:19PM +0200, Michal Luczaj wrote:
>>> On 6/4/25 11:07, Stefano Garzarella wrote:
>>>> On Wed, May 28, 2025 at 10:44:42PM +0200, Michal Luczaj wrote:
>>>>> +static int __get_transports(void)
>>>>> +{
>>>>> +	/* Order must match transports defined in util.h.
>>>>> +	 * man nm: "d" The symbol is in the initialized data section.
>>>>> +	 */
>>>>> +	const char * const syms[] = {
>>>>> +		"d loopback_transport",
>>>>> +		"d virtio_transport",
>>>>> +		"d vhost_transport",
>>>>> +		"d vmci_transport",
>>>>> +		"d hvs_transport",
>>>>> +	};
>>>>
>>>> I would move this array (or a macro that define it), near the transport
>>>> defined in util.h, so they are near and we can easily update/review
>>>> changes.
>>>>
>>>> BTW what about adding static asserts to check we are aligned?
>>>
>>> Something like
>>>
>>> #define KNOWN_TRANSPORTS	\
>>
>> What about KNOWN_TRANSPORTS(_) ?
>
>Ah, yeah.
>
>>> 	_(LOOPBACK, "loopback")	\
>>> 	_(VIRTIO, "virtio")	\
>>> 	_(VHOST, "vhost")	\
>>> 	_(VMCI, "vmci")		\
>>> 	_(HYPERV, "hvs")
>>>
>>> enum transport {
>>> 	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
>>> 	#define _(name, symbol)	\
>>> 		TRANSPORT_##name = _BITUL(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>>> 	KNOWN_TRANSPORTS
>>> 	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
>>> 	#undef _
>>> };
>>>
>>> static char * const transport_ksyms[] = {
>>> 	#define _(name, symbol) "d " symbol "_transport",
>>> 	KNOWN_TRANSPORTS
>>> 	#undef _
>>> };
>>>
>>> static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
>>>
>>> ?
>>
>> Yep, this is even better, thanks :-)
>
>Although checkpatch complains:
>
>ERROR: Macros with complex values should be enclosed in parentheses
>#105: FILE: tools/testing/vsock/util.h:11:
>+#define KNOWN_TRANSPORTS(_)	\
>+	_(LOOPBACK, "loopback")	\
>+	_(VIRTIO, "virtio")	\
>+	_(VHOST, "vhost")	\
>+	_(VMCI, "vmci")		\
>+	_(HYPERV, "hvs")
>
>BUT SEE:
>
>   do {} while (0) advice is over-stated in a few situations:
>
>   The more obvious case is macros, like MODULE_PARM_DESC, invoked at
>   file-scope, where C disallows code (it must be in functions).  See
>   $exceptions if you have one to add by name.
>
>   More troublesome is declarative macros used at top of new scope,
>   like DECLARE_PER_CPU.  These might just compile with a do-while-0
>   wrapper, but would be incorrect.  Most of these are handled by
>   detecting struct,union,etc declaration primitives in $exceptions.
>
>   Theres also macros called inside an if (block), which "return" an
>   expression.  These cannot do-while, and need a ({}) wrapper.
>
>   Enjoy this qualification while we work to improve our heuristics.
>
>ERROR: Macros with complex values should be enclosed in parentheses
>#114: FILE: tools/testing/vsock/util.h:20:
>+	#define _(name, symbol)	\
>+		TRANSPORT_##name = BIT(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>
>WARNING: Argument 'symbol' is not used in function-like macro
>#114: FILE: tools/testing/vsock/util.h:20:
>+	#define _(name, symbol)	\
>+		TRANSPORT_##name = BIT(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>
>WARNING: Argument 'name' is not used in function-like macro
>#122: FILE: tools/testing/vsock/util.h:28:
>+	#define _(name, symbol) "d " symbol "_transport",
>
>Is it ok to ignore this? FWIW, I see the same ERRORs due to similarly used
>preprocessor directives in fs/bcachefs/alloc_background_format.h, and the
>same WARNINGs about unused macro arguments in arch/x86/include/asm/asm.h
>(e.g. __ASM_SEL).

It's just test, so I think it's fine to ignore, but please exaplain it 
in the commit description with also references to other ERRORs/WARNINGs 
like you did here. Let's see what net maintainers think.

Thanks,
Stefano

