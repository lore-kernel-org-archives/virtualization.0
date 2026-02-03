Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C530CD87
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131083; cv=none; b=btJ/0QOktXiVYbSMsZruyF9KRMzrAxZRZ1wxzggIsTGAcd5JekY/rIdFQPOENoJpnmw91c4QzPUMQUBoebM8afzitydUJxt1Q1JTcAPNkBAlmwAafwQJmvXwXjvmqjoUPuA4gY2VC1XIxywkkFBowUfxcVOdk0HwXw7k4OdwbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131083; c=relaxed/simple;
	bh=Tm2QM8i1svuuoJoHK9V7Ek5vZ8YrLJM2q5ownuHMJ0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdXjeb0nskdeO8iAHsrYx7YvwPRkWLbTkg8hLlIc8C42Nexu0pJKhc3v9i/7hFUQleCLyyvWCnIzB1Rwx/he9LJ3B0FS0CUA0BvVaAgUBFQfFQaCURkclFBY9eL7mVVn39vf1OAT4bbqMEZ+4hWfi71Mrq67o1gEhpdSq8xcoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DE87ySjE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DE87ySjE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770131079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9godM2Ifb47b6uvcj/guTRS45/W+PeIwjHNaTPGuQs=;
	b=DE87ySjE5Ht4KYtECie8CUKaPWD1MT1gQ3UIiufW3gxJprNIrRduCyxNlz3OGiIiV3krsK
	Y2GQW9iPVJfuWD4RQcuvDa/sIRzpy9+Oj2DXSlt73Y7uaEiAWmwZ2Tpr1WlwgkiLr2z2p7
	kxinfGwGX/nlXnU6dUo+nLszU4Ncxns=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-0ZtB2crdPWCs-BU2InviiA-1; Tue, 03 Feb 2026 10:04:37 -0500
X-MC-Unique: 0ZtB2crdPWCs-BU2InviiA-1
X-Mimecast-MFC-AGG-ID: 0ZtB2crdPWCs-BU2InviiA_1770131077
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794b240c0d3so20141847b3.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 07:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131077; x=1770735877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9godM2Ifb47b6uvcj/guTRS45/W+PeIwjHNaTPGuQs=;
        b=NQoCA+yt3FAsuZuAKvYYqIDBGCaa14YKTYE4HxYgJIAncVv1YonOMh3Xh2lEBP2Zx2
         YQW/7KKwjJz/cD9gReyCOuysulJNNecNqfc/X/tPaV5kPOskJdMMgj4ewWy9x6W517v1
         qaHgilTnW+1vthOo0zK+kDsru7H2lKXcAjJXaru8urshzgI3tnqfvznKzDyEVbqPQFga
         N+VeNZPypAX8r4xkrfVZ6ZL2uSK9BLeCKUuCovs4o2oczEP2oBr6rQpjZPcnG/BXLV0Q
         5moAgRQcFzkoIgXhHQbK1/02+kt7tj4p0b1+yN2qIhotnPRgpbqiPdpmSthHXM5Zjb56
         Hr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWIkRgRU6nVdVwNHU4TrhgZy+pdIidjoSjrwkWxX+85JMF8XqaVi7ZamuKKeC4ecCS3363A+a7e9ezsFOy4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YztgSCDiUrP5o+oqNC+mOvVl5PjwUnWTOAINxGHFks07hmJoJ2A
	lenHNOWTRB17ujp2Hx6GLT4bPIpKaH2+l07M+iIP77c4lH9kBijSdX8IefRvVhq+wlSY5d66Nc3
	rm1zJMipI58Ve279VAchqiLHYvb8es+qtwN69hE8n4/XkHFrq4e3Wc8XZYx5ye+Y4ZVDj0Akte9
	9PsY9WfbIxd4dcfmOeaPhCan84waKeNvFPmGH5dWjKN1g=
