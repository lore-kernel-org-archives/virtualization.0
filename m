Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2F22A807
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711741; cv=none; b=e3gwiy1vOUbHaCA3E/O5EKPr1DqADOH/4oXRMuLkXYnvuCzP7H9bfaqNXXuuekoJarurIFjm3+MWKBGls5xQItK3KRnWy/fbMJ/DsyRTKFXBLZecVoq3tPZcCu6wmPw6coa25tFhVPGn1I4+QiZIH+q/ojR2Ym26V4acW7vXTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711741; c=relaxed/simple;
	bh=153T2wtHJJxhKb4N8JyfLhbRn1FPHrxAGrBpSnTQ1Pg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NoV6Eip88ldXR3/Rg/rw9Pr4SSqrZr6aeZwjAJ7TPmJ1civ2Mg/XmuuAnhmbkVBiYFsXjD7Wxo7fhKBvT0wH55d9r9WzmTY/1ylDoJdQMzT/C9VFBSHdS3N7FfTuwV4h3CopBCmXSmLIlgtNjthinu5QmsOoX7JK/QOYUQJzPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjMNqYu+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjMNqYu+"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0ad74483fso11293826d6.1
        for <virtualization@lists.linux.dev>; Thu, 08 May 2025 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746711738; x=1747316538; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kOzwqokdjdtpRm1HS1RudL4NN1LsmIuMPcFChDAi10=;
        b=HjMNqYu+ncSUunFVlT9CMSyNgkfh2kApQWxM/7getCxXcwEhq/mAOqdI6dpMZCJu2w
         /MQWcTUDPM8OFcSSCHTaHxXbdjJVZPctEQRjF+iT+DlkJjj2lZcp2Nd4rxpCbc21HeYP
         olcTlEFa63NnVdnEmL/h+ncNNEBcrbmoOffHmyxD+bTb6TTPejZ7Os2s7xvEGbOgTgLZ
         DcFdaSWUP7W5u1THa+ueZhHg2CWs5911iNUnTvQjzjwLHdRfaPciCmOT355SPzXybQDV
         zJgOyNvQulk710yDvUGlpIjeMdrpXATDvvRHVKQT7UFpdjV1KjapWq2fSIY54nG01qrT
         jChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746711738; x=1747316538;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1kOzwqokdjdtpRm1HS1RudL4NN1LsmIuMPcFChDAi10=;
        b=o6BcNTsP3/QydO0dtoiOxvs2yEOH7+EJU9WlEvp5e3hbqxJ3nMV2HJIb9mIxujIbcf
         ptqHd1hrCtJ+/lgFgEM6NxaB2OhnVOv7eKnH9BFKRz19uppKFHxMZk7jyZxYRLbruJF+
         0kYj7wufMemd/CtwuyRVO/fFDcpsZIysDdjsk38Pti/0iNlPrmqrkV1UkcZwXU8fnJ8B
         C+O3G9wTP/afLw2br0DLm1EZKNab3FJ+yXjAb++r8PYIqh8O/ur7T7sEZYEnzbHuvMqT
         5r7u81am9BXl+2e+zGi79NXBJnpn13tw58dz9cGBqwPhPOrsfUzUOrMbROP+16mCl/k2
         4HbA==
X-Forwarded-Encrypted: i=1; AJvYcCWON3mtnfGsEmGVypk0zuf1fVaUlyhEDlMWHqRgjFlMyCOJt03Gj27CtX4+0TfJzjmxxbHaN8fwXQYnUJ/6zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyKoWd3FRGgtF4VS2hsvFTZPaTzTFLp5E6vwM55/t4NGVXiqGo
	yNg7g/XMpAehE9zJCh0aeMbEQ3uY7XuNOlqqUGt5bya7xy6mtpdr
X-Gm-Gg: ASbGncssM4bntYJBo7GciYtJJX/TI6/iHPHTgWa1/7sMTKQZnmXfYdE6KvJmqIEMByM
	buKzNP7eKhCR7HAkD05PA3Cx+p3zh9OrsFKQMc14+Xaiw22AhjWJqBFHOWeMYfR82Mh18sHshfb
	Od3tkp05eXTo2zu596jUCTioDLKTQTbg/I17KNMuBTMJa5hABcxYv0PEdx3pfa+/vTLgbv1oek4
	eCw1gmy7Rj4ypeoU4iqhgYpyOEawrQuVV4ms7s4KmXEenxXqnXzuq0WFROpcKJ8f2OqUduudU5i
	gRs4Es2X8Ft5r0z7atGEu6GqTY6KGbYjdkBs0sjxZCSbRSX61+4OzhXGJqumswW62atPaFxoq8B
	fLA5h3c3t0cbH4Pzlu6XI
X-Google-Smtp-Source: AGHT+IEDWLW6skXKOvMqdSktE7GaftAPMmvo4fOx9NvYyBhUR9W13eB1A+ZbxTatn7NW27+k/I/Z2A==
X-Received: by 2002:ad4:5942:0:b0:6e4:7307:51c6 with SMTP id 6a1803df08f44-6f542a8148amr99323396d6.34.1746711738227;
        Thu, 08 May 2025 06:42:18 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542780ecfsm32927476d6.86.2025.05.08.06.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:42:17 -0700 (PDT)
Date: Thu, 08 May 2025 09:42:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-ID: <681cb4b95dde7_2583cf294d@willemb.c.googlers.com.notmuch>
In-Reply-To: <C9ADA542-813C-42C4-AF5D-92445EB70A6A@nutanix.com>
References: <20250507160206.3267692-1-jon@nutanix.com>
 <681b96fa747b0_1f6aad29448@willemb.c.googlers.com.notmuch>
 <C9ADA542-813C-42C4-AF5D-92445EB70A6A@nutanix.com>
Subject: Re: [PATCH net-next] vhost/net: align variable names with XDP
 terminology
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jon Kohler wrote:
> =

> =

> > On May 7, 2025, at 1:23=E2=80=AFPM, Willem de Bruijn <willemdebruijn.=
kernel@gmail.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  CAUTION: External Email
> > =

> > |-------------------------------------------------------------------!=

> > =


Minor: can you fix email to avoid the above?

> > Jon Kohler wrote:
> >> Refactor variable names in vhost_net_build_xdp to align with XDP
> >> terminology, enhancing code clarity and consistency. Additionally,
> >> reorder variables to follow a reverse Christmas tree structure,
> >> improving code organization and readability.
> >> =

> >> This change introduces no functional modifications.
> >> =

> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> > =

> > We generally don't do pure refactoring patches.
> > =

> > They add churn to code history for little gain (and some
> > overhead and risk).
> > =

> =

> Ok, I=E2=80=99ll club this together with the larger change I=E2=80=99m =
working on
> for multi-buffer support in vhost/net, ill send that as a series
> when it is ready for eyes

I forgot to add that it makes stable fixes harder to apply across
LTS, distro and other derived kernels.

So resist the urge the just make stylistic changes. Functional
improvements warrants the risk, churn and extra work.


