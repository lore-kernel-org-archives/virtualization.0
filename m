Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323E18C912
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113521; cv=none; b=moUkTaLpHC2foRWXzhue0w1jo/uabgu9xiJqwhjRhDc15/nblF5Uw/2MMEXaxyF9gdgqrzqwcB+W1XMFipFkXLGd4NMvkcytrKpYAYkpOpYzxujHjfqKlisFVIguBN7ptQhpd9TfkJtT0ehFqtJe3EavW5N5uixhTwaVcZLl+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113521; c=relaxed/simple;
	bh=3za7BURotfmf25pYrluOSaycbV9zOEtwXOCNqO+bgvQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBsxz8ZronrVz5z/Lm8XD/QKkOdl0vRgnoH3c603QP6zTclIB3U2udjHiQZ+/r5JiG6uTfn/n1UaXSZxNz8FMycP81nLin8RAabDjC8Vb5tZI/a13/yr7zrULLP7ku96GRtJdhd9w8kRFWTKH6r5NHl2E3ltQH/x/n5RiflgAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiTmUFQo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiTmUFQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723113517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRwnpUIdbkqOIA1QwdrH67QxUD8NaDJn9Y50HZQIuz4=;
	b=ZiTmUFQo5VS3f1dlSUdQhzy4/hCtq3Nvkh2IHpEpjrYpsa91IWYTs27dxQ/2ZC1YZMEooZ
	6tnktsTswxZcbE8MkyAZA58oVNzZ5ITFmMFtHW037zffTKq/bHSfGZSaHriPQVg1tqbWrs
	mp0t97nzh1geZVTryhagG3vcJMjauz8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-_Ek9sPFXPaGu9lOCeyIHAw-1; Thu, 08 Aug 2024 06:38:36 -0400
X-MC-Unique: _Ek9sPFXPaGu9lOCeyIHAw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb5ab2f274so1120838a91.3
        for <virtualization@lists.linux.dev>; Thu, 08 Aug 2024 03:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723113515; x=1723718315;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRwnpUIdbkqOIA1QwdrH67QxUD8NaDJn9Y50HZQIuz4=;
        b=rZh482WQIolMps7ghXy5VYDBE7VkmIWj0/6oOiOwEcPkkacVGf3RlqCIsgkOTyaQ6X
         QnJ7VR4J5pEVy4ia5jt5u8vjgpBa2dcFZn84DmAOV1cnkzJdnaBvBV/YSeBNRGutz9Nd
         zUDEw19PWz/8fLQHMX+FlC9Z017v0grKdVnCrqmLHbKTv4wNFRv6KuBwWiVMi0k4nTOH
         6XUXM/33SP6mPHhEdHrDHJ2wFnsI8LFbunAiGz9IhgGGcB9DTXjOwYSPCIPESnCbKdHo
         rEzdJhqdMsWIES3OMPfbMMTDljmbVSusznYwmjToXeXl+Ubl/XJ3ZJKy5CLS3x6qv9pg
         HpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIJYCK5va44IAlxEgh/yv3/r3FNS2XPdBDdubgrNBKtPpsnvXxd9fXnngZAMXvQeCnQBDTCMpQD0qXWppYMuf3dlgS04YSDJMsa3NRfiA=
X-Gm-Message-State: AOJu0YyyL1kzTcw0iUohu7L1sDRdPlpFDyAZRiLrfnTwsLIfQ6q1OUmu
	ZH00XydGMkuZURVG7Ns8zLn+IrX/GDDc5dmQxp2KXEnqGyrZ8/CGxTcKrY1BJG5CdLzRozg2RpC
	E+YDhsXFZCGcG9CqUvJFIT6n18zbQ/uCnBGBjNd16ArbNVy660eg59UFe9+SjTcoo7gLGQcNe3N
	I1PFA3P/28PPTPpCxJ1EPZuhCdCYkqfnFoa0knWMy6RZl+ivrx9w==
X-Received: by 2002:a17:90a:5d12:b0:2cd:3445:f87e with SMTP id 98e67ed59e1d1-2d1c3363e33mr1679353a91.2.1723113515122;
        Thu, 08 Aug 2024 03:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOzJRKQe2DGOfVTSSGEssWue8gMrWTXP9ffNqImYaeYOp5wav62zp54H1TgQfbyYloERWPOSL4qaV62zRFwW0=
X-Received: by 2002:a17:90a:5d12:b0:2cd:3445:f87e with SMTP id
 98e67ed59e1d1-2d1c3363e33mr1679323a91.2.1723113514650; Thu, 08 Aug 2024
 03:38:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Aug 2024 05:38:33 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CAAfnVBki816fSPuQ_FcvuwYzbSwiS_WaYsGSA1AyitmAA5OsXg@mail.gmail.com>
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
 <CAAiTLFV6mAgrMj=itcxoBCibvYRyrAk02wYp-gYJ8kxhF0EPmw@mail.gmail.com>
 <CAAfnVBkWKn3+YEhNz0CTmw-T_jjL72axkWqYgkzkSa72t_Gf0A@mail.gmail.com>
 <CAF6AEGsnpEYFsCfZUAPopWzY=wv_GWn0P5f5D6U9y-JrWGQVnw@mail.gmail.com> <CAAfnVBki816fSPuQ_FcvuwYzbSwiS_WaYsGSA1AyitmAA5OsXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 8 Aug 2024 05:38:33 -0500
