Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718562;
	b=D6C6PBdmPpaliq10gQA4tWYPwCk/3e4Z9KNRARw0xaiYuF+DlMRCAltW0bAnV8GK/lom
	 TgxN7z/9fsCf1OGvIAhy6gilDDIvKw+UMPxOVIMLkpUj0KRZEQnDggqFJCFxpAxOWGmHl
	 CITVEnxP7mfLh0dlP4OpPbngEGR83KRIaKOb5MuouSeL+0m35KaijJrZMLU2v1V2G9ndk
	 qh+AfpoK5O08+tgSM7+H1qQdszPzzq4WuwKL0VXOkCkLkGvEnOc+14zDgLivzAMturR7k
	 0aNshx4JSJq8ZxRhPNet1vQf54qMDsUkcExhOcmVPtVQUIRfy2m6UO6Naqt7KGCo2uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718562;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=0+i+U/dvxPucQM79FhFWJkFQ9Ju6Gdb2o1CKxuQhmCiU6VuUjTktS1GW0dn6jaU9vBeg
	 /m8O5cJbf6/RIxCW74qjOxh3HsGm4nC7tHJce5Ghzg4IezK5Vuzz2EN3yd8fbhARFCNU9
	 idTMjPrPAMbScUma43QhmoJdl0PwIl9VeGEFw78crjaJMGCHSa8HXJLE8mSsJJ769/7AD
	 jcgIhtzCpyvF3z/pC18lLA5LaMykkoJ1fgVjTn0mvWYMRLY3+n+DhVHATI9yDEOwEM+RK
	 0nkMuPnPbuq74R/APS7LBdW+U/H4WERRGEHTSOMP2yGXcGX47QBqfEUBCLiw3n5nUAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfXIfkCR;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179A606A327
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D179A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfXIfkCR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795718560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=SfXIfkCRbQzIDvKQkDcpskMHAkS7KZdmZYQKjAGSZiQiNcHl59FMBFaRoAenkPbLl9N/xB
	A4+csaOMuhqnWqvWTQ6UrD3O3hRTRw4zoX7m6aMRqb1qEzBIENGORUgzsZ1M8ef8Rl4VnL
	MlGyA5ikUQEvGhWI30vOqSvTIlg2om0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-JUxQvU5iPlWYj_agCt79qg-1; Thu, 26 Nov 2026 18:42:38 +0000
X-MC-Unique: JUxQvU5iPlWYj_agCt79qg-1
X-Mimecast-MFC-AGG-ID: JUxQvU5iPlWYj_agCt79qg_1795718558
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-92111028a03so129992816d6.0
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 10:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795718558; x=1796323358;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        b=MsA042eHj5gXlkx5WuT/XytSrB55wNps/+k08OZM2mKYXBOWBpIs46vJtlthdawgIz
         i1qi3W7cC2/e8Hzyt1QchIH13xCVv6CT2rfCDjobXBU/uuEL2LVRv9O9oLMO4cHFZc0b
         y375Et/j5RdZw0KQyhWLj1Is8m/lpNEtKYX+cMP7qimyor/suLrjnPkpIBKxRg9ikzjU
         AYWIhMwDbMZMFdXWez+0t+s1X3nAtf11A4YuFtbaCqtIuq8mq78GQWEM9e/G2K47XxQU
         L/mZU1jJdY+XSArsAtqx7+7ht/NW1wIL7HzpQfM8YaYTZpiJeXhMFcG4OGlakt1ju5ee
         h9bA==
