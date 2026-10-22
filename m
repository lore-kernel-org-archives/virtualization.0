Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664398;
	b=r/M44qJfp6bObZtTeGeG0EQLKhTWqvVkADjlaSTYcKso1kBnX/XwKD28e2fPu87lJwiS
	 igrPoYE74wdAWvtJBPhtP9mWf8bO6zalh1VL4w4vLEA1vNsbaB+GYfh1RnQ9e8mOzsobh
	 4fPfu05xmatPowFwt+vF1Oa9owK4aLea0Co4Xr0xWpusT/g1L4GeBZjdIpzgfeP4AiCNf
	 mposkkVDrzWxC6UvwlSsdwX9iuxozytDcNGPlIKkG5GwkuPNa6LQ4qYPu+a9hgm1Rb7Gq
	 hPlhVManRGtGvYXatBRW85VXgRYTv7zsm89SvvbK/wTagHWY2Nde7iR0kAKMOH6objw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
	b=iirJlD64aUTIXtGI/yremZTLarO8ETPbJM3M7yooBTfTzr9N2COY7Vo8lhzYMqLZwLT9
	 L4nBZ7tTGXXGUJUuOoL3fHUKOPF3gIvKy668KofaPtiTG+wCpvHcIxWk41sZXPtImSQYL
	 /Z2BxfZcrhaWyd0Mx51WpMAiMc/hyXLw/3tfCrCldkNsoLeQfTTI/zjowHNMEq4eyFCB4
	 nkTwckiWzxftGxcAXYMuT5TIdcBAZl+GxKLivXCPe89ktxf00d0o7uhkkbxfbhG4nVp1G
	 6THAF/v3CPcitZbIG6Om5emjyvkMMpoX9dMbpY0eMFmY1SgDmXaE91vjhGZcH6hj/og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FFUWEbuh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD81606A31D
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 10:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD81606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FFUWEbuh
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53665358476so17295081cf.2
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 03:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664396; cv=none;
        d=google.com; s=arc-20260327;
        b=WPgACNgxTpqNcNymVkNbJMgwl3/UP8xfG/dXK75agBDxaPCprO4+wNT2HKgwbeASXQ
         8T1f9E9E4BIybGhhpYycNCfSydoB9j9Fdua6EDgfcQlamvkupcGnM/Lrf+detF+vyAmZ
         D/njW42B+7Hr+UZfuyyg54U1N/ozI6ualOM1wBrgFM8cWY8hL8pn2ul7K+hztgX1Jza8
         H+yvDef4C8r6wmee7H5VOpBcsDO3Fag4bC5067joW3PSxFk1GArm6JkkKjqeDkSdSELo
         Scg491p7EYXKVh7dlN4gVdZKuda5m/nbfwqyRNZ66w8/etQCpKKBAdKpfcKCeb00WC3C
         1hUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        fh=5kvH1nTknihmAvTnIc+fPNsjjFtAcmZYnx5iAsk/Cts=;
        b=AIPtapWjxMjV44ZTyZ2ZDOeASyPE53pNAyw3kEHaQ92NkvNnE9ACGBusovbTV8SO9B
         39sFssjnpOR61Vy1JX0Eg75OZoBCAZDVtXa/TfxVGr2PHvdgPqEm9QiRAjeziIITpgvO
         CVC8ClqI0sO3vsXTBAzQA52feq9yruK6pik7ab1ldO6/97myPcHInzo3S2+TIYfppVnN
         6oRosDNPGreDSUFAJiPj/UfK+CInDUqo4rQ7HeB7RsLjQkNFKtHcMe9qiVZXnh/L0YA0
         xyxp6QOq49YfQualvH6uu2Fc2m/4Zq2pZFQG7y4KK72GtHTH/JHnv2UD2nCClXrf6X+o
         7nPA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664396; x=1793269196; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        b=FFUWEbuhD4JolKacBRiwTFha4/Jv3GkJT6/dW1NHvLFZCuDNPoUAWyjNTZYSzy2p3A
         E/2KxT5q7w7YkOu8d7nSmGuFbq3OnHqQk5fttOoEO/fZ406LtbxemJpU0R/jQ4q3wQ0Z
         RYX8A5rTNtoA5fB7fP+unvxRPggotgAjc+9TM11zoNsj645lClu3htzokX5Ab9AqXqBK
         G4F0DIfJudHHF8XGMKVyBEcNPVroX5zbvpLP99M1oGGTjA8Maeko1pq5R2oN4Wde/jiF
         M+BsR4MxRRc895Zgv07zQanrdknU433a9okLs6+1t+2fxDs1fT8jnsQ7V1fm4r7vjwzo
         Os/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664396; x=1793269196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        b=07g9JpL4rY6nG5PyUXXriH60urUwP7YmpRzVbTJTgK0i8N0omxavSYLXuT5bxAx9sa
         56tZQIF8qCdKcpDpci/lU/VP+I9Jf0a7MeAMrp4BJdfEvt4tDIuJSaQRrmFPB2FIUovW
         ar+uXXWwLlQ5j2GR0s7Pevnmyco37mqmnfxtNs5iNGjg5D9f3Zmr3oJIe3nGujZ4RtX5
         wvV/SC2poLXuZn+k4N4FlzLb5id2LoK8RYSGU9kfcetJ6F7SshVCtXklhKqvj/UocaWD
         MMtyzjLsfl33GXO7QUm2toeprzvEXj9FGiXGRVNENbJUTcadke3kC7J/PEq14cyjxRpp
         iT/g==
