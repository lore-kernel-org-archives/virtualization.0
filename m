Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3A3C76AD
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086728; cv=none; b=u+9v9c388R/NMWckVkKouk8tXUkc8qvP9jJPkpJN8J8iTDVxE10waHgNf9RkD0edRYLr4F/o0jFTBfyVChMp1k8khWpq/gdC5OPkTgIGIx0CaZTIxlYK6VsW3AywvVbYC2G8iwAupw5FNC08GgrPEfvN4yzt4qmjkemCcyyzvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086728; c=relaxed/simple;
	bh=HOlGzBOaZBctXa1+Bh436/Ha3C0B8QoiBcCUEZruY5w=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=YPqiigYndvMovj+qor9EyK9zvVTEk8m7+l3q0duO8xUGt7zhduCw2UvBytMe0vdw4bEMzyHYb0tVkESHc66pc5iccQW1yAltJq2NBY0fEnSk/RKWIgNnlfIUP4o7T5SZom+jNS97Fi3dBKpaprKI6XT4hnoia1aMptyDG0gPe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO9wDGjw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO9wDGjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779086722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=lb4D9I8LCWFY3eDV+BXkeQ/GVQwuSR0y7Ch7qCZIx6o=;
	b=YO9wDGjwVbHF+VLOoxgxGHUW1Gk0H80MvCABjh1WRY3nSVH4pz/JTHbamcolaTZuGg0Vo9
	5OqB/wMxrKMRM2uLBEhALpafqceIfsZC3Urji9XXDiK0D1MV45IlrCv4hmJLdONLvs/Eea
	+LxA7KdmP5VAfsuKSydSKcinoiPsu3U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-My7F_FPoMwuYj1_NLFnGAw-1; Mon, 18 May 2026 02:45:20 -0400
X-MC-Unique: My7F_FPoMwuYj1_NLFnGAw-1
X-Mimecast-MFC-AGG-ID: My7F_FPoMwuYj1_NLFnGAw_1779086719
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so1666981a91.2
        for <virtualization@lists.linux.dev>; Sun, 17 May 2026 23:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779086719; x=1779691519;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIbbyJCYg8R6Fd/O6iKvRYV24FiZuro4jX0wJ+biCCI=;
        b=bGqTDVv3rh+lRVkF/61mZKZipSWCG1vOoO7sMn0HrmAG0wGce++6BPi6fhLQh+xjjf
         w0+roP2R9ZtpSAt+68VoN6mudl6DAFmbwG3oy22KRy1eqxZgPHEFTtEeZdK3MrJqCXU/
         q8uB9VpOSaUBCNw+astrNT7C1mhEdMx13hfmq6sL0I0bZcA0ttZ2BLigcPfNtWsjsJ+A
         RLpsT1v6WWAqChdWM7F9MwgZEvMMXVZhrJh2USrfr4jvRr/7eeG0huTF0rTLNegHMMrV
         EAamMWDk7V84s7D18Bf+yLr4WLh2xLjviESAROaIBnhPLc7KqfhQHsZckYUDTlvkhb79
         qFOw==
X-Forwarded-Encrypted: i=1; AFNElJ98eUupwoSQnkOKM7Y+73KGdkjigCAU6QVH6UCf1vYYM3PwPacJgfVjWM66gxpxzc/xqZV47YKJzX/ceIn+Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvA4VXNh6QtcHL5w5SxbPdOdUNmrnIx6Y4G24QhJ/5j/GkOFKz
	rJhj0DjROwGzUNcBuzHOWn7NS19l4hcEIofshAskWngyFhRs8I6Qxlrb27wnDqisCOjm/JuvhkX
	kVamk+rOkBQIc1aFBQmQfnYjVpdKq8V05SD+WvtY9PMobaEoSA4Dy2b5LS0lldbkRgoU5
