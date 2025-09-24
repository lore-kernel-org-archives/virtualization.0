Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534D25A34F
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701331; cv=none; b=hGKwnl17ezAmzE+ePc0ggKzYp2ye5QQtkVj4USgiKxxeBFZGQ7p7txV+EJLAReotpj7kI3R2OzzSWfgtl5932/eobWoR7Yt9Y3CBFh8+UJapDPk+NXFFV8WcInXn70LHtd5RSXkRCf+welUKYldvokCBfGeX2Uz2+J6sywDgnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701331; c=relaxed/simple;
	bh=a6oCuIAb870BUM/wLcCKideEO8jeeHZlteSZfzewe0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4fGr6hY7rEN1VEaN86PKyp0Fu5GJmwc/M1f3BW7F/xIX0ooKBGW57aVu74NaQLtD3TEOXlGFmYhkdgxW5FQz7nM5rJxmWSf8BorBXcXr9ssIfenfm+NyzDzDkLrdmAs28YE035cDaX99s0Ou0MEuCykuRAXLDG/AC/Y5HZgmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDOVuFnO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDOVuFnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6oCuIAb870BUM/wLcCKideEO8jeeHZlteSZfzewe0o=;
	b=CDOVuFnOCZtdEaflcZ0gXCyYCUu1cyYpIH55MRnBun8Ms6MJshF7RSguhqUxOgh8Rr5dYI
	wBcn5pqYHTyGyefpYjmDPidJGiavSmyJTTecLTF6cPSt279BJ4NEkwnt0KxNn7FuTy7A2D
	mzuoX/9146wLUa6dNJsrTgyGnmF6Kqg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-lgdVkAqYNxq7LRJe1nI6MQ-1; Wed, 24 Sep 2025 04:08:47 -0400
X-MC-Unique: lgdVkAqYNxq7LRJe1nI6MQ-1
X-Mimecast-MFC-AGG-ID: lgdVkAqYNxq7LRJe1nI6MQ_1758701326
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so10367599a91.1
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 01:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701326; x=1759306126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6oCuIAb870BUM/wLcCKideEO8jeeHZlteSZfzewe0o=;
        b=SyRiVXi+xlQIAFgKvt1j/0x2IufHGgmTCCftzJSTcJjqbd1TBVqBoOkpWFvJFvG5Hg
         K830jZtjwOI1ozuv8Aqh2ojpp9goMn/xQ60Yvuyw+nVDwE7zpvAYVRLfR4Y6MC7wQOo2
         Sk5B/7/zfHIPZ+HmH6JsLPfD33UTuQWmJzmfharq0RDejfwt51/DL/mXACS86uWAis25
         6JReGh5uFSe6dBUlIxwg54+xKHfnwHFnwPOSeiS6yQNiNPlOybhjZ0e42PsiAm4ao2Ka
         ecArhhDoKp32hOfZhcsnJsmJ8OmDAmZInMaw5RFq0cgGWSveM+ABfDFvstDT6/PoPBK3
         SbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN/ntPWH1XZZDaxpWWpCO9K8s1CQ+omgajm6JkUQPB79bFCV+5G8AeiXTnpWl+DNmRM9KIrsbl+JNNUI/gqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt2yPHTBtNgiXM0EQsvmcTCoRMwAwmQO/FHEktimIr7yiKyyrV
	E24c+SCcjdRn6ml94WrVwEEAD+piXu9Quf2kX06Kvlkn7fv7pegLxSKAdM2H5gQT+7UEKEbfAur
	/Kj0kxdvaddEHLZDUZWPvBtniGSXpMHOUWAqidD0wD9o8IqrwkjalyEfjLhakas0tHhqwk+RSri
	6f41N2Or9lXTBNb44x1FKuuJ+TzFV7GRqYvz5N8t/8Hnw=
X-Gm-Gg: ASbGncvC/M9XuSa9g5omQLX/Zb68wFJ2zBFNMdPIMYAu6QUY0i0iQQM18odmPBBjGf9
	V5Yf5FV2EVZ51qbuSxq4LoWbJTLdK1swmHKbDC9ctD5oIEp6JFqz322HtdOnDqUqE8oZzef9UaU
	MXqDCRYuZh0SNeSvqK1g==
X-Received: by 2002:a17:90b:4fca:b0:32e:381f:880d with SMTP id 98e67ed59e1d1-332a951400bmr6699305a91.8.1758701326151;
        Wed, 24 Sep 2025 01:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2GLbIR2MSlOxRK5RL4gOPgfnLpfnRkVHAyb6+Hg393gRc4iItMUlqLDitFzlb4iawxNuY2oPPUXbPSwFGVqA=
X-Received: by 2002:a17:90b:4fca:b0:32e:381f:880d with SMTP id
 98e67ed59e1d1-332a951400bmr6699276a91.8.1758701325715; Wed, 24 Sep 2025
 01:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org> <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
 <20250924034112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924034112-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 16:08:33 +0800
X-Gm-Features: AS18NWA6IoDbRnFJrQROlwKl7JtPi3QrLkppEKjQdynw71Swtwg92BSiXVWInSg
Message-ID: <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: knMSnUnC_AMFOQkXMGFM67niOt4yzFR8QAZwe1nU4bM_1758701326
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> > On Wed, Sep 24, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > > This patch series deals with TUN, TAP and vhost_net which drop inco=
ming
> > > > SKBs whenever their internal ptr_ring buffer is full. Instead, with=
 this
> > > > patch series, the associated netdev queue is stopped before this ha=
ppens.
> > > > This allows the connected qdisc to function correctly as reported b=
y [1]
> > > > and improves application-layer performance, see our paper [2]. Mean=
while
> > > > the theoretical performance differs only slightly:
> > >
> > >
> > > About this whole approach.
> > > What if userspace is not consuming packets?
> > > Won't the watchdog warnings appear?
> > > Is it safe to allow userspace to block a tx queue
> > > indefinitely?
> >
> > I think it's safe as it's a userspace device, there's no way to
> > guarantee the userspace can process the packet in time (so no watchdog
> > for TUN).
> >
> > Thanks
>
> Hmm. Anyway, I guess if we ever want to enable timeout for tun,
> we can worry about it then.

The problem is that the skb is freed until userspace calls recvmsg(),
so it would be tricky to implement a watchdog. (Or if we can do, we
can do BQL as well).

> Does not need to block this patchset.

Yes.

Thanks

>
> > >
> > > --
> > > MST
> > >
>

