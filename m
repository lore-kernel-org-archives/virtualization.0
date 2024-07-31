Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7218638
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396057; cv=none; b=enQJf1NgG7/9/+EXCmTkTGq0JG/dYp3LK2P5wZRNjjBcGkQutRST9uw8Lkf1ZdnuzrXzzqEmKy+xHe4WUy5dBjZb4GPk6Kt9KmW9ZzjKuklWu169RXquFgJRhFQy9kLPpHrlzDvXy9QdAqjKMLPu0huCgspX1HmFqquAboxZbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396057; c=relaxed/simple;
	bh=2pK8gm6ZVpEeA1ly3iczVmymWCxm8XAdJ3C8puJvIlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5mw+VlwNb4V/hGZ2k+o/oYO3KRjApSLl69UaXnUf1IEDSPFBhgvMxmrGz3za0T/WphSA4ff6Rm1vDmf5niFmNvsyBgUwtDmVXjun1YumqVw+YeC35JBzV+QHyIxjUmnm0vQiJXkmhiZYAXPGtYzjaoWZsToSjMsQW5rLfwS9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+L5IZGt; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+L5IZGt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F22B60A76
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hwWBZTANeoQ4 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Jul 2024 03:20:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B93EB605A9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B93EB605A9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f+L5IZGt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B93EB605A9
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722396053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU6UZtmb7nqWjCNh35gVT9eXpDgbdzROuHvxgQjoBAA=;
	b=f+L5IZGtZvHaOv5BqDIFHLIWxxRVZ546G5FPanSCsxuChzCQ0x+hD8PYOp8s9cyPrKg2xG
	UQPS80fNeClfSFcwc0uIVUay8HjL/EknHWIyJjm5qBxeUux/PgYOFwh0PU3iPIbB2B9/oX
	J2dU28tca8/yDLvOGFpfUgoB/N0gFEI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-lcfY31olN22RjLKDoEqE_A-1; Tue, 30 Jul 2024 23:20:51 -0400
X-MC-Unique: lcfY31olN22RjLKDoEqE_A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb68c23a00so542639a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 20:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396050; x=1723000850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU6UZtmb7nqWjCNh35gVT9eXpDgbdzROuHvxgQjoBAA=;
        b=wVtoPdT80qzUspfKYRx3/gSo3mOn8vVopJHrNjhlE9n8eH74wWSFraY31dpEQGyBov
         r9XDZaZtMpJmpjwMjrnuQajdyiGegL62+wojDnDuQI0HD7zaOOW1CD+hCAEqHM5Rinpw
         qYyAAuYwQzsBvBxhiIojDsN3+e15MbljKxiLgIWdEyUipR2JltccSvkLXgk5k4Hy+iGq
         IV+0F+ft3dWCJAXSM20OhRToRLCDPq8Yg5rQOqR8P4wjMg2RqDKVCRSPA9ZMghND84ir
         44qBR4UevabMsVbCX1SqYClBJraE0yRdIdouGl2XlUmrxe8zLv5rJu33GHX2CxtC3Be4
         rjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV14hbUftqm4kIYcfn7/5PYM/26aNbxZd4uvmVpIGn0asvoiZgpVK7GKqGKDgeHNmdIxoaeKNJh5toA+s+xIB8rwExcP7IVTX6UMP0sAM3H1ISU84jjKZWXxg==
X-Gm-Message-State: AOJu0YwOgZJq1MEluzIhldcrsM5GsO4LOPG4PWvrFScbdjaqwBi4H67f
	2K5h/G0xjsu6w2uHb23RcbEh8RfZITGM6w/GOsMctXxsqOR5eJsWAJMeS27YaTBo9ZFco+qjj61
	ioSXf9UGx2gDLXqFiauvgG5FSkeg6BVzKEiUXrDiyrWosxVFDas/8GNHuN3KBcXehwsZO0xDVAV
	FIYne47kCKAx+Jtfk+EVdM3k/mLl9YJTZQwTiClCt4qfj9acxzLngwTg==
X-Received: by 2002:a17:90a:558b:b0:2c7:d24b:57f with SMTP id 98e67ed59e1d1-2cfcabb4428mr6355874a91.19.1722396050567;
        Tue, 30 Jul 2024 20:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdikMPaOaei1HHj0OApex9jIV+xfMGVWj4qGTkYxBDHCya8v0ooI5txmdfclcFYjj3oMf8dl8KVIItDPVvzbI=
X-Received: by 2002:a17:90a:558b:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cfcabb4428mr6355848a91.19.1722396050017; Tue, 30 Jul 2024
 20:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731031653.1047692-1-lulu@redhat.com> <20240731031653.1047692-2-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:20:38 +0800
Message-ID: <CACGkMEs+bpWtpFp2hT+GrRUOJQq4h=2LgKWj+U4tM9a9wMQpDg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
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
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

