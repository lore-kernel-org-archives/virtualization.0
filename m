Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB181A0AE7
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739251; cv=none; b=IcGgcAnet57p+MVWoItGDSTEu7jtm9tBfKIuExLVgFHIeu7PmPpjLKMeHlV0sVDF5IxeCJFzkcM6zLGMMifG/LRqblUTixUOfVzRbhB/kGnjswsMmnSwDRT71FB/An3hFj1eb/FDC5ROMRVYKppdAVGB6IO9oUd65D6wSs6TDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739251; c=relaxed/simple;
	bh=UcMXaEV7R/bUuyeSozVX/+Hj1QoPeLuD2nEoxOWGzU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8AnLKUqStkyyxtujG7RszlTbV1uTKgWltz5vRLprAtr3W8RrnxQYqz/XTPyTa2nLzsYKuvsplSToWFgsNViinVDsOUQiyti4ILnCGBrL/iPgV6efkH3bwXOnb+D81w520EyjiuGKb5+Jd0klMWlkf7j4vWhfCS1Z2aqhGF3N9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuzWovHJ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuzWovHJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D7F9404A4
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 23:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rdZdU-49m3Bu for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Jul 2024 23:07:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b36; helo=mail-yb1-xb36.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 70A014037C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70A014037C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IuzWovHJ
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 70A014037C
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 23:07:28 +0000 (UTC)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so1243580276.0
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 16:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739247; x=1721344047; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2hBswY+u8xjK1Kzvor9fB+2gLyEPUsUoItxFLjtkvk=;
        b=IuzWovHJ7f7cHiATgrLkQyCABHOXNcMfKgAxiNiJsjWPvS1YLAv9SUwTx/R8h5p931
         f25nwGqHVCEQoPUd97WcO2MPctB4Azx5J+eVldMn3TXlpztbbT+TPPvKDrsyySCnX2zj
         YCN0TURMrVO55fXeSG1NaWgzRJMRefoT37DB3nISmPPwZztRY0OVwbvXpyF3dgFU9evj
         Ug3wu1vby/qrJJ191MsCMLNYLhNJvuK947RZC2bWBfeRgSNIOUSDnerBqeNXd7xRhjmM
         28csQ8ttpK5UU7lT1/1y/GqGdhWkTsMO5LYGD7zSq137N/5iCi5QIDszEU//A+G0QaKN
         O3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739247; x=1721344047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2hBswY+u8xjK1Kzvor9fB+2gLyEPUsUoItxFLjtkvk=;
        b=qqkjXQr3M3d87R00q5lPUafE7JYOs/iAldFKKCvwoOj8hC5WSMRcgnVsv+jiaEEk/A
         ntwKw9LA7Tmm0nK6Sfki+5LMd2JmemuwHZc5xAvtEKQQvIAdMrD/R+xBW9YfKGwRnDsT
         8drKRoGas0cSCyN5QDNYGUTE6qd5F5ZTWZT3Oj84y3eBEXRzmIZPrMeFaRvaTAkVIMcl
         oN4CcZtAkZ2Es/tLwUrfEo4eV05hvPVu3kf5XiGtSQh6cSj0E7aTBt/K9TtuqTK9XpxD
         zct56J9qXT4Mt0ph65vZ6+z0nhxce8PpuRRMli81nPUfNgU+ifqjGLj/mCG1BERo3EGI
         p7zw==
X-Forwarded-Encrypted: i=1; AJvYcCUCTdVl6PUa0+4EgfGojVfKbNTx6XcU6SFAd+/aN7aRoCuM95Dmz/9vObam6WgYfjEKONxxXYVkRvhuO69ZZXnvJYkIROcf9pLK2mBuXsIVfS3lv4aSbhnDGA==
X-Gm-Message-State: AOJu0YwF0PNazsBtspiEID7kfdjIw1HWQqT/8aIYILWuQMvbabGrRCkV
	6zbnIiWCBHXoxU+Gm3nigdDOTHygB4UTsCW3MN2ADW3GGwusGeYGWysU7t+rJULLaLcDgx5xXuJ
	K1aT9el6aDgMv4q1/pY/ZVX/W4ck=
X-Google-Smtp-Source: AGHT+IESAzgUImuWHbpxSCeLvNle2lAnCtNiymuxM6do/gswGHb65EvzDJ50dh8SH6D3heE0PgCKfCSwNt2zccYk0iI=
X-Received: by 2002:a25:4ac6:0:b0:e02:becd:d5eb with SMTP id
 3f1490d57ef6-e058a4d4875mr967584276.13.1720739246975; Thu, 11 Jul 2024
 16:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-14-amery.hung@bytedance.com> <AS2P194MB21709F0B79D6FB686D373B199AA52@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <AS2P194MB21709F0B79D6FB686D373B199AA52@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 11 Jul 2024 16:07:15 -0700
Message-ID: <CAMB2axMyA2TDZmXaO_BaFHk4Lh3Ri1LgEc7UU7ZoNsBsqANivQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 13/14] virtio/vsock: implement datagram support
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, amery.hung@bytedance.com, 
	bpf@vger.kernel.org, bryantan@vmware.com, dan.carpenter@linaro.org, 
	davem@davemloft.net, decui@microsoft.com, edumazet@google.com, 
	haiyangz@microsoft.com, jasowang@redhat.com, jiang.wang@bytedance.com, 
	kuba@kernel.org, kvm@vger.kernel.org, kys@microsoft.com, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, oxffffaa@gmail.com, pabeni@redhat.com, 
	pv-drivers@vmware.com, sgarzare@redhat.com, simon.horman@corigine.com, 
	stefanha@redhat.com, vdasa@vmware.com, 
	virtualization@lists.linux-foundation.org, wei.liu@kernel.org, 
	xiyou.wangcong@gmail.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:03=E2=80=AFPM Luigi Leonardi
<luigi.leonardi@outlook.com> wrote:
>
> Hi Bobby, Amery
>
> Thank you for working on this!
>
> > This commit implements datagram support with a new version of
> > ->dgram_allow().
>
> Commit messages should be imperative "This commit implements X" -> "Imple=
ments X".
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
scribe-your-changes
> This suggestion applies to many of the commits in this series.

Thanks for pointing this out. I will change the commit message in the
next version.

>
> > +static bool virtio_transport_dgram_allow(u32 cid, u32 port)
> > +{
> > +     struct virtio_vsock *vsock;
> > +     bool dgram_allow;
> > +
> > +     dgram_allow =3D false;
>
> I think you can initialize the variable in the declaration.

Got it.

Thanks,
Amery

>
> > +     rcu_read_lock();
> > +     vsock =3D rcu_dereference(the_virtio_vsock);
> > +     if (vsock)
> > +             dgram_allow =3D vsock->dgram_allow;
> > +     rcu_read_unlock();
> > +
> > +     return dgram_allow;
> > +}
> > +
>
> The rest LGTM.
>
> Thanks,
> Luigi
