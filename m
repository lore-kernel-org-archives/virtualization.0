Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043715B020
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865919; cv=none; b=dsGnk7FN8QbBqxiOFtRoKnXWmRGZJJuQ+OWaxiuVzd5f56da7PtFC1AIANUwZMqpjtrjgDqkMIIpki8P1UfaVXFiYo6t6YRqnM9PIPwtTa0ACLWr7Mm1meQI0yi/zSQlU5XVFUu0yFRoJSd0oE4ceXrO387qNGkhqthnVzo1svQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865919; c=relaxed/simple;
	bh=fnmqYvA56Zz8Eso8lomhs4kIgscSdpmYnGPeuXogSRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXyKdZMvOY7PaIV03UgyvlUEcxiZFcgToscLMb3dLVTdE23/S04kh5fV4X9HKo69yPZ5GCSd5ezJJmEbKvY7AfVUGUWOW8dBfusXIg88vN4zQ/kuGKPQF+RFGNvuoFEyx97eO1K/sUhg4TQM2mWACuXwwkUvI6Gw3AeW31V/qSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq//9ALn; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq//9ALn"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8624A6F80C
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 09:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8624A6F80C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hq//9ALn
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eaoA4JlHVQN4
	for <virtualization@lists.linux-foundation.org>;
	Fri,  2 Feb 2024 09:25:16 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A759C6F7F8
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 09:25:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A759C6F7F8
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-785388b3281so113612285a.2
        for <virtualization@lists.linux-foundation.org>; Fri, 02 Feb 2024 01:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706865915; x=1707470715; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnmqYvA56Zz8Eso8lomhs4kIgscSdpmYnGPeuXogSRw=;
        b=Hq//9ALndfMNEAPFRt6XuDMpskNxGUryDap/ZIQVkToxu7jm4wo8dF+Cv/HGDttt56
         QEeXXTkseswnfRmrQjXah5MvP4V6faOeprmeRoFj4Jga/wxqmaf9yMkexdbZSS/C2NfR
         0UWoL8RN4CyvOT4R5Z9muCmIPcZDWJ7/Lj/O3THZihqFHuYneO2WvMyABcWm9pAntEU6
         L3eQUAzC3HNTen+wRYQ4LeWC/eGMSGsvrPcUiRD5a4yOQhLBOovr5/MsNH5IphWpDaEI
         e//GANLuWgLTX7Fq54vFihWvkMsu0Zf17zPYJOaXLKIuzioZg3JShZCWkkXPzzTQl+xy
         Qm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865915; x=1707470715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnmqYvA56Zz8Eso8lomhs4kIgscSdpmYnGPeuXogSRw=;
        b=dut58rwcabUAn00sZ0fxhm0na2UJrDd4sClRkiH3//b+aNMs7bG8Is1lf/Rh5gJfVy
         UDMY2RQs6B2oe1JreLKMhjA1MgYshLaNj60CQPkztRu6SyfRk0CFCfH0Pbc/1C7/M/XG
         OOXWrx2Wu8d42H9QkPuc8DscJnJStRjQYoq0ZkvNkBUpFToxhH2rf7ls/UOLqI6KAdxg
         jsjvrWp4yRgzTAc+WV6iJYzEVa7cG6g6G6M44F4V9UoowuNAWpoERVJTfASCpwIjYZKs
         QqJxUaGlj0SaxoWFfF5kXy6wPuxZlanHudlKGaLCSbbEtnayhUiImTIrBjeJBM7fhSMi
         tf7Q==
X-Gm-Message-State: AOJu0YzbHYGtHeM6mdweC+8fUVb8RY0xfmSQDwhlRSg9FoDv3RChlLE0
	wAC/weBiA9J9xw1Ie6O00ZzEt6biqBWqGNJOnlrasp7AzziEMAEeZylcTZVnVSsCuPrp8kKTnDu
	4D7DBkFELQin6UkC1FKQy09SLuBg=
X-Google-Smtp-Source: AGHT+IE9cNG3sz11N0QRuC78t6vGU21ikbAl+arTMtQUFcQAt3aBQPWr0ea3DbEbozwD/ORqzuNnt2sz1xBBd5dGRzM=
X-Received: by 2002:a05:6214:cce:b0:685:2233:678d with SMTP id
 14-20020a0562140cce00b006852233678dmr1730712qvx.27.1706865915509; Fri, 02 Feb
 2024 01:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240131035535.22258-1-liangchen.linux@gmail.com> <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
In-Reply-To: <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 2 Feb 2024 17:25:02 +0800
Message-ID: <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:37=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@gmai=
l.com> wrote:
> >
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing
> > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > 1.
> > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@dayni=
x.com/#r
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks

I've just realized that I forgot to include netdev@vger.kernel.org in
the cc list. Would it be advisable for me to resend the patch with
netdev@vger.kernel.org in the cc list to ensure it receives the
necessary attention for potential merging? Thanks!

Thanks,
Liang
>
