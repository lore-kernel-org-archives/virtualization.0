Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE52224D0
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164302; cv=none; b=ew0gjKmCgMt+Hnd1BhUHhmoCAx9hyecQiTOdEviaGjAkjvwu6Ju+ojm4rmgWyimAdBvfIu6JGD2jPmQpQYovIHd4peXPhowJflahkDwxnhwPbjthl5R0QlrrJ+FPH/CW1Rd2A4tUv9AEZxQTy/zIFZ8DpmoKxvrkylPiEZFYx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164302; c=relaxed/simple;
	bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En8LjEYsntTsd3q60/hcMlK5xmllnPfZ+gA6sed+7mhxOBXZPrnYLRSOgqWwywcRR4ACLrw2V607Jh2kpMIHkM6O4DRUYzZ7a64YKEgEDH90hMMifPMe94rlkb+vU+ZkngBoknEreG83kEShy4wF80pyOdM2mDdO4dYZe+uWCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvTdNNNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvTdNNNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713164298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
	b=OvTdNNNxLhZpNDTjZF1SBowRw4BS9Z9Um1+gGgHhHR7LIV2k2cfIE3AQW4S235iX74eXNx
	3bziquNTan0AinX8K4Yzfr1AsSLQ2eAnzAT3HjWFUQW2+zbbUMfxLI5ac49Y/lsKuZ1mRJ
	LkKLdE6Y0iumk0H4GH5mRb6x5PSGBOQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-kzNhs8mJM2WxcRg5YnvC-Q-1; Mon, 15 Apr 2024 02:58:17 -0400
X-MC-Unique: kzNhs8mJM2WxcRg5YnvC-Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso1890930a12.2
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 23:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713164296; x=1713769096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
        b=Nt+NRGrNlyClfxlLLKU7xs3wYB/zenQFcQLx2OFl/4G6CqnU2na8Srm21ItBfUN/Zb
         yQQ2CU5UZ/d+g4GZTnkYWvRy4aS2LvtQkiPza4y/tLhJxMXu0Fv+K3qRxauP8aW16mf2
         f9T1zWyOHV3ZOAFBO0Y/8f8QcbJjA8+mNThzhbesGHN+14innAQ+Nb0E3z8LZoqbQmG4
         EK9QAowLesXwiaA0vPJk+NtiNpCp1kzkg2XW5gxz9WXzb0hfohKnpfwaYJf1Qv3LYLUY
         TkF7pt9lT6j+Sh9K0nCBmrxG+IvSYLHF5hUT1zWKhMxf1N9S1gmvSTo1ET8kyktzY9Nm
         072A==
X-Forwarded-Encrypted: i=1; AJvYcCV4cIoSP4GLmC+ygOKgFarW91aBqZG45CKkwTwGWS/t5QCdD90pLs0OnQanBaV9SUHtF6jIk5Af0ItHAGkWlDTs00Sdj5hAGLvxdn+o1u8=
X-Gm-Message-State: AOJu0YwFoADSK5oIJul5I01jZBDu6+q1TsRXVJA3OCvFeyL6bFO0Pxi1
	zmfNgVnnIskzaX6IurhOQKO7/hIu6BVFHkzjez/I9tDfJaJzTMvBa4uznK1Ux+tFQ5WT3eHcP+K
	/5BfQpHOfLCraNNMBn0WxaLgKG3NtKvf2G4KrxMzZHAfAV1DX4mvzHLJ9HwwioiVQa9Y4+E5EdS
	UdidmtEsuLA90hTCPfVMXiSBkla+LCqxfEnMSk7uA=
X-Received: by 2002:a05:6a21:191:b0:1a9:6d96:c700 with SMTP id le17-20020a056a21019100b001a96d96c700mr8932587pzb.48.1713164296249;
        Sun, 14 Apr 2024 23:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfCe10Cxttrxe8F4OkPc7KjxC+SFTe/Z0SKvR0xbdRbE8/iQQiMdWF3kDr6DPf/3wtsnu4W5Rb/yh0o2uaUZk=
X-Received: by 2002:a05:6a21:191:b0:1a9:6d96:c700 with SMTP id
 le17-20020a056a21019100b001a96d96c700mr8932578pzb.48.1713164295965; Sun, 14
 Apr 2024 23:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67c2edf49788c27d5f7a49fc701520b9fcf739b5.1713088999.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <67c2edf49788c27d5f7a49fc701520b9fcf739b5.1713088999.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 14:58:04 +0800
Message-ID: <CACGkMEtufa6MqWkcsZqHW8eQzj4b2wCh8zFMSAuHkxpWowLmdQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 6:04=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> Note that the upper limit of ida_simple_get() is exclusive, but the one o=
f
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <horms@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

