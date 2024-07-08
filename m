Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F3A1BC39
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422300; cv=none; b=cL2Tl0ot3LeBQre7yOnZkyJg+y6JwcVLEumxp44JZKcM07UMzBX1v+dvHDMdaC+5uW6KfflxpCEE/t+Ppyj0Sci3tNa0W7BNTr/vopzpdxv9DCPKS/mqZ2BFwVVtRQZHo3a2Ax1fP1YgE8D2y1ZLiM1zqO7Z05SHXOQuLuFrvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422300; c=relaxed/simple;
	bh=Lyh+OGU1qSqkgNUOSt3XboZ5A/fxDtSPgkO065fsa0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPiV/yK4yFJzwuQo+idlmdO6DMD5J7z4T9Mzr7dHiAF0yhMjNp3iCiQwkxRLGIFirWwBocNDydjDBZSeqVbYWanpCnjP3mP6Eo7Xi8e7MERO3GBVIePOWzikIPVlp4t71pgpI4/JSucJvv1Xot+p13AqBFblQauBqRx/jld9sfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQBk15l7; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQBk15l7"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D91E80FFF
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADCD-b4tcbJN for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 07:04:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A46B780EE2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A46B780EE2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DQBk15l7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A46B780EE2
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuevZFB7MKI/Lq5uYauYhSH0Qsz8j07xL7h/7QL0zAQ=;
	b=DQBk15l7wcsqDpKfI4wFnm0bKEB3ge33XuOrj8f0EMf/RaXLbnqy+uA1evTowMJooAvrlP
	bgSVAunfYT/W779EbDVjy+5wrz1QPtxymcqPe2WJQlBsvawYKY6DRACuimB4aPr0F/Eh4v
	NPICCztreJIGRFcgssvZNGEfCBS+xRg=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-rdULlNzVObOahZ8L9GoKVg-1; Mon, 08 Jul 2024 03:04:55 -0400
X-MC-Unique: rdULlNzVObOahZ8L9GoKVg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-8101973e274so1079226241.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 00:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422294; x=1721027094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuevZFB7MKI/Lq5uYauYhSH0Qsz8j07xL7h/7QL0zAQ=;
        b=fw3J/kSkxg3Nb24vGQxfB9QvPWLHvOXei/9huqSFVdr1LxBgqDk0+hLYdZN28KpCG1
         JrDX8TPuJIgR1JWWTTaMeBUorV2CqfYlYWw7U+/t/ZXiGo4QlxpKEp5TzUZXHFVFCM/n
         MuXkd48/CrkD+bPMyG6U7ppQmMWfOMqryQdY7xCeZv4K6a5S0aKDSF8fYtNT7cw8hnqm
         9B4K2L+M3BpM1Hc5bLokmmj502SxEc5yg7qfc9HEKEgYVMN4quSWSsvhLXSV8xgSQS1K
         BUIEmveh8KzasXStBkDeIxnRFin0k21V0ae/7LxCJ0w6kp0fW5y5FbUEbWJ9m7o1ublt
         0rVA==
X-Forwarded-Encrypted: i=1; AJvYcCVfwkivkWAlkwsmpLXIxw5JlSko7VNNMTifkiugpGzXjxkRUimvWwloYSx+TCvUd8Y1v686s9fqXecSiPMgNf9jRde0rFNPTLgz1r3dJlRZVAFy1xW8DD0+mg==
X-Gm-Message-State: AOJu0YxQW8pZqvjEtVaVawqiY0YYXs76uVcoAGcpfhIj091qejDXNxJc
	UwujU05Paw7iyJs9CVuMwAaSlyeriYODxXsiPh84z/9TRhvnCHtG6pRadtGUU2FtyDeNMoqrp5G
	juGhhlAicR2mJig4XN/VvIcMh5eTrI2MXdZZVgoxTUlJHqOV3L4g6F428btwrmRgbe6jAKGof1+
	D5UWsKNIvtRrQYaB7im5Ovo8N1KGMdQMj11qBVQ7akyxYhqKNNG5FcgQ==
X-Received: by 2002:a67:fd99:0:b0:48c:376f:fbfe with SMTP id ada2fe7eead31-48fee6dcb3cmr8108040137.14.1720422294483;
        Mon, 08 Jul 2024 00:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNBSM7bOK3sbqftf/T7VmMO3M7PHhmrjnMZg1tK5qooR3N3OIZ0nrg5Mz/+IAvFBjtZftOxhqa1SVHpbqFvk=
X-Received: by 2002:a67:fd99:0:b0:48c:376f:fbfe with SMTP id
 ada2fe7eead31-48fee6dcb3cmr8108021137.14.1720422294089; Mon, 08 Jul 2024
 00:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-2-lulu@redhat.com>
In-Reply-To: <20240708064820.88955-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:04:35 +0800
Message-ID: <CACGkMEvm59kNPvivACZt8mAZsZyp7O7FO5NUF6abB9XS_SwaEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> new MAC address from the vdpa tool and then set it to the device.
>
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
> Here is example:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
>
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

