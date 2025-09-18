Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5828314D15
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210312; cv=none; b=JJo/FJNPXuqc5y116r+UdihYL9LVpJhXNusEGWdXgcYKLOigdWTFiXvgeL7NArlhRixpxUSzjzM6NGXh7oaH87olh70dRgCG77Hu1IPxg2ZEgyBoOwFtnhWiL2SZjNVXnhGiVjz5dT7tgMP0sW+4iqE3v+a/tvx02WuFkTO+lyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210312; c=relaxed/simple;
	bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2c33eqHWlrDDS1gFj5mz+laqc+T8EjVrYiNwACxa/c/uOI7Qp7fajSYBqMhZ73Z9X2o47AIUOEJTo0UDQUdZB2UsOi0J8TFGKZaDG4ORtRdIMVSGk+nbOZAMdTixCTE2LR9wgoT/an9+SUyzWcdjepAmmFsJnoYopPn38eTA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fel1IHi3; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fel1IHi3"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A82740077
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aisk15TtgRO7 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 15:45:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=filip.hejsek@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2128040051
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2128040051
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fel1IHi3
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2128040051
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:45:08 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b00a9989633so232661366b.0
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210307; x=1758815107; darn=lists.linux-foundation.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
        b=Fel1IHi3Huzs0Cmea7J9oqzx6hkbUp0cvWLtqLA2OzIcQBnRrvAVtVRQZ24jsWWTUx
         2JO6JmD/82yBhJctVcF6SCkZtew/EaI6J/BTVw7Nmt4uIxuayjnEr1g2ciO85cj7TdBg
         YSW0kIDNkMVNHU8GF7PIYV68Gm3J0/bzdTnZDHnZkVNPq3o8lVOOW2ZBlNoECn0MC7hj
         vPplhMKGeknpId1toeJPFrvYHIJ8WUWxd+xro+ROdlQvskCPeZJ6z/w5FHqa6zXzAes+
         lw4SsfY9kuzsgUu8LfHvPKedK9wbLYHnPGJm1r8X27j+5UrEnIps/73eZjc7F63E2ixG
         ZTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210307; x=1758815107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
        b=Fv2++vGt6heYzN4WNoO05Cy8Aae5E1z/XQDpu4a4GAXyaHjT4rdRQGIrf2QtAvJ1gP
         Q7T3tfKpOfVq+3SCv4UdCOY6I1fuerfDfAz45rU5ERec0GOSqhEBcbd+qUh0lQ3kz9Zp
         RGI40lydz9/nERmj/yd5Est0yC4drxRYxnaYFfqVscWq0VHLtXap5XqkytN0KXlmt1hn
         xrMv4xAD6CtzplqycozVWjnQu1YBaCutQfQvarKFUS3npOKmMyHubSNuv2s4LK/Nm1C2
         xDE/VRWSFfmCHHY8pQgANSfSKoHh2OEx8j/fUMy9oeDPTGxuOfxkyA9k07lxOrRTRN/K
         dxSA==
X-Forwarded-Encrypted: i=1; AJvYcCVDUeoI2Nn8WpmWeSotnmUMEcIbL44IFkCrOIGIqqXYJp4F5zspXgJUzkztnDvYjWQZmNWzFkGVO3m93GC+bg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxfxslNeOpGXgtZ1JOZBHhLHF2BV5QGsuEG1bXNNLhf+eCdM2L2
	CPfecRfBKcA19KbXRfQIAa/GoJ8Nd8I+OXfWPKp4edUiznPj903Zvf/5
X-Gm-Gg: ASbGncsk9OdVnWZz4pAONASkxmIZx6xQgmo8xIigTths7BuMnRy9beLiVmfk9XjTKjq
	CAL5bFB0WhFFHM7FCywDxq+iHHqSUw6IIPii2sN+0Q4RGlZw50klWYo+In+fpkqhf/vAqs+nOUn
	oBcNqcgglAD3wB6BY3PYMeSfDptVjv1CjkwNU4DEjOYhGrJ70VBsm5j7ES5lO3Mh1XdqJbLd1KZ
	wV+3T8ht+AGvF2W4e6wAAxJeU/4yoydjPgtQbFL/HYADjSkprbPcjssfihEDsYAafRFnmrVjX5s
	Zo77B2Y4mgXzB1Jqijzvzah7Enjd/xkWrpuScpoYtIvlVgbHpmF6Un6NPEhO+TrIEDOC1UvlgQ7
	45AHE7qq36T7E0m2xDb/b4w6FNXlhh849OHcmMM9iTgvWq5wW2NR/F6f1jrYfpvq/1yo4
X-Google-Smtp-Source: AGHT+IHhJpUJxm0JBqQPK1WWHMUOmGprTfN1qsQTFyUzj1uozoUmCz9sEIlUOLodf6VL0JxH0gPMWA==
X-Received: by 2002:a17:906:c150:b0:b04:3402:391c with SMTP id a640c23a62f3a-b1fac8c89d8mr401452366b.24.1758210306797;
        Thu, 18 Sep 2025 08:45:06 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890cc98sm218393066b.49.2025.09.18.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:45:06 -0700 (PDT)
Message-ID: <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alok.a.tiwari@oracle.com, 	ashwini@wisig.com, hi@alyssa.is,
 maxbr@linux.ibm.com, 	zhangjiao2@cmss.chinamobile.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 18 Sep 2025 17:45:05 +0200
In-Reply-To: <20250918110946-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2025-09-18 at 11:09 -0400, Michael S. Tsirkin wrote:
> Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.

It seems that we are not in agreement about whether it should be
reverted or not. I think it should depend on whether the virtio spec
maintainers are willing to change it to agree with the Linux
implementation. I was under the impression that they aren't.

I will quote some conversation from the patch thread.

Maximilian Immanuel Brandtner wrote:
> On a related note, during the initial discussion of this changing the
> virtio spec was proposed as well (as can be read from the commit mgs),
> however at the time on the viritio mailing list people were resistent
> to the idea of changing the virtio spec to conform to the kernel
> implementation.
> I don't really care if this discrepancy is fixed one way or the other,
> but it should most definitely be fixed.

I wrote:
> I'm of the same opinion, but if it is fixed on the kernel side, then
> (assuming no device implementation with the wrong order exists) I think
> maybe the fix should be backported to all widely used kernels. It seems
> that the patch hasn't been backported to the longterm kernels [1],
> which I think Debian kernels are based on.
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log=
/drivers/char/virtio_console.c?h=3Dv6.12.47

Maximilian Immanuel Brandtner wrote:
> Then I guess the patch-set should be backported

After that, I sent a backport request to stable@. Maybe I should have
waited some more time before doing that.

Anyway, I don't care which way this dilemma will be resolved, but the
discussion is currently scattered among too many places and it's hard
to determine what the consensus is.

Best regards,
Filip Hejsek
