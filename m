Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A62FDC53
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416476; cv=none; b=exCQsZwuKDRBVIzpCLNu1rhUehmCx1hmT8TqIRCrksuWQKBwFBwYzF0qJTP7TlJ78z/Zrzk5eki5BwHgYLuEIqxBSs0Yz6cRc/n4mpa3K6Bc34qi/yYW2luPvW1mF0vL5MpXAv538CMVy/Gplu2X5zkzP5mbWrFEyr2eBn8bA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416476; c=relaxed/simple;
	bh=3bYECwpBfkTcXe9Xf4qgJEYNbyztdqohJjIZZ7uI0/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Oyq/zyKtMfg6pKMU2kvivwGvbNxu9v+bXMB8P/PNZadJUlSgJWSn1jjddPtCpU7TCRW9v0Jw5E2j0HcYMPfLIFE1lBnGKqxQY5uQ0WXgkKf4HZBcuOK/cq1FuRKe+iw1G0NEh6qGCr2/dJ92WW8q8norsPOieyneLDMuXqnlhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU6xEIv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU6xEIv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783416474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
	b=aU6xEIv5GCjhsSKNRdzG9RpiStMs+glGmXSjsshuXZAi2pBsxP6nRFA3TXx6lVjgeC7kcM
	lW0kbn5EJzfXk7i/edh3z6T7b8BEh15YZjYfbfxh3RKm/XmWu5sRs3ZYr+E7QevEElJWMq
	UY8JwrWyaZYj8M8fyD4ksVvvmvdMT9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-5gSpTgCBO0-vP78b6lcS-w-1; Tue, 07 Jul 2026 05:27:53 -0400
X-MC-Unique: 5gSpTgCBO0-vP78b6lcS-w-1
X-Mimecast-MFC-AGG-ID: 5gSpTgCBO0-vP78b6lcS-w_1783416472
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so40298925e9.1
        for <virtualization@lists.linux.dev>; Tue, 07 Jul 2026 02:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416472; x=1784021272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
        b=Z8H0xCdeuT61P0a2CmUzOJwUAgdOleZdOech1/c2eQ1/AVnI9YzuJUz7MUa1PaYgR+
         /2wK/ok5/MXKIPXDfyHXGuWx20eamV4pbI1/vDY74j4GIVQBGXUQcoddtj1ie6LyQxEU
         1Y4xtRj4i7e3jF+uXuYjJ/oFBa/NzosANaNHEykmlKsWSfA0Mcz5NqkNniKFxVitGCiI
         hkgsqj8VEgimg+2lslQNMMgSPC38De9GUncZ2Zo17n8W8V370JLZNty5pz/BFE5qV0St
         tpn+d904xz+edokSuXGlp0xP2oFLO4WxLkNhSqL7MzJlVUSDWlAdZs5JG7ehzfUCANIn
         +PhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrur8BIb3Syc/cXFBdRQEJqkb58GARq9uaMHbMCrdfnZ+jSs5xcVRNXo6pOLLtQTFFvorByqZZ4XSSke1zHXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6dwtMYk4DKzj9sdwmlqHTs9xZzVulWlJY5AaQMyA8aGdAvoOE
	2J54z0Hgdd9W6SlVjNLYBEqhHRkHtixw7G3Pg6HvYGPLUqGhXtN2unfNXGk93WxOSEa2tz0g+5d
	dlLjPRRurKch7q4pi2jGWMkpGZfBwjDK3R1xzDkipDijcuQ/xmHdX4LOkDIZd0cHO4NkPUMmJbO
	AY
X-Gm-Gg: AfdE7clbCD5wqDksd+Xx/JFkGRMdtedVIld5wQg1oGKlNOthiM2mw7zN+g+OfrCuC1z
	0hDmTsiP2Ubd0rl8pYs0zMw9N2sZc8KeRorgnQgL6AnaHryMH/TSQpYfDVjvcKRiDxVx8ZUuDMI
	EFD+lTu7pa9j6s6+e0CEv9/h26WPmuj1QCavztU8A+5zjboDYJiGxXAvX8H0Dh0DCr1MMgHX1dU
	fr9swxT07+mqs3Z0Gk1g0WkvMTNMgQMfIghlVRlQlrDOO5LxU8V9GBEVcgTffoFxTvOdh6LCgKJ
	DHXIkGObPG5OszE0J3JRB/oIdgUQM0NpmPW1EQtgvBirvXSaEAsYQbf/5Ok2S8U7yClLvz5t+lR
	QNID2TfLB6SGsUw6DpueOtgQ0XEnvnfzzi8S4wY1+b2Ixj19FcFCct/zBK/25
X-Received: by 2002:a05:600c:6ad0:b0:493:c2cc:aecb with SMTP id 5b1f17b1804b1-493df0a08ffmr34351455e9.38.1783416471683;
        Tue, 07 Jul 2026 02:27:51 -0700 (PDT)
X-Received: by 2002:a05:600c:6ad0:b0:493:c2cc:aecb with SMTP id 5b1f17b1804b1-493df0a08ffmr34351085e9.38.1783416471154;
        Tue, 07 Jul 2026 02:27:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm48240745e9.7.2026.07.07.02.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:27:50 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:27:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akzGUvB9g3smaXO6@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
 <akYl38_9Y4ydXuqE@sgarzare-redhat>
 <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iB8H1h0tTRYv2FOwiNUJbzj-KCZZVgBlSVKDM8q864w_1783416472
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 02, 2026 at 01:09:20PM -0700, Bobby Eshleman wrote:
>On Thu, Jul 02, 2026 at 10:56:04AM +0200, Stefano Garzarella wrote:
>> On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
>> > On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
>>
>> [...]
>>
>> > > +out:
>> > > +	if (new_skb)
>> > > +		__skb_queue_tail(&new_queue, new_skb);
>> > > +
>> > > +	skb_queue_splice(&new_queue, &vvs->rx_queue);
>> >
>> > I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
>> > when adding to rx_queue?
>>
>> IIRC we added it in the rx path, mainily for loopback to pass the ownership
>> from the tx socket to the rx socket, but here we are already in the rx path,
>> so the skb will never leave this socket.
>>
>
>Ah that's right, I stand corrected. There is no sender to leak in this
>case.
>
>> Maybe it's necessary for the eBPF path?
>
>Looking through sockmap, I don't think it depends on skb->sk being
>non-null either (it reassigns owner to the redirect socket anyway using
>skb_set_owner_r()).
>
>Sorry for the false alarm. LGTM.

Thanks for checking!

>
>Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>

I'm going to add a threashold as Paolo suggested. Do you prefer to look 
at v2 or should I carry your R-b ?

Thanks,
Stefano

