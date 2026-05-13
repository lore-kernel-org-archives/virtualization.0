Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CA3BB139
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708473; cv=none; b=ARxLcgZO3laUazcHWQn01/sA526/2Dj0DL96iH83G9XdfxArUjYt14ug0aRiq7kjenDs9FmIeXVq6xsIZzkggQjpTTRJGEuHnEb0ssudpeonrQIgc3OgOrLS5ODx/8dwLc16sMzA/6AHv4/O9OurLEP5xFCVNsMmehXs/FrXrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708473; c=relaxed/simple;
	bh=cGXqcrOJv/yyElce22I9PLZQTvhW2A8Q4mBvFtC4P1o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dNtj4boV00wO4k/PL+0jX8T6Cqg1kgZGrq99h0ZhSCvKQ5zDk+GldddtX5+d7fcw8slk7O7quEiE2I6ekqXDe5+/+Kc+RROOrvoWH2r5PTEOmr/3Fi8VPNmdclST9nDbDwAfcebzn8U6oM2wS5UFi8t4Ih9787jnq28+auzpuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-46ef241b62aso1963321b6e.0
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 14:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778708470; x=1779313270;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqk0Slr65mDNKAZF2Vaic14WCI6WBEKE9EJXBGKW5II=;
        b=fq96W0SI79YS6YQxjZhMYXwFTLY4sg9dxYZptXkWjDT7kjJgay9wZ/PFk2CJ5at3De
         vKPdVRuF76LDJ8malJ6ipXsRIkAGOEXFiJiBAWxGqU5X4W5Ech/HmHoxxaCSToFzqQQi
         n65at8/RkdV+iIiy3o3N9YiP5gPtdlX0GnBD7PdA6tcLm+zT0oHorDw4a52RLnK2wGT1
         HFPsRRgaWWL5acBZSudLldYnjT3v5xtD5Sz6MUUkK0y0Y3XmvY3tDVXRhk7wrkcZ5O2T
         xViR19KOwTIcJ0Kka+nMQAu21f9XHGSbP+C3G3zaVM9eLevaWqz41rOuURni9rpoNBBd
         Mvag==
X-Forwarded-Encrypted: i=1; AFNElJ+3gK7amirODj2cKIkzN5zddmrj0MD8VjPDEd+TpEGzgFF2eBQXjNrUqeyJ8QN3bI5u2Jbs13MhahZ7IgdfEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvWLFE7U8+GH89GsNMcZvrrIh+JUlmsvzM1hkI+ByNwVWgcQmy
	33MkYAz2sd9wgUGafQSW0Cn/hkOxKRR4F+8JZJmy9u9zLjjUzlf4kAPpIci/HsdJfvZIVln6FpL
	0i4rGxIZ4Mowo5fI+s1zHZI+/Kdwh7t/5xjUB0sw9RXViDVILfed72rg02jY=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2902:b0:696:2038:82d7 with SMTP id
 006d021491bc7-69b78d5922cmr2866345eaf.23.1778708470301; Wed, 13 May 2026
 14:41:10 -0700 (PDT)
Date: Wed, 13 May 2026 14:41:10 -0700
In-Reply-To: <82aeba42-7872-4e92-ade8-2b7b6a8a5e43@collabora.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a04eff6.170a0220.14b6e7.0321.GAE@google.com>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung task
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: dmitry.osipenko@collabora.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	ryasuoka@redhat.com, simona@ffwll.ch, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Hi,
>
> On 5/12/26 11:59, Ryosuke Yasuoka wrote:
>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>> wait_event() without timeout when waiting for virtqueue space. If the
>> host device stops processing commands, these waits block indefinitely.
>> Since callers may hold DRM locks, this can make the entire system
>> unresponsive.
>> 
>> Replace wait_event() with wait_event_timeout() using a 5-second timeout,
>> consistent with the existing timeout pattern in the driver. On timeout,
>> clean up and return -ENODEV, following the same error path as
>> drm_dev_enter() failure.
>> 
>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> If host stops processing commands, this is a problem on host side. Isn't it?
>
> -- 
> Best regards,
> Dmitry

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

