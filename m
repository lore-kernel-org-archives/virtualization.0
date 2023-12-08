Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE976FD1
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="GkrttZnE";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="2pkYr6gv"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EC3360EF4
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 10:55:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EC3360EF4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=GkrttZnE;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2pkYr6gv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X1Azj8-5f2d2
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 10:55:39 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D39C760EEB
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 10:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D39C760EEB
ARC-Seal: i=1; a=rsa-sha256; t=1702032755; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K+RBCHuRflsPVn2/sFv8O7Ts1H6JYHaf60UFExvqzKo4CkV5UQlFwk4IEiRwy69q7z
    diEpKKKEEdywfjqWRvwpZypGGJ3rWz73aMzwAm8bXPMdNhr+KldbHUwLB0X9aiGpgl6+
    KknMSRYKYNBaSaMMdSRIyo19xThISEWvSgBtMvnifFnB0jxatwCjJH62Ezedfuew2HZg
    /OLZwOGP6+0/LEdF/kZLmanzPt71JjzYH1oSTmor5xe54151DfubQXqCfbZQWRAxPDB6
    wKyum123P17KVW1w07ApPMqE0F010l3QMfQnwHIX4FoJsTWdg15oHw7OhyT7ueh6MQNM
    A/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702032755;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lH6SBnQ4xrHrGQeEHvJ5u/3KSpQHUvvzwrmVeb1tOZ8=;
    b=O4/4aM+60FaeIWXXxmakbYiOk80wIKjx56pYnOf+NKQ4L1JCqqpi3HXN3gRFkFsli1
    CQv5pHVOAcWacmeQe71w3NubCvHGEHp925oGoYUYIc+A5cPvC/csxDt3JggeOMkI9BxY
    uoanoEYAhXqxUbQOVWHgDWH1fLSAwRFjQxTYkl6i0NLqUwi5ej59bFJqCnVU9f9AB310
    qR/tXrra/mCaZQeKh4OUXoXBWXpgH4f00ul6y37jfRcDBmoHYVcTsHMgQwT/p8Fh4+Er
    iYU2TpDs72oou22WG0XjTO58NSd4/M1D93Uv5NAjzKwu9TsMOwZA++gZNqdVjcnt3u6U
    aRrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702032755;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lH6SBnQ4xrHrGQeEHvJ5u/3KSpQHUvvzwrmVeb1tOZ8=;
    b=GkrttZnEEmTljMGki6GULywxWeVKDPJwje9aehBTYDsAEq4Hu0hYKF5J3dN5/AYSp2
    b4RPLuV9GhYuXTOeSbyA/pazNWIAp6uEQ0WSGue7QPNwRfeZsCrvsVbDjbZyXoNB2wQ0
    X6MDP7cP1yOp1VlbXYSF8IQPOv1C/3zo4AnsPV3Dy026MCKm9dR3VSld2lMVmg8dwylS
    e9XGs7cBYLEKAg4z5hmcTAeZs+JBgnuGka+4qtOMsXaGRjRP44lAdPjVJ+9zlL06UFng
    wrKrrglfgSuzj0kH7y4o3CqYT9Pe5tFVqf79HyDXKz9nkq/IKJ4MGFiBfkHfJxPCq7ch
    YeSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702032755;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lH6SBnQ4xrHrGQeEHvJ5u/3KSpQHUvvzwrmVeb1tOZ8=;
    b=2pkYr6gv/7SxhRY1a7hLYS44BHKDz8fXWRQNd5qrSfeBu7hQ6fLVYtEIymFXoEkcRa
    KY2NZQYH8sZ84JlOZcCQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfi4XXBswJY0lkTEDrUFf1HwyMiKmo0Cv1RTUCg=="
