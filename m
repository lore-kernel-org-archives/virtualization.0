Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF2149E1A
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689937; cv=none; b=Unf85zSi3QpX4aRv5I3qxUOCIG20bBbyPvmLYk3RwLHxYOp1ilpkysHDajRudBArQqramvk6LzRrcflkeTgkhtBNe5kScS++8D2u/krgfy3p6V114ZUvP11Ks5D9G6Q8OV+qMok4hKqPefMcp7Uv9U3J9uRxfwONvA6fvNqZdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689937; c=relaxed/simple;
	bh=RNmNT70ps+kx7slfSFuJ9G/H2xuAhJkWrfXMq+752EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ih8oNzklUKp599Vz4qM+mX1El9e/aUdHct9Q2B7MG2qmzdOrrbRXu4AGDOMRcvOKu7Qt0Mf03IMnPyDHinVlcoO7nf7oi9y1MmwTxP2m5mON/vurExxRHj+M/wD8tYkZfFax4uPL8hOeb9RKZ450QXkuAZmroO+gX626Y6Xl9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kg20+Lpv; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kg20+Lpv"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DCE440993
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 06:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aLbIa3EtNveS for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Nov 2024 06:45:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 585174098C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 585174098C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kg20+Lpv
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 585174098C
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732689933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/rI2EY7Ph6b3KZhYxy9/j/W0i2aqaLJSO/nDcTsMvA=;
	b=Kg20+LpvVR7ZZ/T2BQ2xaa9/rNRkfcO2ej3XoGvGzsPERVwXv7Mvtk0p9hBrUARt5wx/Bx
	PpA35R9/pJkVXu8RD9BH4rsBeQVBa3BHu4qmLJKbX4YkzhVwu9ci+3DChdkNEOQaP0pMc2
	SSc3Ka2SvuhiZiwnRY5cDVAee5B4JTY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-WGulXHftN0-hKsSa__-0cg-1; Wed, 27 Nov 2024 01:45:31 -0500
X-MC-Unique: WGulXHftN0-hKsSa__-0cg-1
X-Mimecast-MFC-AGG-ID: WGulXHftN0-hKsSa__-0cg
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa53f3b3256so224379066b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 26 Nov 2024 22:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689930; x=1733294730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/rI2EY7Ph6b3KZhYxy9/j/W0i2aqaLJSO/nDcTsMvA=;
        b=fD3LtQOtj5/7/Pb4b1U85wlArTjNaAMmUjudCQyBLk0MwGnkeu9HmYx9zMN6EP4cP7
         gC37JQBqo8TgrIahFQ5h8+28D6AUU3YyBTBnusCv38B1u4QHLfCyYmIHiWNvmOsx1P8K
         ZjSTo7Y5O/Yul8LqKXG6Ka4ygX4ZhUMs8cCLGaD+nX62qPdAZHUkxvyNYQ3R0LBYW235
         1LkeDKtFXRGY9CYBSj0bMKZ0yh8DOn36gZ+ebGZ468uZouz3yYHjSYeYc9Wtykcb56Sg
         KHgfaQc2ryqbyEpgZwQvlnMidv6Vr4GukMXwkEablTxoguBatSeyHIz4s62gfSPFKHmp
         0Zrw==
X-Forwarded-Encrypted: i=1; AJvYcCVEgRzgCNyUnt07kho65cEZBY8GxFThB+dmz2oBhMDkSKohsaFqqgIbpZMCEzjxBysDs4oKnP/e97ZJdQZWcw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyMa4OqTtK+LQlqKnEEZB1NGPJ52AgwKIByMz8n6mrl5pVfpq1U
	pxylgnWjztS289P5gutTqAWwq6wZ98LPkQ9eWHjv58f/lKW7l+darBt+W6W0emQAN5hQDBVsYBW
	WUQ8rU19ff3PoZoeJs7gSG5Zk9Fljfyl+2Mq+gnThYrTO40h2DSe3WvvWve4GB+J6o1I55sZDue
	CKTmkPih10X49ZkudjwztIY9K8BSX5pvgaB23EEYotvEtYxvQLdqsAGQ==
X-Gm-Gg: ASbGncsvcyiF8QP15oJ1o6lyCJoPrgkNWc/JqpKPg4Hm7RsylZbVvVda+wode0m1weO
	m8EV5EJwdo7JCyZpFEmh5TNgIj/27co8D
X-Received: by 2002:a17:906:1ba2:b0:aa5:2f8a:b952 with SMTP id a640c23a62f3a-aa58106613bmr111618266b.54.1732689930421;
        Tue, 26 Nov 2024 22:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUP0/KWUbb7Co3AncLRdOmYqmNvbV+nqgWBTGrmbeqC5ZOJ62cFI33uH+j5QLWBacrMzgyNp/kkRsf6zhWK3M=
X-Received: by 2002:a17:906:1ba2:b0:aa5:2f8a:b952 with SMTP id
 a640c23a62f3a-aa58106613bmr111616966b.54.1732689930058; Tue, 26 Nov 2024
 22:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-4-lulu@redhat.com>
 <c6975912-4205-4c75-976a-f68dd6dcaf1c@oracle.com>
In-Reply-To: <c6975912-4205-4c75-976a-f68dd6dcaf1c@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 27 Nov 2024 14:44:53 +0800
Message-ID: <CACLfguWGxNX1PgTCgH2NbBZoJhRSNnvVKzUzq2=cYY60+-kReQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vhost: Add the cgroup related function
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _g_9jebX4n4-hqm_JIk1hgczRNOkNpNz22BMOcVfvJg_1732689930
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:22=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/5/24 1:25 AM, Cindy Lu wrote:
> > +static int vhost_attach_cgroups(struct vhost_dev *dev)
> > +{
> > +     struct vhost_worker *worker;
> > +     unsigned long i;
> > +     int ret;
> > +
> > +     /*
> > +      * Free the default worker we created and cleanup workers userspa=
ce
> > +      * created but couldn't clean up (it forgot or crashed).
> > +      */
>
> I think this comment got added here by accident.
>
will remove this
Thanks
Cindy
> > +
> > +     xa_for_each(&dev->worker_xa, i, worker) {
> > +             ret =3D vhost_worker_cgroups_kthread(worker);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return ret;
> > +}
> > +
> >  /* Caller should have device mutex */
> >  bool vhost_dev_has_owner(struct vhost_dev *dev)
> >  {
>

