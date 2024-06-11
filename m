Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3704386
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140063; cv=none; b=EN416+a/3Ondp/wAxnav++yh+pzULIqVPABy4XN2Y4yoN3TmKRtTGRQ/YxMWwvWOocfxhipV3UfrGGGHGYun+39WFASFMo/Kr+d+Sc2YLjJR8b4V8arwbdxNX+H752Vx5v0NR5gaSop+PFpYaYW6ocfjvOZCWqdM9E4HROerdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140063; c=relaxed/simple;
	bh=bZeW+OAsrPZ7ARO6vDEVo6Rr7MP6oJWS7vPvej6Ro8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCaT6G7TVi3VMrPLMHiG6CQfrBN6jvLxmUoifmmotmDPRcOaSAY9KW/gB4ujaYF85ElBi1nfSEhiMqxAf0c2sQWBxyICcRJBAQI8NH/f46XX7C0b/gxsCrwlA8mgFPrc9NdboQZw95GTnGH1UVigIlm3CJPUTmF0w/1VGnTYjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmmrNhCK; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmmrNhCK"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5743181ED9
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 21:07:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_RkaJVNE5m0 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jun 2024 21:07:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::a35; helo=mail-vk1-xa35.google.com; envelope-from=shannon.lee.nelson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8FE2A81ED6
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FE2A81ED6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JmmrNhCK
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8FE2A81ED6
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 21:07:41 +0000 (UTC)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4e4f05835b5so157585e0c.0
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718140060; x=1718744860; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfYO21vu5Pe2N+UWX/fa2ypzGqTZwP4O4WrXAA8KZ0w=;
        b=JmmrNhCKF2A5nsgLmr7Kc7h/4kyxUQqEtbY2qMWKnSZ6ctFUsw1nGoiC4irxgdvpHK
         K/lw4i+c0EvoEkPYrs7P9jH6BmxeCXqSTti1LRhnUxrJc5jqmJfwHkKI9B+0mN7rYaFm
         a8oK/KGbstqI6K3XhqQc+0Bz6WU9cxasFD9/ld9vr4sv6GERCJzvzyOPMvplfv1/huxc
         1mTaqQ1l6txFSLXgMCK+IwdpSBTjVib5NKMISBiQ0YFke6HUIIEPvW/LTCHxy66C80rv
         68t0K9PPZEnx8NTOXtNUsV3QtfK+JZuAK3VcMAmXQQU+ppIWieeflZHAiAKOASYCvQi8
         5qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140060; x=1718744860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfYO21vu5Pe2N+UWX/fa2ypzGqTZwP4O4WrXAA8KZ0w=;
        b=IV/Bka2i+htEFrajEwCKqjH6O7JcucEeShmfQsuwcPuXaUYLmd3ZraqEtt2LU0En8D
         sgRo72DI/d1Suh7RLYpRk58hoQfdKjQuLTqqswP2spTTrfTvM25D1Rxemfn+OzNqq+Ru
         PeMVZTdCAWAmt/YSCguOahX9LNX8jnrolKRWfRhm4FPzYg3nMsQ9nvubLC39PlWtp96M
         TOkPJa4bv1tAaL9R68lxtDsVpVGjhImYa9yO9HayprY8MHqpoqaWsjl/Xgyf9eZwiQPT
         V+PWOrgO9vU3bwWhW9rSwUNAQaL5R+intikH7+yTjyb9mQTPaYriq7PtZl3/sAEYJUwc
         06Tw==
X-Gm-Message-State: AOJu0Yw8ur7E1S922UR4wgmj/eJ/FDYCZJiRjFsdwYGufa4JJa2j6OFG
	YPvNqiLSrwmzSq68K236eAZNtnQb9Cj5XcqMeqvwUa/Rz5hCF9ks9dKl/+KMDMDsoEur2f9/O4X
	h5novbM1ykZZHO0Kq05RvHqH9BRs=
X-Google-Smtp-Source: AGHT+IHamug4LZaw/nSgQUryiCCMwxMPV06HBwUZEzMLzEYLpTG9GAEuMtDRYlFZ228RLoWsOOhqDBEPin8JvJmRBAw=
X-Received: by 2002:a05:6122:f8f:b0:4eb:177c:a815 with SMTP id
 71dfb90a1353d-4ecf27e35a6mr5291232e0c.2.1718140060166; Tue, 11 Jun 2024
 14:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4c719bee-b0f1-4320-86dc-c2be08f236a1@cornelisnetworks.com>
In-Reply-To: <4c719bee-b0f1-4320-86dc-c2be08f236a1@cornelisnetworks.com>
From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Tue, 11 Jun 2024 14:07:29 -0700
Message-ID: <CAP-MU4Md5J5LHUnPCvU9fUk6KL3ZD7v13ZGMyQa9c-OsONQnuA@mail.gmail.com>
Subject: Re: Looking for guidance on using virtqueues and virtio devices
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the devices I'm familiar with the message passing between VF and PF
is handled or at least supported by the specific device, either
through registers that the one side can write and the other can
monitor, or through an adminq messaging structure, or other HW
specific solution.  Part of the answer depends on how smart your
device's FW is.

sln

On Tue, Jun 11, 2024 at 1:41=E2=80=AFPM Doug Miller
<doug.miller@cornelisnetworks.com> wrote:
>
> We are adding support for a new adapter to the hfi1 driver. This new
> adapter supports SR-IOV and we need a way to communicate between VFs and
> PFO. There are some resources that need to be requested from the VFs and
> some notifications needed from PF0 to the VFs. I am looking at using
> virtqueues to allow a VF running in a VM to communicate with PF0 on the
> host, but am not sure how virtio devices/drivers should be used for
> this. Is there a general-purpose message-passing virtio device that can
> be used for this? Or do we have to create a new device specifically for
> our driver to use? Or is there some other communication mechanism that
> is better suited for this?
>
> Thanks,
> Doug
>
> External recipient
>
