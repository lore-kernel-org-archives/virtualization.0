Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4763BF68F
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708473; cv=none; b=PYd/CxWnPFb3ZM1WgH9LcxlQVYBmBM8LXczkeAbZslxTgEcFdS35a4h207U9Uj+89fSlaKvZCgRu5DT1WYKEZgAvLRtW1y8QcEsqQSnc9PQhbcesPkDBdTb6rWuPu8xQfSkw8Yw6+HhR/35VSeNfZ/6rR6dOHt2x2/7gLGVoQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708473; c=relaxed/simple;
	bh=cGXqcrOJv/yyElce22I9PLZQTvhW2A8Q4mBvFtC4P1o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=RZShIn5C7eh1YPIl83/iDDSAC2b6G6DYnoGucaGS5hoJOyvNsmI9sAZ44gMVj3IZ8wsBhtxzFOneaP2COI+oj5nYDNfAPGDslMJh0KSa1yGZ+tXT2ukEz+CdVMU8woo5Lsn55XeyNYwNe1EXJe5PRhJmpwZ90dH/dcYiYXg7Q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4346755f7dcso9429608fac.3
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 14:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778708470; x=1779313270;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqk0Slr65mDNKAZF2Vaic14WCI6WBEKE9EJXBGKW5II=;
        b=Kkf2PaSrkNaPFEMFSrf79AxdbFnwidx9mY6rwUGQT2s8noaDd9O5xGPnQDNls4zY7N
         ItQ2S8ns7jT6tMHRAzUKRhtC4mih0a0hbo6SWgMKiVJ7j742qUFiwYIiEi/pNg6o3jjB
         YRJ7r6oYOFhNKCRY9nhpC9+IqGcFL/LzWFCWDRiw02y84Bgr1zeSmylqgp/+pC2CNbTx
         3ohlgGrkMg8iXoE2YWXFJn7N62tLL9F/0fYiwcUGss+yJWF3y6exeLw7mS2dK/wTxl6B
         NfXaBl8TXjwVxIJzucQK1/HEfY9lTDPYWMuvOKUxcp2a3B8FSaRL3kpxHwfXejQh4Zhw
         hBCw==
X-Forwarded-Encrypted: i=1; AFNElJ+ypCOW+0BX9Q5Tokd1tjn0IICu6kO0qnyABfGx9V2VliZ6ADD6RE96ehEm5rc38sxhzv/u7Sxj/S2Vn3I6Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbp6q+H1zIel+pE1EQ15oqbTIAF/kVxBLaijaoGfe4KWLzQ+Po
	rjytLueP3/K6k1DxT5b/+U0u6sMPKO+tgPo9cCR9nDYOgaSllo/j8E9Zy54knZr1zoHLpdsrYrR
	7q/8WAMfHzHK4n33DESrllI2UZneshLXAy9ixxxb64frBy0jpQJzZjbG5Nok=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178f:b0:68e:b81b:d81b with SMTP id
 006d021491bc7-69b78dfac2amr2764182eaf.31.1778708470309; Wed, 13 May 2026
 14:41:10 -0700 (PDT)
Date: Wed, 13 May 2026 14:41:10 -0700
In-Reply-To: <82aeba42-7872-4e92-ade8-2b7b6a8a5e43@collabora.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a04eff6.050a0220.190576.0001.GAE@google.com>
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

