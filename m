Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75372E8DF0
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145317; cv=none; b=PfinpaCPJM+gBvDC3bIccZggsItXezGva0TfQho9Sz8Cl6VVzfaPU1pA80sdkpPQb46FPm2qilgq9EO7Z/jQPw/aHJGxwP0P9Qce35d0u5Ehu1B+x4N3GxpDVwBpDm/EEJA7M2nZNyTUm+uBdW2QVU6zg/6tm3io/FPL/KMdkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145317; c=relaxed/simple;
	bh=xhjsvfXdO5SYlYsKGWf6Nq4OBRuCClBU0c1pcHzd/y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i23B2I+z8YYu36D50ySEpBQaY49BNc9Tt1rPaFJnZpPDZ7ce/DbYbGtHWpHXPf2X2xRN6gdlSrF7rZqRfK8tWkYKUM6GiWUnMbBDOuyuImuxNS0vPxrVMQLtspMhrmhdyPdi/0bj9NEobHCH/wJBPSMuyqHFN8vYk3vz5c2UvtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Epy5bwrn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Epy5bwrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759145314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Wwy06Ljl0BBCyv2VUlnRxmOVniJjHrri4cTVWPbGTI=;
	b=Epy5bwrn7Z3tT7nOIc2ogF8vYMJl5RNiuqTt+Cb0zFY7dlObZWzlxsTsPCi297c8T9kgd3
	5qrf2FzBoK1CERkI8QHrVZ3H+GbWt8rdlVeTWkNStg1ZOApgM+tSMs0fw1qbl8Cgk1Z3tq
	bHQ9s/hNpwAvw14W6/pUM6Iy2D/B6w4=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-xQkeoBpLOSes9gcLubQ1zw-1; Mon, 29 Sep 2025 07:28:33 -0400
X-MC-Unique: xQkeoBpLOSes9gcLubQ1zw-1
X-Mimecast-MFC-AGG-ID: xQkeoBpLOSes9gcLubQ1zw_1759145313
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63541ee6187so5424899d50.2
        for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 04:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145313; x=1759750113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wwy06Ljl0BBCyv2VUlnRxmOVniJjHrri4cTVWPbGTI=;
        b=RCLUaZGGDBmCRaCLrNnKN1KL+JZpfCFsWzGXubki1vTsSQ0upl3PWHbtQzm5vHQCBw
         tKUqdE15tBdZShv2dU8rleFSxCmQBpO37/w0SEC+NzIwBhHaYtDs+eb6GUQFCg8P++ZT
         c+NsjIMAgerK9EnG/7TIQS5kZtLSE4qFbOqMbiewb7xNLIuKdJGFnO2VfbJHmnr0i+RX
         g0/eWAAIL6H8do6y8ol0BXZM3P/5LpiGOmD+ZG3eB5igLTxmcWe+L8wDES9jaL5ag9ml
         Gv3FFvV34wn8nrM+WBD2VM6CF0T/Uv3fJR4lap4Vb5Da0qFaKEMDkwafJBr0dUiax4fP
         OEwA==
X-Forwarded-Encrypted: i=1; AJvYcCVntPrqIM7mF9B/LYiH2oOqn09nTqhDTo5uIEkuYmdKTJOvr6M8wN5CrMjgX/PTol8GJ5/difGDcMT+slkCbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylCkoZDhqRcH0w6j/1BpPeA9nrGiXcN9KJUWO9hinnQxv81p0U
	zUldGU6IjyGTIffvOOtgXB45l3g47OXEejIXx4b5ewyejs8TjZeWWpaX5mWGzQus0C+7ma/gCdl
	xT/WCZ5GOIHJQn+/dkRkvGu7Q6QP6uwEMF5nggggS5Wfz1Z4puf2SSxooOPpVYFXu5s096bGdus
	EiwqAVew7DpLqHvOOp19Cg4aWmxZ/8wu3azX+KVJVfRl8=
X-Gm-Gg: ASbGnctn5Yf67NHznBEMWuBbYmANZo5grGQZ5wIeY10htjAcKFXW3wppvGFM76mnNYA
	QBgSo0aHRiEkAucURz7Xj7QKUAVn5kvjHonb8YAJBO0UpWQdbqjvug91ZbD1QdIpVv6/coDPMEO
	8Tjq6K1SOtVMX6/LAD4iDdi4Ss/TGUEQ3ZMp8MBlIKdcRqJupOPUpJMHZvwRBrspQaFVNU2pUTJ
	H4QYgR/
X-Received: by 2002:a05:690e:40e:b0:629:7a71:ff8 with SMTP id 956f58d0204a3-6361a820fe9mr14186961d50.28.1759145312796;
        Mon, 29 Sep 2025 04:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuDBuJWNZwxfGsSc2MO0wrCuwt2NOJAY/Zy9NzygM8/lNwEH7TCf+dALzc0a5g/oX6DhafT7R1g1/FWE6Wkl0=
X-Received: by 2002:a05:690e:40e:b0:629:7a71:ff8 with SMTP id
 956f58d0204a3-6361a820fe9mr14186944d50.28.1759145312427; Mon, 29 Sep 2025
 04:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-6-eperezma@redhat.com>
 <20250927155955-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250927155955-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 13:27:55 +0200
X-Gm-Features: AS18NWCwOJPe6fL3S805w9mrXhyY5mwgA7fITy-Y21RYdWPFm4ggqzIO6QhSP4M
Message-ID: <CAJaqyWcSR2cc3Mwsm46SQr2uqf4y6tqiLA3HCq30ESqVdCr0Fg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] vduse: add vq group asid support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cIpj9Kw9NXAd9jLWm9JfzxuPRKw2K7UHtOLLO9avlZk_1759145313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 10:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Sep 26, 2025 at 12:14:31PM +0200, Eugenio P=C3=A9rez wrote:
> > @@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
> >       __u16 last_used_idx;
> >  };
> >
> > +/**
> > + * struct vduse_vq_group - virtqueue group
>
> comment does not match struct name.
>

Fixing in v6!

