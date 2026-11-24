Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795517756;
	b=Is5t2RvzpWYcOmLezzkuXGRDtfq2IpBxHe00Oh8g5zCjHkXtM2m8/uNif53r2oa//FrV
	 Ti8i4Er3qgJTYYBHRvK077CBMVQudOLWr3dHwvn8vxoHRGMWWuXyVSzW6Z9JPuhn2Tvmd
	 3yG3xCPnWTCnc/uyufm1b9C3N6PaY8+cVnynRarxrQNHjpwWL9TC/y5OGzxR2Wll0X6V6
	 XadgAwfqtwEguMxy+zyoRPNuiKth9BXxuy4OEN5PzJmX0d3103meWI9gByvi9ntQRUfI8
	 p2+wYYmVBhi4X5aSB5aluNKMRMk3rSA3D/fmoCMMbkJeNNeRc6dEQbN5hGBuIt6pgkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
	b=r+3eK/OTXMj0qGRQH33jws7BFNXa1LztVpXbD2T3IKW0orLjV+9ksxZTa/cXvHoCLUdw
	 FNmsxu+qXVH87CcmlPbgRuUpaq24+jrQzRpikTeOATEWr2P/FW2pyEzvXp1Dbm432RY5D
	 tiTJaZ8evOZTpqqQwqrWxKZUQw3p4qPK/vQyImyMUwovj9eIPN6W7Wkc4FsLffyQJxZ+k
	 mGiwZemMBUYYGO/x+dNuaiGwIXh07Kl7i8Pv2gZ/M5xg2aExLeCOkNVPs3LaF7nUdmN4b
	 rbqZBPOEpYy1O/yolza0Hy1Ob+8GObOVMQEh6Ce7c08LKhb2p4xjEcfJOfROi8FzD7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=aHyUg010;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A100606A33B
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 10:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A100606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=aHyUg010
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53639b8903bso53819371cf.0
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 02:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795517754; cv=none;
        d=google.com; s=arc-20260327;
        b=DFypeHkPJCZCNo50mIWG8CLCY2x8+ecUwCKtSbzUBG0bsdKPIPqGzxDGshkNnspQdy
         y20jhr7ksuYZR3Q+bfWtXrQl9ZvFB8FJLsUSTWzovF/boxxiM+qnAJ6stfDQIGWFq3xf
         LyAweSxaFmQSU7MEBDwULfZcOZRubOqlQHcV1QMQMBopthouppQqX/b5aYntpAI/X+DJ
         UZsNT7HegDO4XjCF56eWe4N/trxTb+KX9kwNj9MqruT3wplFRppoBYM4BcFo0mjSKWXG
         Qd6raibya4wFDRY9rvc5WDlKkVvClId1WKcW7ajV4NNi+K1LjGIEPEG0QBDHvcvp9OPv
         JFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
        fh=KrIQprUolUHugiOfjrtl4S+OrjWFEh9OR7ePXAJnHeg=;
        b=LmeHX/ddWlz6NyZVIFg5OKzW55f6yvrhy9wJuS2xtWVD5RQ5NoR1K3AddE1z8hQJ9M
         eLXtMC7i+xp8RnN5T3JvnDQtJFPfq+NhWof+FcDqRAyaALlJU/J41F1FiISXzJMGAvAe
         VHMFxn4R6pG+/S3ayFJcoFwZTdxeW/VTKM9qVteccu7RV2FF69eqZBGQ/kx17y5VNkBD
         YKDlGU923ml/E5lg57vigb4qiJTVKjyUJ4ZBEkCfeH3AxRCUy6LQmZTbkwmsJnBEJimd
         g5z3UyiMfnvKxgmY0KxD3J1lHKI2kSZLaFf8+vZsio2b6Yc19jU6vHw/aKF67tnIvrTV
         5BjA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795517754; x=1796122554; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
        b=aHyUg010Fpa30tqfBUn1Gih+DTOzaKalA8zN1XBuoXqQay7t9Nf0/FQfF7TKBld6Na
         H+oZLrT9EDYL/2VEaZ6JqGj/vg4ixQZUUDwvM+f8N57hPXmm5vlgshvUvsJyk5JKHf6B
         iEel12hsckPmiRCfJSNtL4IHY5Bc7QyOmEMdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517754; x=1796122554;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f7K+OWT5/zN97AWFOPBzuexi2dmP1ajwM95QsLerSkw=;
        b=jm9QlL855lf/cZYl4PRRrE2yNbv7Y5qnEJaaoJXfVy0Oth3t2xWl8wlBPHvsXiFpsR
         vwR5Yu0BGIEPrcOCm+G8r978M1g25w71Cy/3rCUt20i3jyN7dGpmyEWWcFZZ3mt1ShPY
         Rv0zk8atKFWBwhY5kgsswVRFYlaz4TSCodvM46H1WvAeWy0eZac2/nbSIMZMlNDh4+AC
         EQkdzfDSCJ/rjZXczVv9vHHDB/nG0XMImd95XugQPPmS60a27MYJwkjp/SiJtVXpvK0y
         qLSydwRNNTQAZmwLhDIqkAlLnHlGZ4O2GznQ/tGa00+l5cu/a9qQy5Hm+R3CmYAVkiyc
         mQkQ==
