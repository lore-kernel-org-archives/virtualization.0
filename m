Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B335957
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Mar 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257770; cv=none; b=joxc2zieKobWlQa0omBOS/KHQnTBEUrZJWfunNEdj3FEEr77u7JwStp9WijHHK8uBB/Rah5sxJVd+NYrSbLuistAAMjd2NqhkqvbbHjhNrtS9knfvmSYLzXyZiiJHOhylUGTCis657wM2d0Z5ZsYxoH8TRKEAzcbhqySiRcai8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257770; c=relaxed/simple;
	bh=Iq6VTTpZ7kMw4sehGuzpV0DZTLHk3gC3ZjUxf5EpShY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgNi/Ww6aW2R/OaWD6K957zrUnvLP3vzQJ9IJpYzAwBoEafpwm98yV5+fQRxjaqJEe4rnjl1I4Y3bK/dvkeDkGuSbb7l/MY8QWrNVS511PC4EnlcFrAam0nn9iXWUGdY4mfhjvsH3dQTw+pjr/TMR/DQUHLWAawfF8c9d2Kvufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Se7yO4wP; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se7yO4wP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8A1D40679
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Mar 2025 00:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RiJkk6Vbp9d7 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Mar 2025 00:29:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4D3524066E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D3524066E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Se7yO4wP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D3524066E
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Mar 2025 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742257765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGlyUD8vqNUb+95XWNLKTz4/ExHYTFqRQ19vbWD0q9U=;
	b=Se7yO4wP6Q86jgXj8j9GJzlj4leGqxxsZSLnykxduCBia0XGw3x6aPjFan8MTv4otyTnGb
	govatW4RAJMPD6iuYJIq6QrUINMJiV7P+3a9JhLl+2ppDi+n+vmn/F/9nKHEAGKwH8nhqv
	oCc+IGjoqC8MGgIbxLfmxB5WZd+pcjA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-8SsfFa3FMFC1B1WtGxt5_w-1; Mon, 17 Mar 2025 20:29:24 -0400
X-MC-Unique: 8SsfFa3FMFC1B1WtGxt5_w-1
X-Mimecast-MFC-AGG-ID: 8SsfFa3FMFC1B1WtGxt5_w_1742257763
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff69646218so6932609a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 17:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742257763; x=1742862563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGlyUD8vqNUb+95XWNLKTz4/ExHYTFqRQ19vbWD0q9U=;
        b=QEIXqQofZdxF96jfRf5BDU9l/byM35qPPE2tnPodufJV1QR1U1ATYD9Q2kNUMqMNEA
         at9J7+nyND/LP2Akl2UWrHz0w5pQnw+wDUAqjwMUb7BLNX6yHHNHgdR7DJ5zLVjFQYPx
         1OGNqJvwnGtUp7X0F7ya8JJs1D3UuJF70kbMdsA17J7uoxNH7qlxmAy/CGsQGdtGCcni
         rljfCEIWIkwrD8TyMalaQJe4rR4V9hAEWvt/FtuNvj1tDajoXRMA8ye0/Q6HWaBNZWfF
         MIwCUm6FQqEb1ekZft5apBdnTxjAK4qym/Jk6jQ3/U7tz/r8IPXGHEcwtVeLZbAu488O
         vYQg==
X-Forwarded-Encrypted: i=1; AJvYcCU+XwlbmUjqTEabrYKITaeTe/fSMnuxFshQb8rEFjhZudUx5LeHKazqZOZm3ozq6z9car+Udpy66toJfJ4fhQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwmlLjLvsPVRp6+8HDhWGn7dEPourpkUgjg7douUC5YKqPDDa3i
	uqBqXvWUyuQqmALBstwRyC7lo45he1f4mfF/VRpfjsxnJLSVv25wZOLDry0FuJaR0XH2CGK59J8
	pCb4sRIKWBmCJTMqYOYegPDE3ZTRiT1eToJA5aH3sKVMeKDMUwC6MqGchk7kPbkqqQ5obha9K5s
	mm+Wj7+tYpF7Kls2IwVGSVfkePGbyheVxHp14IVCLUu/QF3Ebra6vseA==
X-Gm-Gg: ASbGncvp8J77vs/6FiojORYdU6WkaWbpHIX2inuoWzs8KugM7lwtk4xT8h2FoLwuYzB
	WWPdFOPRBovjx+VtoQrkolqQ53JqRpFoZMRdzZfEMQNykuPrA5nN/9ql7MN8Pi7GkamDrBQ==
X-Received: by 2002:a17:90b:184e:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-301a5ba9e76mr360777a91.34.1742257763161;
        Mon, 17 Mar 2025 17:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOGBbCKgtLfnNUEqdVYBOyaNX4J8YQ0wrsnqj7PZlK8HAfiTPLx5TPUO4ZzYQvRfRq3UkxLbm7lMIv7cr07dk=
X-Received: by 2002:a17:90b:184e:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-301a5ba9e76mr360742a91.34.1742257762833; Mon, 17 Mar 2025
 17:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:29:09 +0800
X-Gm-Features: AQ5f1JpeJNqrDdWSKhpRoLtJXf8LNGibcE3CCqsOw8cQQUTRxkqjeK2TKIkholg
Message-ID: <CACGkMEu=pPTd-QHKRDw7noRCTu-18c7JLJNKZCEu5=BHAE0aJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 00/10] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WZHxZkNcWxU4xXJDUF3gQqSqkdaiGdfb_f7uNCuJPmw_1742257763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
>
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
>
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).
>
> The patches for QEMU to use this new feature was submitted as RFC and
> is available at:
> https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/
>
> This work was presented at LPC 2024:
> https://lpc.events/event/18/contributions/1963/
>
> V1 -> V2:
>   Changed to introduce a new BPF program type.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v11:
> - Added the missing code to free vnet_hash in patch
>   "tap: Introduce virtio-net hash feature".
> - Link to v10: https://lore.kernel.org/r/20250313-rss-v10-0-3185d73a9af0@=
daynix.com
>

We only have 2 or 3 points that need to be sorted out. Let's hold on
to the iteration until we had an agreement.

Thanks

