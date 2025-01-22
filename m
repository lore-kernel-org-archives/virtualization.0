Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19511C1F23
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532411; cv=none; b=BjTMO1/N4OnmtY/DlpruZBy+IOY0pg923XUvRiJ79+aPHM8EsWLzhiP66N8U8FFvIxitTNUojgP5sxgLd+bKD+se8/4Q47a+2nRbicensItD6L04XPI7uBjnPh3U5zgF15pxTxAAzCruB6hJ6XxiDt12WN6iuSsVvpPpRDVm4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532411; c=relaxed/simple;
	bh=NWi/X4EepEORBpF1EdWBM8ejrh0TAtd7EwBf34ua8eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kl9t6bsUk8LnwmpMgjPezU4VjA3UF1cL8GDJr+eQLWcJZLkHD4Mw+c6fhhDVzoUgmzekJmk1NG937U1KnRU6660HZtrXaWDDaWvhYLg08Aqk2yY7xk8zWPi6iL8Zffy8DqOUIETJzS5pk5jrNRXcXe7rEyVo8B5fVE9lJdMKEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUTSDdnj; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUTSDdnj"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 791B0400B9
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 07:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eTRqSVm24-k6 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jan 2025 07:53:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8F3ED400CB
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F3ED400CB
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PUTSDdnj
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F3ED400CB
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737532407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWi/X4EepEORBpF1EdWBM8ejrh0TAtd7EwBf34ua8eY=;
	b=PUTSDdnjkloKXgA18+GXtyUBrm66W2ME4ediBGNjs3Zm4DPUNKSweh0pyuQsNK51TUcFdK
	UKszEkidVhjBjHAoLjeLU1PEPZhu/Pw3rrEBEaQi3TiGfxHGbtgTEXviW+gsFJe/nAe5Xo
	7CbhZjtWlNoKg0zpvpyrRXSfPOssQQg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-k7weG40gNu6D4KsskRg8Bw-1; Wed, 22 Jan 2025 02:53:25 -0500
X-MC-Unique: k7weG40gNu6D4KsskRg8Bw-1
X-Mimecast-MFC-AGG-ID: k7weG40gNu6D4KsskRg8Bw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa6704ffcaeso641345466b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 23:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737532404; x=1738137204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWi/X4EepEORBpF1EdWBM8ejrh0TAtd7EwBf34ua8eY=;
        b=nCZApSdCgiK8+EsuHul/jI6A6MZIA6VOcAi23djM6RAsIYxKc/0+5Kx/Rbfb3PPwfK
         NKb2U5i0S8/WHAD7RbUCKqgF/xmWvFi2XeSCYo3Y1nj2qKxsoatfpGj2zH58LuiSeap5
         8AYS3qht9NLIWapQVeGFZxixqwt00P66NcNsNLxXyESaNgYdj9PZ1gR5VGV9qq2FY7RN
         tshusgTDYYGLVsVl5ZwS8PCX+6J5VT3w0OzpcX+HLYCNCy8nPXfzLMn5v+Wl4TpcjRqu
         bA/A59c0OQZ8oSkYQG/2T0/EXcuVDJMh/wt0SCvgwHWHUfEuzHyljaFQGfrZsFIt2gPE
         b4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIx5lzTspWVonC5EKPnBjGfF8l0xEqSOxNOvpb0z/eHEd7PZirI5Wd3fO495CIddMq7zxKcWUG89JHtSbPqw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyU1J9QM8SQfBgYOayj7wr+2gYyH2BkKE/gvKjzQDiA4QNsn2Fl
	BsJ/UE5ugtkbKvO/pS1F8zzoDglDfPJIa+U0weHdnpjXaXr7CuUbWEobm0Yu5+yeV6tVQcmm7zs
	atW5PNpx9+nQfsc6HRLFCZeYr+0sbdUK5UDiCjkEEk4SNRcpWkWccZWVYvz3e5WmIZE1el3pnA2
	kLuybYKPvkKFjyqF7c0+Xgt1OTgkGzOcKe5i9UOd9OJ4890ene7Rne6A==
X-Gm-Gg: ASbGncu8wPhhZ/GBcKR8UDT07SFgAudClZHcYvODgxWbFPahTXpeSPxzNt2y60bx9yG
	MhScLpcrz5+IU4uZr4TrsTZ5RIcdzIkdCP77M296aoEcIgOr9igmj
X-Received: by 2002:a17:907:3f23:b0:ab3:f88:b54e with SMTP id a640c23a62f3a-ab38b2e71e0mr1780355366b.31.1737532404277;
        Tue, 21 Jan 2025 23:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSBrnnYOS19m7TjOcd8x/cUksXSdlCsHJSmkD+58MAUdLUpHDe1Ee9rZmzT4ECq7IA1QGLbTFKXzGcQJZeEsE=
X-Received: by 2002:a17:907:3f23:b0:ab3:f88:b54e with SMTP id
 a640c23a62f3a-ab38b2e71e0mr1780353566b.31.1737532403990; Tue, 21 Jan 2025
 23:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org> <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
 <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
 <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com> <20250122021720-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250122021720-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 22 Jan 2025 15:52:44 +0800
X-Gm-Features: AbW1kvacW-HF7AuwY6uOBpM1Y_iEZw5oTKBTTe0PcrH7DGqKdHy2_T74XYD0FOA
Message-ID: <CACLfguXoPMfvvio92Yq696bdm9nQKXDeBqbh4DDNXDjkK8hhbA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o_tS_POHl7fHTCuN-rENC6JemVaIlMLQnaBt8YpF8_s_1737532404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jan 22, 2025 at 10:07:19AM +0800, Cindy Lu wrote:
> > Ping for review, Hi MST and Jason, do you have any comments on this?
> > Thanks
> > Cindy
>
>
> I see there are unaddressed comments by Jason and Stefano.
>
sure, thanks, Mst. I will submit a new version.
Thanks
Cindy

