Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6E3B18C
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtBTF3KD"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C8A943863
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 13:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C8A943863
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=EtBTF3KD
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.601
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id myX0bwxEUw1G
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 13:33:25 +0000 (UTC)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 324E14389B
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 13:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 324E14389B
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-40e49906305so28948665e9.2
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704980003; x=1705584803; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/99NiF4A2BrTs/f1i+EHbcfLqSPcc4NdjFBKleOmWo=;
        b=EtBTF3KDYFkqfCZ0S2O9YerQYh6a/4kth35xhBLTwhgbjErb4Esxg+DhhokmMXT+JA
         12i6teCL7gBnzHgJO45i/2fldTYF8nTJux2FE50CJEiuitgvXrSHZlqxnyMj/zsP6fuQ
         G9T7kBzYxnDOcE+jch5X4og14buk5aMMPU5sIxedF2V+2m+1mJCXtPmsTyYpF4wJfA/X
         xkGlqjEOZ/VTqs+wm53S/p1UyUGt85r706OnnApw47ZELVDVNkmZ16zDpgm+Mu2QijPq
         x320T65ZRLZU9UKz9xyg+asrBmFqLcUg9lL0z5GyCYnhq5hlqZzVABT+xys0IL1qroYn
         lPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704980003; x=1705584803;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h/99NiF4A2BrTs/f1i+EHbcfLqSPcc4NdjFBKleOmWo=;
        b=ks2h/FZGGPAGjkL//4XOwg60Utnvz1EezrlgbjsHCo6x35Yegt4soG0ol8KULXr9Y4
         YpZsYd8MnC5SovifqdPbvM1LEyt9DOMPbWzAxJENHGGnbOjsDEC6UnRHGbEW5xeOWnNu
         00El+QvAflGNQK8/QG6YqLTJ7xg6+Agvs0uweS+Bd1+HqFED0VGVmRCSOw7tsFT9QnTI
         NiXDS2oGjDlIJKExZQyxjs5B8HGjEvKgWBNy5xkHxBj8eeRk32DY3DvOrp16bAEHYymD
         Fsi40i3kSERlh4PchkYog0DlDYEpCMT7J4R117IeXxLL1YBicRnQqwooNKy18gDeAedJ
         t9jQ==
X-Gm-Message-State: AOJu0Yz0az3FVXEGaRWOBY8qL13MdhmJ1zuaso0gLUoYo9oCcl2/MWmm
	pUP5Mt1pGAg1u0TBNs+9rGpzpZJyFYmpXpB6KSk=
X-Google-Smtp-Source: AGHT+IFsuF9J9DQ1b9o9M0B0uCNQ4u2/hpHiLtI0CB158k+7cM7TbsSjNtoX1gjNCAU74IrCTBCB2sPeakzF
X-Received: from dextero.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:364e])
 (user=dextero job=sendgmr) by 2002:a05:600c:350b:b0:40e:59e4:6563 with SMTP
 id h11-20020a05600c350b00b0040e59e46563mr9699wmq.0.1704980002699; Thu, 11 Jan
 2024 05:33:22 -0800 (PST)
Date: Thu, 11 Jan 2024 13:33:20 +0000
In-Reply-To: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111133320.2717702-1-dextero@google.com>
Subject: Re: [RESEND PATCH 0/1] ALSA: virtio: add support for audio controls
From: Marcin Radomski <dextero@google.com>
To: aiswarya.cyriac@opensynergy.com
Cc: alsa-devel@alsa-project.org, anton.yakovlev@opensynergy.com, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	perex@perex.cz, tiwai@suse.com, virtio-dev@lists.oasis-open.org, 
	virtualization@lists.linux-foundation.org, vill@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aiswarya,

I was looking into VirtIO audio controls support in Linux and came across t=
his patch series, which seems to be marked "archived" on patchwork [0]. I w=
ould love to be able to use this with mainline Linux. I'm wondering about t=
he status of this series - is the feature still under development, or are t=
here some concerns that need to be addressed?

I'd be more than happy to help with testing.

Thanks for any insights or updates you can offer.

Regards,
Marcin Radomski

[0] https://patchwork.kernel.org/project/alsa-devel/patch/20230209115916.91=
7569-2-aiswarya.cyriac@opensynergy.com/
