Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05B155C98
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816648; cv=none; b=o/xYg/E5P4JTh2W/EYSY5XA5+PAfn+iMjCkYfShZoixI4gHP+clC1ePyFD/Dnkm9EpZq7U6YF0EEC+fJxr19vjyLl2MWCvno8f2HZ0cSV14TBgYLJeHmVom+nJ2Y+aK/FYYEKbcoCWekG7/8nfpcdbrGvNRSfr7udQPMPUCyrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816648; c=relaxed/simple;
	bh=4WUxNepm7FlTM6Q3xXNdD6+MO40RR9GnP4n3D5Y0Sno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/KhvJFYbZbGv2vRLUhpCwNxnCdUoKc0vjzAGQ8Zbynf5YVMyEqWzfASlwd6uXA+IsV77NVYUgjmgESpC7nyELFpIvW+/6GcCTBnKv2F7xJtZdtZLRO0ez9KaD9FakCWwdpx5MuOCjekBIYTiLCKSB8v8pr1ChbSrTHvsAKKPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+JfVuMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+JfVuMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721816645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAQ0rKvxHJTcaTheWzBNwf0GQNQszN9WhVAMEV8DN88=;
	b=e+JfVuMoVGz/7fFsBezY9ZiJpPZCxKvbz9Gzz9+prjycFs/ICFlrLs5iTibGv/SjhrGjYu
	HQBmalEb+Soc0d48Y/2kRYdz0MaVtIJtgn1W0LVQ5b0rnaxXwwlWMz9KkdqEmlp+DsLFl+
	s6VIRxMIY724VvJpiDrrTpWha5rOCxk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-7QG-Ei-mOHGIJW0_zWAgwA-1; Wed, 24 Jul 2024 06:24:03 -0400
X-MC-Unique: 7QG-Ei-mOHGIJW0_zWAgwA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-665a6dd38c8so198951357b3.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 03:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721816643; x=1722421443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAQ0rKvxHJTcaTheWzBNwf0GQNQszN9WhVAMEV8DN88=;
        b=PKZD0NLOg5fDWrWRouqaGoWvzLZX/7OlYwsHSMkWr/OPHYnnvasSMOaTey7MUPV/7T
         e5kL4el+BRrH8xpUKa6CHVnTCInFWIMMkeX9CpHaENyo/Owgbfhr4xPbUy/DNbq5tXpQ
         zFLiBhbbk7m+f5wIsk2+i8RhA+9mMy7xNr7TuHwx1YF03+yIMgrcp1Xtkhaeds+R8Oyb
         3RhXTX18eVVFB8vL9mpYhgUo3Kg8Wt22qovFMZH7+Yuk4v8GfCVTP66sL3570hNxxcE1
         d0/oW64iufBW5Ce4Ua4iXXYtH9y1cOXUrXU5AYa48eIWHuRlK64cXwFUvE38ZAfqgtsU
         RJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1dbKxZSyj6RFeIHTnwmJvZnvlAew39k9ZYUwL1UchSVx+1yjI3316Hslf5oCLUBBUgawcemeohKpGHdNW6ybRJe3l8kMW94fnaMbQe1w=
X-Gm-Message-State: AOJu0YzAiDrUf8JoOFMFYCry1ok8S5jo3kwoiz40YBDT2Bm0MaK4wP5s
	LaTVWTDDL+UQldNumVajc+hqKkrdME1fTC4E49QP0llvwVs6cjcfzNYTNgRSZznVK0dKl1QRkqQ
	FDJ0wdqHmv5k77IJUHXBVBwvy8hWVDMThB3l3MBOQqsvu/gz+WzE/g1EvQb09Weo6bZV1V5E0ev
	5+JdDLfD4rHkDuIWbMwIp2qTEtdntihEGtL5QrmVI=
X-Received: by 2002:a05:690c:2fc7:b0:62c:c5ea:407 with SMTP id 00721157ae682-6727d007064mr15879537b3.29.1721816643355;
        Wed, 24 Jul 2024 03:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUoebJqX/roKXRORJyg317BEvIg20RlsD7Cy8+nONERshnK/enlM7LbIlX5MWWgsLejCOIDIvI6vjx7tjUFJc=
X-Received: by 2002:a05:690c:2fc7:b0:62c:c5ea:407 with SMTP id
 00721157ae682-6727d007064mr15879427b3.29.1721816643081; Wed, 24 Jul 2024
 03:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 24 Jul 2024 12:23:27 +0200
Message-ID: <CAJaqyWebCqm4jwDS_G94uCncVA66yftAYb7Bj4UcQ0PcyRMvXA@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 9:44=E2=80=AFAM Zhu Jun <zhujun2@cmss.chinamobile.c=
om> wrote:
>
> The unsigned int should use "%u" instead of "%d".
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  tools/virtio/ringtest/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
> index 5a18b2301a63..e471d8e7cfaa 100644
> --- a/tools/virtio/ringtest/main.c
> +++ b/tools/virtio/ringtest/main.c
> @@ -276,7 +276,7 @@ static void help(void)
>         fprintf(stderr, "Usage: <test> [--help]"
>                 " [--host-affinity H]"
>                 " [--guest-affinity G]"
> -               " [--ring-size R (default: %d)]"
> +               " [--ring-size R (default: %u)]"
>                 " [--run-cycles C (default: %d)]"
>                 " [--batch b]"
>                 " [--outstanding o]"
> --
> 2.17.1
>
>
>

