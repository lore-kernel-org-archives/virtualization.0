Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90282638B2
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098924; cv=none; b=LapN3RNhPKYQl75VjZ97cr7uQQIx8Sl/dC7hiFVy5sO0J3ozUP2udsPT5fTG4E+AnVlxLZqb1qJj2GV37euONYgOwSFPDsSKX8mAwFEj69jwHe/lW71pq2xDgSX7NR9f3CRXLZJbewZW+baYXEG8ZA+lu1QI7fhK9Nx2sI8Wc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098924; c=relaxed/simple;
	bh=A8OsWXAueBE0PuEQC4ic4IQiibJGAlkVcpHSS3VZ8iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJuO37MA3DArNgId+4DQcj0J9mQVGe6J+R7wTCAz+M++e8Mc+wJkvEuIz2+ddJD+HdkiSvchTkOoeF8LBEDA/UojxMX01qisGLrkC2ByC9rSk6+Ac9tbag3rjBghWiF5nNVDBn9dywoyvV3pXHER4xh/AaLXu8+MdPtQOH9UoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0rQnJuF; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0rQnJuF"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6343E80FA0
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 07:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aFIQUk88zgw5 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Apr 2025 07:55:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AA8A28107C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA8A28107C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0rQnJuF
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA8A28107C
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744098919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x79QHpIfsA+l7691cd5z+VO+/jgiyth1028qKXbzGKk=;
	b=Z0rQnJuFphvtXmoGngJgvbsRcLH90ZkUew5biWjqFf5XXxpKLyba3UsM+ufRLgWotF7q6r
	DgbMqCqwqeLOv7r3WBFfQTuAQ/Y5Gw6HhRfRskIaONWeqyRfMSvjU7/SUYuzLijj2ALg1q
	7pY55fap6OlgXXftmY4gTsDV9ju0aC8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-hcaYpUX5MViR50PMTKvgeQ-1; Tue, 08 Apr 2025 03:55:18 -0400
X-MC-Unique: hcaYpUX5MViR50PMTKvgeQ-1
X-Mimecast-MFC-AGG-ID: hcaYpUX5MViR50PMTKvgeQ_1744098917
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac25852291cso521242366b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 08 Apr 2025 00:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098917; x=1744703717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x79QHpIfsA+l7691cd5z+VO+/jgiyth1028qKXbzGKk=;
        b=nQJNjkcbdPAcbu68UqY72tDd2rcWhSCSxg5nJcjHaceOGf196eMa2oY58JmLzZOHEK
         gwlhHY73t5ypWS7uTOFkpNWKHNe7MF5I6j1tF3WZ++23YTuCNENquFFuRCb/d4klqZ4u
         QHrijfAakIYerFtnK2jFSWsv9VDArqojbGszmBIMKOIP/4gI0Xz5C0llDzAPeUXDTSnp
         JNbXwdhc1eaujfrFFVSuUg1hUSq+xhNQS+kYPUkiUf9sX9L+hDhRx86Ppuyxu8SOaMIb
         8bZF5n+He2ol8bUSPOxIN6rat15zfyB0tO4p+vEfccdu8XnVj/sqqhcwVw/YSHnYZR4/
         p+qg==
X-Forwarded-Encrypted: i=1; AJvYcCVbzmvw1nWB361zlmtnuPYBb+zUtv4WBVR4xxc3jUIplcLNufUCq/NFdw0CUZ98OYbAOWByCfSL0cYZYPk2LA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwGdTL+vSEoTMpweYGbkOCBrwqbJWdAIc7BSIb9TXKYc8y+IRNZ
	7DvZzJQNFcJzaxuvqdpvkCAQFeBpyWgGbfY/AQzqMC6uMCbZtdtf959EzMIQn+kD8vPwL3+NAYh
	UmNEW0GmQwreGfFS/Z6EtVqXqPEd5hjV0HF9JTi7g5VXXbE/icGHlmjlCnrlKglSaw9G1v0lJsp
	uPh/Ki3vOrwDBxCjz7OTkIK49xXpfV9JQ8aUAqXWSsaPOJ7m5RvgRWiA==
X-Gm-Gg: ASbGncv6MILkL21iFIMiNhNpUqmBYB8Ln/eqq85FEQct7e4I4t/j5zVClHoON8x0/47
	AK59wCRhiLd6fIKLc50rZfWDHv0j9G7b+J5tqYSxRupD2J8K+BiL0FnjW4zVgJrTyQrsx4YVR8w
	==
X-Received: by 2002:a17:907:970b:b0:ac6:edd3:e466 with SMTP id a640c23a62f3a-ac7d6d03dc7mr1243224666b.19.1744098916911;
        Tue, 08 Apr 2025 00:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsrjWeGBerTieJ+ttyB1gK4msQNk0ahMdt0piWop09SNP4zpG8Otx87xRRHmyaRFy0Bq4LVDJzBGSQoM5E+Po=
X-Received: by 2002:a17:907:970b:b0:ac6:edd3:e466 with SMTP id
 a640c23a62f3a-ac7d6d03dc7mr1243221566b.19.1744098916535; Tue, 08 Apr 2025
 00:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-6-lulu@redhat.com>
 <8c87752e-bffe-4cc0-b838-cb6486b6261d@oracle.com>
In-Reply-To: <8c87752e-bffe-4cc0-b838-cb6486b6261d@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 8 Apr 2025 15:54:39 +0800
X-Gm-Features: ATxdqUFbbN4Q5UKXqEkcU4pBHlwr8BYd3yOQUAtnTFpNUfmJCvAF1MhDr_dM47Y
Message-ID: <CACLfguWQD5yMBOQLhMh1rt5FoqdfJtmBiHaC3y9g7p1f5q9zRw@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] vhost: Reintroduce kthread mode support in vhost
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wi3yS2-p6P-IAuDicuFLrK1X_HaNdnO-AEWM7BChuuo_1744098917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:04=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 3/28/25 5:02 AM, Cindy Lu wrote:
> > +static int vhost_kthread_worker_create(struct vhost_worker *worker,
> > +                                    struct vhost_dev *dev, const char =
*name)
> > +{
> > +     struct task_struct *task;
> > +     u32 id;
> > +     int ret;
> > +
> > +     task =3D kthread_create(vhost_run_work_kthread_list, worker, "%s"=
, name);
> > +     if (IS_ERR(task))
> > +             return PTR_ERR(task);
> > +
> > +     worker->kthread_task =3D task;
> > +     wake_up_process(task);
> > +     ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_=
KERNEL);
> > +     if (ret < 0)
> > +             goto stop_worker;
> > +
> > +     ret =3D vhost_attach_task_to_cgroups(worker);
> > +     if (ret)
>
> If you go to stop_worker here, it will leave the worker in the xa above. =
I
> think you need another goto to unwind that.
>
sure, will fix this
Thanks
Cindy
> > +             goto stop_worker;
> > +
> > +     worker->id =3D id;
> > +     return 0;
> > +
> > +stop_worker:
> > +     vhost_kthread_do_stop(worker);
> > +     return ret;
> > +}
> > +
>

