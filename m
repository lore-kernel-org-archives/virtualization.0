Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CF15575B
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611940; cv=none; b=HsgskMwkMU+grlvtcWyS/3IMIxXxvDaTBpM8zIvjGtcoVN2GfqazCktFxgbUEI8S6s4A6DGuSUp6DDVu9fw1hc4pGDOhUJ704huNm1/YtM0mLrbrvElPajoCtcBmcGKfyIaMtKE4C5RDvfZVRGPwb5zb4KXccTcNRgHGhCS2VWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611940; c=relaxed/simple;
	bh=JbpQGyS2k2ae5y5xVtR1Gxoy3SaqtFSjvZ/rBlydswQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tmfv0w9rC4SKOOALav1NuLTnYMXNMivbgD4nwliwm+/LFvkZl0LPfwUHbhm+2uRyU9S2AomKomMvvzDbrx/0pdnR6h8GN0B8bbWA+XXnfO4vk1bVGK3XEL9MGL0Vh0iwtohS3LNM01dTX2aiK3/N4JnxZny2OBiP7Hk/teE6epU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhFyt3Dj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhFyt3Dj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743611937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jA07gZAckB5bQhywn6Vwf6YGCI+Gg9x9Lpp/1wjtdSQ=;
	b=PhFyt3Dje+jQIPTHrevqM7UXEPBBNX0OQEDLj7Lq/8j4iHgZBQq3tqN3e9ONAo0dYmbsAX
	nLCzNK0T0ADO9TrhToZnI/kcOkPYo9lg4J0qIbJwHJ/4ZprgRoUOs2cGbqBB0Rw0Vrosw0
	m+blJenT81xx6sjMms/zF7LoYxKgnOQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-PVsBxscYMMKdWvKk5Ze3GQ-1; Wed, 02 Apr 2025 12:38:56 -0400
X-MC-Unique: PVsBxscYMMKdWvKk5Ze3GQ-1
X-Mimecast-MFC-AGG-ID: PVsBxscYMMKdWvKk5Ze3GQ_1743611935
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af96cdd7f5bso28214a12.1
        for <virtualization@lists.linux.dev>; Wed, 02 Apr 2025 09:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611935; x=1744216735;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jA07gZAckB5bQhywn6Vwf6YGCI+Gg9x9Lpp/1wjtdSQ=;
        b=GulvNIH7oCHGtPk1N5MnPmvyjNqmzG3DRQujwDHY7Kpl+3fawSFa2glu9twGRcZUR9
         KeRtZk5gKffoVTLWIztvqZj8JXAyEx8Dy4+CHM8cXk5aFB/7C4FMEH7q2j1WqDhnMq3R
         gSM1gYyb38RNDtYXbnhpRNQse1HQyXTuK2UG3A9ggKZ+fFVNIvFqDtvrWSJU2xgthivj
         kwgmxk7cw0tGXsxeeotIcjiW+O4v66/DIFY1gYVdwd13C+Fhc67sUlPr5wz+tDY0kQRl
         VN9tUVbxKDmkab5x54JC81jpW+1G+zd7yhM6kNMCD0yv7nQZNPNE4QAhIexVdxDbYBPf
         caTA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+GtgFDxny4GRLJ/+1LdzOX1Zdf8P1B2yQZOnMp71aisZ+NBdNNacOn7Ohmzlk6HExLbf0GinHUcjZOCnrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWCY5/PffB8DNGyTpbUI9uEUV8Fb9IoTbZP/cQHQ7bp9VC8+2M
	Wzn9AZ3ahLvwclyec4OujBmnqbW38/KWOxY1X0iq6+ff5x51x+6L7CqpHmb8aquZepEW5YQz1g1
	hpJH1Bz4/C2UoKXxphzKm9Ds6S03zGUGbjlgdGwRjq1gxq1Z649r6vRinwAVUsOr30JbAJTznvk
	bek7+gkmrkhz4jcGoXrP1rPaMbGyFhGkDYk0d5yLA=
X-Gm-Gg: ASbGncv/ClzoT4XvxKy1OQ4kRQtExo8+vQQy8nuAIaexqvDH858r8PgJ0j9FfygX+Pi
	UbffRxFxVM3WZausCLSEH4CegbFjeW277uzvol7KORoW0z6nakhZcSYNg2yzrUibgy6EfTw==
X-Received: by 2002:a17:90a:e183:b0:2ff:5e4e:861 with SMTP id 98e67ed59e1d1-3056094b28amr11892719a91.24.1743611935193;
        Wed, 02 Apr 2025 09:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJeSWFRN5z2wxWXtKvRsOPT5CfAHrY7buz3TM6wH9tz9gjBfwFVkgsnjlHEgDTEqYebTRrhaxUSg2BrAW/4wM=
X-Received: by 2002:a17:90a:e183:b0:2ff:5e4e:861 with SMTP id
 98e67ed59e1d1-3056094b28amr11892695a91.24.1743611934877; Wed, 02 Apr 2025
 09:38:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Apr 2025 18:38:54 +0200
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
Date: Wed, 2 Apr 2025 18:38:54 +0200
X-Gm-Features: AQ5f1Jqh3JlHDowKtF1SlejjtYnTX8s9zM8BYZmloreOmj3oPMj4ojBdK_5F-_E
Message-ID: <CAAiTLFWOfX+TOcLFKpgqZvGoC6xSbDyHcefET-jtbm=bCTtqeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, tzimmermann@suse.de, mripard@kernel.org, 
	olvaffe@gmail.com, kraxel@redhat.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YfpXvtsh3L2C2zlrLusDGKwVR4ZNEiQUp2DyDYwvz9E_1743611935
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

There seem to be certain consensus that the information about alignment
restrictions must be shared in a device-specific way:

https://lore.kernel.org/virtio-comment/CY8PR12MB7195B5E575099CD9CA1F2F39DCA=
F2@CY8PR12MB7195.namprd12.prod.outlook.com/T/#t

There's also the precedent of virtio-fs already sharing the alignment
restrictions through FUSE_INIT (from VIRTIO SPECS 1.3, section
5.11.6.4).

---
The driver maps a file range into the DAX window using the
FUSE_SETUPMAPPING request. Alignment
constraints for FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING requests are
communicated dur-
ing FUSE_INIT negotiation.
---

Given this information, I'm going to rebase and respin this series.

Thanks,
Sergio.

