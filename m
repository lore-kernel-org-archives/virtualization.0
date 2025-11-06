Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018A3502BE
	for <virtualization@lists.linux.dev>; Thu,  6 Nov 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445819; cv=none; b=KeR086ZNlQZHKbhWCQA0vDfJWNEYfPshgx5ITn+qDIfyJGPwtUTb3gMu85eC9/pkLmAzmjrptT8guzZ5V2WEtNwc39iBeH8yT9v20/lyMHhECwp8wZhNLLlA3VjfMAmPk0isWL4hAcGaeXysEvyr59BWpzDLaw5UoCTlo4cZZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445819; c=relaxed/simple;
	bh=Z7eSKPc3txhBUxRtndXMLROsssDroOhR9kPjB1j/JTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F5rK+4HzoRVnw/xaWPVbBRjIY3dTgBXGdnGYjMAV3CiWRFbVz30J0MgGx0auDGmsagYjBHmiNTag7NXWOwtRfGmLH71bHyt/P5oHH1INb/T5v+wAUxL7yva5LaADWzM4sY+eiqFYrYcaBE74qQpM4mDHozOPW8Oe7NA6p+TzvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn2eCXt9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn2eCXt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
	b=Nn2eCXt92UmiS7NClPsmAfyr2JZZzMFyRpX9qiwi6zHDRw4jbGzpMeTIQsjTTrcAlDoWNy
	/n+MWb38eX86bGE1B4vq2MLU+E0Ed5YnVOlgLWW+AYwKIQBlX80403bnMd+OZkjuAzRaXx
	1LIdqKty9N13ydRN0+owYin14pQYi1Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-e1C1Eu93NyCAcQoCQOvpUg-1; Thu, 06 Nov 2025 11:16:53 -0500
X-MC-Unique: e1C1Eu93NyCAcQoCQOvpUg-1
X-Mimecast-MFC-AGG-ID: e1C1Eu93NyCAcQoCQOvpUg_1762445813
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47740c1442dso9292325e9.1
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 08:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445812; x=1763050612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tCanlI7uiN2snt10ROgiGSCHaaEX2aQy3SErwtUYP8=;
        b=i2cQibS4+pBtQH4LV5+Fu7u6OJX+EbCoAPj/7uDwv3ZBkEcFpPNaSa0v/WOQe0WeUV
         HC36nSHM8fQ4gOQosMeu3BL6ZEqOjQMu9ug1x5ctaBzyy9gbek02hqqb1urvzpZHmtUz
         zBJh2imLUascIOXzPDq5ADXO18MY7OhT+f8WoMGuOh0skRV0O0UQB8xfDrwKJFaCQt4s
         jgLwDU3igWWk2ItmYJ/oIqX5sTewvRK3vWnuZuL9i/aeQDj1wiKW3Es3uEUcHDJBghQq
         xeLS+d3lLtOYnb2vEajg3G4Je0ZHcfSe3htJhllBpMTE33TrRZ1peFhW9n731zG8CKIs
         Aheg==
X-Forwarded-Encrypted: i=1; AJvYcCUgz4TVNznr/JQu1KvsH7e0JKgv3Nmdn6AvxRFfk2AGFEWBQiiLW+9rvr2xpM/we5/LC9sx20m79hOvLW/EOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRMykkjv6rosLlkhbFElEwLLNGnwhpvblZ47P9oHVKobbagnMw
	Q/ZUFGrL5MgR+QhJEvWK08K2lOpSLqr3m1Ddj2v7hRnk7RdnAIiGgAraD7VhsCeBcLY+f5V5kEF
	APlRz73jnelMmBoVwhVFe96ODvzYYjseCFqS51xHlqQ9zi4aQsfrLKCSQbKvj8FlSPSD2
X-Gm-Gg: ASbGnculGrNfj1orBabA1UTH4nQdzhznbjmgtKckqboCTAy4UYp4iqxPFx+d8fiLt9X
	vHuBK3xRRyP3Ibh7wNfIG4dZYaaIigZJTmz3G6Knf+djCUjvtziMFUL0U/OvrtoTVzrs9N+Hi2B
	KNK0MpjSxXLPop18tCnXlaCsDPH0L02UxrDLUhnHJzRuBLQKqJWzoJAZIoyKOHptEGtq9g6BoYu
	SqwkFWMvuyrFwRxdbolbF/HVRRDLIJk4jvZimv3YE/qP4PyOUavJd/CRHZULNucyuJEsmq0FOne
	4q80vZ/wMKELsUxrIZDcoEXLzNhvCnez1iZ6IwjGYJER1ZjdoIiNqvSuYeP3b+luIDu4l4s18A/
	Rgg==
X-Received: by 2002:a05:600c:8216:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-4775ce208a3mr70634085e9.41.1762445812528;
        Thu, 06 Nov 2025 08:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW3IYi/YdprfC2n+fzLAs5f0/Jy2gRulDCDLn2/BkchwC+aok0NFWkDfKX3ED9iPmszk8KKA==
X-Received: by 2002:a05:600c:8216:b0:477:10c4:b4e with SMTP id 5b1f17b1804b1-4775ce208a3mr70633685e9.41.1762445812098;
        Thu, 06 Nov 2025 08:16:52 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2fb8sm54077105e9.10.2025.11.06.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:51 -0800 (PST)
Date: Thu, 6 Nov 2025 17:16:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 02/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Message-ID: <ruxocfuprofj3mktmjulqy5dhnzkbad3fetqrg2f6kw4gh4wwj@x2mb2dw7pjk5>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M3AUPoHz4RPWVmzFHNvxtH0ayU5H9wJAnh3fcof2JPM_1762445813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 23, 2025 at 11:27:41AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
>grow, we want to keep it trimmed down so it doesn't exceed the size of
>skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
>additional two bytes for new fields at the end of the structure. It does
>not shrink the total size, however.
>
>Future work could include combining fields like reply and tap_delivered
>into a single bitfield, but currently doing so will not make the total
>struct size smaller (although, would extend the tail-end padding area by
>one byte).
>
>Before this patch:
>
>struct virtio_vsock_skb_cb {
>	bool                       reply;                /*     0     1 */
>	bool                       tap_delivered;        /*     1     1 */
>
>	/* XXX 2 bytes hole, try to pack */
>
>	u32                        offset;               /*     4     4 */
>
>	/* size: 8, cachelines: 1, members: 3 */
>	/* sum members: 6, holes: 1, sum holes: 2 */
>	/* last cacheline: 8 bytes */
>};
>;
>
>After this patch:
>
>struct virtio_vsock_skb_cb {
>	u32                        offset;               /*     0     4 */
>	bool                       reply;                /*     4     1 */
>	bool                       tap_delivered;        /*     5     1 */
>
>	/* size: 8, cachelines: 1, members: 3 */
>	/* padding: 2 */
>	/* last cacheline: 8 bytes */
>};
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/linux/virtio_vsock.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Yeah, thanks for that!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..87cf4dcac78a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -10,9 +10,9 @@
> #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
>
> struct virtio_vsock_skb_cb {
>+	u32 offset;
> 	bool reply;
> 	bool tap_delivered;
>-	u32 offset;
> };
>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>
>-- 
>2.47.3
>

