Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D381495527
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859118; cv=none; b=GE1FS66GneBWOxZqFiuRek8smZnPkwalsBOxwjujXulNw8oJZkC+DfXbtNn2rjN9JQ5XP0YaAF/9EYtEtBAKO8wicZ5+CL9N3YcbKjfo1UMMu4VZE5rxCCy1wiYPLirMjR4aHLqERscnDaRih7gVBmj3SU+U5QceH/xcchW3fVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859118; c=relaxed/simple;
	bh=eVU3MNy62hkr4mZA2kAadzm/wO61vBgqYeIJY4Hn+Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rl7B9QX8Ja7aXqceG9LPRtWL9j6zZbpZ8ZSXPquBs1qmdhbzlsc3xTGX2EcmRpM5DYVZfurttWgFypwOKJ18l5G4CQfl3BUkQrwRDxgTFpDRCI9iVU/ecakIaP9uZW1p9jE2bsexQr3LTklOZ7T6TmsTwPNJD8DyhgnmlmIyoo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbCIJmSn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbCIJmSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778859116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNoThb3GH/r9XH/lrFbBvY61nIvTAMuk1snRo8d5TUs=;
	b=IbCIJmSnDnfTv0/C+OQhSNpDTsGMoDYikul6fhGLKMkTJpldoJvSHnVgTctktNXw8dEeWb
	N30eiSyYkrJesPpyWMkI+1/xy3N2GZ018sc6S+vGtqacjlAb9+n0vDrPGpI6g1T+iWfnF6
	/F6LLHdn70LzYP7gnA1MSrHAw296RDw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-r13iGxmiO3iF93-GkcUYtw-1; Fri, 15 May 2026 11:31:55 -0400
X-MC-Unique: r13iGxmiO3iF93-GkcUYtw-1
X-Mimecast-MFC-AGG-ID: r13iGxmiO3iF93-GkcUYtw_1778859114
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45d7293c595so2116872f8f.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859114; x=1779463914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNoThb3GH/r9XH/lrFbBvY61nIvTAMuk1snRo8d5TUs=;
        b=FqXO8n3Aoh/0NUkMNlKa0bnRTPIQNcKZVP6kVMwclzECdvCkrj6Mt8Ne2BRulPMoHm
         TEDjRQERmt8YIuq0Ay6WKQlQACoHksfyj4btg7QCCW7yo6pL1fv1q7viU5ObPziBu+SY
         ifkz+H/s0iD4gT4ZBk2UtktnRgYOOyTwE67WqOqiFeXuhqkxnyklVljlgxBEVZrwQYIH
         EkuveCLsXGAkI/xDhO9ikG4YCcrhT/EI20Ah12qP/73hspxvHg/yvAueHZTrksy7w868
         PM+ZPdKev5mov97Y4KicqjmRaWOWEjh/Vvth+mhVSDDVBgUXzdKeAJ06u3uA+t217cL9
         9aAA==
X-Forwarded-Encrypted: i=1; AFNElJ+EAgyYFYKUmxGPxz3HeO0J2WWqU0XM2cnUjGEJDfUU3eOeSdHJ2b7G3ruzH/kKwH/C40mZh1EeuKjvjjUHYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy1pTrvPYVubJWfbRXMY5SCnRw0TkmdwQmFH2Jh28u42Ey9SEI
	3sKy9vFhqIvdF+YGCL0TQteEqeTg0IPo9Zm3YfaPwa7WVcqgUzgkFBxNJbdOr/d0PZ1us/yWpds
	nVUUD/BycRg19aO6IEbWu4maWpIul/gEpwaD1DIFf5eXD8gQ+DNveeXT0VMYhPnRjQEKZ
X-Gm-Gg: Acq92OFZfpKWfml5vyGaD4O7kSqkxprnHGNLB00CD3cgCLkXcLCtdbw8qwHNSHmgBRm
	Pk3A8i6taFeT4lwkBxVPQBw30iGVfRGvNaN74KNjqXUMBjIJaXg52aLuA3pwn24DTyKEnS8eIlZ
	pQle/RfBRZDSUi4INTyAw6796fGBhowu+Gr2dMhpM+KEte4UR8pyoGf+YfOT7L2+RJRiiZa58M/
	oHMGlu8YAnV2BYI2DAjkIJO8XOoeX/+UygNoThskn6JglSd3wbPCQMqCd5vOff/GfirhUr3kBw1
	6/HdYiRVismtBugSHB0Co4DZPgevcmXqDEE4o6zEg18vfqRBQGjDCBDqXkDKNvuXoO3WPHNveh7
	dIEElBOsUlOH5TyTKcrEAEdpX8g54gLcAeCsVcZii
X-Received: by 2002:a05:6000:290a:b0:43d:1bf6:30f7 with SMTP id ffacd0b85a97d-45e5c5d2c12mr6598348f8f.18.1778859113649;
        Fri, 15 May 2026 08:31:53 -0700 (PDT)
X-Received: by 2002:a05:6000:290a:b0:43d:1bf6:30f7 with SMTP id ffacd0b85a97d-45e5c5d2c12mr6598277f8f.18.1778859113136;
        Fri, 15 May 2026 08:31:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm16563554f8f.31.2026.05.15.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:31:52 -0700 (PDT)
Date: Fri, 15 May 2026 11:31:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260515113100-mutt-send-email-mst@kernel.org>
References: <20260515-dumazet-v1-1-73468c902889@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260515-dumazet-v1-1-73468c902889@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8rz58fOIGkdpqqcihYyBkVy8uRR_xdbhVfpaPw2mLVo_1778859114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 15, 2026 at 04:22:12PM +0200, Luigi Leonardi wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5
> 
> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> 
> virtio_transport_recv_enqueue() skips coalescing for packets
> with VIRTIO_VSOCK_SEQ_EOM.
> 
> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> a very large number of packets can be queued
> because vvs->rx_bytes stays at 0.
> 
> Fix this by estimating the skb metadata size:
> 
> 	(Number of skbs in the queue) * SKB_TRUESIZE(0)
> 
> Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Eugenio Pérez <eperezma@redhat.com>
> Cc: virtualization@lists.linux.dev
> Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [LL: Fixed conflict since this tree does not use buf_used added by commit
>  45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 4c374c36c29d..86e3051d000e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	if (vvs->rx_bytes + len > vvs->buf_alloc)
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +
> +	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
>  		return false;
> 
>  	vvs->rx_bytes += len;
> 
> ---
> base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
> change-id: 20260515-dumazet-07c0c855a9e2
> 
> Best regards,
> --
> Luigi Leonardi <leonardi@redhat.com>


I am not sure we should queue this for stable yet. It causes regressions
that we are now trying to fix.

-- 
MST

