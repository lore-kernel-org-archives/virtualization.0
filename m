Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773401;
	b=r465Kpjo15oTyeAph01tucCHvixWTFKTCv2CfhH90kiVnVMPEyXfZrV0L5q8Euzg/Qpe
	 teyr/KkNsFU7j8NthYZPCj+TKZkVHy8evd0Gw4/zTLQRgxMF1ajhjr2hT5aypBFYrMSCA
	 FTkw60aV6I2mV+IQ+exVfkK9zFR4duznEh77ZOPwNT4XUAiJpGxsEAn8TPUxIPZ8gV5/v
	 9irulIVwU55f7VHUSvpdm5b6Ass7eaGYCsHxnP05qkb9s37fY5gBMGiEhc6CF7q5MsWNC
	 7Ogc/qZuwDLgl4mdELdchPrVyjYxERVfsX03jzT6B5Wun8ura6o1yaxzexlOEJ+Yx7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773401;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=6LdHhyQ4qYGaeUAtkR2L4ANZJ6ir0QFdHTHjhQDfZlk=;
	b=pCb65Ln8oaE888pn5BMH661hNyqCfhX5TOoMs2CC7w78sZexzN0YI1Lpj83OGglmoz41
	 d8RzGdye84sfYBVbJJ0Efz62EampuOxZAOE/Y5aJOXI7M1pu+VQHkZQJabr5mP4CyPA5k
	 qdqJ/Ov9YK1z8cKpA+p/PSB7+MfBRYoBfam1MziBwjPwNLH8yiyxvTCC3etInyzhcxDN+
	 vzMJaW5ZFujkQxcqmFOKyO1Q2jIEGrY6oF1OS2UDbU1upFmcNcgNvEZpAv7LMi0KJdh7l
	 lUb2JYq0Qnf8nvx83hJjdpd+pmmoMzqQThRgPgf53elcNAiBgbLhhl0NsydNdUMphTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X4HskpcC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745C606A31F
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 20:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E745C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X4HskpcC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794773399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LdHhyQ4qYGaeUAtkR2L4ANZJ6ir0QFdHTHjhQDfZlk=;
	b=X4HskpcC15U04NaPuWOHnR+uN9+KtTPICz7h9i22dvV26XfSWWKAjewU7IbXVpGpI5nmYB
	dr6OjxwBA7SC+mejGpPwdxQPLcHeZmT+QHAgx+zEbiIKBQW4AoFolRzpc+oIRMPJuiU6PU
	32YFYiPBbrNWW09sX3IkM5C1iK3WTFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-eTxOJqAbNDaY8zYshOxFtQ-1; Sun, 15 Nov 2026 15:09:58 -0500
X-MC-Unique: eTxOJqAbNDaY8zYshOxFtQ-1
X-Mimecast-MFC-AGG-ID: eTxOJqAbNDaY8zYshOxFtQ_1794773397
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso18052495e9.0
        for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 12:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794773397; x=1795378197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6LdHhyQ4qYGaeUAtkR2L4ANZJ6ir0QFdHTHjhQDfZlk=;
        b=RPj8Mo17wy3kYftLJW8MsGHHNeamICD+ya5/uSdsqt+0leKqArOL+sEopPXOS97iCt
         HJ1PODy+qYn23ZSyntpvJ+x3foZW/esw61RfJOmM8uaPpzllToxKtc7GK09wvCxXRSdm
         MqK11FJyNx+/FeT6Dn4mMMydCnAkZeK41JvSGXr7KT07vUh9WK/cToDU0ioZHyHyrT4f
         P3CCSYB7vHOSdRGerdfRjZHSwi+KMDxRfDSLnRxkUfZ8PABQCccNpzLdUYxv5abC5Rh9
         zGJmuiWOWRCDIxl3fjRYXUqOKoh7U5nRjtK73rPujcxJBnNChIhmzQui7eCuFXRda3sp
         6MtA==
X-Forwarded-Encrypted: i=1; AL+hErFH6W54BFLbQOWVh96G4om1zAPfwmnxumSgDGCuffImXCblNZIKOqgqwn7i/b8AzxRQMK9QHGrLU04DxEg6Sg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Rw9Hm5FZkag60Tlgw1bKEY2es6k9O5aYTHmSo3usydwuHDFGC
	xWEWOmM/QdQmqEk3Y7yuF4AGQIQxM6Q338jFplfUl/wlmiItLIEGCvAtUvZDbkovawewUSYDZbb
	uTuFR5YBo0GUxDl48JZ+JdlqDKnDFJd1CC6EbMG13IOEv1m/0yD9SC6nDuxfgKPZoT1j9
