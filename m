Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A737B025
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195626; cv=none; b=BPs20sOtoB2qqcumAZMtg/7fu5XOOQha0n8NFxRvyOK/mD8kcjkRdDkH8LO+Z5s9vWiOsUNSfB2Wq+HUrEEk8Wj4X63hvaOcUjpI/W9xLyRQf4MrkhirF3MXZqpH6+fp6mpNLrlYr6dGv9oTYn7QN3aSTQUPMYhnBMjon1qPk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195626; c=relaxed/simple;
	bh=dfpwAV9xHNszFGQtcNEfMMhthwAAcXyQFXxKaZgnC8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhAqkOM9oq/LvEdz4LULuTaC6pKuh5cTD7gMp7a2d+ENQorh/qyKtlJUwEZN7lKfNHHEHpKNy/1KPEBvUIiPMCnvjMgR4ZipxCg606FH917I+UjaStehNYg7ZoZJvEvYsq1RIrrxk2v8Uw7idNlxAejp7axTRS0XO79e+x/cI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OgWS9YWj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgWS9YWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781195624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfpwAV9xHNszFGQtcNEfMMhthwAAcXyQFXxKaZgnC8w=;
	b=OgWS9YWjq1z+kBvdxAf4AEt8dSDyUxYCtfLsh4JP72mVxn1j5+ivrv7Ar/ARI8tqYzNvO6
	cWNR0nf5ostc9YDKEglAHFtlmvuG9Ud2/ugeRJ6IoJEelv5sOQ1CmprHfHwLhUPQ1OYTbd
	ryuPYL7JSxw7pTWLWY/ZPu0TewFPqLo=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-fEK3KIWPNyiISJYDLYJlTA-1; Thu, 11 Jun 2026 12:33:42 -0400
X-MC-Unique: fEK3KIWPNyiISJYDLYJlTA-1
X-Mimecast-MFC-AGG-ID: fEK3KIWPNyiISJYDLYJlTA_1781195622
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-660e9ff05c1so38146d50.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195622; x=1781800422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfpwAV9xHNszFGQtcNEfMMhthwAAcXyQFXxKaZgnC8w=;
        b=NGhDUVYOty6+tdo+MzMQOoJl9MwqMySgJkOBxiCf438UOL7qa4QLCcTIfRSM6F+vO9
         ya4RSjavLGjZaaSx167dk/G3svGJ8uaZa1FYZU0krVbwJ7S9oeiJOV2VOZTfXmuAFs2C
         xkvKvJJO5p3I7FTsyFwd5z0Tku9pFC36dURpeiup8Ha8utbU02Sewp2lNOZs6YYoOOB0
         urkb1cZlA/NEotPxlQO7ASgPz1hLbfn7NfmEd42fyz0DMajtz6XPBIzF/2OwTQqBbdZ6
         iJQhYd504dH4T18ZgdczdoCE17AND4oRfj4Rp75J78g7vpIcoofEF3ixMWIjuZLouZ54
         SZ/g==
X-Forwarded-Encrypted: i=1; AFNElJ+gLx9PF6Y2NKtmD2UzXHRmLEZL9uypppyqm7521E3bbjd02qpz5u7eakHbuliITVeOJ219iMO3hX0Zqygt9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxDWrcfjz9qwb9RrW95JrCoRua7sM6k1nJlJzgBhjG7TBxcpB/
	bq8Kwqs4PSvvbnORRczpGcxPanCWafuAYJ1y+UtAfInSjFbb5EhguL2q5WC4hXIwTLfsKATZ1Du
	Dhh2T4Cge1BmiI9iDVqRiJ0q8xNbB6Xhxx/vjeLKGxdht9V8gu0jrEgeJTbvQmSdWBCSpfMZXhV
	E4UjzzPxpJFoo3fmSvT9iXGZITcMn1ZrxjCut/1kPc2NQ=
X-Gm-Gg: Acq92OEbxPVAa8W0g7F3HKyKBQkrl7gmz6nBpTyVX0t6Cjgr0j9ECMpAEXywCBq3NgV
	kB/9KmGiztljfGK7IJw5yGkNMPGPlYxrWBib4IeaDTVzRBNTJViuIAwOMDC+kyCTmVkOXW8RLQQ
	22n0DaOnVoHKeXCivJ8MEcMQdbF52Bu6XNYCtSCoWnCqnTC4O4C1CJ3p6TuU0iRAb7MR6895CHH
	D+HFQ==
X-Received: by 2002:a05:690e:1385:b0:660:3b18:57ea with SMTP id 956f58d0204a3-66269610771mr3141138d50.1.1781195622118;
        Thu, 11 Jun 2026 09:33:42 -0700 (PDT)
X-Received: by 2002:a05:690e:1385:b0:660:3b18:57ea with SMTP id
 956f58d0204a3-66269610771mr3141093d50.1.1781195621592; Thu, 11 Jun 2026
 09:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260611133806.198402-1-eperezma@redhat.com> <20260611105251-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611105251-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 11 Jun 2026 18:33:04 +0200
X-Gm-Features: AVVi8CfVjI1aVbTclqihthQAdaiq-zHkPmnTN62lTOtUTKKEZ5gi_HwgIw_ME_4
Message-ID: <CAJaqyWco2y2Ebnq5kDW4ZobOD6y_=d+6JjfLEA=snsL0fuMfmA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix lock errors in VDUSE suspend feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xTyyckGnwwZ-TOFLXrrcGomgWAso3zxG7pruDjT0-nk_1781195622
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 4:53=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 11, 2026 at 03:38:04PM +0200, Eugenio P=C3=A9rez wrote:
> > Fix wrong ordering at taking semaphore after spinlock and convert the s=
pinlock
> > take and release into guards, so they are not lost after a return.
> >
> > This series goes on top of https://lore.kernel.org/lkml/20260610083452.=
477759-1-eperezma@redhat.com/
> > ---
> > It would be great if these can be squashed.
>
> ok i figured out the confusion. squashed
>

Yes, you're right; this is on top of Nathan's. Thanks for both merging
and figuring it out!

