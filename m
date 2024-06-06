Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F366FD0
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633787; cv=none; b=o5bL5BBAPUzRgsa08LN696cIMqT0kCZqISMrNSkhxxjKZXkOkHSDtJ9jwelQztpuHFwLtGvO+i7fV3q8tQTBO2JfUYCRnXaskwYz6JcTJ62wPcNY9b02vBLwpk6lor7lvLq/Bs9ed8s3kP6GmjwtCh/6RmPKZRgHrrHEMQxocNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633787; c=relaxed/simple;
	bh=9HRvxSNghce3RawNOIoiA49EDrjj1qS2aiw36T1Dl6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmNQrWv2DnDl0qktkQHi6SyU6y5faPnCpQoMSTaJeMQjr3rKAHMtb3XWs0VQ3Nen3jo1eyWkYJjRi/FitAshjH1HyUS7Roz7LEcB9gvpi7zAvGBEKyiferIlAGquuRsT350RQl74BdoHbIW68PQoay+4RG6O+n9HfVpY0HHGSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdbQVg3H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdbQVg3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717633784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dy8RecKrsbrtUZOaJeeQUMzmYXMFk/2qfZzulio2MDA=;
	b=KdbQVg3Hrz6Onwmsh4jjC/V7cRuHedWJASTxbR1lCNAeLPmVa+DfRU2Pwcyt6/41TorH/j
	Nw9lJxqCO5dQ/PxfPfUmKa0J6GIuZfebS0xUIAq6PGfHIQSzAAiV3uw8spRzGrGWIurbY9
	Nc+U24TjtpHlEzQp/CMJbE9x86cBijU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-0hSAQoMuPuW1W6gEuYttMg-1; Wed, 05 Jun 2024 20:29:43 -0400
X-MC-Unique: 0hSAQoMuPuW1W6gEuYttMg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70243d6914bso344511b3a.3
        for <virtualization@lists.linux.dev>; Wed, 05 Jun 2024 17:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717633783; x=1718238583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy8RecKrsbrtUZOaJeeQUMzmYXMFk/2qfZzulio2MDA=;
        b=qVlV2zJaTqYIECSy2WwaO3Jkn60SsY8OQgMIr0XKXFGufxddl73BRo2fg3PVub3jGj
         KYDAyIbjHBljAXDhsRJn09knuu3BFCdKl834POlQ8Mt8/0TmAUgp4IakeF1KBx9Iupxt
         3oW0blXPcsOhqWwsQIS0GxkxHDhL8QfNE/4ANPO4G8OG32oN/gXczxWFtjqMAcknoeq0
         0fcI/eV3Ya3ia8mZHK/ZMgD8h7elezCF2GCSoP3IeZInpdvrxuSxWR/JnF022vqyVqUu
         t/IXCv26KqiqC2bo+ex3Tp50KOfOa2wg98T4ALbDeec9otHDb7P9RO1zXy701Il7m/R8
         n4tg==
X-Forwarded-Encrypted: i=1; AJvYcCXu5XfAjaXZkC0cWIElnm9nFNPyHbb47HdFILOzvXlhG3kstzVhGebjETGgY1PXjgJT3r7SnN8hhc+OP6w2NknFbymMHY6m5fcqctxT04I=
X-Gm-Message-State: AOJu0YyHGQCgKXeyMT4cvSPbkYKxpdwoL4mvMt4/8yYF49AsuLVn4r4V
	X5ThAlHgKPw8PbbJuz+IPZn497f2axmCNPa7AzZu3uv4zjBukED3lRTNknkYjjiicXVgEKLMCT+
	TelsbBCQBPcGkbc/icUROhY4XnwivPCf46nphhMwv/cg+WKqhG1hQUR3t5ks5U3auAxh23F4YM6
	c2hRnRpmEwMZHQh+qhD4KcqatmJPARgHG1go62+6Q=
X-Received: by 2002:a05:6a20:a115:b0:1af:cecb:b64a with SMTP id adf61e73a8af0-1b2b6e3cbb9mr4760219637.9.1717633782413;
        Wed, 05 Jun 2024 17:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7dGT7LxJOjRZPml9gySlcFgSTsjNhhTPaTCsUhl4sJVsTFgjndYkpOFes4/KelIU21rBjWXq5/ZqgSpluWnc=
X-Received: by 2002:a05:6a20:a115:b0:1af:cecb:b64a with SMTP id
 adf61e73a8af0-1b2b6e3cbb9mr4760203637.9.1717633781731; Wed, 05 Jun 2024
 17:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240605135245.14921-1-cuitao@kylinos.cn>
In-Reply-To: <20240605135245.14921-1-cuitao@kylinos.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:29:30 +0800
Message-ID: <CACGkMEvB4MoGqqOLvNyY8css8kq56-D5J2M4VZCM1AfGCojiRw@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: Use the __GFP_ZERO flag of kmalloc to
 complete the memory initialization.
To: cuitao <cuitao@kylinos.cn>
Cc: mst@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:56=E2=80=AFPM cuitao <cuitao@kylinos.cn> wrote:
>
> Use the __GFP_ZERO flag of kmalloc to initialize memory while allocating =
it,
> without the need for an additional memset call.
>
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
>  tools/virtio/linux/kernel.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 6702008f7f5c..9e401fb7c215 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -66,10 +66,7 @@ static inline void *kmalloc_array(unsigned n, size_t s=
, gfp_t gfp)
>
>  static inline void *kzalloc(size_t s, gfp_t gfp)
>  {
> -       void *p =3D kmalloc(s, gfp);
> -
> -       memset(p, 0, s);
> -       return p;
> +       return kmalloc(s, gfp | __GFP_ZERO);
>  }
>
>  static inline void *alloc_pages_exact(size_t s, gfp_t gfp)
> --
> 2.25.1
>

Does this really work?

extern void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
static inline void *kmalloc(size_t s, gfp_t gfp)
{
  if (__kmalloc_fake)
                return __kmalloc_fake;
        return malloc(s);
}

Thanks

