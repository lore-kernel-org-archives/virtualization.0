Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2616204C17
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166944; cv=none; b=LDdJl1UuxfQwzszhNdldgek8HdeOvUwCasKFsszfCm1nQYE5rOMRTcDameCn/BTd2Y2Fd5Fit1evCz0IW5yTjscWyc72b8yFLHXAzt5ripC5NN7zsKtugDXoqSJUM6/cDYcog0DUKagJcfVaofL4DhpO8ShvKJk6RJH1YYJwe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166944; c=relaxed/simple;
	bh=3RyfPyCJa/tpuKGOY4+lgz/0CKbtUzXOOAWxjU4A/sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dt7OsgjWPBKMbcLmGypE+pB26Wd+bxBOG+TiTnXrJ97aBGb+AKCL22a7RvVqqOoH6RxAptOVJWpj25SifZP9ZleiNzJNNuTovTfDcD/Zz/2zg4XS2aoxh/6eHPyDXBTlqTtp4siG6t9SY8WCCF/+oNYPdeCA74+oKNqPOL5eogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB6IJb1U; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB6IJb1U"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7135660F2A
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqQzovx-PNfc for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 09:29:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6269E60605
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6269E60605
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OB6IJb1U
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6269E60605
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741166938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FTeYQGmJeU97hLjZUQj6XASwjS9zaIwc0VW0y5NqZ+Y=;
	b=OB6IJb1UsIomAElJUvTPu3O9/bO+Gu5CH33NTxPdwUU79HrJJbEWiRwd9saOrkuBVLawHL
	yrNRZaMMS9dNGFPM/oRiV9L07/0qqcmQ+GmOsFsX+V8WGOkmwDwpoy5dNHnoGUqPENHvaD
	JckSr/jw1llz0OrSgYqEt5T/81H/aSg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-b8gm3nl5PRSBrVQdK7uh1Q-1; Wed, 05 Mar 2025 04:28:55 -0500
X-MC-Unique: b8gm3nl5PRSBrVQdK7uh1Q-1
X-Mimecast-MFC-AGG-ID: b8gm3nl5PRSBrVQdK7uh1Q_1741166934
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390ddb832e6so3182040f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 01:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741166934; x=1741771734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTeYQGmJeU97hLjZUQj6XASwjS9zaIwc0VW0y5NqZ+Y=;
        b=DdR+7nNK7/UH2mWxLvxFUMnl6QMh3rzg/zyZOtTAmHJq3/uD6rpdXtbT2CW/+bLnjF
         n5WfNpodGr6Hf5eVF6e/oedEdh1liB/peJol1TkYmJX/VLq2TJmZzUN0cr/bHJdzi3Bq
         O+9qB57sY+ipxFirIM5nA1PoLfMFIoNi/Zb1zan/QQfaxWkX/tBvJ7AF+pkaVKZ+oMZM
         K9e2XEm7YUHvkTj65tD4Fp7PN4q8uv+a2xzoRXO8qGgo5IaDWhdE1VxT5LizFApuBp6U
         7CNC/+CaFyHycRR8HVspfZDiAuFWsm65nIw/tb0CvGl6iuKopPWCOMBhryN7JWI7/+ZX
         m0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsVGPmBW5sAihJWEAd6uy/adSLO4aFZOtWINTh7E/K06ciQMcnx2P5vyyTNu/+jAsjo+h2U7LXvJClSL5cuw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyB8yUIYPmOCJWG6ghmzFY1eB2TY9TV4iBgcGOmu8W6vWFsEvUz
	ozkqrZOkOgIXSCgW5Qq27NRJDeDNPl6ZZzMiA20YQAoTLb+7hSbfJBc8foVLApIoAOD53H3OjCO
	X40lCOTHYgRFYyEmJtvuxgGzgq0STdU+Yfs/DEkzobs1I91viuV2XGiyWx8S0RNDYr24UiOFb+3
	8a5+0=
X-Gm-Gg: ASbGnctpxVNYJbBLZ9iMVFPiN4p+QqwFiTEcGuHMk7RDbFQQDP0tabKcbKwqGrx97B+
	1JyAYzcYNummi2z9QvCqZ6UrpL7F2lyDARwoMugJfr0S7dRQWDu2o9QbztWUgVuOrisf9AbECQv
	8ORxaYm5i7vjY6IGAJm2HG7GQRf3kLa6PrDu9lZjD+8v4uUBt2ds0Q8ahu97q/wNZpvBnYmWcQE
	COpvu0RsMwdMpRpBK0JzWjiuxmy6JEBFO6vaBtwoLyiIBaBgaQ5AatZCVnHP9uievkcLRALbZ6y
	oAM7TD/tlg==
X-Received: by 2002:a5d:64a2:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3911f741aa8mr1774264f8f.24.1741166934463;
        Wed, 05 Mar 2025 01:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqbiZg1q9NO5z1obiHx6s5lNrsAIzRTkNZH2/z7S8MpItFePV0q3Z90uV+qtbX8GSklxWg6Q==
X-Received: by 2002:a5d:64a2:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3911f741aa8mr1774238f8f.24.1741166934111;
        Wed, 05 Mar 2025 01:28:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c5b33sm12002165e9.22.2025.03.05.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:28:53 -0800 (PST)
Date: Wed, 5 Mar 2025 04:28:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20250305042757-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org>
 <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HLflWXF0zDPYg_xdiJVRk3dZDk774gfp7Jjtxt5yM8w_1741166934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2025 at 10:23:08AM +0100, Stefano Garzarella wrote:
> On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> > > This patch adds a check of the "net" assigned to a socket during
> > > the vsock_find_bound_socket() and vsock_find_connected_socket()
> > > to support network namespace, allowing to share the same address
> > > (cid, port) across different network namespaces.
> > >
> > > This patch adds 'netns' module param to enable this new feature
> > > (disabled by default), because it changes vsock's behavior with
> > > network namespaces and could break existing applications.
> > > G2H transports will use the default network namepsace (init_net).
> > > H2G transports can use different network namespace for different
> > > VMs.
> >
> >
> > I'm not sure I understand the usecase. Can you explain a bit more,
> > please?
> 
> It's been five years, but I'm trying!
> We are tracking this RFE here [1].
> 
> I also add Jakub in the thread with who I discussed last year a possible 
> restart of this effort, he could add more use cases.
> 
> The problem with vsock, host-side, currently is that if you launch a VM 
> with a virtio-vsock device (using vhost) inside a container (e.g., 
> Kata), so inside a network namespace, it is reachable from any other 
> container, whereas they would like some isolation. Also the CID is 
> shared among all, while they would like to reuse the same CID in 
> different namespaces.
> 
> This has been partially solved with vhost-user-vsock, but it is 
> inconvenient to use sometimes because of the hybrid-vsock problem 
> (host-side vsock is remapped to AF_UNIX).
> 
> Something from the cover letter of the series [2]:
> 
>   As we partially discussed in the multi-transport proposal, it could
>   be nice to support network namespace in vsock to reach the following
>   goals:
>   - isolate host applications from guest applications using the same ports
>     with CID_ANY
>   - assign the same CID of VMs running in different network namespaces
>   - partition VMs between VMMs or at finer granularity
> 
> Thanks,
> Stefano
> 
> [1] https://gitlab.com/vsock/vsock/-/issues/2
> [2] https://lore.kernel.org/virtualization/20200116172428.311437-1-sgarzare@redhat.com/


Ok so, host side. I get it. And the problem with your patches is that
they affect the guest side. Fix that, basically.

-- 
MST

