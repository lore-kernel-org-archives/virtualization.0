Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53938F954
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102066; cv=none; b=Ub3q5AwmtWzb+S8HSeusM+GzYpksZVJ5HZLSUmHVvfw/FPABbRZVFgNtAJSddFwviqjK6Wwe5h9RH7OfvjWeHheHtYnpbsX1aXI3HrsqT5+uBz9Fhm9iID2ZzNQum4Z/ZfQLUsxHOR0CT3fxYz1eqf65duog0tBjZ+MdhczDzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102066; c=relaxed/simple;
	bh=jmx1xSLThRneehyoyR0kE6FheolcOw8azLbLXbv83Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlzM4DFCuIrPL90msDNDbqwfM+aSUPTW5PZLXBrz8MgFW1tVOucwYUL3u3fe8nzs4XYMuGd9aEtP8k6wROAZCJnH3RPRhy0xBTIiWxZQSp2Hvjn+6D2BiPXKs9AhjRucLDWFlMFNggmaufaUSZW8fj+adNO1vkujNBMOjw636LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGzscgLe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGzscgLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770102064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNimXzTpG93X03QIaNiDxYSV57jvg89lSI3XuRnCCFw=;
	b=BGzscgLeBpgiVyYzbMtS8XahHQyBwACrE5FRVn1Wtponm30UedKXz+OBcOhHaijbBAvVu/
	FSUGYKNMB3lahBIjB5tsT/8Ge/VEifxxgIwxuDLaO14jiJKxpNS+Xp5S7O8APvHdL6CuTi
	bFGetaOVYh6c0uCT0I46x7Qdgru7EOo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-fKNDq9mTPeykO3Y6fqrvwg-1; Tue, 03 Feb 2026 02:01:02 -0500
X-MC-Unique: fKNDq9mTPeykO3Y6fqrvwg-1
X-Mimecast-MFC-AGG-ID: fKNDq9mTPeykO3Y6fqrvwg_1770102061
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78fb85eddf1so76343747b3.3
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 23:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770102061; x=1770706861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNimXzTpG93X03QIaNiDxYSV57jvg89lSI3XuRnCCFw=;
        b=XzzTd0jgW2uNVp1WFhHDGjHVIjrwNb2bHZn2SYuYHANv+Ay0MnYnkZ7uzAoUXp5HUx
         tHnIZtJjDsgGnWX1hBV4kft1m7bfMezNHanzSCwJCVjYkpwo2S3FsRSK5nLj2OiFxKvz
         bDjQoKZmwoM0RnkWK09QEdJv/NntCRN180O6mOPL7HR/03vBaNhH7xbB3sRBUwS51tLp
         HQ+sc49da/PHtTOalsxrZrylNX+DbMyuMQWgqhXKOb+ls343X6eMhWbFNqrqqCtcbmBj
         f34BDcpUTy53WVgn21gWygK0EF3jOpuj9pReOFCCiaVCtbMJ2Wy3agxaCB++kDSAXjVV
         Pmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWpZDNjvf8zy5lpHnpvWZMjt2fps786K8KtR6wA1E8puBJw56hCnVtKtQjKBzhZ4Ypb0XmiS+WV1hJlq8Y0zw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT2C4wjH7NpwSGDyNY45trONLSSaNChSD6A0qKB4OsZYIB3Vug
	5OnWUTs4Rp61QwgbUZt4TN7KhdOIAVSziOclTSIp34ulYYN7mlV3nUcM3JFkHnV2cqsHERHsL5y
	C9FBA5y1Ndp7ACPbWNIjji9T7xmAV9tk+HkyN21Tp2SD9ZPE5FmscU3csuj4W4ozyynCbKPOX2b
	MXmLOVykM8Pr1D8Ih10E1MTISOicUyNYQHwiWdVicSA0g=
X-Gm-Gg: AZuq6aIEz167J5a1EDmW28eJu6+52YeEEgfh7WMtJyWTyTGiLS8/sl1F2y5kqeVKjkr
	2RHjKNH7QAQ/l9h9/WoDsAgmHjXBX6VhPx3a1NOL++zKoHawT0VYJzo3Z8aq/BEmBW0EDWdEbWO
	UbrfpU3zhTUZ2XLk+7oAKn4suuirzJK3gitcV/iF5jSCOvh1aoTLRAutzIywnX465Spg==
