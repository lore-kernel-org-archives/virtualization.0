Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689C17DFEB
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458921; cv=none; b=uc/iy3HVZGlW63dTCqRzYafckvf8KAHbDsv1BlMN6zBto3V7HTuu6SSZB08VuGUniotezmisVjdkkx8BoI2imJ+ITv5B7YUtLf2t4QX2pwvhGKQMfN6SdhW2bzwPdJmGcGEpwLjiLlGmBmQ7+b5mRZNovojzs01+P81RzQ/u5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458921; c=relaxed/simple;
	bh=nAlwX7heCTnYT7gHHjut1Sm+B6Ti5/c/smSRa0DeyZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPORUGFJnJrToF0P+BCKssjDld7WzAwj31q33Kg0NeDYMDuNjDBADFln3aqmKiHfxtr2GbplKkPCCS011cKuLoGe573qVdSgWPCgsYMfriMtW5RM0rA07gBq8Kpuis3JC6e8tNI2Zo1kTVl4cnQk52u1rO2AsqBfLWtpZktCdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5Emdgee; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5Emdgee"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA00F40431
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XV8UDGFFQxuN for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 07:28:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EB0DB401AD
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB0DB401AD
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5Emdgee
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB0DB401AD
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728458917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAlwX7heCTnYT7gHHjut1Sm+B6Ti5/c/smSRa0DeyZQ=;
	b=H5Emdgeen/HGZ5HVMICP5Pku/gOrwT2RE2byUGIx93f1iP/yn6XYReE6oPIAZS2dmDAgAU
	LUR/MZEMmbUwmvnd0gyD4Gn0NH3t40POP1PJ9BTmvs33avlWyMGjhW1All95TW1FfbcYAx
	SBmlDSMVaC1Xo1/ek9z9MTpNOmQqjf0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-y5mQx6gzPmih6OItdm_FzA-1; Wed, 09 Oct 2024 03:28:31 -0400
X-MC-Unique: y5mQx6gzPmih6OItdm_FzA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e1cda109cfso5350607a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Oct 2024 00:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458910; x=1729063710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAlwX7heCTnYT7gHHjut1Sm+B6Ti5/c/smSRa0DeyZQ=;
        b=l6VFneRNB3LucohKn2BH6K2+zu03/vtmuLX1bI4ZSJ1y+JIQb1tOc1+rrWahOIVKnS
         L83qBWyEgTMrlMTG6cWqnMGFuAQlHHOfMY327E6fRbX5gjTZufO9REKLDo6RUeHVw5xS
         +U5FQI4srrl0UIpucuoaHQU3G84tjG+OtYIefyGYNntphMzxuffsNnK7FS5FYhCp2K/m
         BoTdXejLZHexGLor5UKKuJAfQlp/KfQ2VJIL3zBKin1Acb3EEfgVjhBZC/HKGC9BwTgv
         I+wexXaaNvu2gVi/W8Wva7sszcuA5KvRwAZAFSaVjZAad9uBgeYslOlOuE/we6slANFQ
         FZpw==
X-Forwarded-Encrypted: i=1; AJvYcCX91htgqzOlnP9y050eaadUWfF9dObuuWeZemnozZgHei8A6MeDePFDClq9JhAvHEXMEyph9l7h8hiqFvz4Eg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YztBgCX0fAks6wc2XFwKxML/VCmoD7mY+/hLx31vnN0ZB+E+knC
	QriAdPgONjBNPZwVJU1ecuv6nTkGfxbcYbSDRa+hvMy7RTgiO8e3NbB/4IJwhvHiZB/FdlxHQCT
	/DXkZh6AP7fkCTZi5pWMUO6uWiUqxpoI1vTiGT160fy4DoI7arx+pcbun4TWqL59P6YSlNbY7td
	RIMz5NqBNI6XU6Mz3f9GaeAtaJNVvnlsVjb2FugMSVmA3hnk7MOH3V5A==
X-Received: by 2002:a17:90a:6fe2:b0:2e2:8744:711 with SMTP id 98e67ed59e1d1-2e2a21d4d1amr2103322a91.3.1728458910412;
        Wed, 09 Oct 2024 00:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLz9tstmnsOxhFo9SgB4hJ8Yecxi8VvRl7k62LSd/ahWAaKz/BzKbB4YS/dO0BgAqKF6liAjeW1yMcJRWvEPo=
X-Received: by 2002:a17:90a:6fe2:b0:2e2:8744:711 with SMTP id
 98e67ed59e1d1-2e2a21d4d1amr2103302a91.3.1728458910005; Wed, 09 Oct 2024
 00:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
In-Reply-To: <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 15:28:19 +0800
Message-ID: <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 9:31=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> >The vhost is now using vhost_task and working as a child of the owner th=
read.
> >While this makes sense from containerization POV, some old userspace is
> >confused, as previously vhost not
>
> not what?
>
> > and so was allowed to steal cpu resources
> >from outside the container. So we add the kthread API support back
>
> Sorry, but it's not clear the reason.
>
> I understand that we want to provide a way to bring back the previous
> behavior when we had kthreads, but why do we want that?
> Do you have examples where the new mechanism is causing problems?
>

The main difference is whose (kthreadd or the owner) attributes
(namespace, affinities) would vhost thread inherit.

The owner's attributes tend to be different from kthreadd, so
management might be surprised for example, vhost might be created in
different namespaces or having different scheduling affinities.

Thanks

