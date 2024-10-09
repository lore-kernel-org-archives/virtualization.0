Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A000183CA7
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462023; cv=none; b=MMHlqbBD+BxegdPZ94i8OEVpRnD9mOuYXR3ipTF2ypR1GRob5MSAVZHaOP5/rZICeIbi9Bmq/ea2+QvRdaHq6eIbla2DE6Z1LF8QhdaA4g9K2bpijCSU4fOEyE+OUYi1iOFACpaLYyNWb6NWPw/z3xBiWt8MN8jsQvM8/K7GbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462023; c=relaxed/simple;
	bh=D8VSyWdM4/Dw5SrlkwgbxBP3gu8g2wjdc1qGVUjDVg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRb6BJy5OaNkXzO7RP/YUnx/vvyFVe7tSv+1NRb3pwEyJXqCN+mf3DGhoWMovtFzCCDaCeOKEdtAgpSWBNrYjdLtoeOuWXgr1cYSL9yWGelXRIvpFkCeSZVEZFyMapCP64QbYFJpFYr4k/iEySgHOGEdOY385wIyCuo+lpKlsMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdeBX21Q; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdeBX21Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB48A60671
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 08:20:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzCsGZnfKoP1 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 08:20:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D75BA60645
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D75BA60645
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NdeBX21Q
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D75BA60645
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8VSyWdM4/Dw5SrlkwgbxBP3gu8g2wjdc1qGVUjDVg4=;
	b=NdeBX21QUaiS+eTnX58aDVnl1pp+a6kbkZypQL0WBeAzT8QnLgVFBS47FOXPgaSbbq1Fia
	2UYe0qXpFww1WmyAHgKkYz9h+iRaWAPzzBpgJpYKVBtbTjP5lxWerPk3EOiDVA8S3N1pXX
	5fyJANyGUQq455G76AJLOhSpPqVlMEU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-RHqjG9NLPXeCE36VGFf3Yw-1; Wed, 09 Oct 2024 04:20:18 -0400
X-MC-Unique: RHqjG9NLPXeCE36VGFf3Yw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2a047d06fso612364a91.3
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Oct 2024 01:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462017; x=1729066817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8VSyWdM4/Dw5SrlkwgbxBP3gu8g2wjdc1qGVUjDVg4=;
        b=j6RU2Hb5f8rEPZ7sWckREt2QWFy4CQnRPjeqB/NxfURlo/AykSdlQJ4W9tgl8dm+Kz
         i1BJd+0BeWDf2ySQ0kzv1r7N3gOmSQ/k5IN2fHvMQzyi8kLOAlanQJ73t0Y3JJ48dhEv
         fN3v6CtvD67RT8tLDtHlllsZ1v1h7tIH5KFlsUo1ZBsueIAP/Zev5joTTPoQ7Vfx5Qj1
         1ITcOtYj7lLB3YvmTsLi15u1u1sN1/laEQmY5kHcTU1d7kRVgbY/aTsVIE35LTB7Dk6i
         gHvT6v1gOiM5u2ytI2Y13WuJlsRYFyR00Ubr+n/jA9v2LNOay9QMHwvYHInLTn+oz6sk
         wmEg==
X-Forwarded-Encrypted: i=1; AJvYcCWb6yZxrL/HVGKWVqkmZpx/KecpONMMnt9KVeyLJ6PFIclDIfKYhnQmy0mLMDG2tibV6bh9QvGmIFlufmw8FA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzxqpi+CwvZPgn0SMOWOM9DyvARcFDRerW4nhgM+m4jEjUFzddz
	Kby5RR7D9X14NCfjodWmcAR5dDQJji1OdKPS6M84Eeb5xBg3GOAG1S1856SpotcRaFkZmTsFiAq
	aVT0oA1OVFt4Ui3Kd8zHejGC81kA6EU6nAnE+8NkE5HSZW3EbwA6uUcf9hPTkLF5zwMAS/5KInZ
	KYilw+ixUSqNDXNupdQ7u/MyULPaOpqIJMy39N4wkbv0y0kA9U3oc1MA==
X-Received: by 2002:a17:90a:fd82:b0:2e2:a982:e21f with SMTP id 98e67ed59e1d1-2e2a982e2abmr1519523a91.10.1728462017102;
        Wed, 09 Oct 2024 01:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzq3XMDK7buMc+YqoW+DuJ828CjCMqzlXqHQN3V0on7iADibxhf+AHHqExyIIAlXBvqsSOSMz/rLhD+CHGIgs=
X-Received: by 2002:a17:90a:fd82:b0:2e2:a982:e21f with SMTP id
 98e67ed59e1d1-2e2a982e2abmr1519505a91.10.1728462016722; Wed, 09 Oct 2024
 01:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
 <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com> <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv>
In-Reply-To: <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:20:05 +0800
Message-ID: <CACGkMEv+qfmuEnjjgbZc2nSKCN0TbwJvu6D1CiYV_zHw7QR46g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:10=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Wed, Oct 09, 2024 at 03:28:19PM GMT, Jason Wang wrote:
> >On Mon, Oct 7, 2024 at 9:31=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> >> >The vhost is now using vhost_task and working as a child of the owner=
 thread.
> >> >While this makes sense from containerization POV, some old userspace =
is
> >> >confused, as previously vhost not
> >>
> >> not what?
> >>
> >> > and so was allowed to steal cpu resources
> >> >from outside the container. So we add the kthread API support back
> >>
> >> Sorry, but it's not clear the reason.
> >>
> >> I understand that we want to provide a way to bring back the previous
> >> behavior when we had kthreads, but why do we want that?
> >> Do you have examples where the new mechanism is causing problems?
> >>
> >
> >The main difference is whose (kthreadd or the owner) attributes
> >(namespace, affinities) would vhost thread inherit.
> >
> >The owner's attributes tend to be different from kthreadd, so
> >management might be surprised for example, vhost might be created in
> >different namespaces or having different scheduling affinities.
>
> Okay, so this requires some API to allow the managment to understand how
> the device vhost will be created.
>
> But why do we need to restore the old behavior with a kthread where the
> resource accounting is completely disconnected from userspace?
> For the old managments that don't expect this?

Yes, as such change can be easily noticed by the user space that
breaks existing management layers or tools.

>
> BTW I would suggest adding all this information in this commit, in the
> parameter/IOCTL documentation, and in the cover letter because IMHO it
> is very important.

I've asked this in the past. Cindy, please make sure such information
were included in the next version in the cover letter.

Thanks

>
> Thanks,
> Stefano
>

