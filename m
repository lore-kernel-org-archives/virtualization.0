Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BEA2DB79E
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551692; cv=pass; b=MnWVN9/C++8d0SiEFXzvdUxaD2EqzyenN8zWpTD6mFWihig32Quv0T4K+7GZiOW9l91PImpz19x/xyd7QsRu2cYBrs3u72MUw6xaZmwIIlHqwH8eVuh3kxSTQBDeCU5DXJBP1Z1ooH0GdAsMP46w4TNm3paNnX843UyUvJLjL/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551692; c=relaxed/simple;
	bh=tBWsdUmqpMA5QmxhdhkcdrvEGx/LMSt531O8iAp6EJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEceTPyYbEV9KDdR8qmaj82XqDiwIcKVIrjUjTa4gnFE9crr2jg5+7c2uE179l+Jht8B3/T/rSJnSP3RqfsnCKagIwx4vyTVtXWqs8dg0vtNrXDfj0yV2UTZH9YT/svVUr0aUF0d5WU3tp+RR1YKAbgX5MipI+4zWyqTqzupJ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBLhG7ou; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBLhG7ou"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd6f65c781so45011997b3.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 19:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778551690; cv=none;
        d=google.com; s=arc-20240605;
        b=kdpfk88kgaeJeS+G+DJqsXXR1+2svKbuYvAvgcwQMF8vYcxXZFGtvDyW3eQP9zFSWS
         kW7ka8wpeDLEnBv5MYxDUq624qLy7fYY2NXhDzdYvYSz9+LmR+7Euam3i3l4BOFkk8FM
         pHj7x4zbDUkXqEiyURjlyccsX5pQgMOVQGxggAs3yXN31MtSt7trnF4BzHcwQCLIVKLZ
         EoyCe9Oc399sAHazifhpQXaKqU8HTYLLLJKGk8r/Nk15EG/zbXIfyRA/DugPvOQLvojE
         97X/3YJeW5q1YFFjbkDIapZzlccH07SRkI3/eJ4RdnjF6qFww8me2+3Sd1pbsxXilyOj
         o14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
        fh=CIvVc6c3WEbF61tOGBeSeLiXQPWJmlmABmueDlfbfvo=;
        b=JN8y79Qu2F4G8mqX7JE8s85P7GBONZCYm52nZ+6vWW7N9iETBGYG9FnfOZiFg35B+M
         o8X/tXJdfmL+4nTjUyoMQoH5ztFByb1bOcD/h2YLNmuy9CXBaQDw+B7U2Qtg3j2HxDjT
         FhvtduSWbZms3E7yydOcdx9u+5ckXO7sZ5yIY6LIvLxq+Gxsq17oLL3WgZ2B7ZmPLrUM
         k9MHPH9lXqo9MqUzmBNSYqYv1iD7Scke7Z6i1rMESZizbttgEjiXNWu0aGmxaJfmCshN
         yGFeKvJrrRVAFHr5705qYF1FoZqpmbH5a6x3Cc4egkNFOHRKpmNgAUiPF5g3C7QnxLyn
         Blew==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551690; x=1779156490; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
        b=DBLhG7ouFTCZZrKaehbja/aB+ffk98MNoioWqg5EGmc99tWG1mfujixmeFeARA6obv
         dzTGQsVlk1ID3oE6TBvL/dH2AICMIuy2opYzdEzU6sR/KdCR3Ai2NUrIJYkyTDKZRkD/
         zuVv6zk7iYuUgMp/iSiyuwbLBQX02urCrLWwvVefKnbZ0UwlC6v0vn3v3nIpYHUCglBZ
         OXhwbmipV89Xua4sHNa12xWsDp4kjQPhLjYrzO8JH9iturwxPC+jqMe5sD0DFzD7dMaQ
         kJWFuLbExgyiZ43ZEHaYI177Y+M2ZAjZVo+czttEBN9Gqq92pnD92zlOU7fKKMKgKAIr
         GEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551690; x=1779156490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=77FISKu6p2sK0Ty+tC1DOLiHarz8B8kEbkXuaAXpQYA=;
        b=ngg8pwcn76HR46K6e9vW5nv/HuWokEKyJ/ep0vy67z07e7cCdY5fTwEViP5qH3qcpy
         NAxOaOFnz03czMiwlU0nHiAgeX5YLAmb4QPJFPOi+LXVDsAuaOrNcR2n9n757e0gDAl1
         XuUuryLhHnc/w8JeFVE6QrPXLatfJ6AFL3XDqU9E+7kMF7GVqLQB3eNeigD8Z3Q472/6
         /NHGxhiTA9JAdb4l8j63aVVHCJAsX5zmCnjXxegWkI868916O3iFnmybBsQhy+FhAjpo
         voNiSu6hDN+5yz2neEo+P7Vc7iIezaWXQb89rv9mUIHyDVsCgHEoM/jCQoNphy2FNaH6
         Ic1A==
