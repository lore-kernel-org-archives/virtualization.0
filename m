Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EB208A0
	for <virtualization@lists.linux.dev>; Mon, 23 Dec 2024 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734926349; cv=none; b=dLCrrncBy96W8CVW+7dCRVPzxmqlQ82joF+7ff04G6cX5+K+28i6EGgVAGlNoNtJt2Jw69Lk4pgB7TVUUPfp0G3G6jOPG9wdjYOj7/jadGUhdr4xw9Hx4Pr10cgJvk5PiQeCv+CM/7OrTGiM952JQS7OeSJ0r2wtnc5LM6Q1IFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734926349; c=relaxed/simple;
	bh=tIPndJZQtA1RcBNKVALGBUcrFnYCxwpGcIl2+L4CvIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt0swjOCSm1HBgVsg6B1ipqxUAs7qvjtNSeanpkUdTU6OKKwPhMj/5w+SxAKkSaTv9EDXvsPsbIQdVY/wsuzEk+gAwqt5cpm/Q6PRnPenFYTut2eBTNmkMnfT9wQD0UOZR3fGdZQgyeykKoJVKGI6wc6F//9ejAFCmSnWN/xR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGk8KSFt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGk8KSFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734926345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Gh+/qAlv1nIRMNhmX5QpSVYM1VgOctdtq/Du2rzbvw=;
	b=UGk8KSFthLcPulPUBc4L1ZigGIpiynSSrczMImzXK8ZOCxXYtm02RpS4jmzKkXDOaIYf/1
	T2Wl7E2hPEl0KiuDL4Zn8TFvYP0eNUjQ8eKFk3pgmjl3BYeGt+8khNUt4WgMQAaOSLyM93
	h8TMIiMY8VlvL1xdWo0TC4oryVGg+A0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-gu8coJBzP3yoO1uIjgXYQQ-1; Sun, 22 Dec 2024 22:59:03 -0500
X-MC-Unique: gu8coJBzP3yoO1uIjgXYQQ-1
X-Mimecast-MFC-AGG-ID: gu8coJBzP3yoO1uIjgXYQQ
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-728ea538b52so5247098b3a.3
        for <virtualization@lists.linux.dev>; Sun, 22 Dec 2024 19:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734926343; x=1735531143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Gh+/qAlv1nIRMNhmX5QpSVYM1VgOctdtq/Du2rzbvw=;
        b=wa4d5cu/zNIZiG2JNXMNgUk28tXHF3az/UU9t0zX/TDVWULewUd/+EIAbmSBhCKAaL
         a0I8tVKSY/gezBz16KM5CKTVh7p2sQmIe4vIgMHAicJT9uMx9IGFEGrgIyJy+D6pw2YK
         w2yXDwCxz9FFI59orG7pk3wnTp1A+eIOA2/UUoq63qABMYdGtsXOgBHA4pyrde58PSiX
         RARu9o3nA9kk5cx5wHjm/oFC8OFywkJLYAAAXphAQt4OcksLOeyggXGj7xuitlmWGuZh
         xk58c0KZGDBQ+xEN7uw8MzicsDFVrlf1YeRsEzBraP9asLwRTuFVnNebzDTmMRwkadRX
         cP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ul/VsqRO6P6lKGKtR06OZNCqLZiKrPBS+BQojdBmPj2Rneg43aRyI5EqOGeyJdTxgDbtlLrr5Vb8H28eHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5/I+V0GtJ1NDBV0oEB6BLVoD77ay2FTYyaD+4KEK6jaLgJwb/
	L6pAiw4twa7V+rceSP1qk7oj0fUNG1FupHmRu+Q6rucdvwp5pXiPPqH6QbJy8Ijcw4bB5QvBwW6
	z+HKeIlZ/Ll/32Zc/8DTP2jv1a4sRYoUkxAXXvIC0C7U7m+PEVdyEi9u2dGxJScgC13/J4OcFGS
	TPwQgU9r1vx+RXmM8/WcTZhTl+26hgB5v8KaklEAU=
X-Gm-Gg: ASbGnctagSZYSuumemOX+kxHBWDyjhGgLuvOnnrpE+WoQWcJ6om6WoxpQwCE7I8Mx8/
	WG12Wj0VZVziWuCVXLWxqZ8ExX2vpvcqR9gXDQv4=
X-Received: by 2002:a05:6a21:164e:b0:1e1:bdae:e054 with SMTP id adf61e73a8af0-1e5e079985emr20393689637.25.1734926342793;
        Sun, 22 Dec 2024 19:59:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1xTfMZNZM8eOASp1BRmDgMtcM0YaCbLNXZIDF8VltfOo4iVOSpCqeWUKwRhgUOgjLnIUfgqF9I1o1AQR/B1k=
X-Received: by 2002:a05:6a21:164e:b0:1e1:bdae:e054 with SMTP id
 adf61e73a8af0-1e5e079985emr20393658637.25.1734926342331; Sun, 22 Dec 2024
 19:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
 <CACGkMEtPs5O25KVxN3UJX8RD5f0EhNqrqdVqt28FZSMX_W6GTg@mail.gmail.com> <CANN35wLA6V7BzQm2nKENnVszmb2qWYuuOe_T_qb+vRJs9EkTXg@mail.gmail.com>
