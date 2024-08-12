Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1D1509BF
	for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446025; cv=none; b=uPLq0rqjMtTtbSI83voPFNuaBcOY2furUifqUVKUEIFfxxHrOKsAGkFbu+Al15QL0QC5CMCAnjK9ip9vn/UBlt+mMaMbbDZzc0SuejJvPVM4M3n/pwlvhTFyEvaIS4adaSVuahknkxEO66yllrb3KNpfya8rtJ27njTJxe8svNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446025; c=relaxed/simple;
	bh=S0zPhso4B/BX7cFCElhUVcufYJsv494XwmqIF2Y/yxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F24MFOOwmiSzg2xZ3DXXfECHTy0xLEXo6SwsEid+b0+8/4PQ6ElgBOcXwEZgzC4kDBvbwa4TEXndCv9d2i9q61CMjm0EgdGNF9Hh6jWurW16h/KJjH3dC1w6zCK3LncBcRHNxO7CxeBD5M2auNvwtdnKXtZgtr8aEvbURiJqB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IThX+lwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IThX+lwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723446023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSsSzksoUZv3/VShmqUKFIu+S4eeg5+mXA9YiUlfHtE=;
	b=IThX+lwEbC3JhJlskRI5El0p7y587WMtqqZEbwMmv2MXGkVOGyzvhJaHjwPlnQtI3PlAKs
	cIz3KGBWaZ1vFeiCbpVMzgEwbBmGROIDuHp5AKDJrlo8LqHr+L8BKiiA4sMpgKnsVlr0Z+
	YpgFpXBNGIb+ocRCdttrRZ3ckExaS5o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-PAn_sX31NpS1BiqOvOWHrQ-1; Mon, 12 Aug 2024 03:00:21 -0400
X-MC-Unique: PAn_sX31NpS1BiqOvOWHrQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cfe41af75eso5522377a91.2
        for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 00:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723446020; x=1724050820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSsSzksoUZv3/VShmqUKFIu+S4eeg5+mXA9YiUlfHtE=;
        b=XaSoOJzfAnxRvD2wuv7P985nj15ZNgjd3h0fWZrkewzGZiDrpP4ZfJOIidshezI8Op
         39WXqDLl+INKqW0QV/MBRAKXwqALSMJg3MpEEiwniKO5LDUjSYJEA8FKWYAbnkps9sSm
         9OeBQzLI17k9HQeWBsqJUXYtou4fixJ5OlafPtM/E9kobj67o56VoKdEDWokoeuE0d+5
         E1viNBKdLQZYwqm1pfWaAtixvCaFZHSEm6X8WQ1mhmEfke/A0dH8qKV7CzLC7jBm/RBT
         4S6DX/FyOtineU/CoCJOIJMFBkVmDcE9HQuG+BvleN6VhL3/wrJAGJ5ywqpYcYIApznI
         Abog==
X-Forwarded-Encrypted: i=1; AJvYcCXflA5eX+8V07TiTLkhfAGYMoVn4lIbHFQVwqS4FetE2d0w6Fl/tA6aIqr3vMQwQQSIE/tc8hWbXzQHpuW5QJ47y6jhkxoLS9bn8KGHE4E=
X-Gm-Message-State: AOJu0YxCl/xghk03v2Hcnmq5fSZVeeFcTx3svkIwXy+JWUaXiRx5l3BD
	wwDTcubrmI+ZN3B+ipDyd78anJEEPy+YIBZ3iQSJEwaoMp3NNGKVO5pDsgoB+zBR8TpfWplksUL
	Li2swccK7olTivDNjsAkdd/j81xgidEo0pcesh83SZIQQWOlJZocmgUCWi6rJZtgDQOZkUNpQ1a
	ppcW1owEVtdxDgt3JD/QUbR7a00bucCMzuavf7mnI=
X-Received: by 2002:a17:90b:4f8a:b0:2c9:e0e3:e507 with SMTP id 98e67ed59e1d1-2d1e7c5e412mr9009105a91.0.1723446020284;
        Mon, 12 Aug 2024 00:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpbWsbXYgU8ce3mzCHOLbVvxlpYnUfy/J6VF+x38GwFCbri9IY+Rpchg44Neo2WJoxq/aQmGduo7dzNVi0jm4=
X-Received: by 2002:a17:90b:4f8a:b0:2c9:e0e3:e507 with SMTP id
 98e67ed59e1d1-2d1e7c5e412mr9009053a91.0.1723446019049; Mon, 12 Aug 2024
 00:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
 <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com> <CACycT3vAv1K0yBKgc_8GBLpEPwASTCCPZYAxMyUROQsyntQdOw@mail.gmail.com>
In-Reply-To: <CACycT3vAv1K0yBKgc_8GBLpEPwASTCCPZYAxMyUROQsyntQdOw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 15:00:08 +0800
Message-ID: <CACGkMEsYRrzSzNHgN490TDCWFm3EG1ic_-f4F+mu9CNz4uY=iw@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Thu, Aug 8, 2024 at 10:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Aug 7, 2024 at 2:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> > >
> > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > Barry said [1]:
> > > >
> > > > """
> > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > loop within non-sleepable contexts.
> > > > ""=E2=80=9C
> > > >
> > > > Unfortuantely, we do that under read lock. A possible way to fix th=
at
> > > > is to move the pages allocation out of the lock into the caller, bu=
t
> > > > having to allocate a huge number of pages and auxiliary page array
> > > > seems to be problematic as well per Tetsuon [2]:
> > > >
> > > > """
> > > > You should implement proper error handling instead of using
> > > > __GFP_NOFAIL if count can become large.
> > > > """
> > > >
> > > > So I choose another way, which does not release kernel bounce pages
> > > > when user tries to register usersapce bounce pages. Then we don't n=
eed
> > > > to do allocation in the path which is not expected to be fail (e.g =
in
> > > > the release). We pay this for more memory usage but further
> > > > optimizations could be done on top.
> > > >
> > > > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq=
8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf=
8
> > > > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq=
8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb14648=
0
> > > >
> > > > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounc=
e buffer")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > >
> > > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > > Tested-by: Xie Yongji <xieyongji@bytedance.com>
> >
> > Thanks.
> >
> > >
> > > Have tested it with qemu-storage-daemon [1]:
> > >
> > > $ qemu-storage-daemon \
> > >     --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=3Do=
n,wait=3Doff \
> > >     --monitor chardev=3Dcharmonitor \
> > >     --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,fi=
lename=3D/dev/nullb0,node-name=3Ddisk0
> > > \
> > >     --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,node-=
name=3Ddisk0,writable=3Don
> > >
> > > [1] https://github.com/bytedance/qemu/tree/vduse-umem
> >
> > Great, would you want to post them to the Qemu?
> >
>
> Looks like qemu-storage-daemon would not benefit from this feature
> which is designed for some hugepage users such as SPDK/DPDK.

Yes, but maybe for testing purposes like here?

Thanks

>
> Thanks,
> Yongji
>

