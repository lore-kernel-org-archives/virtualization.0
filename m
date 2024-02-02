Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A617C6C3
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867895; cv=none; b=tK9ZtWbhq6LNLxubFi9q3+eNf2RYPcOD/UcB3kB0FxNKoHBCvsFSImZtlAplC7K7GTSqBGL8Ldgw/YkB74hdh9jCINzwZoJmE/v1nRUD0s4PQLhdVWzkm+tD/rxc/s/UAANNkctGEW3hr8ZbJxRtm9xQO7OgSj8UPIyQjF0/v2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867895; c=relaxed/simple;
	bh=l6H1gbJcCr35vCqymXlCF/h8YZTcgy5+Gozii0AQ/Yc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=R9xzUvQZVA39CBk1cK9EAqFs22owTJsks3mYs66qfnF9seOQPZBdQfZZqJRLEdMXQDXciO7Rx+MC+UYyUkL9bt+TZ0v2UQ+87Oo7QLoNuTs66p4H68QOdVPyfAum+e8YScSh588UvDBVwQWBdbQIEpfaF5VHU5CDdwZuwnCBVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i0sbqRxN; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i0sbqRxN"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 848566FA84
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 09:58:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 848566FA84
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i0sbqRxN
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.499
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fG_hjr5eIJc0
	for <virtualization@lists.linux-foundation.org>;
	Fri,  2 Feb 2024 09:58:12 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF4076FA63
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 09:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF4076FA63
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706867888; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=l6H1gbJcCr35vCqymXlCF/h8YZTcgy5+Gozii0AQ/Yc=;
	b=i0sbqRxNt/cim2uZ0pxatBDfeAxnZJTMIpKIHy+YEhyjhaSjw7vZa00/wGuGW/HdyRdfw6/Wt6GguPfwkLmuM3IzF9aNz6YqcCI1aHx/me3G0RTjZyHv7byq37cu0kRIzum8tuHwdFLgOJH2dY4MaJryf8K+l9LAAr5JwN1EsdQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.wcDWh_1706867884;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.wcDWh_1706867884)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 17:58:05 +0800
Message-ID: <1706867854.8480594-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
Date: Fri, 2 Feb 2024 17:57:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com,
 hengqi@linux.alibaba.com,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20240131035535.22258-1-liangchen.linux@gmail.com>
 <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
 <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com>
In-Reply-To: <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 2 Feb 2024 17:25:02 +0800, Liang Chen <liangchen.linux@gmail.com> w=
rote:
> On Thu, Feb 1, 2024 at 1:37=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@gm=
ail.com> wrote:
> > >
> > > The RSS hash report is a feature that's part of the virtio specificat=
ion.
> > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vh=
ost
> > > (still a work in progress as per [1]) support this feature. While the
> > > capability to obtain the RSS hash has been enabled in the normal path,
> > > it's currently missing in the XDP path. Therefore, we are introducing
> > > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> > >
> > > 1.
> > > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@day=
nix.com/#r
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Thanks
>
> I've just realized that I forgot to include netdev@vger.kernel.org in
> the cc list. Would it be advisable for me to resend the patch with
> netdev@vger.kernel.org in the cc list to ensure it receives the
> necessary attention for potential merging? Thanks!

Did you use ./scripts/get_maintainer.pl?

Please resend it.

Thanks.


>
> Thanks,
> Liang
> >
