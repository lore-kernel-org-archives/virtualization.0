Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB702EAB72
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466506; cv=none; b=Kch+MCLDq5QATcRluHWLxPqlEMD+3wpVlGr2/iN3UsqPUE1H64H962q56OIVY2Cv4pV2OZCspETVJj1ImTK+Fgs6/Jipt7OBuG5tk8pcJbmHtofRy4bEM0CBdVCCAmjCR2bi3kRKAumgBWCBTB7h7dWO9XPYi4LDUfDmI0R17uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466506; c=relaxed/simple;
	bh=g8SIqJKTw9b/5YobT5JFo/oBsxcZiRodL8lJWIp9WIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnU/Juxu4N4lzlh2wJYg4wWsraxswfd7peJ7mNEXK2kzMKGwFxRcybEF+oiIuxg2hqlWOf9HExbQI42ikTOoO5IWplH71cgmwTmIFVHGq2RxGVbyeSCOM8cIXGicP2+n99FfmM/L1ZIPLwxLulhCMtLbol2Lnk49J8JAoRc85Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJAH3j5m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJAH3j5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768466503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5DTqAAi5+bRbnKuiswtCcR03N6rwSR1X5aj5rVatdU=;
	b=cJAH3j5mASGKKS3DkwS/WqFsSz7/IjBRtfg1JUid+orL8xo8nbiQLrembgBwQVDdI2z7Wr
	glxPoxpEe/VA59Xw0TVvXmIBy8C6tmCYQokGF9ikqnLBy1wvtZiSo0++F2OvCcMdbfGQYb
	2hKpajGHE8q49ywwjH/+qhglw8ljtUc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-CgtzjIA3PX274kTyu_oBtw-1; Thu, 15 Jan 2026 03:41:40 -0500
X-MC-Unique: CgtzjIA3PX274kTyu_oBtw-1
X-Mimecast-MFC-AGG-ID: CgtzjIA3PX274kTyu_oBtw_1768466500
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so593350a91.0
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466500; x=1769071300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5DTqAAi5+bRbnKuiswtCcR03N6rwSR1X5aj5rVatdU=;
        b=bh7DAi0d1hQxKVaZh21WBnserkIm0+FA7jwz1MpiWJlN0RkhyN/Kv8V3HeivK96G2p
         W9flo2FhPeYrcvG0ywMI3PHt5PpIwmXBHcwoeQ9XYxtTN7NuBvQyFSUwr4VhWenkjYXp
         3uq4J7ultNZfBZuxbxkNNAoM1vJO6nl9XN/yKs3iEv/1HML3SRXgXPihR1Zb9RsBrfNt
         5tvumMcGBYuBLFHol+vLtsuXMY+2a/6xuVdVl0nyGj2GI9joPtSFDQEO9l4+we+FzGcG
         FZdqKyDSrEFyVDv4vuB8gwxDb4ks63pl0uTDLLpcS3wALAiQZkJr7Mr/Wys7oALcmQtS
         1uFw==
X-Forwarded-Encrypted: i=1; AJvYcCX1/hDramGzN16esT7+ExQ6QRffMupGh60+leK17R3D1A2oh4+mQuyhmLk1TO29Ixv8D7tcgUBCVcEevcXowA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywdz3fjxQvgpjpLTyqgm4f2j9g3+dWPo69mICDP1TPn1yuT6mRo
	2vGBgLsraHr7ll4qWl3fS+NDoUfRwKFOQudnmNLLZjgHMMsLRa/PlNHaHSIfa/2sOmXqK4SZPia
	wtv+4r4TyUH+UL3n1SWXNJWO8jJTyvWxJvTMjvkfjPjNZhVL3whxq4vVrHVxc5t0NAsCxmD8HCc
	PAYDoefCzz4uyaouwBwZuYve3Dn9ozosuO5QN6IAoMKNY=
X-Gm-Gg: AY/fxX4Knm4MCe3ANl4MKRKvjyDIozCDTJLYEd77xlMD1QiRpY3vCH/kNT6uezjms0E
	s5zihcM+zZogkyCZZQ+t64OP4Ux8Z8emtD8oscP3u5FuEt240l0suFB/DztoVwDzbfq6rD93C1s
	vr1XNP/hsPWiFXIbX0HIofcHvrVvncpZAvDLBfZDpb08TquEBOzCIel/zVDd+85CnCaIY=
X-Received: by 2002:a17:90a:d405:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3510915b515mr5612078a91.33.1768466499800;
        Thu, 15 Jan 2026 00:41:39 -0800 (PST)
X-Received: by 2002:a17:90a:d405:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-3510915b515mr5612047a91.33.1768466499220; Thu, 15 Jan 2026
 00:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-11-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-11-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Jan 2026 16:41:24 +0800
X-Gm-Features: AZwV_QhO0WZ7_YyTxB3phzC-rpTrhMEQ893sFcQmUDaaP5kwO24okoZ-PWKuXCc
Message-ID: <CACGkMEv5mrMJZ10Ub+S0wxfyxRD_SwB3wkHhx-ywUompuCGJ0Q@mail.gmail.com>
Subject: Re: [PATCH v12 10/13] vduse: merge tree search logic of IOTLB_GET_FD
 and IOTLB_GET_INFO ioctls
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eTzNdYIlZnGphbAraBi3NyCMHQpdeRrdwJjS1z8OtxE_1768466500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> The next patch adds new ioctl with the ASID member per entry.  Abstract
> these two so it can be build on top easily.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