X-Forwarded-Encrypted: i=1; AL+hErGzo6jhuJ3rsJ/zaR5GwOcp9wOTRWkMlGu09qu9DUjV3kNdUZUrR9zsGlEaQpyoiq6ZaQoTv/zJDcdGiGY4GQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9mK+z3aaS4EvJKp5ckAEm/qAHz9lKbhfmogsTdXTASbUnATMq8
	oSvYlgccyb3TiRlwsD9Bu2REWbFnpafIJ5MCpuyeSxvBw+73FTt6KKYMP/Hk2/09e45j+b83TIC
	qj1mn+EciYULaq4/70UQ4XbF08OvuoN8eCtbWk/7trw==
X-Gm-Gg: AZFdTZfO/gfsenxkJJ5N82mgO8ksFgcGulFKNPpamDCGwY/rIgnomBbkK1m8E/Ot3Kn
	BN40BdKDBqj+G8VlKsR/McTf6FDuaOQEQmMcHXpev3Q7Joks+VZnHLja+vBGe991yLKfAaOx4Xu
	Rtpt/VtnAFycReyh9B6KuAijDgZAH4QPKvWYmrjZizr72u0+QYH9ZVdOPuXoaHnPOvpIS61jNxP
	8JHo80jiZ3IQPwAGZK6NOR0HkB30JifyE+VWrAtQm9Vjf305WJ6MU8BOvyJRyY5rtDTy5ajHXn8
	wUSX1oNIfLlfIgB4P3TIuBSoT4IW3hK3sxrK/7htBiYSMkwJygHDk7QUNORcr15V8EMHCBUOABe
	ylpHGyUPXObJkkFg2CkuHV315GeWU9Uq8IlReUhelx4j/xYi27pDS2mvRV0XxpBL4kw==
X-Received: by 2002:ac8:5d04:0:b0:54f:50e7:6d69 with SMTP id
 d75a77b69052e-55d6fbfc728mr265521821cf.1.1795517753910; Tue, 24 Nov 2026
 02:55:53 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <6c6cea56-1af2-4a37-b081-83244d5e09cd@kylinos.cn> <20261123063609.82014-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20261123063609.82014-1-q.h.hack.winter@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Nov 2026 11:55:42 +0100
X-Gm-Features: Aa3M54r7eAE856Qdq3AsqWMUaoTcqR2q2T6lCT40Ts3802VL14VNSmjueVArc1E
Message-ID: <CAJfpeguspTb0w7DK8-4ALHMcHbH0+Qs8nfh78mOJRwN3VQcAdg@mail.gmail.com>
Subject: Re: [PATCH v5] fuse: virtio-fs: fix lost wakeup on a full virtqueue
To: Qihang <q.h.hack.winter@gmail.com>
Cc: Li Wang <liwang@kylinos.cn>, German Maglione <gmaglione@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 07:36, Qihang <q.h.hack.winter@gmail.com> wrote:

> On -ENOSPC, add the request to queued_reqs before releasing fsvq->lock,
> as send_forget_request() does.  This prevents
> virtio_fs_requests_done_work() from checking queued_reqs between the
> failed submission and the insertion.  Both callers can then return
> immediately on -ENOSPC.

Applied, thanks.

Miklos
