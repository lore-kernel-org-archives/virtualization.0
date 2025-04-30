Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5725D553
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021048; cv=none; b=O4p3PRzP+AlFrAHXXY+IOP3iCF9tmyFkz9esNP9PnhGuynuCa2lVUG2ZZXK9+kIOwUAl9gp/S4fE2mxdNifrZBN5YmXwI+PT2MkVPaLtHmmHPifTYBQ4c6HzuqPRum/kIkGHy2xpNHTXtimoHXT9eE+SMtpeIpOSXVYFT700QuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021048; c=relaxed/simple;
	bh=XkIQo7LPf5Ok9RWGc7zcJBFMi0NL+uFcvQctnQlXXsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GsyMhgE+frM52bPtPRc5BbcEkqK4wpsN5dRRkmrCyFq1GT87P3p4HS6K0oVu0Guq0iMRAAJMVr+Rkp3zGiPMGykKmSCO0xNESd4on9WYjVjZGnoyJX2HO+AzqdRx6KUWYocEP3gHtlo3jSQdAUCcM7Mw3b8roCVqPr+dI1Pccfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gl2v0wFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gl2v0wFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746021044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtvDQU7c0DbWPgBlbfWVJ21g70tkL57uEZ0WOXCqKjE=;
	b=Gl2v0wFemrgjL10u4IGP79x5N5gf+Wflg8XkupA1C6trbconM3fJEvX/ne4ZYfyO9gRRHe
	9cTx+S+9WKp8ryc/ZFyw9lLRurMrXqhU22mu8fjEkAuSqe2NlJ0SxqsguUa3IeUfYQr0o5
	YqFcH0I43R93R4iRJUCbsA3cMkkWv9U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-VTP8CfbANeSvcY0r_buUNg-1; Wed, 30 Apr 2025 09:50:43 -0400
X-MC-Unique: VTP8CfbANeSvcY0r_buUNg-1
X-Mimecast-MFC-AGG-ID: VTP8CfbANeSvcY0r_buUNg_1746021042
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb90bccc16so516334866b.3
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 06:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746021042; x=1746625842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtvDQU7c0DbWPgBlbfWVJ21g70tkL57uEZ0WOXCqKjE=;
        b=RI6WH0snrTaT7djfcZzKzrRSx263XRH+B1KguQbVDLfenD4t4Ph7yPTIXFQ5BzXZRG
         XFZ53W9HV/W0TdHFv7ZQMK5TnUyFd5zkpPQn7CkGK5Y+YJsrOE7ffnw6Y6e9T34VAtx0
         FYoVZ261d33qj3nhY4j8OVfxmtOiHh2cbY2MKlgts6rvriyS4c2QHqwdCUeprTqApqgi
         Q6IlYQwyjvyoQB8FyGPxQT5N0SiN86CkwSMhiZo+LSwN0Ex8cnItw8Qr041wqLCcjZb7
         Y+vuADeYoHGYgYepd4vy8klyWo/pl0sv5QDJj1NX87Yp2U3shzNCrIttbNLtVciewK3D
         c52Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2o+ChiMAe4zXzhaB6GjP4IT2ViHMdsIw9CS1JnBAiIqRQjZU//IS9iMke4aTw+R+6+UN7fwdY/rQeIADow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+G1iXTt7UY/JpKBODAV9Ky7qfYCgJqxsErKrCy+1csFdCOTOs
	2EzXvRoDLtdNNQ+mNuIGuE1pcsZq4TXxHCS46/rX0IzrakEbl1pvC7A0q+O8FX093WgrLix/iA6
	ksVBHnq4U5gFMcJ4b1XRw8+FOKD/pyKHMeXu1slD/d3Tc36KhyI4k7Vksr1LWrniC
X-Gm-Gg: ASbGnctoXITdAwuqIF5ZuAByToRwxk0Y+kN0d3MFwSkOGaBjTYjttNRvvesQCmMUQFt
	670kGFuPvUiD5HSlFU4EMUX3U5s2UkRrpTflnCjkvCRpsmBSQFS6hkbghtGju6rSKKBHatCr1bG
	ZcZB8azoPFfIcnOKOGQjC8B1iS9pksTyj+sRNjtGDFSWnl8c7Dep15pkYhSQQObXZ5RYpc/4QCH
	mMsl8ebeoLPI0myvLNoXgEpcwsMFpgyVdwdrHe0tW2b9njho+JfTNks2q3EcePogI44g7AUxKA6
	F3q1Bbui3CCOVyZPeA==
X-Received: by 2002:a17:907:9408:b0:acb:baff:fd5f with SMTP id a640c23a62f3a-acee21e5fdamr268768466b.35.1746021042166;
        Wed, 30 Apr 2025 06:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjmc4F5C0ScUDooY60QYw9aKFDqWQU9lPIHKeft/Gghe0ofd5YKvvbBWiYfVKu3t+CO5GkTQ==
X-Received: by 2002:a17:907:9408:b0:acb:baff:fd5f with SMTP id a640c23a62f3a-acee21e5fdamr268763966b.35.1746021041545;
        Wed, 30 Apr 2025 06:50:41 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec5d0d74esm277482766b.117.2025.04.30.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 06:50:40 -0700 (PDT)
Date: Wed, 30 Apr 2025 15:50:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: Move lingering logic to af_vsock
 core