X-Forwarded-Encrypted: i=1; AL+hErGWCasoCSVZbTLxROUcaP2Ju9DS0K8wdRz7zH2J5iTkt3Z0tLDVBAyjSZUR08m+409q0QCb9UXzpxbhUuSwIA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/wEVY8dOigm+mO2V0dIXbiA9K8cQxYnCfe2quF92Onj129dfwd
	I93Eqs8XjqjWckDzGvu5yVorPFsrgTSr7O2OHE1yTv03kcUp/7l3urnjGW65l+gV/aW5RQp8e4Z
	a7hlCNsWcmpe9Jf0EsBttLjDCz9gBA/AUefIEcbkAmGobZ8kLSXc2hpvG+umFLnEhRYGhQ2D8p9
	h5or2j5df+E6AXHGt+tU/xqDB1pbPtdVlUGnedUV/sdK0=
X-Gm-Gg: AZFdTZck6wbiuYYOxJFeRcUZ0nemM2kMLiIjN9i9SUS7/ds/x9IZ9LrU3IwYRv6UK92
	MQASlFytxsy7kkLXsndfNYLeqANCLBppSFh/X8PMj3P1GfaA/ujnkrZleRtEe/Ay+uiHIBHIeCG
	HbYT+UcszamrjQlrEIYa5kTGNDIXfqd9ObGhhmhdAHKP4APoEuPDejukM=
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id 6a1803df08f44-9217c1a5a29mr99541946d6.14.1795718558243;
        Thu, 26 Nov 2026 10:42:38 -0800 (PST)
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id
 6a1803df08f44-9217c1a5a29mr99541386d6.14.1795718557797; Thu, 26 Nov 2026
 10:42:37 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Nov 2026 10:42:36 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <awhAaTuR375RpyAE@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com> <awhAaTuR375RpyAE@sgarzare-redhat>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 10:42:36 -0800
X-Gm-Features: Aa3M54odw2FRTdRy2uflU_aL9ZEV5X35-hMgLihiDc4DudGmLOU2wiibEdItlhY
Message-ID: <CAAiTLFXT_Dqs8sUY+dL7KhXL=-QYudikb9kVFFRvGv9Ri7y7ow@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/8] vsock: add datagram support to virtio and vhost
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rccvD867JQGwNzY1ZUiUdH8HAB3U6LcT-wFg4vDruyc_1795718558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Tue, Nov 24, 2026 at 01:20:18PM +0100, Sergio Lopez wrote:
>>This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>>the existing AF_VSOCK API. It is intended for guest and host services
>>that exchange independent requests, responses, or events and need message
>>boundaries and sender addresses without a stream connection or application
>>framing.
>
> Thanks for restarting this work, I have finally found the time to took a
> quick look, sorry for the delay.
>
> Reading the cover letter, it is not clear to me the changes we are doing
> to the core and VMCI that was already supporting DGRAM. I'd like to
> understand better how the backward compatibility is handled and how VMCI
> behavior is preserved. Also reading commits, most of them just contains
> a description of what the code is doing, but they lack the reasons
> behind the changes (i.e. the why).
>
> Overall it seems the right direction, but I have some open questions
> (some of them discussed with Bobby, Stefan, and I at KVM Forum some
> weeks ago):
> - Can the virtio flow control be affected by a flood of dgrams ?
>    See https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-5720001
>    and virtio_vsock_pkt_info.reply / virtio_vsock_skb_reply(skb)
>    handling.
> - Did you test virtio transports when VMCI transport is also loaded?
>    That one is automatically loaded (for historical reasons) first time
>    AF_VSOCK socket is created, if af_vsock.ko is not loaded. So could be
>    a common scenario.
> - Any limitation of the current implementation that we will need to
>    fix/implement in next steps?
> - Any performance number?
>
>
> About patches, I started to review, but I hit a wall with patch 6. It's
> too big and really hard to review/maintain. Please split it (e.g. the
> refactoring for vsock_assign_transport can be moved out, etc.). Also
> there are too many if() with conditions duplicated and few comments on
> those conditions, for example:
>

I agree. I focused too much on quickly addressing Sashiko's feedback and
things went out of hand. I'll rework the series with a focus on
bisectability and readability.

Thanks for the review, Stefano!
Sergio.

