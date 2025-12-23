Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3B2C11CE
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525813; cv=none; b=KmBF7aYk8M6p4cFuo/2R/N/Ir5jmPeJrbvUnE/1jpKg9Hcfg2hT3EKi1Z0NWfxcWYvQ5MERpYQqLs8f99DauULcMVjH+C9os70+rO8gPZQ+zXejlFKICmxzS5gUbpKpX4l3N8PES7rf8zxHla1WGY8qRUh/kNZ62mYwUpCPtE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525813; c=relaxed/simple;
	bh=gUdUk2X7+RSxU+5LaToWss7k5SP9k1Z4vEiO6zzXczE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKPK5CrB4AUMTA8+k8mvL3J3dt2wvrDngDsv5oxdSzQXcOPOAqDiizdSgMgt5NEhSVYH9SiQWlcDDjy9VPoM9tOdxFi2/mLuCtyXLIJgbuS2fiqG4yMs16trv01v3fiUqMezUg32+OTZieI43j2GuY6HkehSd3aWRtfgywrV5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBYq7b8S; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBYq7b8S"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73161849e1so1112149766b.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766525810; x=1767130610; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUdUk2X7+RSxU+5LaToWss7k5SP9k1Z4vEiO6zzXczE=;
        b=RBYq7b8SvMGVQQvWc7oMTmoi2f3G3OZKe6eeDkjtO16CRjlwfqSdKej9lass75O8QX
         43aSjUR5s1JYVwn3hlAwQ2/0oI/9wT/bz+8S2YJbEsdMK2/1KNjI9HzJPuvMiPQZgJ3e
         +hptAGa40G/TsDAybGP3PZPRvtZF6e+eKeXRSNmFW+nOjtJlIajD1CNEd/NtBBuahDuK
         igQfjf5Zqo37A/PyQc0O2j0qOZQu1TnUnjNbxtR7fUbghBZC4dWosK6rt2lJHLfy0zQg
         aTZNPhi4IGVbZVs/8zhFYU7cVhv+DR5ItHMzWzQwINyH8yk3xz68pgVOp0YpZyoGVnjw
         FPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525811; x=1767130611;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUdUk2X7+RSxU+5LaToWss7k5SP9k1Z4vEiO6zzXczE=;
        b=KZBFQIN2bG3atGjNi6Sy7HtT5yvwFl6kEPB024ols072TazLzrJgf22vzaCtEGwTqk
         /NYWeXVEKIFLsv0vkBKua3B/+V8pF6vTakBpo+4tyn6aX1wXvG2PPNkI7A7p6v9oHwzK
         vk36KGCMnuUAnAntbCOyCZpETeWpsH153QAruv1UTk+UGjH5C2/w7gmXVZ4TAfgXSpqn
         f8evziUavoMYdnHtUi4twgD6CQ81hyqta4jgnar+MBUqqozPshNBLg9Y/YLFRjgroaQc
         TddMxj3R1nHy0p9iIJJEihUvkjVCL7+g57ieBnHbVVL+nivRLNNjuDgtBR2szSCDdKFz
         raaA==
X-Forwarded-Encrypted: i=1; AJvYcCVnOiFW05reV9eMwoTe7+vdsUBrJzk8oGm4xLQ1L4u6snHUtpfRtmbGq4xUuZckg6QnwkCQMZiCcyu4ElJc6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YywaVO8JRC0qdsQRoK12qOKD0Df5C2pPijo5mQNEi8Np/oigmoS
	uZDL1F2P2qWvfNGAQK62Rt3hhf5Op1flMa/m1bGBbQD7se5b96JO5FzC
X-Gm-Gg: AY/fxX70IWq/OViYT3mnYzzCeSsBSI95JcVzKBh0flGvMJ5/bAngjAYw/IHVMiu3pap
	UQCeR68Gl9Ej4pQ9YVdELatBFz48dPE09OmbjV/VqaGe3Dgqvo1oly3+YTQPCAltDRHn1nznjvm
	taV7YzRktuw8cyjPDPhxu7lKe6uQN+oOeyyDX1MboLOm0RfTlKT/yLhXRwBXfeB8+oEo/Q0Y4KT
	zK5nfhU7MPZXGTAmRtYIfqN+kWLlgJxX8OFLIKu1FDaClsZkoJR52wnNFtALYkl3qyOuigoakL/
	ZZFhXcsAlKkQe+PJIQ+Xgm+tkzteuQ7xjSwrKoK5UQPahbDDqmj2DJWuMr7J7jaZcLsyEy4KWKf
	uJD1+k6x39Rhamy5Y8pRoiX1/6lS7GH/1D+QuOBx1D1iMCML83HN/mTNHYykMU6ZxDGc76jhbgF
	WOvs3GSNIu1pjGohgTeesOLSHaFWNBsvng/jlHIs2mFxKEWQ==
X-Google-Smtp-Source: AGHT+IEOKCU+ecErprVHNUinzwMQMU/A+Vj2HrOU9NUH54HaNAaJTE17Fm5T0tT6yY58oECtSAB36A==
X-Received: by 2002:a17:907:3f20:b0:b71:cec2:d54 with SMTP id a640c23a62f3a-b80371f6e11mr1575022866b.57.1766525810413;
        Tue, 23 Dec 2025 13:36:50 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de004fsm1551254666b.45.2025.12.23.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:36:49 -0800 (PST)
Message-ID: <b905018d5ac8a852759e8483ccf8d396eac4380b.camel@gmail.com>
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: stable@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, Daniel Verkamp <dverkamp@chromium.org>, Amit
 Shah	 <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev
Date: Tue, 23 Dec 2025 22:36:48 +0100
In-Reply-To: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

I would like to once again request backporting 5326ab737a47
("virtio_console: fix order of fields cols and rows") to LTS kernels
(6.12.x, 6.6.x, 6.1.x, 5.15.x and 5.10.x). The patch fixes a
discrepancy between the Virtio spec and the Linux implementation.

Previously, we were considering changing the spec instead, however, a
decision has been made [1] to keep the spec and backport the kernel
fix.

[1]: https://lore.kernel.org/virtio-comment/20251013035826-mutt-send-email-=
mst@kernel.org/

Thanks,
Filip Hejsek

On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> Hi,
>=20
> I would like to request backporting 5326ab737a47 ("virtio_console: fix
> order of fields cols and rows") to all LTS kernels.
>=20
> I'm working on QEMU patches that add virtio console size support.
> Without the fix, rows and columns will be swapped.
>=20
> As far as I know, there are no device implementations that use the
> wrong order and would by broken by the fix.
>=20
> Note: A previous version [1] of the patch contained "Cc: stable" and
> "Fixes:" tags, but they seem to have been accidentally left out from
> the final version.
>=20
> [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.=
com/
>=20
> Thanks,
> Filip Hejsek