Received: from [IPV6:2a02:8109:8984:5d00:f8bc:fe1b:3f93:a193]
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id 626c0czB8AqYIml
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 8 Dec 2023 11:52:34 +0100 (CET)
Message-ID: <1dca4a2e-5bde-4825-8e8a-4b4ac8dd958e@xenosoft.de>
Date: Fri, 8 Dec 2023 11:52:34 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-m68k@lists.linux-m68k.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
 <77c6gkquzq4sdtmrlko3lkxvcnipm2zfjem3kvhgslcellkefh@man7pbbzud47>
 <a9ade305-f90e-4250-a795-49ef4e29e0ac@xenosoft.de>
 <CAMuHMdXtUYJmEharJhBXx7D=fA3mQxg6uMP2=4Qgi==2a+kVQw@mail.gmail.com>
 <37b9e5ab-e170-4071-a912-f3fec0d59d5c@xenosoft.de>
 <ee75377ad22a3d07f272e17f53cabead7b43afcb.camel@physik.fu-berlin.de>
 <9e8d2abd-94a1-4fb6-b30a-c6e4c52af011@xenosoft.de>
 <1bd6d2c8-007b-46f7-85b4-9793ec650f94@xenosoft.de>
In-Reply-To: <1bd6d2c8-007b-46f7-85b4-9793ec650f94@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25 November 2023 at 01:35 pm, Christian Zigotzky wrote:
> On 25 November 2023 at 01:22 pm, Christian Zigotzky wrote:
>> On 25 November 2023 at 12:09 pm, John Paul Adrian Glaubitz wrote:
>>> On Sat, 2023-11-25 at 11:06 +0100, Christian Zigotzky wrote:
>>>> Could you please revert the v2 patch because of the issue with the
>>>> virtio-mouse-pci cursor? I will try to use the v1 patch for the RC3 of
>>>> kernel 6.7.
>>> I don't understand why the v2 patch should yield any different 
>>> results as
>>> the only change compared to v1 is the fixed patch subject. There are no
>>> functional differences, I just diffed the patches against each other:
>>>
>>> --- geert-patch-v1.patch        2023-11-25 12:09:19.122936658 +0100
>>> +++ geert-patch-v2.patch        2023-11-25 12:09:36.313039085 +0100
>>> @@ -34,6 +34,9 @@
>>>   Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
>>>   Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>   ---
>>> +v2:
>>> +  - Fix truncated one-line summary.
>>> +---
>>>    drivers/gpu/drm/virtio/virtgpu_display.c | 11 +++++++++--
>>>    drivers/gpu/drm/virtio/virtgpu_plane.c   |  6 ++++--
>>>    2 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> Adrian
>>>
>> Hi Adrian,
>>
>> Thank you for the hint. I think you are right. I use the following 
>> patch.
>>
>> --- a/drivers/gpu/drm/drm_client.c    2023-11-13 01:19:07.000000000 
>> +0100
>> +++ b/drivers/gpu/drm/drm_client.c    2023-11-14 09:45:44.964199272 
>> +0100
>> @@ -400,6 +400,16 @@ static int drm_client_buffer_addfb(struc
>>
>>      fb_req.width = width;
>>      fb_req.height = height;
>> +           if 
>> (client->dev->mode_config.quirk_addfb_prefer_host_byte_order) {
>> +               if (format == DRM_FORMAT_XRGB8888)
>> +                       format = DRM_FORMAT_HOST_XRGB8888;
>> +               if (format == DRM_FORMAT_ARGB8888)
>> +                       format = DRM_FORMAT_HOST_ARGB8888;
>> +               if (format == DRM_FORMAT_RGB565)
>> +                       format = DRM_FORMAT_HOST_RGB565;
>> +               if (format == DRM_FORMAT_XRGB1555)
>> +                       format = DRM_FORMAT_HOST_XRGB1555;
>> +        }
>>      fb_req.pixel_format = format;
>>      fb_req.handles[0] = handle;
>>      fb_req.pitches[0] = buffer->pitch;
>>
>> This patch solved the issue.
>>
>> Christian
> This was the first solution and it works without any problems.
>
> Christian
Hi All,

The issue with the virtio-mouse-pci cursor still exists. I still use the 
patch for "a/drivers/gpu/drm/drm_client.c".

Is there any news regarding a solution?

Thanks,
Christian
