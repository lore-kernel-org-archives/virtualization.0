Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14867E60
	for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692345; cv=none; b=TTnrhalD7MGDuDjzX2olModn+uBYzvTp+CTb8GQxd/ltIfZXmY4+GRmS1siydul40uePwYb6ZwohMGM3HNE6krUlsS0VAZIowcySw2jshjQ8Vwmh4TFoHkc5mH9Peh7FRwJCRBeyAePTeCiBJ8IjF5yTnzkHTj/K1aqgy+zFBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692345; c=relaxed/simple;
	bh=F+LXEdvariXw6k3eT3r4qbtwZoi+V/LnKUO9+lO8CbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z43rVwlsDM4Aw9Gv57lOKTqw+N2Iyz0L30BxRKEyFyw35McK7gLBNKYPuIyQNFQRQsMM82muRwwmAA/czvrC1W5ublGBLmwJqbQ8HIb9WSXBnvp6yd5lqkd/B7IundubpdiK1mDIBVzZu+Fnrj23vCzJDUBbyfNOPRtbD/lXgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P85JyqGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P85JyqGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
	b=P85JyqGO18V/9vsqEqCm/9ejvbQdIHCQJSBKRW3ZRgonG2DHOWk4IHAg8AzvoHhjfeCFLe
	kfBcBPbpUXAIPKowmIrY8ww/PF0gGFBEWS9ODtN/XC/bVHS2uhx/vft2qS3gh2rW8U94VO
	hmNCFTcozZEfggsdNOjRhwl8FhBkpU0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-WSSV8NPTODiitoEYhviveA-1; Wed, 31 Jan 2024 04:12:20 -0500
X-MC-Unique: WSSV8NPTODiitoEYhviveA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6dd65194396so799177b3a.0
        for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 01:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692339; x=1707297139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ+jKTMQJGFtJxaVD3p8fA3naqwcYxXT6QmKNrH4jT4=;
        b=qa3Wr2aoBRv2aKUjTzcrNJ4hPctfDBz/EMo0brCGNe9qnl2rEcPv97y5kwt63ur3YP
         oEPa8tKHkkwgBNZeKZxmO0h+BgTrvUNOutF4R2n3BMbVUrFSOjRIY3NHIJkVnViQjHnj
         R+7GpUR5TWPF/T/O+esJsw4xtmWghVLfeEIu+cxwB2B+yB81q6o1eCKUh3bW4dX39MR7
         vs0TIQlScKjKCRurtCOxBV9vhnHolE5G4BQT0CzdWX8lHOHlEg1kndDLR7JAIoq9qnHf
         D29i1KsRQTvekwkOXdlO5M3tWno04gwgVb5RM2LOM8wOAonx6hmnXBUcpphFcJp8k6O8
         HQkg==
X-Gm-Message-State: AOJu0YwEVMOBDfZqpUdaYTcAGQ/x9IdtCY32PtYx72R4yV5MNDWSyafz
	Re+zmGJK8nMf/V8FEZmUCZPd8rfPyT3tvVg7+AyKQOK6vX0d7iqLrKmO44KpYIAYG/VyBTD3Z9b
	2SIfuzMNs3nIY4eIr1S8BabLjT1V+Lk5gozMRX5Q65Y7Eb2jHQ3C0G0FeLogKZRD0TPreXMK33b
	WcZ2K769hG3u2hMR+byPZmgjmcjxt+UCraTZY438U=
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id mj23-20020a056a209c9700b0019c93eeb0admr1177501pzb.31.1706692339192;
        Wed, 31 Jan 2024 01:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmM479Cl5hy9Rh2S2MeFkPZK97XeCIQ/W+WuJDw6bc/3YGrYz5ABB3TPxpsK6OFnyn5gpDGlLKohRyPGIa5F4=
X-Received: by 2002:a05:6a20:9c97:b0:19c:93ee:b0ad with SMTP id
 mj23-20020a056a209c9700b0019c93eeb0admr1177464pzb.31.1706692338808; Wed, 31
 Jan 2024 01:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:07 +0800
Message-ID: <CACGkMEsi4B7Rz7Uu-3sTEH=9XRBRDmNSacZkVt6zxaC-FbYqhg@mail.gmail.com>
Subject: Re: [PATCH vhost 01/17] virtio_ring: introduce vring_need_unmap_buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> To make the code readable, introduce vring_need_unmap_buffer() to
> replace do_unmap.
>
>    use_dma_api premapped -> vring_need_unmap_buffer()
> 1. false       false        false
> 2. true        false        true
> 3. true        true         false
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

