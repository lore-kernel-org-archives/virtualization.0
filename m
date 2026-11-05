Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874168;
	b=AjWq9JBeMrvILsdBRbkigpLqidv1rdF05A9BVnCzIsQ33N5DXm3mNo6itkKIqGVWSE9A
	 YMoAMjwrM2B3xBjCViZdffr631UrP7tuRclH8yyE7jsCnf1n6q+UskQaycBm2gz5O597v
	 ezoITz9Ap7iew4iq4VKFAQ0Nwxuq6PjD7bdKL7+yV7FTBGEIwVBOBY5jBRSdusHzjo0/T
	 vWQ72FAZ8r4BWEqn5Hqxw1QyHUhi18toeyafVo08nPg7rzD5wEZU62l+aRkGEM+j0Ialu
	 lg9cCIKR9l3eZRcN5ozeY76eMNVa6o8mIAbRaoNDbXBoE2vdLA/qvIStalPpxM5w0GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874168;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=mA0JUWIMJDLe3trqouiE/a4ohypc9UC+FqDIAXVqBsQ=;
	b=1O2TcclxEXP+ND1gbLvMYaUcfemIVO3VKs6RWyVN6C0r050oa1ZFUNvtBxaO6TObB85a
	 4BDCnLN1UiZx4oo2u1OdlkSQUEKIvU8cbTFszTfI4TUPrM4JrJM1yvl5peZdYtF0oHMsR
	 a18G9XBNS8rU1vfOkBtOxNn/WL8y+/zUbzgCaXuTyFhzXLiDuI4GbY5D2r4wq0GIgQ2bd
	 pIqB4DjR39sCNieiBN9Qv0ZhCFquyDr7NGagpSyTdGuMsFMe4DqsUJZ9ImBllRchE3Lw+
	 /RS5X/woT224F1+sxhFl3wXbfhMIpTpD7s+G/IlGMQe7GSPfnySieoi6pFyRK0n9P+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCu7Whgr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017C606A334
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 10:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C017C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCu7Whgr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793874166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mA0JUWIMJDLe3trqouiE/a4ohypc9UC+FqDIAXVqBsQ=;
	b=fCu7WhgrFhIYm6aOm8TvUiaLoRGd+tQ8l4NyTEEioT6TWLV3PTbdrOfsQHOD8olNCTo8Le
	0SzebBEbxVYVtSJWVo0abW7qz+GkFGzI4aJsJ39Z9GO5APt3m9g+em1NmQmrmiUZMNXSaq
	gC55XlnIRTkBh9SwgGGKZwkDkMEPOx0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-BUcXpWUXMZm9GeqXnvGrtw-1; Thu, 05 Nov 2026 05:22:43 -0500
X-MC-Unique: BUcXpWUXMZm9GeqXnvGrtw-1
X-Mimecast-MFC-AGG-ID: BUcXpWUXMZm9GeqXnvGrtw_1793874162
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4916d47eeb5so483024f8f.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 02:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874162; x=1794478962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mA0JUWIMJDLe3trqouiE/a4ohypc9UC+FqDIAXVqBsQ=;
        b=NCEsTPLaLIG2GtvYY2T0N2GnkuAAe+FrPLNYkdRz0lrdrKwGSJc9A4/PeSymBM0pAB
         SmQYBlEqm4vNwWQc3EAqOcCQ2gw7b6AzuJlJW6SxJfEEW0zkcHvJGhOJLP9S994uRiTU
         C6b/+8DXZppLd6pYlnLJRv7yvO+HS72unHbv/c9Vr1V0yGA4cX/MZ5vW/wdZvDznGEpe
         1ZR/Jym1zTI4Ye+HfI4AUMdwLtF7uH8mpnwOrI5JpXl/vSadu1Pvkj5vnB85Eb8RInAR
         PiyXNqeGqXpNnfRrQamLkPjqy7lSWUXkrFwfvAesKBb9B36DfbYK1Ij8I8Sw/P5WrtOu
         A7Yg==
X-Forwarded-Encrypted: i=1; AKwUvBynwHWEydBGQsLeRteqHQFTasI/qv2runbQFzmYwwiHFNZZs6oCU9yZvKjoHX5IwHcSKJ71P1SgiebnOm/78A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8pI7qcW3Q/Z0nSzcHzDYQdR572sfvs19I3zB5i7LhJeVOyUhZW
	jH9fKVm9OpgKl2GlGDvW/KZbYlp0NRp/2mGdIikdz6cc4zPtJ0HfcfK0BqasEcHwJLpyrD9BjAM
	JfgadRvYuMDclfRwnmyGx+CdFZMkyNFBrgFMxsYKyBOmo9PHBC3c43WU0AbiddgteMAP4
