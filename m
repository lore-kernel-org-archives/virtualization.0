Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4062D
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNe9ywBt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A58A60E4F
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 00:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A58A60E4F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KNe9ywBt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWiattjH8H6X
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 00:11:49 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B34D60E3F
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 00:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B34D60E3F
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso5025338a91.2
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Nov 2023 16:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699402308; x=1700007108; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5FTMnIkfAnWQrINqJsE9vGOX5Y79juiKePAWCBp2xQ=;
        b=KNe9ywBt0GkS0mWU4QIStWtWlMhpomcUPcloP0Avp0zqE59kMPWO7caTu5TE556Z2M
         w+mOKp/XFBgHTQtbnhc7DgflGwJuL5iASUUKyUZUSi9OAuRvDE4yC6x1BsVPBvBsKVTM
         /L5A997ychDfqY3Co9l/IH3JTSkhTOShRyIrhx4uR7zAbHHrZykTfj4IjRTWCSgsg+3M
         +Blv5e5KzrUl86ShkaUI0tKSY4M7EpfdgsIhskQS/m92UpxoNwPAn6DKo8WQMqKuQ8qJ
         frvDacTSJRrsQVz/MWytcKYEnyWild1WSuWDgI4Km/dQ2CjudSTFtxqxohUvZmaJHhpe
         svVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699402308; x=1700007108;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o5FTMnIkfAnWQrINqJsE9vGOX5Y79juiKePAWCBp2xQ=;
        b=FZgpCsVDSPJsR0SkPsRlt/lGlo40BlRpmjZ4wcL0t5mgOQMDEwmLbdbhx2hudmfUHH
         bHiQkZIvEzizhP0MXSWsRvRpGp0QZfWc07Soo8aR52dnu4GIZNFQcbuz+LMDggnx1Lxq
         0iPpuRYYHwDdPw9GrC6M1cqF2dRu+EqtEx90ZPO/1a0O7W/md2kTwaAIAU2XXk+oN6BD
         C+rNSYQp+5VxutY2ep9/1qJR69P0cTHtefzjB234x5vdbrB7hmyuJLOUYLlK0A04P2T6
         DT2vpjng7jzqRwwgzDtm17Nr4gLwg2DC3YKIHx1Nt/cyJc9xjPjU2wch5p1L1P8rjRFI
         duAQ==
X-Gm-Message-State: AOJu0Yw5CsydoJMhO0okqS8li6GQIy+1lCsXk81hxn1Xfarl9AJu+ur4
	B2Scsk+OphG1C28pBfJ3nsM=
X-Google-Smtp-Source: AGHT+IFKm49M/VNzE67GA8NDQr1TupQFHjgD/NPr5R/pbLEg4jII8BqgTf96Oyl2ntsD/3uIsg4c6A==
X-Received: by 2002:a17:90b:4a88:b0:280:1a19:6dd5 with SMTP id lp8-20020a17090b4a8800b002801a196dd5mr219806pjb.36.1699402308282;
        Tue, 07 Nov 2023 16:11:48 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090aad4700b00280fcbbe774sm352767pjv.10.2023.11.07.16.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 16:11:47 -0800 (PST)
Message-ID: <ad48a0bf-0454-44ee-ae00-eff3f8b66ca6@gmail.com>
Date: Wed, 8 Nov 2023 07:11:36 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Christian Hergert <chergert@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, bluescreen_avenger@verizon.net
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: 01f05940a9a75e11a2be64993c44ad8dd06e6e26 causes Wayland servers
 to flicker in non-gl virtio QEMU cards
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> It seems that commit 01f05940a9a75e11a2be64993c44ad8dd06e6e26 introduced an issue impacting wlroots and Weston (possibly others) on QEMU with the virtio card. happens on QEMU, and it happens in virt-manager when I do NOT enable GL. (When GL is ENABLED it seems to be fine oddly)
> 
> It introduces odd flickering, Weston's desktop shell flashes when a new window opens, wlroots also acts odd.
> This is QEMU 8.0.4
> 
> I have narrowed it down to 01f05940a9a75e11a2be64993c44ad8dd06e6e26. Reverting the commit (it still reverts cleanly), and the flicking goes away on a rebuild and this is on Linux 6.6.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: 01f05940a9a75e https://bugzilla.kernel.org/show_bug.cgi?id=218115
#regzbot title: fb damage clips property enablement causes Wayland non-GL flickering on QEMU

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218115

-- 
An old man doll... just what I always wanted! - Clara