X-Gm-Gg: AYBFou2BUQeDWwXBb1pO+tPFnSUyMLmCZkHudDeT89vQfsXAnpjfaqYanBYx5kG2ZIy
	/52DH0lhKEpFqPnnE/Qd/+SvNEGmaIGycCaUlyrGm5wDgg8qNlVSf6fwgOPsexUkjBQp5cD0KXy
	OIz8XhEcfp3NVH70jIDGg/gj7mAWa/LcI7hhYGGzKAhy+8iZctGc+xi5zkHbnyrOuiQniu9XRxV
	VwDZeFCVuwCMtLaPAk81Ih1kTnOOubS8iHjx2dMdOhmm+X2wzn96hXTRVwOMUMQfeMPqSn+VXz1
	AL7PhWEDGvvA9lK8aCGBZLs8Kj4ADyEuBrVa/M74xoyWN71sRTO6xNJWIu256ZwzyKgWtNblXS6
	wgTvbZfPxDAWSV3/R7tZuSVmn3h2pGn7alAaPNsf6Jw==
X-Received: by 2002:a05:600c:3551:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4bb55a99d21mr192253045e9.16.1794773397187;
        Sun, 15 Nov 2026 12:09:57 -0800 (PST)
X-Received: by 2002:a05:600c:3551:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4bb55a99d21mr192252645e9.16.1794773396626;
        Sun, 15 Nov 2026 12:09:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm514095655e9.1.2026.11.15.12.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 12:09:55 -0800 (PST)
Date: Sun, 15 Nov 2026 15:09:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Congjie Zhou <zcjie0802@qq.com>
Cc: netdev@vger.kernel.org, jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] virtio_net: RX stall caused by masking callbacks after
 NAPI ownership release
Message-ID: <20261115145652-mutt-send-email-mst@kernel.org>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: or8XweDzPW6B2A8ETklRrzXrR2wyjyqsMdmYlhxg3oc_1794773397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 09:36:10PM +0800, Congjie Zhou wrote:
> Hello,
> 
> I observed a persistent virtio-net RX stall on Linux 6.18.58 during a
> multi-threaded TCP receive workload. After the stall, the RX virtqueue
> contained unconsumed used entries, but its NAPI instance had no owner,
> the NAPI timer was inactive and virtqueue notifications were disabled.
> The receiving TCP threads remained blocked waiting for data.
> 
> Completion sequence
> ------------------------
> 
> The completion sequence can produce this interleaving:
> 
>   old poll                         successor poll
>   enable_cb_prepare()
>   napi_complete_done()
>     clear SCHED
>     arm watchdog; result=false
>                                    acquire NAPI
>                                    poll, enable callbacks, complete
>   return false to driver
>   disable_cb()                     callbacks are now masked again
> 
> Root cause
> -----------
> 
> virtqueue_napi_complete() calls virtqueue_enable_cb_prepare() before
> napi_complete_done(), then calls virtqueue_disable_cb() if completion
> returns false.
> 
> A false return does not guarantee that the old caller still owns NAPI.
> The hard IRQ deferral path can clear SCHED, arm the watchdog and return
> false. Another CPU can acquire NAPI, poll, rearm callbacks and complete
> before the old caller reaches its final virtqueue_disable_cb(). That
> stale mask overwrites the notification state established by the new
> poll.
> 
> The watchdog is one-shot. If it has already run, there need not be any
> remaining owner or timer to recover after the old caller masks the
> queue. This leaves later used entries without a notification-driven
> poll.
> 
> Current source inspection and local validation
> ----------------------------------------------
> 
> We reproduced the notification-loss condition using a deterministic
> KUnit fault-injection test on the latest mainline snapshot fetched on
> November 10, 2026 (7.4-rc2, commit b3dfbde62cf1). The candidate fix
> passes the same test.
> 
> Candidate fix
> --------------
> 
> I have prepared a candidate change that masks notifications on the
> relevant completion paths before NAPI ownership can be handed off,
> rather than masking after a false return. It adds an ordered,
> non-sleeping, idempotent mask callback to a new completion entry point
> and uses it in virtio-net. Existing completion callers retain the old
> API. virtqueue_enable_cb_prepare() remains before ownership release,
> preserving the ordering required by the earlier RX virtqueue race fix.

so... can we just check for this case? Like this?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe7..41778d727a89a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -740,6 +740,8 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 			return true;
 	} else {
 		virtqueue_disable_cb(vq);
+		if (!hrtimer_active(&napi->timer))
+			napi_schedule(napi);
 	}
 
 	return false;