Message-ID: <t4ltq5zni4x7ahcntnhjeyzaj5hxciqzto3t6ubjfn2klb5ici@zhhlqjw33lie>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>
 <oo5tmbu7okyqojwxt4xked4jvq6jqydrddowspz3p66nsjzajt@36mxuduci4am>
 <fa71ef5e-7603-4241-bfd3-7aa7b5ea8945@rbox.co>
 <CAGxU2F62CTUKVjuG9Fjo29E6uopVzOK8zgr+HwooqMr4V_RvLQ@mail.gmail.com>
 <f1943412-ccbf-4913-a5c5-818f0f586db1@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f1943412-ccbf-4913-a5c5-818f0f586db1@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w0OKUVbc7GVYe-ZHccs-dDcWbmubCfrZW9TVlxu3cks_1746021042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 30, 2025 at 01:11:48PM +0200, Michal Luczaj wrote:
>On 4/30/25 12:37, Stefano Garzarella wrote:
>> On Wed, 30 Apr 2025 at 12:33, Michal Luczaj <mhal@rbox.co> wrote:
>>>
>>> On 4/30/25 11:36, Stefano Garzarella wrote:
>>>> On Wed, Apr 30, 2025 at 11:10:29AM +0200, Michal Luczaj wrote:
>>>>> Lingering should be transport-independent in the long run. In preparation
>>>>> for supporting other transports, as well the linger on shutdown(), move
>>>>> code to core.
>>>>>
>>>>> Guard against an unimplemented vsock_transport::unsent_bytes() callback.
>>>>>
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>> ---
>>>>> include/net/af_vsock.h                  |  1 +
>>>>> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
>>>>> net/vmw_vsock/virtio_transport_common.c | 23 +----------------------
>>>>> 3 files changed, 27 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>>>> index 9e85424c834353d016a527070dd62e15ff3bfce1..bd8b88d70423051dd05fc445fe37971af631ba03 100644
>>>>> --- a/include/net/af_vsock.h
>>>>> +++ b/include/net/af_vsock.h
>>>>> @@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
>>>>>                                   void (*fn)(struct sock *sk));
>>>>> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
>>>>> bool vsock_find_cid(unsigned int cid);
>>>>> +void vsock_linger(struct sock *sk, long timeout);
>>>>>
>>>>> /**** TAP ****/
>>>>>
>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>> index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..946b37de679a0e68b84cd982a3af2a959c60ee57 100644
>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>> @@ -1013,6 +1013,31 @@ static int vsock_getname(struct socket *sock,
>>>>>      return err;
>>>>> }
>>>>>
>>>>> +void vsock_linger(struct sock *sk, long timeout)
>>>>> +{
>>>>> +    DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>>>> +    ssize_t (*unsent)(struct vsock_sock *vsk);
>>>>> +    struct vsock_sock *vsk = vsock_sk(sk);
>>>>> +
>>>>> +    if (!timeout)
>>>>> +            return;
>>>>> +
>>>>> +    /* unsent_bytes() may be unimplemented. */
>>>>> +    unsent = vsk->transport->unsent_bytes;
>>>>> +    if (!unsent)
>>>>> +            return;
>>>>> +
>>>>> +    add_wait_queue(sk_sleep(sk), &wait);
>>>>> +
>>>>> +    do {
>>>>> +            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>>>>> +                    break;
>>>>> +    } while (!signal_pending(current) && timeout);
>>>>> +
>>>>> +    remove_wait_queue(sk_sleep(sk), &wait);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(vsock_linger);
>>>>> +
>>>>> static int vsock_shutdown(struct socket *sock, int mode)
>>>>> {
>>>>>      int err;
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>> index 4425802c5d718f65aaea425ea35886ad64e2fe6e..9230b8358ef2ac1f6e72a5961bae39f9093c8884 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -1192,27 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
>>>>>      vsock_remove_sock(vsk);
>>>>> }
>>>>>
>>>>> -static void virtio_transport_wait_close(struct sock *sk, long timeout)
>>>>> -{
>>>>> -    DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>>>> -    ssize_t (*unsent)(struct vsock_sock *vsk);
>>>>> -    struct vsock_sock *vsk = vsock_sk(sk);
>>>>> -
>>>>> -    if (!timeout)
>>>>> -            return;
>>>>> -
>>>>> -    unsent = vsk->transport->unsent_bytes;
>>>>> -
>>>>> -    add_wait_queue(sk_sleep(sk), &wait);
>>>>> -
>>>>> -    do {
>>>>> -            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>>>>> -                    break;
>>>>> -    } while (!signal_pending(current) && timeout);
>>>>> -
>>>>> -    remove_wait_queue(sk_sleep(sk), &wait);
>>>>> -}
>>>>> -
>>>>> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>>>>>                                             bool cancel_timeout)
>>>>> {
>>>>> @@ -1283,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
>>>>>              (void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>>>>>
>>>>>      if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>>>>> -            virtio_transport_wait_close(sk, sk->sk_lingertime);
>>>>> +            vsock_linger(sk, sk->sk_lingertime);
>>>>
>>>> Ah, I'd also move the check in that function, I mean:
>>>>
>>>> void vsock_linger(struct sock *sk) {
>>>>       ...
>>>>       if (!sock_flag(sk, SOCK_LINGER) || (current->flags & PF_EXITING))
>>>>               return;
>>>>
>>>>       ...
>>>> }
>>>
>>> One note: if we ever use vsock_linger() in vsock_shutdown(), the PF_EXITING
>>> condition would be unnecessary checked for that caller, right?
>>
>> Right, for shutdown it should always be false, so maybe better to keep
>> the check in the caller.
>
>Or split it? Check `!sock_flag(sk, SOCK_LINGER) || !timeout` in
>vsock_linger() and defer `!(flags & PF_EXITING)` to whoever does the socket
>release?
>

Yep, this is also fine with me!

Stefano

