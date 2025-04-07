Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0959212B1F
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992107; cv=none; b=LS+Knf+mjYrZa+gzuzoI4xv0iYE9KPsbYC0g409yGUVedyAm4apimdGlEUSh73XILdI9f1mj0tPjm4ubRtbuE/ImymH4T/dJ7h3TvHvriqF+C7R96ZzgOUhxNgFLP1yB5+asxYiaXNH+Yw6N0x27WpRxIX1M/ANoemMcGcQT7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992107; c=relaxed/simple;
	bh=5iGnaKTdh8qdUpTGBnIaXxXw7Npl7YWIGBbllmqoExE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieZFo3EG30r2hF0YkxW0tXZIXDlJE/6Lb8Yq34Xfy6E6aWPuUjXwI9BZT06cEYKjdek1Kv0fu2re5JXb/KxD6+HO5jUjiwkjcrm0AcxSK9DswpRzbWGldx3LD8vyFf1fngQKK7qxrN0OUvAR39vDESoKvzeLobzwqUAofefNsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnSCPLdd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnSCPLdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743992104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iGnaKTdh8qdUpTGBnIaXxXw7Npl7YWIGBbllmqoExE=;
	b=KnSCPLddSynLTtvxfQGVHpXe3C3iA45Eph81H50bcLguZMiAv0kOy1tRwgySB6yFSxtk+S
	tBnSYAcocbRMRW+0ogZsKTgibVPgIhbFtKMvYskoJXVlqY1ojmzL62E9/UQ+nSa40wIAQk
	K9thyJGsiguuf14MLaO0lV696q01l0w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-6oKTXR1FMIKUUxAags1omQ-1; Sun, 06 Apr 2025 22:15:03 -0400
X-MC-Unique: 6oKTXR1FMIKUUxAags1omQ-1
X-Mimecast-MFC-AGG-ID: 6oKTXR1FMIKUUxAags1omQ_1743992102
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736c89461d1so5992226b3a.3
        for <virtualization@lists.linux.dev>; Sun, 06 Apr 2025 19:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743992102; x=1744596902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iGnaKTdh8qdUpTGBnIaXxXw7Npl7YWIGBbllmqoExE=;
        b=ww3W+xNLUVNZH1YobMWVlbzR2Vu19292HdpVWWKa0kfX9YJi9Agrj67LlRYIL7+eIK
         SIb3Y7gn5NGneE+sI0JH8B3jtx3uwniSPrGvHMnTWkKVkPyFPs+bRpswBi3LRVI9lS7F
         9LrtMT6/k5aV/+y6tgNxrLa0TyfKf6CMGTgeGizVu3HaTys+bKbSJqVEtjeLp4xlvrNo
         cetAJNx35rrITwCNTHL50rHUZ7Jk1sRQEFGO20H2mQX/0dwX3wltJQTBV+IetjrTpl1g
         +yWl3TfHtYKiU6G4t1wsQBvoyddkpSSsDqy544SgZrFJJFBDH21gJeCuvOfAd95rlIKJ
         g0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWASnX/Q0JE50PFHjIiziG5UIjNF+jb4hJuqLBx/3zTYVuhe0GGVhQr/4D+wt/ofxFSrJWp1uglPp0rcOxwIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq5TbCIQli+xYBZOFC5lp2MkYI6pt+I1IfqOqi86aPbxvGuAG+
	snqjlWX75itqcYpTZ4BJYyDLCPkFxyBUpn/yWS5x7nRtiK/vZ83d0o2HFNumLnZ5uCBg9uyC+p1
	HgQQMHMA6a81NlsoZEq8px3yHsfMi0XBTaDGLNf2mfzHrpvJVrpv60m+5SWOylIdxqiou4HczsZ
	NsaYPfUi8Fy/lu2034TE9QVeaWc+vMDxWaeQ1sEYU=
X-Gm-Gg: ASbGnctZ6UO3wgysOG9xShgqlq/Xk/p5kGiHUuq6aNtYrj4hzgQslO2n3E924URjj3b
	nrAobb6K8bYyFX1xP8Q3HCEQex2m3wtR9uO+A+zRL7mRpk0ylrsjbFWx0xUeAmhnw0mHbqw==
X-Received: by 2002:a05:6a21:6f01:b0:1f5:8655:3287 with SMTP id adf61e73a8af0-201081894f9mr15997602637.40.1743992102454;
        Sun, 06 Apr 2025 19:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2xrRUCjmDh8gU4TsrPWubO4RaHlHA1/mZMFsc3k0pvCi4jb3ExJetOAjK+ODkU/PKVNydcIKM1LkzsCQTKWs=
X-Received: by 2002:a05:6a21:6f01:b0:1f5:8655:3287 with SMTP id
 adf61e73a8af0-201081894f9mr15997577637.40.1743992102154; Sun, 06 Apr 2025
 19:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250404145241.1125078-1-jon@nutanix.com>
In-Reply-To: <20250404145241.1125078-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Apr 2025 10:14:51 +0800
X-Gm-Features: ATxdqUHS0zfr8JGoyzsGJ5km2ABwTqNENhD1uX4yKsHGytOkPk4bkII2gJMMLUM
Message-ID: <CACGkMEsFc-URhXBCGZ1=CTMZKcWPf57pYy1TcyKLL=N65u+F0Q@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: remove zerocopy support
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IBBsP8rQbjkick1kug5BYRhDkUlGNUKFh3YC8Zt8Sao_1743992102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:24=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
> Commit 098eadce3c62 ("vhost_net: disable zerocopy by default") disabled
> the module parameter for the handle_tx_zerocopy path back in 2019,
> nothing that many downstream distributions (e.g., RHEL7 and later) had
> already done the same.
>
> Both upstream and downstream disablement suggest this path is rarely
> used.
>
> Testing the module parameter shows that while the path allows packet
> forwarding, the zerocopy functionality itself is broken. On outbound
> traffic (guest TX -> external), zerocopy SKBs are orphaned by either
> skb_orphan_frags_rx() (used with the tun driver via tun_net_xmit())

This is by design to avoid DOS.

> or
> skb_orphan_frags() elsewhere in the stack,

Basically zerocopy is expected to work for guest -> remote case, so
could we still hit skb_orphan_frags() in this case?

> as vhost_net does not set
> SKBFL_DONT_ORPHAN.
>
> Orphaning enforces a memcpy and triggers the completion callback, which
> increments the failed TX counter, effectively disabling zerocopy again.
>
> Even after addressing these issues to prevent SKB orphaning and error
> counter increments, performance remains poor. By default, only 64
> messages can be zerocopied, which is immediately exhausted by workloads
> like iperf, resulting in most messages being memcpy'd anyhow.
>
> Additionally, memcpy'd messages do not benefit from the XDP batching
> optimizations present in the handle_tx_copy path.
>
> Given these limitations and the lack of any tangible benefits, remove
> zerocopy entirely to simplify the code base.
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Any chance we can fix those issues? Actually, we had a plan to make
use of vhost-net and its tx zerocopy (or even implement the rx
zerocopy) in pasta.

Eugenio may explain more here.

Thanks