Message-ID: <CAAiTLFUWhP+wy694MbYDvzHgUD_pZZf7Jj=AfVvTj6CWAYZ+zA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, tzimmermann@suse.de, mripard@kernel.org, 
	olvaffe@gmail.com, kraxel@redhat.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> On Tue, Aug 6, 2024 at 1:15=E2=80=AFPM Rob Clark <robdclark@gmail.com> wr=
ote:
>
>> On Tue, Aug 6, 2024 at 9:15=E2=80=AFAM Gurchetan Singh
>> <gurchetansingh@chromium.org> wrote:
>> >
>> >
>> >
>> > On Mon, Aug 5, 2024 at 2:14=E2=80=AFAM Sergio Lopez Pascual <slp@redha=
t.com>
>> wrote:
>> >>
>> >> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>> >>
>> >> > On 7/23/24 14:49, Sergio Lopez wrote:
>> >> >> There's an incresing number of machines supporting multiple page
>> sizes
>> >> >> and on these machines the host and a guest can be running, each on=
e,
>> >> >> with a different page size.
>> >> >>
>> >> >> For what pertains to virtio-gpu, this is not a problem if the page
>> size
>> >> >> of the guest happens to be bigger or equal than the host, but will
>> >> >> potentially lead to failures in memory allocations and/or mappings
>> >> >> otherwise.
>> >> >
>> >> > Please describe concrete problem you're trying to solve. Guest memo=
ry
>> >> > allocation consists of guest pages, I don't see how knowledge of ho=
st
>> >> > page size helps anything in userspace.
>> >> >
>> >> > I suspect you want this for host blobs, but then it should be
>> >> > virtio_gpu_vram_create() that should use max(host_page_sz,
>> >> > guest_page_size), AFAICT. It's kernel who is responsible for memory
>> >> > management, userspace can't be trusted for doing that.
>> >>
>> >> Mesa's Vulkan/Venus uses CREATE_BLOB to request the host the creation
>> >> and mapping into the guest of device-backed memory and shmem regions.
>> >> The CREATE_BLOB ioctl doesn't update drm_virtgpu_resource_create->siz=
e,
>> >> so the guest kernel (and, as a consequence, the host kernel) can't
>> >> override the user's request.
>> >>
>> >> I'd like Mesa's Vulkan/Venus in the guest to be able to obtain the ho=
st
>> >> page size to align the size of the CREATE_BLOB requests as required.
>> >
>> >
>> > gfxstream solves this problem by putting the relevant information in t=
he
>> capabilities obtained from the host:
>> >
>> >
>> https://android.googlesource.com/platform/hardware/google/gfxstream/+/re=
fs/heads/main/host/virtio-gpu-gfxstream-renderer.cpp#1691
>> >
>> > If you want to be paranoid, you can also validate the
>> ResourceCreateBlob::size is properly host-page aligned when that request
>> reaches the host.
>> >
>> > So you can probably solve this problem using current interfaces.
>> Whether it's cleaner for all context types to use the capabilities, or h=
ave
>> all VMMs to expose VIRTIO_GPU_F_HOST_PAGE_SIZE, would be the cost/benefi=
t
>> tradeoff.
>> >
>>
>> I guess solving it in a context-type specific way is possible.  But I
>> think it is a relatively universal constraint.  And maybe it makes
>> sense for virtgpu guest kernel to enforce alignment (at least it can
>> return an error synchronously) in addition to the host.
>>
>
> virtio-media may have support for VIRTIO_MEDIA_CMD_MMAP too, so could run
> into this issue.
>
> https://github.com/chromeos/virtio-media?tab=3Dreadme-ov-file#shared-memo=
ry-regions
>
> virtio-fs also has the DAX window which uses the same memory mapping
> mechanism.
>
> https://virtio-fs.gitlab.io/design.html
>
> Maybe this should not be a virtio-gpu thing, but a virtio thing?

This is true, but finding a common place to put the page size is really
hard in practice. I don't think we can borrow space in the feature bits
for that (and that would probably be abusing its purpose quite a bit)
and extending the transport configuration registers is quite cumbersome
and, in general, undesirable.

That leaves us with the device-specific config space, and that implies a
device-specific feature bit as it's implemented in this series.

The Shared Memory Regions on the VIRTIO spec, while doesn't talk
specifically about page size, also gives us a hint about this being the
right direction:

"
2.10 Shared Memory Regions
(...)
Memory consistency rules vary depending on the region and the device
and they will be specified as required by each device."
"

Thanks,
Sergio.