X-Gm-Gg: AYBFou0nXVTt/c5js36UaWoOi0iAF5KX9vgzGPEPXkMWxEw8OrJEw2KQCqqX5R4BAOF
	NWpwIYZEnmCTAh2BoWV9WNJ8RgUIjareh0+KmiODSy+4OmMJgO020ZJWTZe/vOLY6ykmPoAsr3T
	A9ewJ0snIT7LcNbOsUGsJqC1aJmFHQ9Kh3fxUP5amYnQpt4woHitPDGzRcLJwOaPDvQvYu1MZRI
	Weui/mMEt1caR0UHiEd+NCn5OVaO8bTwIg482UgBos5zlLGMEBehvOgtVoETWfPAS3jLeOcfx/i
	rE5/9qRVIbaw0r1DWwnu/B9YVQgvi0y0jkfoSQRHBbitkj1nb+ItQiAbM91HBjiUtqROM6UIVdv
	h/tj1pGT8QadKjNKxLFRWsIpULXetvLPFKJOuiI5nsqME3rjB24CN
X-Received: by 2002:a05:600c:c87:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4ac186b1a2amr423568255e9.18.1793874162231;
        Thu, 05 Nov 2026 02:22:42 -0800 (PST)
X-Received: by 2002:a05:600c:c87:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4ac186b1a2amr423567735e9.18.1793874161708;
        Thu, 05 Nov 2026 02:22:41 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f0237aesm56586085e9.9.2026.11.05.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:22:41 -0800 (PST)
Date: Thu, 5 Nov 2026 11:22:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
Message-ID: <auxYWGV4l-xEAajy@sgarzare-redhat>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
 <auSkQOU6qmj0NPEt@sgarzare-redhat>
 <179381093020.9.4719932034061956856.1746278795@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <179381093020.9.4719932034061956856.1746278795@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2rj_91Vl27Nzt9a4KIJAEUrzab9JAXVrSZeMtve7NvE_1793874162
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 04, 2026 at 04:48:44PM +0000, jrmmhm.kernel@eldare.de wrote:
>On Fri, Oct 30, 2026 at 03:18:10PM +0100, Stefano Garzarella wrote:
>> Ditto about commit message, please put more effort on writing something
>> readable by a human.
>
>Agreed, I'll rewrite both messages myself for v4, much shorter.
>
>> >+            if (sk->sk_err) {
>> >+                    ret = -sk->sk_err;
>>
>> Why?
>
>Same as vsock_connectible_wait_data(): an error that arrives during the
>wait is returned to recv(). Without the check the loop still ends, since
>every path that sets sk_err also closes the socket or sets peer_shutdown,
>but recv() then returns 0 or -ENOTCONN instead of the error.

Please add a comment with the reason.

>
>> >+            if (sk->sk_state != TCP_ESTABLISHED) {
>> >+                    ret = sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
>> >+                    break;
>> >+            }
>>
>> I'm thinking if we should split this in multiple patches.
>
>From reading the code, it can be split without breaking bisect: first
>loop on all exit conditions with the lock still held, then drop the lock
>around wait_woken(). The order is fixed, since dropping the lock alone
>brings back the early -EAGAIN, and the loop alone does not fix the
>deadlock, so both would carry the Fixes tag. That is why I kept it as one
>patch, but I'm fine either way. Split it like that for v4, with the
>current 2/2 on top, or keep it as one?

Okay, if the entire change is needed to fix the deadlock, then it makes 
sense to have a single patch. Please make it clear in the commit 
description.

>
>> >+            if (!timeo) {
>> >+                    ret = -EAGAIN;
>> >+                    break;
>> >+            }
>>
>> Is the move of this check changing some user visible error?
>> I mean before this patch it was one of the first checks, is this okay?
>
>Yes, for non-blocking reads, intentionally: -sk_err, 0 on peer shutdown
>and the not-connected result now come before -EAGAIN, as on the native
>recvmsg path. I'll say so in the commit message.

Yes, please.

>
>> >+            if (signal_pending(current)) {
>> >+                    ret = sock_intr_errno(timeo);
>> >+                    break;
>> >+            }
>>
>> Why? Should be a separate patch?
>
>No, the loop needs it: with a pending signal wait_woken() returns at
>once, so without the check the loop spins until SO_RCVTIMEO expires, or
>forever if none is set. I checked it by removing the check: a signalled
>reader without SO_RCVTIMEO never returned and used a full CPU. The
>native path does the same.

Okay, please explain this in the commit description or in a comment on 
top of that check.

>
>> >+            if (data < 0) {
>>
>> Why not data <= 0  and void the other if?
>
>Right, will do in v4.
>
>Thanks,
>Jerome
>
>