X-Received: by 2002:a05:690c:4c04:b0:794:e9a3:b132 with SMTP id 00721157ae682-794e9a3b963mr61260197b3.4.1770102061531;
        Mon, 02 Feb 2026 23:01:01 -0800 (PST)
X-Received: by 2002:a05:690c:4c04:b0:794:e9a3:b132 with SMTP id
 00721157ae682-794e9a3b963mr61259757b3.4.1770102061050; Mon, 02 Feb 2026
 23:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202095940.1358613-1-arnd@kernel.org> <CAJaqyWcrjuQAp=sTfpiQsBu4pS7sxix-ggS4BPCzxyDwW5MZQQ@mail.gmail.com>
 <CAJaqyWeLYCTmOAqOPuLZWaJWGn8Tg3uf4DtYTZYpvZUCXxxYzg@mail.gmail.com> <2941167c-822c-4f37-a3ce-803bb94ab566@app.fastmail.com>
In-Reply-To: <2941167c-822c-4f37-a3ce-803bb94ab566@app.fastmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Feb 2026 08:00:23 +0100
X-Gm-Features: AZwV_Qhf5BlKGdn9L8N3P3MHu5sziqg8ioSlJmThOIMrStlZEXnVB1We6pPNkHo
Message-ID: <CAJaqyWd5b4vrRnrDS+fvQd+=vzmV=WhOL3ZahU_eh3_mwfNTtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vduse: avoid adding implicit padding
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	Ashwini Sahu <ashwini@wisig.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9Ki8WNLUOEV21UlAIWRqe0F9cwaaw5-OWuwf7xvQQUM_1770102061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 1:07=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 2, 2026, at 12:50, Eugenio Perez Martin wrote:
> > On Mon, Feb 2, 2026 at 12:28=E2=80=AFPM Eugenio Perez Martin <eperezma@=
redhat.com> wrote:
> >> >                 ret =3D -EFAULT;
> >> > -               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2) {
> >> > -                       if (copy_from_user(&entry, argp, sizeof(entr=
y)))
> >> > -                               break;
> >> > -               } else {
> >> > -                       if (copy_from_user(&entry.v1, argp,
> >> > -                                          sizeof(entry.v1)))
> >> > -                               break;
> >> > -               }
> >> > +               if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))
> >>
> >> I did not know about _IOC_SIZE and I like how it reduces the complexit=
y, thanks!
> >>
> >> As a proposal, maybe we can add MIN(_IOC_SIZE, sizeof(entry)) ? Not
> >> sure if it is too much boilerplate for nothing as the compiler should
> >> make the code identical and the uapi ioctl part should never change.
> >> But it seems to me future changes to the code are better tied with the
> >> MIN.
> >> I'm ok with not including MIN() either way.
>
> I think it's more readable without the MIN(), but I don't mind
> adding it either.
>

Yep, I see how MIN() adds a little bit of noise. I'm happy either way :).

> >> >   */
> >> >  struct vduse_iotlb_entry_v2 {
> >> > -       struct vduse_iotlb_entry v1;
> >> > +       __u64 offset;
> >> > +       __u64 start;
> >> > +       __u64 last;
> >> > +       __u8 perm;
> >> > +       __u8 padding[7];
> >> >         __u32 asid;
> >> > -       __u32 reserved[12];
> >> > +       __u32 reserved[11];
> >
> > (I hit "Send" too early).
> >
> > We could make this padding[3] so reserved keeps being [12]. This way
> > the struct members keep the same alignment between the commits. Not
> > super important as there should not be a lot of users of this right
> > now, we're just introducing it.
>
> I think that is too risky, as it would overlay 'asid' on top of
> previously uninitialized padding fields coming from userspace
> on most architectures. Since there was previously no is_mem_zero()
> check for the padding, I don't think it should be reused at all.
>

Ok fair point. Yes, this would need something in the code like:

if (cmd =3D=3D VDUSE_IOTLB_GET_FD)
    /* Ignoring whatever came in padding as it could be uninitialized due t=
o
     * not having this member in the struct definition
     */
    memset(entry.padding, 0, sizeof(entry.padding);
else if (!mem_is_zero(entry.padding, sizeof(entry.padding,
sizeof(entry.padding))
    /* Return error following the style of the rest of the code */
    return -EINVAL
---

So we make sure we can use the padding in the future. Would that work?