X-Forwarded-Encrypted: i=1; AFNElJ9JkYElk40RAc4qA25m2L0ODSInVCMXuEygUEL0tg4niCsiuuG8+kRtfwtp9vT6Yc7v1TSEk3dUNNTnKdDScw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI8cMcV5fTCzlnmmVBPivudbyi0rPCVOYhJbA+7Ff8zm0bIFu4
	LEHx4fmIBe2ijVtBbQN3cSksAcQW8H642qL8hM6UTGVuB14ayadR5MtCCqK+Vtti3hSLp+Ni8D+
	OZ1vZLOfZRPOOs+1+pVcugzluXfW5zwE=
X-Gm-Gg: Acq92OE+HF48eQe6+LktPut5tLP1pHugBuPm3w68JGRqNQqcvRdiy/ArW+44JGnNqc/
	PuTVRw1hazpbhZc2lZcAUiv/RI9ZrqOm9mWuU4QOl7GzG95sDXe/3cvBpmQmEiSKo/HAL+rUoc8
	26PU4h2I8of3UyUwosOO6F9PGwHPQ341ZQtJk4eG0+EcOrQKC5ag0Bdg5gE407Oz46ikPGYE2vA
	qPU33lLfVcFp7qPZMLo2G8qLw8+E9CA2GRBL+KdNVdObiCWAtwOuAP1uzEA04bK5MFkbn64i2lQ
	rygL/KdVq4i9npsoPlPnNpJ7DSifCKRaWC7YvpxD99mk4EVZ+ecKKr8FX+ra+6eB4P+0LiOK
X-Received: by 2002:a05:690c:22c4:b0:7bd:92fc:bffc with SMTP id
 00721157ae682-7c510b7019dmr17683127b3.28.1778551690519; Mon, 11 May 2026
 19:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260510053025.100224-1-kartikey406@gmail.com> <e1741cf2-3416-4464-bcae-741f0c87448b@collabora.com>
In-Reply-To: <e1741cf2-3416-4464-bcae-741f0c87448b@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 12 May 2026 07:37:59 +0530
X-Gm-Features: AVHnY4J2D1-C23A11f7UqzcVhKI94fEZIIYuSoxukd33EEp1xmrI8ysvEMqjWdI
Message-ID: <CADhLXY6wZfejdnGRKBy5raFE8U_VAivqx=oa+tmNAAOx-cSF9g@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: check virtio_gpu_array_lock_resv() return in
 cursor update
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 2:41=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>                        plane->state->crtc_w,
>
> Thanks for the patch. Atomic update shouldn't fail due to non-critical
> errors like on a signal interrupt. Could you please move this code that
> may fail in update() to .prepare/cleanup_fb() callbacks?
>
> --
> Best regards,
> Dmitry

Thanks for the feedback . I have sent patch v2.

Thanks

Deepanshu kartikey