X-Gm-Gg: AZuq6aI+gid5GYQfqyx6cXKupW287QjfkvHJVkq1yCoBioCSqS6YP6aKeD3PSJilmEU
	JFc/wYud0uTtY2GPFJgTE1QBccSURQZLZBQPSulthUTeMuv2dp+OKaXK28qZjLg+2KG+Kvs4v7L
	nWYWXqnm/QQuCWeTmfnZl9/rVKS9nk2lpM2uf9t0Q/tj3wLILI7grMvCPv6TNA9lWhAg==
X-Received: by 2002:a05:690c:e3c3:b0:794:87bf:76ef with SMTP id 00721157ae682-794ecce77a2mr31178007b3.7.1770131077034;
        Tue, 03 Feb 2026 07:04:37 -0800 (PST)
X-Received: by 2002:a05:690c:e3c3:b0:794:87bf:76ef with SMTP id
 00721157ae682-794ecce77a2mr31177697b3.7.1770131076653; Tue, 03 Feb 2026
 07:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202095940.1358613-1-arnd@kernel.org> <20260202095940.1358613-2-arnd@kernel.org>
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
 <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com> <20260202114412-mutt-send-email-mst@kernel.org>
 <34d3ce77-84b2-476c-a678-e092831041ae@app.fastmail.com> <20260203053142-mutt-send-email-mst@kernel.org>
 <CAJaqyWeZes2nUFQNaq5NmXN7127eh+bNFQbB7yX73TuZ0=xRng@mail.gmail.com> <a4612499-6a67-4d6b-946f-dc038ec2b6fd@app.fastmail.com>
In-Reply-To: <a4612499-6a67-4d6b-946f-dc038ec2b6fd@app.fastmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Feb 2026 16:03:59 +0100
X-Gm-Features: AZwV_QifbHp6p7hyy2fcbKu-Dh32Ta0Gw7gt6W2K8Xl7c7CDxB0t7XZZLwdyciY
Message-ID: <CAJaqyWfNyfid9YHjQfZrwStUxvXwFahni9FcNFf_C49-BS=_eg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sFF6OCxR-_O3KKG4ql50Mpmhq4fjSK7c-5msOpSghtE_1770131077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:42=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 3, 2026, at 15:13, Eugenio Perez Martin wrote:
> > On Tue, Feb 3, 2026 at 11:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >> Along with it or no, surely before the release.
> >> Given 32 on 64 with this apparently has been broken forever,
> >> I will merge this just based on even you did not bother testing compat=
, I am
> >> inclined to say I am merging this but not rebasing because
> >> of this.
> >>
> >> Oh and we got lucky this didn't leak kernel stack info.
> >>
> >> Eugenio, note for the future: please help make sure UAPI
> >> structs do not have hidden padding.
> >>
> >
> > Sure. I'm trying to find an automatic way to check for this but with
> > no luck :(. Arnd, did you use some tool for this or you just found it
> > by visual inspection? I'm trying pahole and -Wpadded but the output
> > includes a lot of struct not related to uapi.
> >
> > I guess it is possible to filter it with some clang or awk machinery,
> > but I'm asking in case I avoid developing something already existing.
>
> I have the patch series, but it's not quite ready for submission.
> In total, I annotated around 10% of the structure definitions
> (500 files) in include/uapi/ to shut up -Wpadded for all the
> existing structures with holes in them.
>
> In the end I turn on the check with
>
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -6,7 +6,7 @@
>  #
>  # -std=3Dc90 (equivalent to -ansi) catches the violation of those.
>  # We cannot go as far as adding -Wpedantic since it emits too many warni=
ngs.
> -UAPI_CFLAGS :=3D -std=3Dc90 -Werror=3Dimplicit-function-declaration
> +UAPI_CFLAGS :=3D -std=3Dc90 -Werror=3Dimplicit-function-declaration -Wer=
ror=3Dpadded
>
>  # when cross-compiling with a minimal toolchain, use nolibc headers
>  UAPI_CFLAGS +=3D -I$(srctree)/tools/include/nolibc/
>
> which of course warns for all the existing holes. I will continue
> to send fixes for new instances in the meantime, as I'm testing
> linux-next.
>

Got it, to develop something in parallel would be to duplicate work
then. Looking forward to it then, thank you very much!

