Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C430FC1A
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509584; cv=none; b=c3Vj+lxBsSmkxHyW3t3E4HP8q369RV0fclizJ2och/LM1WAtK5o8+uexY7GeSL7YeORqoCtb39JL4/OboiHCFg9WvNAEMOOt5wqwJj2VRBcrIFT6OZIEcOrKEmZ8BiwRu+CoLNvaJ7WqpeuXWvdAXAm3kvOa6XCCFzm0dhZpjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509584; c=relaxed/simple;
	bh=1X5r5A1B2kjjGeMbXGSpjomcqgwt++arkl6QDDiWrAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUgdGUVB7zlzPY4OvUoXCIMSVMFzaeagsLQpSWN0CqFqqotRf6XNgf6leWWme1PXKCcIb5lFrgm8xP1yE0rF2e5KRPddzGJ1DnNrUrO+UizEZPM8Vuiblvbq5H2ZVZtkLXWCnbV/3HU/YID+xhjZG7s4LiC0ZAtEg0CPX5kqQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKvUSlQa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKvUSlQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760509581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X5r5A1B2kjjGeMbXGSpjomcqgwt++arkl6QDDiWrAs=;
	b=QKvUSlQarPjxeSoFPcFODwYjzkp2aS/gqRykd8cTK/vJzhujjAtIv1JnGaPbvraRPrTtow
	bfBqe0PPFxaDPXcIfhgFcOSDuq6/kvn6MxyFB8i7Jhb10kbskcByZn/s5AeNZTMRazVZEU
	gZTHjUsuO3SY13cmjH+fXJBMeTdPEmg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-WJjcHksMOayaMjVxNr-LFw-1; Wed, 15 Oct 2025 02:26:20 -0400
X-MC-Unique: WJjcHksMOayaMjVxNr-LFw-1
X-Mimecast-MFC-AGG-ID: WJjcHksMOayaMjVxNr-LFw_1760509579
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-738a7fc9901so115103827b3.0
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 23:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509579; x=1761114379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X5r5A1B2kjjGeMbXGSpjomcqgwt++arkl6QDDiWrAs=;
        b=vWu97o9gocvBMLg5YgnHJxu7g/rd2gT4XgqgHtZV8Mi6GosYVCM9LvphBhfyiApXlJ
         Bic9m/glaT/CkleEfi9g4882DhWN+SjYuSWX6k/IMTVVzNu2yxxdNBjiLOmduCTBKu9J
         Pel1lQHb9G2tNM8ypSMVtxnryXhaBhZOq8N81XcyaDDNgSGreagJSnHSZ95i21EHNeEz
         FPF9Fe/aY0dkAaAb/SQOB3sVC7Djwl4SkOeZOWSg7r3iZMmtM8+EWyp26OMpwz39NIBE
         6CgGNb3Lv94Y/Pg1lyWoAbzsVZhPS20gmDsVTI2RtFgdijbvOsa+XWFKvk+hk1m2DYvc
         CHRw==
X-Forwarded-Encrypted: i=1; AJvYcCVaFQldAscGXQIv//TBYyGUOQZZTXyFnilVVKcgL+8tzIz3Rln//O/8suw5WDsju79T17E3Dg12/c0Q16ZB8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyJP2lyFsxpEUmyPEYreAG29WvttUJvvvWKTXmZicx9Sb3Vw5K
	PVHNYd8x4+pOeICKkR2ykgJ8BedGLcBeK7N2RcOk3QRQqULb8rnseTpkZY5wj3jraZIQtrwpqlw
	4sFPIlIWq03dAme2IWyS5Wdqe2tE4gHn5RZ0m+mljIwzqXfm6imWbPcP8nTiT3B1PKP6OnUexTV
	gWeP5vsFiJqBqi5iaItggroPhY+hb24fpZosRvhTabc/w5+2fCasw=
X-Gm-Gg: ASbGncvONlA0MYtObRnsej3ynsHLsfKgp6/RWkdJ0lFZww71Bd/4jb0weofid1dplcQ
	k7F/yGyTvhoOugx1ciKZ68cHzsfwLfM8sLbTrDossTEAPY6mCy7kq/JEvsn+UZhuHUp56AlUKzt
	Ss7NwbhpDaG0FMp8nMem4feivlWR7JJuLl0YsWUOeE4WFmRLU5NFGtlyR1cp/xvqc27+Q4S4Hze
	9wKk6oq
X-Received: by 2002:a05:690e:d4a:b0:63c:f5a6:f2dc with SMTP id 956f58d0204a3-63cf5a70856mr12235624d50.62.1760509578844;
        Tue, 14 Oct 2025 23:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX+vfx8qv1isFFCeU+W/mGqMDeDE6Yla17ZwBRh+wdPY1fE4diJLaULX40JUFbrevmDIlQOeoiti1+NWdvJQ8=
X-Received: by 2002:a05:690e:d4a:b0:63c:f5a6:f2dc with SMTP id
 956f58d0204a3-63cf5a70856mr12235615d50.62.1760509578517; Tue, 14 Oct 2025
 23:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-3-eperezma@redhat.com>
 <20251014043004-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014043004-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 08:25:41 +0200
X-Gm-Features: AS18NWAg45RzyOP9tnUy5nGSIH1lniNW6YGYImHL_ui8inHzxlsdS5EdGSEbSVM
Message-ID: <CAJaqyWd82UMT9Ddtt0LfXz_L8WLi_4rKtsefo=wuYKKBSOtvAw@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: lift restriction about net devices with CVQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UVi05rnP6bGWMAenylnAJs71WYP3Y2l4zRbLqooQfio_1760509579
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:31=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 07, 2025 at 03:06:22PM +0200, Eugenio P=C3=A9rez wrote:
> > Now that the virtio_net driver is able to recover from a stall
> > virtqueue,
>
> it's not able to recover, is it?
>

Maybe recover is not the best word here :). s/recover from a stall
virtqueue/unlock the RTNL from a stalled control virtqueue/.