X-Gm-Gg: Acq92OEn7Q0B8y61fjEo+EaXgKipvCZ0UN2VzKIMfnVjwhUxJuGR3ptJwaGL1LyWUsa
	2o8qs4lQ4Jdy8oZL5dlpuwGOwKN74TF6eWNyXIkFURFFo+cNlmD9zBDzpPwS/0t9aRgViar2DMN
	+pxHr1AMAZncfe+j/jqDHFTnS3p/d3G8n3WwQBFVBBmNHTb9HB2820hKqYgaySARS9M/WxPf3Aa
	+jP4NalOrrxpqELeDZtpmUd8eFRMNOOfLOQBSM/a3Lj/oydVhUCuORQF7xbWrFpg4DtVpFHRJXV
	xnlFe8L439S/ujco9EAiU9MO+XTGWyR9ckQhFbHM8sz3z2Zgw4NN8ay7SLfifgg4B/0FEOOcoMj
	8wjT8e7XvNK1LtGlfeDx+sjSBCw7KjbZs4A0MvY12zWAv+QDQ1np4t9bfSRM=
X-Received: by 2002:a17:90b:57e4:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-36951b82d4dmr14013358a91.13.1779086719361;
        Sun, 17 May 2026 23:45:19 -0700 (PDT)
X-Received: by 2002:a17:90b:57e4:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-36951b82d4dmr14013324a91.13.1779086718859;
        Sun, 17 May 2026 23:45:18 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a09e95esm3849670a91.9.2026.05.17.23.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 23:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
	"David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
	"Gurchetan Singh" <gurchetansingh@chromium.org>, 
	"Chia-I Wu" <olvaffe@gmail.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"Simona Vetter" <simona@ffwll.ch>
In-Reply-To: <8a986c52-964f-42a5-b063-fbe2b242ca36@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
	 task
Message-ID: <18b095f06dafb7a0.57d57ad28d13539f.2240916b4a5459e2@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Mon, 18 May 2026 06:45:12 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ItNpS3e676LQas5XsLUXBvG1S3EkQrdMrDrLLUZ1W-E_1779086719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi Dmitry,

Thank you for your review.

On 14/05/2026 00:54, Dmitry Osipenko wrote:
> On 5/14/26 00:40, Dmitry Osipenko wrote:
>> Hi,
>>=20
>> On 5/12/26 11:59, Ryosuke Yasuoka wrote:
>>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>>> wait_event() without timeout when waiting for virtqueue space. If the
>>> host device stops processing commands, these waits block indefinitely.
>>> Since callers may hold DRM locks, this can make the entire system
>>> unresponsive.
>>>
>>> Replace wait_event() with wait_event_timeout() using a 5-second timeout=
,
>>> consistent with the existing timeout pattern in the driver. On timeout,
>>> clean up and return -ENODEV, following the same error path as
>>> drm_dev_enter() failure.
>>>
>>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.=
appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e4=
5c1c6e549453f224
>>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.=
appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7=
baf376cc873a922e
>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>=20
>> If host stops processing commands, this is a problem on host side. Isn't=
 it?

Yes, it is. But the guest has no way to recover from this situation on
its own. The wait_event{,_timeout}() is inside the device critical
section between drm_dev_enter/exit(). Removing the device via sysfs and
graceful shutdown call drm_dev_unplug(), which is blocked until the
critical section completes, so they cannot proceed either. Also, IIUC
the virtio-gpu device cannot be hot-unplugged from the host side. The
only option left is a forced reboot.

> It may be acceptable to have wait_event_timeout() in a loop, printing
> warnings about unresponsive host.

I considered this approach, but it does not solve the recovery problem
described above. The guest would still be stuck in the loop with no way
to remove the device or shut down gracefully.

> Don't think we can assume that 5 seconds is enough to say that host is
> busted, unless spec says so.
>=20
> There could be a driver module parameter, specifying the timeoout. This
> will be acceptable as user takes responsibility for the special timeout
> behaviour.

Agreed. In v2, the default behavior is preserved (wait_event, wait
indefinitely). A new 'timeout' module parameter (in seconds) lets the
user specify when to give up. When set to a non-zero value, the driver
returns -ENODEV after the specified duration with a warning message.

Also, I'm considering proposing a host response timeout in the
virtio-gpu specificaiton. If a spec-defined timeout is accepted in the
future, the driver could use it as the default instead of relying on the
module parameter.

Best regards,
Ryosuke

