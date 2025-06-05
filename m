Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13771A7262
	for <virtualization@lists.linux.dev>; Thu,  5 Jun 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120382; cv=none; b=aaNKblu53jzaksbcAA7JWnajhaDcSPq+mHjSrKhJ+NdxL4Qsi3YOSD8ZlxBIWGmhhlM2WxDQUS0IvZmfv3Ibba4QHJ0vF3hdz/jSmS/KfXwD58H1sBUL1ry/bwwXjYcg9o7VCj4B5wwNBvX4SXVFdRMSHosZl9Cd8OAo7Crfugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120382; c=relaxed/simple;
	bh=dI6qpz2KIHyN65XCCBmaV4te4lobXPKhgB8Vm+iOVio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CMSc+dvmy81MbgSDCXmHLUfoj7wKzCjMXSQrnpkrwRKI9/U4oGHdP7BtYb12GH7gLeQwSzFH9fn0WdKxc5a4mJ+fUfcJ4qnysmNeiqHY15GcevHzhrBHdcWUlIJFgM2tw84jyD8NQ2cHsqGBfKnMbsgFbUTjBVBscs7myCqeCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byZFCIwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byZFCIwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749120379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7H6zcBjzLakny0tH2Rd3mdTARviwtcKxD112Kp1NxU=;
	b=byZFCIwaQlqkJYgKNyzB1s7bQbpYXQQ4GjNktTn9osXTWclCPSKr2kUxFb49FoMg5ufd9Y
	fSFYQLok6HDLmM5XRqRldvc1x7u05mBsj//TSBTDlF49TsfrjyfDmwvyniBIzUshS4l2ll
	buabWBHj5hYSOtdTtyvAeC3LH5qh2js=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-wFLSyVuhMHKaLArT55vMeQ-1; Thu, 05 Jun 2025 06:46:17 -0400
X-MC-Unique: wFLSyVuhMHKaLArT55vMeQ-1
X-Mimecast-MFC-AGG-ID: wFLSyVuhMHKaLArT55vMeQ_1749120377
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442f90418b0so3927565e9.2
        for <virtualization@lists.linux.dev>; Thu, 05 Jun 2025 03:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120376; x=1749725176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7H6zcBjzLakny0tH2Rd3mdTARviwtcKxD112Kp1NxU=;
        b=bc1FilWTUY6tiQR/KIW3+DmgruREEFuD3lMw0gzd0UquvlFumM/qnfJ/ZALWXrZlJc
         0aECtwnqqUA3V0uXnOzo8DIDpt9SNz5Opu9PEP7Xmn+EWSRfIeiQK/1jxEnqm2oj2KHK
         Qp0weo8mINH5OIoXYLCogWPkN1cAfO2s5tDZJylP6qGRA3lFZmRDs0auWgGQv6Eb6csj
         r8/EiSuxSDBkVcd9vohJvSpF2XKi+tvPvGbkHPpyPVLHbGvjJu/+sf/J803zAUVbswtK
         +JMWmCx0P7iaMAuWnf9yZitfeceMOCKKsRsfLPrzMXNDrMj/7nvtj+1749VJ0ux5XC4K
         45YQ==
X-Gm-Message-State: AOJu0YxF/RniBRpAElm+c4MbBvWU7M42udCSZ5irXA6WcZ0BaMf7Wdg+
	dMJj2ceceynedfk0s6b3sJgW9inHm8pgX5/wFcGJN0omS09wUtiYCDvS9jMmGPJc7JU/pBYVndQ
	q4bPJ0nljpyLW0bxHxMRwZ4pd5oci9CCJbPi0N2kmTF7rHxKCexATZTwJLRe3qrHLMl7B1zwDbd
	CARSI=
X-Gm-Gg: ASbGncv2VVuKyhR6SS/OlkRaPQ/P30L+yf6SO/CKwEWqbcwH8PdpL8KRuhKIweFkwo5
	4gish8zljq1xZdd/5OBL8LUQuaFUjSU1kVUcElLkRi1DEK1VfmUUpEzmX+aGzhYAUyw7QLxaQ7o
	pPtj2V5c1ztcAh6cUmWUvpX4s/XV7Vcl3D5IX6jpD7cT4Q+B5+TM8UZJhqfI6UHeUMuJA9V19Ko
	WH6vpiUGOZVIsYetl8bCwL/O+hYwvHFS+hLlAcYyzM5daGhNpP3t9ChDeKs20NPkNhf3sSkyaP1
	c2qSyTSMoBgceKGUA4mAl/rP1hwxxE93JpHE8fZfxXthtbnEOMQ=
