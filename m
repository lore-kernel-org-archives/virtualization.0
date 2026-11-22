Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358315;
	b=Rdoa825HmkyxHfB5WqV1DxxJn/ctTdcJ3Zn252lthWibc4I424Oiko932EROlhpZcwGX
	 vRn1tieZHDK5dSPYm4fx7N39pifcoTvyZbJE/vgNzTv3BiGwWGK6RcoosbWelfY/8MuPx
	 DfxRTuIdWRXSzt6X+7y4wt7RoYZh8eZoxNdpiFJV1y9o5aNLQpNb+rbHklAP+urgwbIie
	 +7LP9vH4FEjFNRwEJKNE7P9+GDLCE9hAtxi/3rP3BAacBh0/geeusp/JRLwwEyj/u6LRd
	 HCY5e4D1Ho7oglt2xvNNvrIC9SqgMYkUKEE6w6zIok8kcFyw4JrfMn0hvi+zlnUjulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
	b=ncgOzBfXL2XY3PljExmN4IUqJqMlKyNjj5nEWNNhsuaHg4twQuHFj/8HfZ8hYK3sIxEH
	 IGvXXiJYQVcuaAqy2WDRIB519NyqVE4MtL3jL7mqVLazNBqDa/51m/2bTqxuxaeQYUEm3
	 aebmq5ovy5b+lNe1M5a8Awfkm/7AU/ntqqzs6tEedAX+ydbBor3C6wKx8UaXQ++Ij8N1+
	 lYvAyi9y2i0Y8zMSvhe9xJ/QKgbjUEB0ONOZlwWPHGE24nplhsXbW9DSRPbPTCOKzawVs
	 yxDPCdlVMutndeuvacS2dlxw/1l4ODjiXxJ409uNdfXPLx+5GiUHTZVJW35fOotM/dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=AwdDYYff;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD7606A337
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 14:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2FD7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=AwdDYYff
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9214032a2fdso17697886d6.0
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795358314; x=1795963114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
        b=AwdDYYfflELfR/b5OcZN0PhvmBlwx/ot8s3TcBCgqak/0YvxpY6Jqj3N0VhFdbqERd
         EfVcT8uc1St3x6iQiLlQXafHQXUtgG5zKcrhMI1H2ReXQLiVSqgxDpBUWllP3rUrNOEh
         AOChrmCnBlGJZJuGFYNs834ISymOkN25t5hP40Fl22Btddf4g2nsvaEZh2gef1arkcsz
         vpSKPZcywXXTrnZU8WSraygswQ/xZWub64BY8RXO3eh56Pk7C+aff/6KjlTH8IOcxCs/
         IWZsCUWA5rJf0Zjkv5xlOYS9SyqzH3/1c5X4La7EFd4E3yfBr6Hqv0LCCCi9cOr8Ksi9
         5JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358314; x=1795963114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
        b=dG8E1g76SpnYwYCCCabVN0YasL5pI8G8nxxKlGYqjPt3WCYUFi7q6cKK2DaHgss6ye
         v1vDI/Zp+FA2P59xzg7KFUhfu4064NmlfPztIKmoFpiwyeiWsJZD3UamkeDRB/OKwXKX
         izn6RWDHoE1l1Cf5ZkJAxh7CLALyFKOaAICopGfSZag55mgnI24XyurMGJU+QS7dOU+w
         aiTcAV+yBWq/VZA/VqWYP3deajfc/kSc+56xweY8f6IbI3IV/scTm897/DXpEYWfqJtm
         ugE/exBBasxsc3lk3RM36BLBOhKUfKOTR++A2E9TRMP+TJS1UMGFw5GToIsakpglIK1B
         6t5A==
X-Forwarded-Encrypted: i=1; AL+hErGTSR4Zm3GOrpbFy3CnCtDMNGTDpKVHq2B3eJz+MgICssVFS6XNAX3dybV4OTtdAlqB+QJXhlrYXhpgyMLung==@lists.linux.dev
X-Gm-Message-State: APuU4Z9rbdG/iuKGokmkoIx2gRZHnDHcst07CaK+RJzm4QvLsmg9WUHg
	PXhlMoRWIHnX1U68KWtamX1Fw5+FWWSoN4wg0GWrhyBPpzUpd/HyAkS+VQrhdJ7/ZQ==
