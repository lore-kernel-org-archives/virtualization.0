Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9C35BDDB
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558289; cv=none; b=iSnP1i8YPwT+W1YNmE2IVGrtej+17KB2AL22p8GX5Xyf6QK8cOEhc3i0cW5GOx+g30puxgYKYY5tqyVtcXuHLu+dI0k3plv0DohWOvJvSTm1BJjFwmUgXNj/m3S/8PDjrAU+x4n/irP2XexV8SP46A7xWV0cRiNQ9RLsWP8HvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558289; c=relaxed/simple;
	bh=GvKTSXpSnV61qIeIj7djXSRQdMUqOq9sB7I5GfaTK/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=prz7JQ9E/fygnqEd1us1aBFd/rKFdMIkNfZFu1QuruAq+dxwLrBqMXqyNV8/BYbd1Mseizzjtb0xRfqFjzrctRf1Vdq4I/MrzkuhYJmvCCyq8HtGbA8kD6rK8VRI3hiU8jrjP78zlnnCt7lpl6Sz+KZrP9TxDrnwCCR92uczZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7BOVrZc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7BOVrZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768558286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYdYs09o1BdUi4chDtWqrhvtiarKfR63xIzMRlbqh6g=;
	b=A7BOVrZcSOj8NtR1qeEtI0L0SXcEF22LYwdmkdics4UTOD1aYlpGGzn9LRpZtuIrEi8Vkk
	z59VVikqaeDdvqSKmB/JoduO0pJVyXrktQYwhQp5qob3yCHw33DnFbIGoIAwudrNewFzf3
	Ah3uWYLC9pM7IjrBi2/Q/VGnQbedQxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ZjFRAnmEPgm_KdVIJYl0jg-1; Fri, 16 Jan 2026 05:11:25 -0500
X-MC-Unique: ZjFRAnmEPgm_KdVIJYl0jg-1
X-Mimecast-MFC-AGG-ID: ZjFRAnmEPgm_KdVIJYl0jg_1768558284
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso10977535e9.3
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 02:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768558284; x=1769163084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYdYs09o1BdUi4chDtWqrhvtiarKfR63xIzMRlbqh6g=;
        b=SeIJruhZdJR6pIbw4TB2yQCPy2M3K7/pW5egcPUUkRnXOv8akL+j/S2zZ+cQbAupoP
         Crw5sfF67+ynIPjYIIhE6Z4dt1JymP/EMeK93tH6H+1zIN1ytvSiEWRzqP4qdY/lz6wb
         0OHJhXObgRNDa2ddARIPdI4+9Wfr2fbNHv6c0uEPJxhQE8u5XnARbU2WfwmHr7CdpdTP
         DeLOZ9uFBI9u9Qw1+9BmRIxVkHjHsdeoVJkU1E+F0Fwz5ddNAFRI9uY9b/pTSFsTx27u
         s48c/9syvUW7SG97tkvUAQrKNR1BGAYJ1Ia+UemDKhwfRcjzQRch5ueQBBJsGfsHn4JU
         3pvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0EmHJk9Brv0VDs3FlnbLjWng4BU/uO2AijDUyeGovorcTx5IG6AWlMg8g6ti5ZnhwaDegDpRlB8UCUt5n8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxC/YM1IzL3rAxJYiOY6SmD5Rg+/vaHCWNEl7VWWrs/pFLImJ0+
	hEGZLIRzYtFdMaLGilsURcsCMKZ16hfrPNPb675DY+GE02lysCjia/W1rqMP4E+UipDeXcn+zLn
	TQ6pmGhEeJsuecSCEVEGQLxnN0sQT8SBCajg2bJKYYUAHIAfeJMhsrNpmMdVhrUqmBuXA
X-Gm-Gg: AY/fxX6wF45WChhYPNMVbKmPX9vgq3dp0PZEqT1lOYNiGa78MI+vAxHu1ZUhT3/7nwI
	j4GNUbkJvpabcPFXrX4cyya2f/dvbPDs9jucZjUZ6HQydrHbcfjm4XqBTsibJm3YDcai9rrfSp0
	K7svHPrGD+AxhmEQwJwVHlddcEOHrTgu0pXkEeYHv5hrycD2HqOYoD0hf9SlyE89bLNJpnPnIwc
	RB2A4wVOxsSQ87G1Dxr2duP94BIivvBtSrLjU2l8NZyL+sRd8DNZegd5wdPKKwhXR5ZJuyoH6rV
	2ubCHnmOWQIe1aD2I0K6F4GHFr+Z/HgzFskY4Fu9aGCp2b92k0N52SICrneex8BRnstAlKOiul0
	xkvo0Dpf0UX2WC119f+BIioZ5/AbU6yaO98T0Zq7WoSvKc6UJ0FRIGNrpQhE=
X-Received: by 2002:a05:600c:c178:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4801e34cd0emr32517735e9.31.1768558283735;
        Fri, 16 Jan 2026 02:11:23 -0800 (PST)
X-Received: by 2002:a05:600c:c178:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4801e34cd0emr32517485e9.31.1768558283318;
        Fri, 16 Jan 2026 02:11:23 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8d90b3sm35848465e9.15.2026.01.16.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:11:22 -0800 (PST)
Date: Fri, 16 Jan 2026 11:11:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Luigi Leonardi <leonardi@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock/test: Do not filter kallsyms by symbol type
Message-ID: <aWoKNf1AI9s1bmYM@sgarzare-redhat>
References: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pdh7q0KdQsFAUlmN0N9GFntlb9ggJpXvn-syi0plClI_1768558284
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jan 16, 2026 at 09:52:36AM +0100, Michal Luczaj wrote:
>Blamed commit implemented logic to discover available vsock transports by
>grepping /proc/kallsyms for known symbols. It incorrectly filtered entries
>by type 'd'.
>
>For some kernel configs having
>
>    CONFIG_VIRTIO_VSOCKETS=m
>    CONFIG_VSOCKETS_LOOPBACK=y
>
>kallsyms reports
>
>    0000000000000000 d virtio_transport	[vmw_vsock_virtio_transport]
>    0000000000000000 t loopback_transport
>
>Overzealous filtering might have affected vsock test suit, resulting in
>insufficient/misleading testing.
>
>Do not filter symbols by type. It never helped much.
>
>Fixes: 3070c05b7afd ("vsock/test: Introduce get_transports()")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>man nm says: 't' stands for symbol is in the text (code) section. Is this
>correct for `static struct virtio_transport loopback_transport`?

I'm not an expert, but yeah I was expecting "d" too, but maybe since
it's static and built-in will be in the text section?

BTW I just checked and for example on my 6.18.4-100.fc42.x86_64 I have:

0000000000000000 t sock_fs_type
0000000000000000 t proto_net_ops
0000000000000000 t net_inuse_ops

And they are all static structs of built-in modules.
So it seems it is common.

>---
> tools/testing/vsock/util.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 142c02a6834a..bf633cde82b0 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -25,7 +25,7 @@ enum transport {
> };
>
> static const char * const transport_ksyms[] = {
>-	#define x(name, symbol) "d " symbol "_transport",
>+	#define x(name, symbol) " " symbol "_transport",
> 	KNOWN_TRANSPORTS(x)
> 	#undef x
> };
>
>---
>base-commit: a74c7a58ca2ca1cbb93f4c01421cf24b8642b962
>change-id: 20260113-vsock_test-kallsyms-grep-e08cd920621d
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>

