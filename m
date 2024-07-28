Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1D77F10
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722204389; cv=none; b=I6ydeGYU9X9Wm1yyakSzejnobtyYguElOWr/NaKLq3OXkB+t2N+KVmWujNEXHosB9ze0h6OFDjA3KbAU+3NkxrmVpC51evV6jBPdatjWuREG1UU/O2b48236OLihJUEQ/CAY054i7saaWEauAr53HMbbODnpfpjpY6FC2f2WybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722204389; c=relaxed/simple;
	bh=/Om46CZc4PtsVwKq9RtMi4ggxQSke4GiB3ovayUyC2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxKb/vn++MBPvoJOZPy3IEiQvLLQ8xmCisQo1SvZGg9esuH1PsVR1/gHuhd2btdjNuhxOOLFKcumsHUvsP/LD4wlnso77oShDXpGTHUc+5QUiUCrZjP4f5Jr1nSOgws0Anosz9rLNVMycZL0iO1Q22gwS+8yckXFkhpqoiGGqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpNAOgao; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpNAOgao"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFA7F81168
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 22:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bC67tCkKhwOO for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jul 2024 22:06:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0E43581148
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E43581148
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TpNAOgao
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E43581148
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 22:06:26 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-260f863109cso1808891fac.1
        for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722204385; x=1722809185; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PlRW1dSG2ar0Zr3x1aqaupGL6BKGnqIl5mXFxckCJI=;
        b=TpNAOgaoedxGay75TsGpWbkkE70/v7kqTYfrsYbMF2PxuECoe09cUe0joEBrsFMEIK
         DQauu17utGEI1H0na4aBXH/4bXGlNJqkQk7x0c3/xJRKlxtW2FeBfkbh0LvHASKqvHd+
         JRDMF52fMHJRrICSXSCiq9mhjAB5d2l/uTAbB6c29v19XjHu2xzUwr16aRAe8qrI5RLz
         lDZ5jIZbi8WFt+7mK94OuTmkQkEBisUzM/LVs8y5dHQ+ogSmGJpn/maqnt/hxjlqJojf
         SyrPTplO3dTUlYUrVn6ezht/lBS0sxkbGPrmkgC50ocjZg0Y/UpSyFC2TWs3Naej9emn
         qqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722204385; x=1722809185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PlRW1dSG2ar0Zr3x1aqaupGL6BKGnqIl5mXFxckCJI=;
        b=rW0iXery5bjB7eSsXRGE4q33d76mjj/eTwtEOnBumI+WAonoeC+aJOcZEH+TmljnjC
         7IzFt9Udy7KSH5/fEpD1rAhn49dNI86pSByad0EZ0VkxCJN9oQl2HvWjpt6YvO4v7+Pm
         EC0lJJOBURw2o7sk7mBhOL7DQbs5tsMKIUFlhBgD3tNXywLihEdHEO8XezMLJPSKqTZ3
         d7vx/lclQCO5DTGRoPGzlgNzeFkItmFb+2suzG5Ty1Py4iAPyu5cjBK4/AjGgegljO06
         GHAp03Jukn1P9rJYHDHkDMohbwocjgQHWrthzGJvrZ6gALBX9c8Wf+xZmtW8g+dtePLd
         MUgw==
X-Forwarded-Encrypted: i=1; AJvYcCVdhFUtXoBLA3aUs+P7r01GiPy19dThCGGelKhxwYy6l31LZDjIG9BWt+sRWab3MNulqza2cHtEn8yDBnyc/5C6DDEBBXcaGcPGNjY/dHHYkxeJGGq/OHFQWQ==
X-Gm-Message-State: AOJu0YzX7l0pLUHUH5+UJQhBPimiv9UBOQgCQWDiSyaJ6ol31vXCXvTv
	QemFx6y5mDdH71wuqC/VE5DFE3N8QNqBFneW+0ib0hsVIVBjy00Pqni4yDiVR/dvwwnLSiOtE96
	qc3F74uU0Bi70hgdNcnoOm2aSpOQ=
X-Google-Smtp-Source: AGHT+IF3/AMl+VL5PHR/DpM82Ipap8UKg9+sdjntJk+s+YWO/Ff8gSb9JdRn1a75fyaaDpHxZSylfC0YOgiPdWqx72U=
X-Received: by 2002:a05:6870:e310:b0:261:858:1982 with SMTP id
 586e51a60fabf-267d4ef3b36mr7816424fac.36.1722204385516; Sun, 28 Jul 2024
 15:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-15-amery.hung@bytedance.com> <3ajts54ndduloqhl2uf7viyy7n5azu63i6waptvf3mzzwkrzr7@jebnovap7xxz>
In-Reply-To: <3ajts54ndduloqhl2uf7viyy7n5azu63i6waptvf3mzzwkrzr7@jebnovap7xxz>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 28 Jul 2024 15:06:14 -0700
Message-ID: <CAMB2axNS6QEBuj1vMToy80fXvtJEzo_MzTgYQ1xc7__6jXNAVA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 14/14] test/vsock: add vsock dgram tests
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, bryantan@vmware.com, 
	vdasa@vmware.com, pv-drivers@vmware.com, dan.carpenter@linaro.org, 
	simon.horman@corigine.com, oxffffaa@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:43=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Jul 10, 2024 at 09:25:55PM GMT, Amery Hung wrote:
> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >
> >From: Jiang Wang <jiang.wang@bytedance.com>
> >
> >This commit adds tests for vsock datagram.
> >
> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> >---
> > tools/testing/vsock/util.c       |  177 ++++-
> > tools/testing/vsock/util.h       |   10 +
> > tools/testing/vsock/vsock_test.c | 1032 ++++++++++++++++++++++++++----
> > 3 files changed, 1099 insertions(+), 120 deletions(-)
> >
> >diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> >index 554b290fefdc..14d6cd90ca15 100644
> >--- a/tools/testing/vsock/util.c
> >+++ b/tools/testing/vsock/util.c
> >@@ -154,7 +154,8 @@ static int vsock_connect(unsigned int cid, unsigned =
int port, int type)
> >       int ret;
> >       int fd;
> >
> >-      control_expectln("LISTENING");
> >+      if (type !=3D SOCK_DGRAM)
> >+              control_expectln("LISTENING");
>
> Why it is not needed?
>

I think we actually need it. I will add control_write("LISTENING") in
vsock_dgram_bind().

> BTW this patch is too big to be reviewed, please split it.

Will do.

Thank you,
Amery

>
> Thanks,
> Stefano
>
> >
> >       fd =3D socket(AF_VSOCK, type, 0);
> >       if (fd < 0) {
> >@@ -189,6 +190,11 @@ int vsock_seqpacket_connect(unsigned int cid, unsig=
ned int port)
> >       return vsock_connect(cid, port, SOCK_SEQPACKET);
> > }
> >

[...]
