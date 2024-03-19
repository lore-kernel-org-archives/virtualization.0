Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8F2D052
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871790; cv=none; b=W9AJxIW2XmDei4/Hb3mjFaedFUP+5svUgDlrVK7hkfXz/8vusEc0kfZlrYfDjUKh+/HwcvFy7xmrW7oCbUBjjfiUQAkl++AGsj5VS+Akir3TeiQOrLENdul8+56ZNImW3p/pyIWQWKoYDEN4//XAKApsx4R2ViFb01Y2o70Jtc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871790; c=relaxed/simple;
	bh=DFh9J+u2qXCj6UQ58/J1xPY8J+BLfhUgqiTlzbpfEoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv0iBfv0j+CV8NMb02ks10OaHDbuojzCmwUUZXp1r7ybp4PxeoYCKcDG8LaoEbEvypQQ+YMUwq8THWvGpd9YQy6gV+kQWxofn762j91+HBFMEOHY8C2yc+hcG2on7yyMDLpcIdabc9Adx6wLQzhsEqKxCLBsxpT+s8oaC66uRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SKsjYGK+; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SKsjYGK+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 620DF81097
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 18:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSVeY-gHJZKc
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Mar 2024 18:09:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8A6168121E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A6168121E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SKsjYGK+
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A6168121E
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 18:09:47 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-56b93b45779so1453845a12.1
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710871785; x=1711476585; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EQCbsWamaqb8otc0jtHP79rNp7jzLPKKgSbrJldR67k=;
        b=SKsjYGK+3z1v/m0yPaBZ0a5qh90gfD8uOtxhd2m2JajP/U4IK4wCM+sP8EbwZrigZh
         iyd+WlBdXwr59m3U2tIgT49NE/JFHEHnVekP/Uj6DWlJSd1Na1CzIzqhLrU5XO1f9Y74
         KQdLvsadRBe0ss6Z24pXu7SJJ8Ok0kbbdfMVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871785; x=1711476585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQCbsWamaqb8otc0jtHP79rNp7jzLPKKgSbrJldR67k=;
        b=sVFE3kqhOPl5ctoT2DyrSM+AM313VdNgpNT2L6yICzvWwyg1L7MZDjV8WBCwAtsQbf
         BhKfWdV8K8vaaWZ9RlUuT27LZPIgPmGOyvHHyV3hRzTQDatEbQ3yyjt6SLBBfcQa4yzb
         nwoO9POL43TbJiDda8IFxJpuNcVelWu8iJ7s0pbTNTyo+9y0Jfcn35EXVr17UQkdGdXk
         X/uSFyzNNDNEIHphhTiqSUFBNKJYOYREqrOCKYeMjtykTCPEbX3AeMpvaNp0lKeyZumA
         8N7K1AQkKKJLPWwgb5VHzHpCaOXoccD4KoZMG7j5dqy2uq3zfR7hwhmbFk95FcrbdX4A
         dANg==
X-Forwarded-Encrypted: i=1; AJvYcCWgwG+MLxuiJyHsOhe8atBX+zFWqk1/XkvWIz7igpgbYShR/yY7kuF+2gK+jkRTk/V7ftj8KC2/7ChfJwZ74aetU+/gn/EbW9hoVsWBcPSwYp/dO1ciqlTxGA==
X-Gm-Message-State: AOJu0YwSqO8zeHaFowDErGRUZ80m5omMm4wrGJs2tjPyGubQk1A9ANuo
	eP2FpE+l1xO96GdFJTRC65CteGL9SVCoW+PIuTCtbx8frFEp39ZRRJv7O+nBqUhXAp2/ENUtk9Z
	9fB6thBJM
X-Google-Smtp-Source: AGHT+IHflCJoyCw1yXMP1x8svvBTQgYol17DEeNe0i/kSGT06XmlYzzLqnWmxcho8te7KuTQnd+c2Q==
X-Received: by 2002:a05:6402:2b8a:b0:568:9996:7cb6 with SMTP id fj10-20020a0564022b8a00b0056899967cb6mr11498950edb.14.1710871785277;
        Tue, 19 Mar 2024 11:09:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7d613000000b005686037bc12sm5941771edr.29.2024.03.19.11.09.44
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:09:45 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56ba73c02b2so487991a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 11:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGPHQqSgFhoeGJgLXb+J9ZSyBepsdBQg8BjXbgF9jmTbeb6uo6hMhD/TP0cLUa7V4gEMG2cP3tRt46DPc4eSb0DirOad3vWsCTHurYvBrQMsRm7t7sn5W50g==
X-Received: by 2002:a17:906:1352:b0:a46:7ee2:f834 with SMTP id
 x18-20020a170906135200b00a467ee2f834mr9239613ejb.11.1710871440743; Tue, 19
 Mar 2024 11:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240319034143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319034143-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 11:03:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Message-ID: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com, 
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com, 
	gregkh@linuxfoundation.org, jasowang@redhat.com, jean-philippe@linaro.org, 
	jonah.palmer@oracle.com, leiyang@redhat.com, lingshan.zhu@intel.com, 
	maxime.coquelin@redhat.com, ricardo@marliere.net, shannon.nelson@amd.com, 
	stable@kernel.org, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 00:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtio: features, fixes
>
> Per vq sizes in vdpa.
> Info query for block devices support in vdpa.
> DMA sync callbacks in vduse.
>
> Fixes, cleanups.

Grr. I thought the merge message was a bit too terse, but I let it slide.

But only after pushing it out do I notice that not only was the pull
request message overly terse, you had also rebased this all just
moments before sending the pull request and didn't even give a hit of
a reason for that.

So I missed that, and the merge is out now, but this was NOT OK.

Yes, rebasing happens. But last-minute rebasing needs to be explained,
not some kind of nasty surprise after-the-fact.

And that pull request explanation was really borderline even *without*
that issue.

                Linus
