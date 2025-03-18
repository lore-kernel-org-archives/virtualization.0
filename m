Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5428192D8A
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Mar 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263839; cv=none; b=KFPIqlV4rHQKZtCpyipJ+JLCPUAFib+HGK4J4IdBUnt/HT4lzqv6+BR07TXL/ZvCJGr9sNim11LxB/hilvuU+3hp9rXHGLp9Vm4M8kv5LgItaNKipMY74bZK1EVOZAcfoNEtEp21yYRG8NL8yQquXc3B+MvGbv0t3Ze2CCPyAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263839; c=relaxed/simple;
	bh=QR2+CQhFtF3wiXNVfMMn04N/Zgc7E9vWUP/WZyEzsE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbR9436VA/qd4kuZNN2JqktwofhK0eymvAcGT4bct2bzSoFlrzVNdKMQfQgToRbmIme04MjMEjeTIgzMDUOXotdJzsGpkKTUGcTiHAqTTAHoQnmdY2EYi1ob+snNEvZsJ6Tdmghqw3CUKA6a7dyXYwirwgnDhMwOnvYwRaxeNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0k64aBK; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0k64aBK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5903840F28
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Mar 2025 02:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4BajXMAE0mC for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Mar 2025 02:10:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1067540F57
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1067540F57
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L0k64aBK
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1067540F57
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Mar 2025 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742263830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bocJ4xY+cvLvF8Z2x24tl3LRmmXAsvkZEGxfx5yQFuM=;
	b=L0k64aBKhp6EbDzupLaFCy+aPU5PrxFhExHhz/+PM1VwUpxn0oFPKX+3zTvabHatSTYEvL
	eczio3BysO3SeOPgC5KWjqCSVJz2U6IwRwx4GVa+vCs/EguTBT0WbQ6mOx5mr3y/vdxd0y
	nyGMqBmL4vikhmDdUUOhj5OJZDwCL1g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-kfd4tOxCOciK8JCbB1ECTw-1; Mon, 17 Mar 2025 22:10:28 -0400
X-MC-Unique: kfd4tOxCOciK8JCbB1ECTw-1
X-Mimecast-MFC-AGG-ID: kfd4tOxCOciK8JCbB1ECTw_1742263828
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5be5ec846so4517145a12.2
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 19:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742263827; x=1742868627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bocJ4xY+cvLvF8Z2x24tl3LRmmXAsvkZEGxfx5yQFuM=;
        b=EkDXe+0pAWE/eRwhmd2CgZ2zZOTimrsn83KyHGhzN9qjvpORtClqP2Rw5QL619VEo7
         EjXFDzosnRjSO+I44bjhsTi4wNfLQtzRA2a168MRLbu42CDbbu+6Go75i0c1Ir3N/mAx
         vxOAj7aTWybf7RXuZxODR8FpqOKOav94h+RadplFl1W5ktN0QOy1Z5edfT9O/drTlQT3
         2eVJh7ASPbOeOVRA4MSFoUw8ESkdr4MkXdMvWvL0Um4smDYpGco+oSaKc+qZW63LuUAw
         9rfTwREV2NsBTjLBgJtNEdonrOU2XYnvikQkeSV7sY4Wjt0TsyTIjtMNq5gi3dHZbdTx
         1DOA==
X-Forwarded-Encrypted: i=1; AJvYcCWwV/gPeUiX04eDwQbmbgdez9ak6z19PQZe2j1GsO2E/L4Ajx0zJRs/nYCEIejZE2DNw9sJpmfsep/Vytv8Ww==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxresqTsvXTfMie4XMQYbYSe42UNc4S+11vQOozy2nes/dedxA3
	Moec+odaifognHnrq95bGrmu5zJsehy1QQLniPoml40O58cs4C5vgKKFGAjHjbDSoBlwsXwdFdQ
	ajYieQNEa6tGtxzIy5U0YOKXFdz4KNQKz3X/utuYsZ1IuDXCs9Jdh3myQQ6KJOmdDaZWoSWV+FL
	61Tv2P9M2VV1nromTViovt301xIF7WclLYa9orRC0S1vT281WTQFAi3w==
X-Gm-Gg: ASbGnctmUrksEpDKM3JtBIBz/FCnk8JyOxifjnRoxVwwWQEJdFmlNY6toNQjoClZvIP
	a12BxHHZn7Dyx/NG+hqUEbHufqoXkLyihLTyoW2mn91cmPcpcJuaJ4DGMs5mwdQREX3svKQk/BQ
	==
X-Received: by 2002:a05:6402:348d:b0:5de:cbed:c955 with SMTP id 4fb4d7f45d1cf-5e89fa5252bmr15904543a12.17.1742263827511;
        Mon, 17 Mar 2025 19:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCvFJRxiUrK3Hl8RQJ4gACrb1PAEIxR0Zqht6rIjp/tdZBCVDepPjzyLxDhCMISfCanvYlkZjNzb4UQTjWFWQ=
X-Received: by 2002:a05:6402:348d:b0:5de:cbed:c955 with SMTP id
 4fb4d7f45d1cf-5e89fa5252bmr15904525a12.17.1742263827103; Mon, 17 Mar 2025
 19:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com> <CACGkMEu=pPTd-QHKRDw7noRCTu-18c7JLJNKZCEu5=BHAE0aJQ@mail.gmail.com>
In-Reply-To: <CACGkMEu=pPTd-QHKRDw7noRCTu-18c7JLJNKZCEu5=BHAE0aJQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 18 Mar 2025 10:09:50 +0800
X-Gm-Features: AQ5f1Jpjunc8xib_cyTewZlm6iAFgRKVvfy1UVZQ0lyOQH2XWEffoxUQGNr9u5c
Message-ID: <CAPpAL=yfgiuFA-SyrCe0Ud8Wm9tJMcMm9L4Q-AnnuRzN+Q9M=A@mail.gmail.com>
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
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XT0CxPMSxrdaUAGushCqpU8jpp_tWRLj1A5S8SBMHg8_1742263828
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches v11 under linux-next repo with
virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Mar 18, 2025 at 8:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Mar 17, 2025 at 6:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> >
> > virtio-net have two usage of hashes: one is RSS and another is hash
> > reporting. Conventionally the hash calculation was done by the VMM.
> > However, computing the hash after the queue was chosen defeats the
> > purpose of RSS.
> >
> > Another approach is to use eBPF steering program. This approach has
> > another downside: it cannot report the calculated hash due to the
> > restrictive nature of eBPF.
> >
> > Introduce the code to compute hashes to the kernel in order to overcome
> > thse challenges.
> >
> > An alternative solution is to extend the eBPF steering program so that =
it
> > will be able to report to the userspace, but it is based on context
> > rewrites, which is in feature freeze. We can adopt kfuncs, but they wil=
l
> > not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> > and vhost_net).
> >
> > The patches for QEMU to use this new feature was submitted as RFC and
> > is available at:
> > https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/
> >
> > This work was presented at LPC 2024:
> > https://lpc.events/event/18/contributions/1963/
> >
> > V1 -> V2:
> >   Changed to introduce a new BPF program type.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Changes in v11:
> > - Added the missing code to free vnet_hash in patch
> >   "tap: Introduce virtio-net hash feature".
> > - Link to v10: https://lore.kernel.org/r/20250313-rss-v10-0-3185d73a9af=
0@daynix.com
> >
>
> We only have 2 or 3 points that need to be sorted out. Let's hold on
> to the iteration until we had an agreement.
>
> Thanks
>

