Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5B5227
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896792; cv=none; b=YuPzZIsvbfARqms85447F8dafNEy+89/EUbXmRshNI1I9m717rf1PEv3XhLBxTHD5C/62+oro+NkSHMXKrHsiBjHi8pL+dYETSGfHyiG8/NfTv6+WU5Qxj8IEf7QZhRWvaZOSArJk1k/70vsacNjCpFOdjv3s0vjse32gnw9dZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896792; c=relaxed/simple;
	bh=od+8DOkUnVAgYBK9LoM9tr2QwuVYSslesQSRWHme8E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNxbNVpNAE6RsyEbNlhAuDPqqfkDvTwRjKaXow/nxs6pMRwquBgvy66TKm1QcfBAGEOyFpfyuEJoiY+lr5c2KFGMbXbEClEENqJADYMYOePImI6zfXAws8LRo/ZXDd9TCPC486imiLWsJQePFyuLNP/CElddtPG+rjWh+wAD7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ealvJ81/; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ealvJ81/"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7A9882046
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7A9882046
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ealvJ81/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OI3T9MF3r58H
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 04:13:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A19D82034
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:13:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A19D82034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705896788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFYZB1OK0jELPTabxPuV0ZEWUgH0u/k7Ra6Xc9f/czc=;
	b=ealvJ81/IM6XUWpBAyPaEP/E25aRvREZad+Ewghap7ghZrj/8/KmrH0h8IBhmnqsysFBZp
	s3sSif/8eBfbOGwQkEuNvb/lW/OzTqzwtZ4FUxruIhVlBjDMI61/0FcBcvjLdIAdRDDRYq
	3Qp8NYbK1s8swqo24Pnm/c+kOnywlOc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-J3yrWP3JN3GNeFx5v0iBRQ-1; Sun, 21 Jan 2024 23:13:06 -0500
X-MC-Unique: J3yrWP3JN3GNeFx5v0iBRQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9b6701404so3006302b3a.2
        for <virtualization@lists.linux-foundation.org>; Sun, 21 Jan 2024 20:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896785; x=1706501585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFYZB1OK0jELPTabxPuV0ZEWUgH0u/k7Ra6Xc9f/czc=;
        b=gCYOJpOpAoRYf37nuspXny3FDxogAQrvVfn/QgMC1kgmryGkRAL031am4l+GVQaKdy
         RPcBFOUY9McwVBWHmkAhdXgruEm/8cZ7DMCcwQ+PDVNtBQWAaxExZoynsCBTBmvyzKxq
         K2fvN+vA92uAvjR1L1P5ZYrGrlg9KePZgSTcXZrk0RH14r6z6YB9RVqOhSIumd1cmmMc
         o8FBJq+X8ItowfYUeAimNi7B55/ZWT96t+2D8+7IA25XQM/PSaJ2Cl7rRJncqvMGJ24f
         2kycKkbH3ssFo/b/KuCl5wh/+qiTVtnWuyJ8R0X6a7h7tdK8eJgUWg9VaAo0IicZNdzZ
         CE3g==
X-Gm-Message-State: AOJu0YxNSHqU4aQ0JTNxYd2IYBUsuqG89HhN213UG0MIp9RQ7jwgou3X
	H5L2g8+LAcK8pc+U44IBd29QMWdHTOaqBbyn/Ei9LQCPLqMlljzxcYphjHpoiki0uUKoaDpSUzJ
	2u9w7aBihjSWjd6lmkxRhO8d14omF8PAm1B5I8pkHrEor+yDSpegTj3dM4q/gmqAhm5KT+BzZi5
	x7BwkLSSOJpExRNw+jBeAd5Ooqk2nRboET81WL0HOWEvoCUEfw4JrJ3Q==
X-Received: by 2002:a05:6a00:cca:b0:6db:dd0e:8d6c with SMTP id b10-20020a056a000cca00b006dbdd0e8d6cmr2338377pfv.50.1705896785539;
        Sun, 21 Jan 2024 20:13:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw6L7G8t4oEO9wMWCBYZqdoa5n5KMgma3CQ7su1LP6qvgNWE1mvqDtNGJ2VEeIUfZzPuoLjHMkocgktDrNNwA=
X-Received: by 2002:a05:6a00:cca:b0:6db:dd0e:8d6c with SMTP id
 b10-20020a056a000cca00b006dbdd0e8d6cmr2338366pfv.50.1705896785313; Sun, 21
 Jan 2024 20:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:12:54 +0800
Message-ID: <CACGkMEsSjtkYk3++aqmPxrivrDzyGxNumiancRxAfY=7D3SsiA@mail.gmail.com>
Subject: Re: [PATCH V1] vdpa_sim: reset must not run
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:23=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> vdpasim_do_reset sets running to true, which is wrong, as it allows
> vdpasim_kick_vq to post work requests before the device has been
> configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
> is set.
>
> Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