X-Received: by 2002:a05:600c:1c0b:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-451f0a5fe1amr55551725e9.1.1749120376069;
        Thu, 05 Jun 2025 03:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeoslgFEZ3R+4NzXqejnaWsWrMqOsjz76qooQAktoxBM6xArUOr3h1Npds2aEkO46Z515I4A==
X-Received: by 2002:a05:600c:1c0b:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-451f0a5fe1amr55551375e9.1.1749120375423;
        Thu, 05 Jun 2025 03:46:15 -0700 (PDT)
Received: from sgarzare-redhat (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb178895sm14743285e9.14.2025.06.05.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:46:14 -0700 (PDT)
Date: Thu, 5 Jun 2025 12:46:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/3] vsock/test: Introduce
 get_transports()
Message-ID: <hxnugz3xrrn3ze2arcvjumvjqekvjfsrvd32wi7e3zgdagdaqb@cm3y6fipqdf3>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>
 <wzbyv7fvzgpf4ta775of6k4ozypnfe6szysvnz4odd3363ipsp@2v3h5w77cr7a>
 <b4f3bc0d-9ff5-4271-be28-bbace27927bd@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b4f3bc0d-9ff5-4271-be28-bbace27927bd@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kd6o1UFKUHDFdU3hEcWlcHCrE60KDouEfOi04tuRaPo_1749120377
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 04, 2025 at 09:10:19PM +0200, Michal Luczaj wrote:
>On 6/4/25 11:07, Stefano Garzarella wrote:
>> On Wed, May 28, 2025 at 10:44:42PM +0200, Michal Luczaj wrote:
>>> +static int __get_transports(void)
>>> +{
>>> +	/* Order must match transports defined in util.h.
>>> +	 * man nm: "d" The symbol is in the initialized data section.
>>> +	 */
>>> +	const char * const syms[] = {
>>> +		"d loopback_transport",
>>> +		"d virtio_transport",
>>> +		"d vhost_transport",
>>> +		"d vmci_transport",
>>> +		"d hvs_transport",
>>> +	};
>>
>> I would move this array (or a macro that define it), near the transport
>> defined in util.h, so they are near and we can easily update/review
>> changes.
>>
>> BTW what about adding static asserts to check we are aligned?
>
>Something like
>
>#define KNOWN_TRANSPORTS	\

What about KNOWN_TRANSPORTS(_) ?

>	_(LOOPBACK, "loopback")	\
>	_(VIRTIO, "virtio")	\
>	_(VHOST, "vhost")	\
>	_(VMCI, "vmci")		\
>	_(HYPERV, "hvs")
>
>enum transport {
>	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
>	#define _(name, symbol)	\
>		TRANSPORT_##name = _BITUL(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>	KNOWN_TRANSPORTS
>	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
>	#undef _
>};
>
>static char * const transport_ksyms[] = {
>	#define _(name, symbol) "d " symbol "_transport",
>	KNOWN_TRANSPORTS
>	#undef _
>};
>
>static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
>
>?

Yep, this is even better, thanks :-)

>
>Note that I keep pushing for naming HVS a TRANSPORT_HYPERV. Perhaps it's
>better to stick to TRANSPORT_HVS after all?

I would have used HYPERV too, but honestly I don't have a strong 
opinion, so take your choice.

Thanks,
Stefano

>
>>> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>>> index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..63953e32c3e18e1aa5c2addcf6f09f433660fa84 100644
>>> --- a/tools/testing/vsock/util.h
>>> +++ b/tools/testing/vsock/util.h
>>> @@ -3,8 +3,19 @@
>>> #define UTIL_H
>>>
>>> #include <sys/socket.h>
>>> +#include <linux/bitops.h>
>>> #include <linux/vm_sockets.h>
>>>
>>> +#define KALLSYMS_PATH		"/proc/kallsyms"
>>> +#define KALLSYMS_LINE_LEN	512
>>
>> We don't need to expose them in util.h IMO, we can keep in util.c
>
>OK, sure.
>
>Thanks,
>Michal
>

