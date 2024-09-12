Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606212BAE3
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Sep 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105666; cv=none; b=Q5ziyIk9v+cXMMu7gB4RkTvjiz9ND4mwzrFgUXGAOs7w5+uJrzgGU6p4Sk3CgAj0MQm2lpFj2Yw6dEO9drjNZ5A0j9urQuZQr4Mw1MnoQKNOAmk2HD27XGhOqYfOdCv+b/+RA+6OhgRpdRDUMqImqIxKqM4SovgNEVlPmAo1KPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105666; c=relaxed/simple;
	bh=4kxuS1AIBSnin27g8FmmDst9UMdWeGBb4Oz2BIvY9Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0sfyxzCdpnhV92chFj2+6Xbh/bF9Yo1T3YT1ijjaAdgiUY1TWzRtMvzKxgGOa2IrP3KDa/8LvO7sQwD5A23hFV5DwhlbrdxW1dwEZJtl8+w8KirtkaVoh7drojIomxK0Bbn2JTsfF2eq0T2FdfQwC+Qfi4noQSdDJO8urEod3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWFWYkPw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWFWYkPw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF03C6074D
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Sep 2024 01:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbeKDgoMj2Z3 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Sep 2024 01:47:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2ACAB60736
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2ACAB60736
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LWFWYkPw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2ACAB60736
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Sep 2024 01:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726105661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kxuS1AIBSnin27g8FmmDst9UMdWeGBb4Oz2BIvY9Ag=;
	b=LWFWYkPwzDjbst+pCOd24kPxBzGGYi6k7c0BjmAvDzFKW1tyCr+voa6+AIqvyRUpMYQoYa
	5z2Zre8tBoY3jRg/0gTM9Ogzvs0Y6+JjyZFS0CEX36AI++OCE9/TjjCGJl/oddtCmDeKO8
	MaVaUI+bcCwf6Cfqo0OJBUmmEJSwA4g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-8tHECyKAMjuGzYZnYX_rng-1; Wed, 11 Sep 2024 21:47:39 -0400
X-MC-Unique: 8tHECyKAMjuGzYZnYX_rng-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d877d2ad3fso598624a91.2
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 18:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726105659; x=1726710459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kxuS1AIBSnin27g8FmmDst9UMdWeGBb4Oz2BIvY9Ag=;
        b=XwXjW4/sRe80PNxytnq40O79Lr9KANkvljxLLMRahvV7blPQT/1KBhuaBjJ6BLr1fK
         SV8m6Z5XsXt64WcyJZYKEdI89//p/azjawujzCrhOIw+LnwefJTcaU6e3YgxeTv38+KU
         D1qcgi5qMZI/VRvQw8rPY34k/S/o2iVEzhDlyXozM0YUAVKjVh1CTiAvmjseRxOa+FVc
         fR0hJy7xW/ac/vmwida7wxyDOmVilbuqRP+/7eJCPnZNDeo/r3wm2b9mK5H2vvtCeB2q
         UrDwVifncD1B+DheOrpvmNRUsNG9W0v6xSIbxN34ZR2/kaBg1/mANseMlysorOvUGA0T
         Pi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA82w3m8lRPdAnz6hrwHd6PTJbKuh17roSnOvQ8jbPZzwiS+hgpJDfM9frt1uHsyk+BTa5MYb1njNVX8rJgA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzM5+dQJ4DDPjpAEijqZY4DHvg1A63O5dhxcYAagaQ0V1MrTMiT
	osOaH5BsP/tTWPfmq1E8w0XCdi6OflC0OmX6hQCTmV8f5ZtXuV88qh7bgwIWVFSV2uwTpwxK1tQ
	8D1UOt0KUMCpE+uGYjZmYmnJVJqa4HKQ2umrD0JlKwekuhqAKhanP39EUll+zLD55d25fNh/Vxy
	QT8R+5lGosLJX3XK1Lu/YS4oXvoV/wvtOGReFW4NtiJEh79lI40hSvdA==
X-Received: by 2002:a17:90a:ce01:b0:2cf:fe5d:ea12 with SMTP id 98e67ed59e1d1-2db9ffb8564mr1569275a91.24.1726105658722;
        Wed, 11 Sep 2024 18:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxZKczFGfKFB53IOYqTjQPUNWxQs4r/wv0X/MYrSTF/VVDx6dP+mE0uScujlc+dYqOeR2GSx9/J6bta8HjgRw=
X-Received: by 2002:a17:90a:ce01:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2db9ffb8564mr1569247a91.24.1726105658261; Wed, 11 Sep 2024
 18:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
 <85fb3a90-fbf4-4925-8b53-197f3faa574d@oracle.com> <20240911150013-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240911150013-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Sep 2024 09:47:24 +0800
Message-ID: <CACGkMEsrpAXz-opeJMkPC7h-3H3POGppZk7_Ke+mO3nyG5y7iQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:02=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 11, 2024 at 11:20:30AM -0500, Mike Christie wrote:
> > If people are ok with something similar as in this patchset where
> > we have both vhost_tasks and kthreads, then I can send something.
>
>
> It would be better, as you say, to modify the vhost_task code so it can
> emulate the kthread behavior. However, given that apparently some users
> are unhappy, what you describe would be a good stopgap solution
> until we have that.
>
> The main difficulty seems to be to describe what the
> behaviour is, exactly, so userspace can make informed
> decisions on what to use.

Exactly.

Thanks

>
> --
> MST
>

