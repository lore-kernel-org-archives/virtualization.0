Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D41A23B1
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147740; cv=none; b=gO/+nXtSSzCgX8tYTr9bjxTfQrMNUW9rqhr2vQ1H9kITYpNV3nnEPkPd/loMam2CEiX0i73qyOLimjcyS1byo8nskTS1vweksi6Fam/5uKdsTc5yYULzAEnXBOlKv8KEtIMVDlZBpbZZx8hEDoUpBOxtk8Uisyh6wQaEqVmnJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147740; c=relaxed/simple;
	bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB/IBK1KBpz3lR/yRa0Vwvuz2y55o6mFt9GBG7m+AVUue5XG0mn5Z83P5q1cEp6y5B4czXIzVtuqbU8qcwzd3vOoE6lAsqWucCEyKLw3XzZY26J4xjAaBu129kozxZtiv0e9XH8nA9391S9OFFgFbNe2kKa8SOZFKB93Saclsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+DZLSE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+DZLSE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741147736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
	b=I+DZLSE4RfdcBrChFqiV4COIQTCnFVvR6GW8D4sC9QnUZcBUQ1HX1qCFxCcM5PhdYVCOXg
	F/cJRclG9ex273VDLJzjVH++mJpNR+jcKH0p84T9oaYVY554qjAZPWA0/L1HWYZgWcfcBt
	VqTLW+gupZm43qmE+qzKAz0HALeHcws=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-OIqibvlbO8-DqrpfPG_EHA-1; Tue, 04 Mar 2025 23:08:55 -0500
X-MC-Unique: OIqibvlbO8-DqrpfPG_EHA-1
X-Mimecast-MFC-AGG-ID: OIqibvlbO8-DqrpfPG_EHA_1741147714
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fed5debb85so7150062a91.2
        for <virtualization@lists.linux.dev>; Tue, 04 Mar 2025 20:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741147714; x=1741752514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl3kF2jIRgykOyy13qNEYv7/mlV05yVeWOFjVH+qAtU=;
        b=lqmBIqK6I3oIzbeALPUPvLBaSF9qRDJ2WMs82+qsFHyyhNfQMZaj6/aJjIJqThPxwa
         F4iMGH6Qag3TWEZYW4lI1a2wOe6BmFAU5k1AzDM57R6oU5ytO34cLT6x2C2z/TnZMdlm
         QaoWObFd1ReE/RxMJ5Mphe/VkH2ZJHpcLI4yIwkypGOgk+n6pCJnRNVN1YrK7U+rW5+v
         ug53Q6J8OZLg2i9Ev2x7jpkCFxj4B2jCWuN0jVPoBuO1HI1TfgDuoT/WMY/WZqac7pP6
         SR7emohFtGmEAZHRw6zU1+IlxlGu1O8Xr8CPZoiFSfVemQlssEXqFpoOqCxHAq9qn115
         KgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGN6MzNN4E8c6DHyVjT2BU8BBaaOqDjj4lNP0YBPUArlb26ky1oAQyMkjeBcEeBXQxZR4LUZijN4e6whIW1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+yZSBU15ZkuUmaV4SV+nk31BVNugYBnS00Fs5V3ayu4wt+j+0
	NjlJ7BQ+GYOjsyOSLQ5gy/rlcPyd1VQUxFXXypIeM855VeO7VPVnPtaqv2NrWSUzuJHgY1saDrr
	YcUtlfONcp7CcOMq76FxYzr0Dbp7X8nL5qBTJOvoypKdjKEjivP2F3kRc7UrBBqKqKX3X5SClDR
	MzkxytDCeTSKVkodYvMgZin1Vfb8nXpUMy3vXTLzU=
X-Gm-Gg: ASbGncuN1xsYRDphLORB52jU9yjboHEKrJndmyNf/8GT3BBCSpvPynQXHlPyjTLjUNz
	mGSJCGJYsmG6c1otSkMUCK+6RNXxgJJBlE6NXjXW4lhoI3zzMooUaIYcc4OKjSA6KD13f9lJv8Q
	==
X-Received: by 2002:a17:90b:38c7:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2ff497a94d1mr3253883a91.10.1741147714162;
        Tue, 04 Mar 2025 20:08:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRhAjiy6oJgdTVYVOYk9K5LcroQa6MmEtafp7KA+t5KO8Pe7O1jHU38xtYt3z4pO+pz1vuRaGm1QENB3uSDNs=
X-Received: by 2002:a17:90b:38c7:b0:2ea:3f34:f194 with SMTP id
 98e67ed59e1d1-2ff497a94d1mr3253847a91.10.1741147713755; Tue, 04 Mar 2025
 20:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250303085237.19990-1-sgarzare@redhat.com> <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
In-Reply-To: <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 12:08:22 +0800
X-Gm-Features: AQ5f1Jr9X3ymlwY6PrZDcvmZUstskG7PfMhNEYJbHpQgXjCqpakU8L3BFGy8d0g
Message-ID: <CACGkMEtycEX=8FrKntZ7DUDaXf61y6ZE4=49SmQu5Nkh_tf39g@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix VHOST_*_OWNER documentation
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iWzN_qENWgg6jDxIqQ3BKiWU42y9xxkjwMZgW7tr554_1741147714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:29=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Mar 3, 2025 at 9:52=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
> > instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
> >
> > To avoid confusion, let's use the right names in the documentation.
> > No change to the API, only the documentation is involved.
> >
>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

