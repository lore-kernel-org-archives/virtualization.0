Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831E27F163
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315079; cv=none; b=RLhxYogOAGfAFLCpzjlPYvYukVpx2zgZ8REH/wMMEG+m2IZ+EyBckob+A+SD+cwlLTB4lhchU70Uj/9gBq60m2Ol/wfInZ96DGnzY1aWeR0YYobv6U9/PUAe4Mb1AeqiO0ANy1Fnwald8W4sjTxvOGc9LYWwzKrXahpU2mNBs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315079; c=relaxed/simple;
	bh=E5/n+gp4oJScjwiNqhRtlKeTPug5EnnZg1wflCdJ81E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SFcOGZZLOWG0ohAUsZSzx16w0qBKA6j754HK7zfDsCieASy3mCh5ozzPdR591gtJvHcRRVdUVMdKV8Go3vt/t15fUup0LG7B1AKuA1WeGokmsdqPNzJxgoS05aHDgwV1WxPw4E8hzmutwdHKvcW1cQzEDFv1qLKSgLS0ytwx/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRT6+bta; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRT6+bta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768315076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9LgnqaJM+XpiwDFJ8HhQp/PFSeMXCj9ObUTssbWH+C8=;
	b=QRT6+btaIpSLel4vGhgT+tTzVWk8ImcsLAiOA3b++qc28WdrQiEPS2W5f/SCpMYT/uxGyE
	sjSEtL2nJUFXn5w/8p+XW63tVDPPy7/ksOejp/jRsuUz+tioJA52TP5GjVV13JW+IdgubC
	dB52w38Mcx0mO3sPru3wit5JgsJSWMg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-E9ZSZp2pNGW95ijXTAv2pw-1; Tue, 13 Jan 2026 09:37:55 -0500
X-MC-Unique: E9ZSZp2pNGW95ijXTAv2pw-1
X-Mimecast-MFC-AGG-ID: E9ZSZp2pNGW95ijXTAv2pw_1768315074
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fb8d41acso5043309f8f.1
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 06:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315074; x=1768919874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LgnqaJM+XpiwDFJ8HhQp/PFSeMXCj9ObUTssbWH+C8=;
        b=QvzwWKHdGGa6os9tiwIquJ3IimMkFKP4dUZK2jVqxzCku1hWnb7L3sikmCiOCnNxEK
         DcDzBw5o+wOacyS5Dm3NeGFx21f23i7uKLVLkQ3tmPgcNsP84UC57u9rNNOhCwXEFtuq
         lESIufrxtvUVSUZkZV8IHBvKz/hbrPORdK2yvPjBhc2g+HTuKmWQjY3E3vlQxIv4re/w
         62UQSW/v2VRTpcMgwJ2BE3nmugOgaqHZpcLauPlDfCLMNEPBvqt4svAQqgx8rudsa5LU
         kPryz02vam4IuSHAEculBaeTDGg858td8aaWX9dwj3O+u+s6Jixa4wYM4Sh0rhbFO+KP
         nFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiZx+MC8gHkR+tr1E+WAU0oDqtix+1IzppX5OSoC3slHrrVntriLmVxrBbJKSZzdBYir7zzkZ/U0NDbat4Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTYfP/1t6juvT5czvj4zXZZn0H6Z4mBP3PPzNaIrLu83jUqWb/
	6AOAk9mqZ14/t0f+PDYCgiEYQjnWdv6bdF7FLHPNPkWfzBQYcuhD9jKCJKiNY9wh16jGYL5XEyb
	tmtA2p79OEbg+WHo5s8Kn6WeAI3X3fZfTjcFTQ1KYLvp2kb/CmSmIP2gOVDU7Yc/eXAda
X-Gm-Gg: AY/fxX4tDx9I8G6snGsepwEYpwt6lR/93dMnppCFL1aJiJoRCO2Zfp5Q3ZB/PLD4ivP
	CIUBHhtqPZOhv7Xw0j2zqxkmgoXUYfjhZaTqzL2269p20KtpnXZAHUHI7+7JcGGMx+VY0aJ+9nl
	sP8edupKCcu6YMtKVdOWeaYWyROnIWGvSB37Wase3SJ43gx65mKukIcwcJXdqnKWR0VmnfSW7vA
	nN+yDeAD+cHl7U96slxde7yT4zE31yeA/nS0wRg9vI2hKZZXHbtRHAxhoAvtyri9MhCJKvZ2+DV
	j/ML+rIFcA3zGp//hEbwkDmo2Fqs73Xa+KDWwX4nnNh0Sv5UZDTCgLRL++blu3g3il+FobhJzFa
	wLf5BHzWRS/jxayhkWxZxFrcYPzgs1MPjySqNYJKfjKhE8ywkPm8e+6CirPSTBg==
X-Received: by 2002:a05:6000:2512:b0:430:f58d:40e5 with SMTP id ffacd0b85a97d-432c374ff28mr26117945f8f.30.1768315074243;
        Tue, 13 Jan 2026 06:37:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaDijBjyQACs7Ec+s3xS5LP+GgM+l6sMs4Twqit+l71cMf1frrOWuoQfHaWNAhM1zfLnP+kg==
X-Received: by 2002:a05:6000:2512:b0:430:f58d:40e5 with SMTP id ffacd0b85a97d-432c374ff28mr26117921f8f.30.1768315073807;
        Tue, 13 Jan 2026 06:37:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm45089151f8f.15.2026.01.13.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:37:53 -0800 (PST)
Date: Tue, 13 Jan 2026 15:37:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 03/12] vsock: add netns support to virtio
 transports
Message-ID: <aWZSeBAdiVs89wz7@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-3-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260112-vsock-vmtest-v14-3-a5c332db3e2b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b--i5YQCwAeu67MactjURPe4LY3L41zSwxQeRABj7qY_1768315074
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 07:11:12PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add netns support to loopback and vhost. Keep netns disabled for
>virtio-vsock, but add necessary changes to comply with common API
>updates.
>
>This is the patch in the series when vhost-vsock namespaces actually
>come online.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v14:
>- fixed merge conflicts in drivers/vhost/vsock.c
>
>Changes in v13:
>- do not store or pass the mode around now that net->vsock.mode is
>  immutable
>- move virtio_transport_stream_allow() into virtio_transport.c
>  because virtio is the only caller now
>
>Changes in v12:
>- change seqpacket_allow() and stream_allow() to return true for
>  loopback and vhost (Stefano)
>
>Changes in v11:
>- reorder with the skb ownership patch for loopback (Stefano)
>- toggle vhost_transport_supports_local_mode() to true
>
>Changes in v10:
>- Splitting patches complicates the series with meaningless placeholder
>  values that eventually get replaced anyway, so to avoid that this
>  patch combines into one. Links to previous patches here:
>  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-3-852787a37bed@meta.com/
>  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-6-852787a37bed@meta.com/
>  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-7-852787a37bed@meta.com/
>- remove placeholder values (Stefano)
>- update comment describe net/net_mode for
>  virtio_transport_reset_no_sock()
>---
> drivers/vhost/vsock.c                   | 38 ++++++++++++++++-------
> include/linux/virtio_vsock.h            |  5 +--
> net/vmw_vsock/virtio_transport.c        | 13 ++++++--
> net/vmw_vsock/virtio_transport_common.c | 54 +++++++++++++++++++--------------
> net/vmw_vsock/vsock_loopback.c          | 14 +++++++--
> 5 files changed, 84 insertions(+), 40 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