X-Gm-Gg: AZFdTZfZrSHMZtn+j7Gri4oSbTtA9ga21M7iIe3rvOTu0xAb0lX7qKRpvahzxKiguas
	AGuQMciTG7iQmuEOHuDq7wzNw1pTRau2tqFnXyNPFIox9fnfLyHhOQeTZPN0yzRw7T1KOJalyaQ
	G9N+TqXLUU5YKxHGr7Ggy8GBRCxjr996QU7V7oduLh/oQIHQCdgrYZ3ign3ZovnErgWQWg4+BEs
	5BbbfxMYpxVWl33AU1YNEHH5KPzgf1Na43JJkl59sQE9FcRhgtuUfowejTJa818gBPiR50xffEM
	FVYVdnt8xzW/zMdSo26lSdVIwjCrv/iHNwuazEe8eEBtIKvWvAuYX9mAxHKNPymL6VOqLy91uvn
	7BF77lxpXMVSIAB/3d40H+JGsWIx07EgaHK2SmDHVyvep7Z+CT2LDszDoM6d1KHwD2Qz/wA2sdm
	J09VQc/cW/Qy91G94mWmYp7VGnXuoEFjHfS23CoIz52KNNzgDt/NJO9wZLuVm7HazzZtvkn6Rj7
	sEz5+apSV0TL67AsjXWSYsTzlKftHrq5pqG6e3v6FvmdnTE/x1dG9qRs0LS6MEN+bhGs4cibjYK
	6ay4iqhLO/fv+ZFMhO8dP+3G2Pq2nXqdhE0pTuykvL2+mQB/F5b3
X-Received: by 2002:a05:6214:5015:b0:921:8d9:7f8e with SMTP id 6a1803df08f44-92134a6ded7mr155188986d6.12.1795358313858;
        Sun, 22 Nov 2026 06:38:33 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm79665516d6.39.2026.11.22.06.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:38:33 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 09:38:29 -0500
Message-ID: <20261122143829.2674252-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122092235-mutt-send-email-mst@kernel.org>
References: <20261122092235-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Nov 22, 2026 at 09:25:37AM -0500, Michael S. Tsirkin wrote:
> this is followed by:
>
>                 virtio_features_zero(all_features);
>                 argp += sizeof(u64);
>                 copied = min(count, (u64)VIRTIO_FEATURES_U64S);
>                 if (copy_from_user(all_features, argp, copied * sizeof(u64)))
>                         return -EFAULT;
>
> copies at most 8 bytes.
>
>
> did you test that this patch actually helps anything?

That first copy is bounded, yes. The unbounded part is the loop right
after it, which is outside the diff context:

		for (i = copied; i < count; ++i) {
			if (copy_from_user(&features, featurep + 1 + i,
					   sizeof(features)))
				return -EFAULT;
			if (features)
				return -EOPNOTSUPP;
		}

It reads one u64 per iteration up to the count from user space. With
count = U64_MAX and a large zero-filled mapping, it only stops at the
first unreadable address.

Yes, I tested it, on the vhost tree at 44293796526f (KASAN + lockdep),
count = U64_MAX:

  1 GiB zero-filled mapping:
    without the patch: EFAULT after 27.4 s
    with the patch:    E2BIG at once

  2 GiB mapping, SIGKILL sent 1 s into the ioctl:
    without the patch: the process is reaped 46.7 s after the kill
    with the patch:    the ioctl has already returned

I have a small reproducer (a few lines of C). Since I found this with
the help of an LLM, Documentation/process/security-bugs.rst asks me to
treat it as public and not post the reproducer to a public list, so I
have not included it here. I am happy to send it to you off-list if it
would help.

Thanks,
Hengyu
