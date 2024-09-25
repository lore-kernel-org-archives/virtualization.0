Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C5148FEB
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235074; cv=none; b=Bim6gO5BP4WNeiajnvNKZ8ngEibSPIkjLjGV3EhTYc+0nXMoxa8VFjuiYD9X3j2NqBvca+oNXcH8GV4NMnBKG+EKXDEjISTLzDPz6eupAtzrTYcj3Nsl3x8j1hVlyPEYpDDyFjpeunaXZ125EpJdQGCWwlyiIllTG63aVc6y2DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235074; c=relaxed/simple;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cao7BgNVDc3epP1f+wNspUytvRLbH3STbTqT05vgXdZjHl3/SKdugyziwukv84GJ3Y2TJZbTHO0cwo/qeI3EVe9ntyPkJUP5GIC1BNe/cuzSR7QWSDbGCeokG7wlECBEt6xYKeO1zpxv2+t/0oHt2NqwmIHCbHGONfK0NeXTjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSfNEiQr; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSfNEiQr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7E2140498
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 03:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a8nHtEQehw6z for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Sep 2024 03:31:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D88C640193
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D88C640193
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gSfNEiQr
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D88C640193
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 03:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	b=gSfNEiQryX5Qntgto1tG6oWI8Yteq3asQBw9mV0khYlN/cDkXo1gOithLrHHonTnbrrbCy
	aQL16PWKNa9TQLZJCbQV+YztanCBtx+JWlIorV7USyWzhvFMH5+I1g8ZIE69cRxTKis+wP
	w8Wf+q7zw4l49h9OTQtL6/8dzH890ks=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-23cZk8eaOjSEqiH0Kn4pZw-1; Tue, 24 Sep 2024 23:31:09 -0400
X-MC-Unique: 23cZk8eaOjSEqiH0Kn4pZw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7cd7614d826so600467a12.1
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 20:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235068; x=1727839868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
        b=UI4oMPidpIzaDTY7aKnjKDw9TZdchW6Mx4fwoUTQxvj3LsxJPpYHB22PCefK/BqRMx
         +cfs7GdgK4Z8UewmeSm4dwijokx1GmSWGCh+1a+OA9afWnk/6/qUV2MYLVeqILO8oVPB
         FRtsn3kH0jbIh/Ze1S3627KvnAn0W0GzT4w1aXDstonOSy48utOIwEg5ludHmn5Q3tRs
         087Hs3aY4mvQkWCpOIldY3akessAwEv7EuEyeTqjt6V30LxGwGtLa5KJfNCXBN0/rUu9
         k69dbqOnocqE1r9U9v/mOs9BBYqF4Uu+lrPQ/MRy+9OzCHl2iAGHh2Qkqn8/Im4lUfAw
         euLA==
X-Forwarded-Encrypted: i=1; AJvYcCVl6Q04jQda40ctxjKbGyrNbVz3GQapK3asDPoY8VLAsHKYgJ4Z2HVImcWfKAq/qTrxfXLcUSGdE+X5wijDrQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxchInrB7TQUzHqGoKo0PgcRyret9Q0edTmR+h9GzvkWNbBdBWW
	NZ9PmYVigXuC89/lDojuop+yyaJNkdHSbjKrTOZcrLyVzgWzHf2QOgYPOwrA0OVu7t5wTHV2x07
	zXqIcI+vrF3mRdJ13jdC7gI+8DHeJq2uvJ7k19Qnz2AY7FC3hQOlHyfAHbm33awDvHQBx1jJ99s
	vqHHmBb6hmYRyBCJPcBrHI3/mur03/atIZ4LH19cIdHfynfQLMfGZpCw==
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2e06ac390c5mr2020790a91.14.1727235068211;
        Tue, 24 Sep 2024 20:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHSXnVXH4KJFogFRlAqrxz0oHdsU+wQjcpSOWPpZkunKpdZpa8uVOFkj6NCDsQxAw+PRNHCHqUsGcOkqjm3ok=
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2e06ac390c5mr2020746a91.14.1727235067738; Tue, 24 Sep 2024
 20:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 11:30:56 +0800
Message-ID: <CACGkMEvKPXCPi6=1938J-k8JNA+hHqzRSt1gPQtqBvSfcgGZeQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
>
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

If we decide to go this way, we need to make it reusable for macvtap as wel=
l.

Thanks