In-Reply-To: <CANN35wLA6V7BzQm2nKENnVszmb2qWYuuOe_T_qb+vRJs9EkTXg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Dec 2024 11:58:50 +0800
Message-ID: <CACGkMEug=QgyAEwKZfzn76O0A+_cQTt_JBpLhTfryNYzR-gc3g@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL
 for non-virtualized environments
To: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
Cc: virtio-dev@lists.oasis-open.org, anna@virtualopensystems.com, 
	a.rigo@virtualopensystems.com, m.paolino@virtualopensystems.com, 
	s.raho@virtualopensystems.com, chou.kensou@jp.panasonic.com, 
	wminer@linuxfoundation.org, jsmoeller@linuxfoundation.org, 
	virtualization@lists.linux.dev, stefanha@redhat.com, 
	xuanzhuo@linux.alibaba.com, sgarzare@redhat.com, 
	eperezma <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CNPVVKrKadsUxrBMIJrF-5Jid1hPcijRZ6b49otP8tg_1734926343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 11:49=E2=80=AFPM Timos Ampelikiotis
<t.ampelikiotis@virtualopensystems.com> wrote:
>
>
>
> On Thu, Dec 5, 2024 at 10:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
>>
>> Adding Eugenio and YongJi.
>>
>> On Wed, Dec 4, 2024 at 11:38=E2=80=AFPM <t.ampelikiotis@virtualopensyste=
ms.com> wrote:
>> >
>> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>> >
>> > We would like to share with you an RFC for the Virtio-loopback
>> > technology which we have been working on at Virtual Open Systems in
>> > the context of the Automotive Grade Linux community (Software defined
>> > Vehicles expert group)
>> >
>> > We previously presented this activity (see [1]) and now we come back
>> > to you with latest development and updates.
>> >
>> > We believe that the technology is more mature today and we would like
>> > to assess the community interest in the technology itself and in
>> > merging the code.
>> >
>> > Below we provide a brief description of the technology, recent
>> > updates and a short comparison with vDUSE that might be seen as a
>> > similar technology.
>> >
>> > 1. Overview:
>> > -------
>> >
>> > Virtio-loopback is a hardware abstraction layer (HAL) designed for
>> > non-virtualized environments based on virtio. The main objective is
>> > to enable applications communication with vhost-user devices in a
>> > non-virtualized environment.
>> >
>> > More in details, Virtio-loopback architecture consists of a new
>> > transport (Virtio-loopback), a user-space application (Adapter) and
>> > the vhost-user devices.
>> >
>> > The data path has been implemented using the "zero-copy" principle,
>>
>> This need more clarification, for example, how could we prevent
>> malicious usersapce device from modifying kernel pages etc. Especially
>> consider not all buffer occupy full pages.
>>
>> Actually, after chatting with Yong Ji, I've played with a zerocopy POC
>> for VDUSE, but it tries to do zerocopy only for page aligned buffer:
>>
>> https://github.com/jasowang/net/tree/vduse-zerocopy
>>
>> The idea is to map the page directly to the userspace if the buffer
>> occupies a full page and usersapce is expected to recycle the page via
>> MADV_DONTNEED. It's far from mature but it can demonstrate the idea
>> somehow.
>
>
> I had a quick look into the POC and it seems like it improves
> performance (by reducing the copies) without compromising the security.

Note that it has something left: e.g what if userspace doesn't
"recycle" pages via MADV_DONTNEED etc.

>
> In general, it is similar to what we propose (though we focused on
> performance mainly). A brief introduction of how data are shared with
> the vhost-user devices without copies follows:
>
> In virtio-loopback, a page handler is assigned to the kernel memory
> when a vhost-user device tries to mmap a new memory region. Any time
> then the vhost-user device tries to actually access a page inside
> that memory region, a page-fault is generated and the driver decides
> which is the corresponding page to be inserted to the vhost-user
> process.

Note that the page fault is really expensive, that's in my POC I
hacked the VDUSE to map the pages to avoid #PF. But it needs a concept
like "owner" so VDUSE can grab the mm_struct of the owner process to
do that.

> Before sharing the page, we have intentionally left some
> space for security checks to be implemented in the future.
> At that point we can check if the page requested is related to the
> corresponding device and if not then do not share it with the user-space.
>
> As correctly said, that solution does not address the case of buffers
> being smaller than a page, and indeed, there is the chance for malicious
> applications to take advantage of the data padding the page after the buf=
fer.
>
> Solving that issue would lead us to the solution you shared above. More
> specifically creating a bouncing buffer approach for those cases. I didn'=
t
> have the chance to benchmark the above POC yet, but I believe that it sho=
uld
> introduce a performance advantage over the upstream vDUSE solution.

I had some tests through qsd. I can get at most 40% improvement when
I'm using 128K write etc.

But when I was doing POC with OVS-DPDK, I didn't get good performance
as it involved too much madvise() per packet. I'm trying to seek a
good way to reduce the call to madvise.

>
> I understand that security is a very important point here.
> So my first objectives for the virtio-loopback future development
> would be first to address all the security concerns about the
> technology.
>
> Before that, I would like to assess your interest in the technology
> and understand:
> a) if the community would be interested to merge a new virtio-transport
>   which does something similar with vDUSE but does not depend on vDPA?

If there's an advantage of bypassing vDPA, I would like to know. Since
I'm seeking a way to accelerate VDUSE with zerocopy and the work was
kind of duplicated.

> b) if it would be interesting to make the adapter compatible with vDUSE
>   in order to add support for more devices in the current vDUSE
>   implementation?

That would be welcomed.

Thanks

