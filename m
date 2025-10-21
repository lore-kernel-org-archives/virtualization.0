Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72901191F66
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019040; cv=none; b=Az2ljsGQLGhHwGjl5MOzIdYFWjOcEVVjFi7qfJtNikmhru8rVJTHrXLEeah5kLAJ/J4OPjiQVBTk8v9i4EywGdnzLbCf0YLX3YpvdFa3x44Jzjkm/88TGcGUxhAlcfDX4nFZbnweG5kBzj2qqvO+rWoB4xm4ob82Cr5N7IxmOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019040; c=relaxed/simple;
	bh=avAnboTjW6tMpgAJHhMAVvcyuciRZrXEfhoaUrC+C7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwxRIjS8jms9tXicKZgfzhomZ9ztA+09Y6ipxEQAh9CP9yULKt0R4OFqE9LWSyimrqMHLTDs0ie4Sz8oisOW5KeuuvdUB5noeX/Asrz/9vwcXWag1i8TLxQtaPwfpqWYYQ7RSEUYuoKGInwauU1CDxqtAXDRLlogMrXy3HhPXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xreo83by; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xreo83by"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761019038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avAnboTjW6tMpgAJHhMAVvcyuciRZrXEfhoaUrC+C7g=;
	b=Xreo83by7ZEdTsMbHEtlsBB5p9t2AKtd6D6tURpKFL/FIOJqQ+cigYeM0FM9+7zMn7XjC2
	5S2nqIS1TjRS/e1RoNOEiHXuMRsLB6VNcwgnV7c0cHnnY6skdXkzZtUk9rwzRWSQ+1AAxB
	MRD/7zL5qqmo/JhZet43sF7l1zC/uuY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-0TZ6G5qSPFa-MdISwyCbkA-1; Mon, 20 Oct 2025 23:57:16 -0400
X-MC-Unique: 0TZ6G5qSPFa-MdISwyCbkA-1
X-Mimecast-MFC-AGG-ID: 0TZ6G5qSPFa-MdISwyCbkA_1761019036
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so9361121a91.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019035; x=1761623835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avAnboTjW6tMpgAJHhMAVvcyuciRZrXEfhoaUrC+C7g=;
        b=uv4jUcO1Dt12RRooCS9OJ8SuNFV/q/0tBaP41xOT+OlbUbIpoge/+u0foY3MCHBLND
         CQ4k18JBHeDqLQtqNvGXr6c+vu4Z+qKpMk/i27KSJ967hkhGptibrJobH3ogFDD85tsr
         FZW8UJbnxHSGixGmPp1LJsPR+meR/X82M8RgQpd9/mcWayJMwrqIMAtfb7x5cwh4ovbp
         vjGcMi1TsDQNaqGPNzyTOdIUVkH3u652jvWIR4ayGf8qelw9cE0VFQ+jiIeon9nWyphi
         scqbH0Cz7LyYcO/NMYvFbR7bFuuDLL51+1eStFEgwywFlaVVNz2OeDqk+V+EIL88yyBo
         vOOw==
X-Forwarded-Encrypted: i=1; AJvYcCXsd0zDEk4soDDWdThlPexjwwX+/nf8zc6meNXlaEIP9pDDRsBFq8Kjz/qBCjzTxPkMnTxxpggzRmE3nbDT+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi/SC9YuXYwn+RKHyZ+tURx4Jy/kUIUOFUpmqPeX/fvC3pdcpH
	nIFN0t1p7bu2Z1kzKq3/KXL3y1KDIC1nbBlVRTR8PUs94ABTfg8IZd+V/sPyQcSiXvHfT30NYyO
	O3hE6z64wnofGxC/BklMiUkPor1/p4/lfH07e4XVWnS/Wbm4pY15UXAs4Qg5A4iaRxYUTxywV5o
	lbkXvASSUY2NCJvcqal7nuY+xfVHLeSNKW5R2oldj5RQobuVjAf5WA5g==
X-Gm-Gg: ASbGncu93zP2jagb1EZrbPgBYCnmy+a+CR29Dh+ZVXf2cJOLlcT18n7SpuVLmaiyr6j
	lFf7RjwwMs+PP8c4DpR/MQeYDmetgl203gzpg4SdCb12/QapYBTr29qBuHPOHh/AQIe+mbueXin
	1fouZWvi6cNDB9G8wJoj+FwVxlFyvwLwTKu4nrsMYsmTQNJyaCNUdFxZG3
X-Received: by 2002:a17:90b:38c7:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-33bcf9080f6mr17871948a91.31.1761019035293;
        Mon, 20 Oct 2025 20:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2AQ5ooNC2Kw7cDDlHQHODRbiZf6YTTMcGqTJDIYsLuIjekqTxqXC2ulUIAMgLEFP40yd7yWnPZVSHbOEH18k=
X-Received: by 2002:a17:90b:38c7:b0:338:3cea:608e with SMTP id
 98e67ed59e1d1-33bcf9080f6mr17871928a91.31.1761019034912; Mon, 20 Oct 2025
 20:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-16-jasowang@redhat.com>
 <20251020190537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020190537-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:57:03 +0800
X-Gm-Features: AS18NWBjFmb6ytc1dmje5mqVvtGdnhFl8MQMgGfdH1ywtzn-hKtlF48bMq1pbd8
Message-ID: <CACGkMEuLgO55NbLVFC_RiwEqX+RATrf90UOMQ=+8npPuvusYUQ@mail.gmail.com>
Subject: Re: [PATCH V7 15/19] virtio_ring: factor out core logic of buffer detaching
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DaLY30HN89kzCLYgf_Zn6y3uPM05AbzIEmKdCxf7xL4_1761019036
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:06=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Sep 25, 2025 at 06:37:04PM +0800, Jason Wang wrote:
> > Factor out core logic of buffer detaching and leave the id population
>
>
> "id population" here really means "free list management".
>
>
> > to the caller so in order can just call the core logic.
>
>
> in order -> in_order
>

All fixed.

Thanks