X-Forwarded-Encrypted: i=1; AKwUvBxaukwvoEvOmc62frXOMkWUm8QLfGCJ/wWNTcF8RYFJMWP7F1BoddW/Z/Do/2Aafb8OBgGSYvPYJcWeKkM8eQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLbpWQfL9956BS11nm4bsppqFBKpGj7DRtIt4AjlYP+lMCr/fMG
	iFYEAg1FXTujCNrNJS9/ow8KY8JrKQaNxhT1Pudj1tcBwgha8JhOCIcZKwpGJStKfNpc2HxUbcm
	iUKEJtSE3qeugPwyWSInQOo7vZYpGR+o=
X-Gm-Gg: AYBFou1bNv+QqPBzgnq+94E81qluUM6XfuA/zegChOtpidORiaVnVp53oK5f2MmDTCm
	Q8dTsegSZuIaE5Arf+z0i+eWxerDWGrLH0dnZnNud6oY9vDGvFIcA2C2K1njTEZBAGaPPapzNdX
	QwAo5/PqqmDWeBgr0rHwwp7EC7OV8uJc3dkGyTSXtdaaxm3I/8u0OUgsv3H9ZUB13l+K3/xXeuH
	ezxCDwfnIW6gNYG2xgG2NEK+LHpL+qoVWTLGoQrRNbmy+RJDScVg3/zpr9BKTmVmt+UOjWluWLg
	9D1nfm7Qa+NscLPmy21F9jdL4ocA2SRFBNLjghksbwbGXrmB5Oym6FOH7609nWmFEwCtfN4Di4r
	rzuhLsk1SKd2VCab0YjsTaWMG6c1mrZU2o72fALY=
X-Received: by 2002:a05:620a:6504:b0:93f:277b:313d with SMTP id
 af79cd13be357-93f57e404e7mr834687385a.2.1792664395296; Thu, 22 Oct 2026
 03:19:55 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261021085458.196742-1-physicalmtea@gmail.com> <d58ea6de-e17c-4426-afd1-0b67ead16b7c@oracle.com>
In-Reply-To: <d58ea6de-e17c-4426-afd1-0b67ead16b7c@oracle.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 22 Oct 2026 18:19:19 +0800
X-Gm-Features: AclHuK9FeuqH6i9COjZB1uH64DnGhDow9zmoJpb-bjLKr8MhdWEwBKDQwH0c-T0
Message-ID: <CAJwVaM+nBJ15=XwdV_wefNxd8iyxxSWjd-K8k_VAAc8yoyUZJg@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O fallback
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On 10/21/26 3:54 AM, Jia Jia wrote:
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e..b7e41c0a91d4 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >       vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
> >
> >       iov_iter_revert(iter, bytes);
> > +     /*
> > +      * pages[npages] is the first page not added to the SG list.  The
>
> Just a minor nit. There's an extra space before "The" in the comment.
>

Thanks for pointing this out. I'll remove it and send a v2.

> Patch looks ok otherwise. Thanks.
>
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
>
>
> > +      * remaining data starts at offset in that page.
> > +      */
> >       while (bytes) {
> > -             n = min_t(unsigned int, PAGE_SIZE, bytes);
> > +             n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
> >
> >               put_page(pages[npages++]);
> >               bytes -= n;
> > +             offset = 0;
> >       }
> >
> >       return -EINVAL;
> > --
> > 2.47.0
> >
>
