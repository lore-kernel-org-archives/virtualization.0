Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628913;
	b=nHVT5E4/79/58ikZJRyPcmvowHVwobdXAuLJrIcLosMSxQjZlkoh6MiW52JDtV4uWFs5
	 AbwHYVq7HlzHHV9IAR+KFZ4YPHOqFlrPk+4vcJbBqRojyWLCaHl321pxcgAPKJpkE0+Mw
	 c+ysAVBIxT8aVzxOYpmdBT2IXsWMGbDtf2ry1tEoYWJHlD1TowzoeDoXNMc7TQJxVRPCF
	 Tg3AGkewYOkA+3yOw8B0lxOVceAUxQInEcB0rkY3T3zA/ex4m6wpQwaQ3YEo5fRkFo0sO
	 hoE+qx6qu0dty3ojDYhOqkp68osZLg6LitetCR+ta3djP6HIvieWpCUeRYzIhZZhUWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628913;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
	b=oflTKj6obUk9zu+8OfE05CRU4jtpHsVJpHousZDH+NODNZS+IDrozRnHZMI//zqF3x8T
	 L8L4RLfbJwNRdJX4P3YhBvE+SMkRupXW/PRO8L/F8AftxlVj4qGVrQeX/KlP1Dxeftsrj
	 qMQyCl8MxmYklODVHqyaXvwJ+KDfzYhyYMzZntyoMYieC4kxBnvQSagJRXSh3iA/JSTvK
	 REiKidQOLQnq9HBi/tAB/0CK953912X06N2ilVuHT/1bBrmlFy9ZZcQ4wrK0/u3IJRii6
	 szCn9AO/QDlEbB7+Iq1CmpkTn245miPpUQRY5Q0SRadK+CNiq37bp6wN8iCoS6vODJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9dMeVlX;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7F606B5EE
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 14:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D7F606B5EE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9dMeVlX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793628911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
	b=L9dMeVlXIytiUJTw094OqZstJIA8ybKvQCT0j6qdex6E5OeexAGr8A7b9vZju4+VRY9ZO9
	nOsvX+uUvx+/pJKgD50UzJhhqXxK0ZhZVUfg9AzxmtQYXvNSL1atiQk1aZxx6g4Vr1PTab
	JkUxIaPdkirri8bjNM/R8NhsuZMZi4A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-pUkS9hrQOqyBoAQxdfR5Dg-1; Mon, 02 Nov 2026 09:15:10 -0500
X-MC-Unique: pUkS9hrQOqyBoAQxdfR5Dg-1
X-Mimecast-MFC-AGG-ID: pUkS9hrQOqyBoAQxdfR5Dg_1793628909
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c415561aaso2078885f8f.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 06:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628909; x=1794233709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sl0xAa/SyZWrBp9CL5o2SaCOERZeomQ7Ndnf7a0XFec=;
        b=sKTn0GUpA2BvlPMDtZh7YzV732BLX0T4ySz9mq8BzSgQkl3grvE4fNWjO8PLaq09Ir
         gyYWOWEoAdOrswwzwVLcbiU39EiclFwHfv6hTYlC+fU00xTKNgucOw4/uGKJVELSW1Rg
         ehZUpb5upB+KrfiLsIsCu6KdqVvymEC+cZMNGJkPojxYpbFlXDcg8Z58HroFR+G3ljoR
         BLv2jSbXoCVJZ0D5QbjJ36EMZzIMYemm1OjTpFqptXVTEK4EnWBf7/QcDElYaor1jyz7
         oQyMmWOOM9z4gSeqRZwlNE+QJ4MEqZ8uPmV3GlIxwhojHRxIW23xcPcf/SkYVvXsy4M7
         QGow==
X-Forwarded-Encrypted: i=1; AKwUvBwHim6iGdvyybXiSW9cB8QZma0XPwpEjQ+xdJT0xpLfbgjKw/gicakbXRl+ckEiPxszXQWFqfNnHoMIi39+zg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9b3ckeHxFeVIbrSiCmGiCB/Qp8Yb+dSmtpGhunJcnLlEgmKzxT
	7kdCbEbQIcuOK7tgifONDYhr5FieR0KeoesxpXF/P5ecCkIFHF5wIscjdFkaz5iwzgLG/dVm+zL
	4W8KIk3ldRY/WT/e0fAlq/Ky7Kxh6KsCvw6IDA/rGiR0bO//5ozXrG2VxUqqGt+N/znL1z88axq
	TD
X-Gm-Gg: AYBFou2CkK2N7NnC5I+Oa/PTasIxJPT+Oalb/DP0GZnJA92vCQXY0AEP1fl3YReC6US
	ak+aTM75GMNwWPS8HUD/kJoWk1ah7tWWVq1F1VV9G2YDZVqlj67GtXf1Y0UgNingaijLFC1dBpA
	zrV91kSCmjW0nDd8LWt3AVVCpxgoJSEBPn0biaWNken7DxtC4pI4rCg9nSwDGdAb5fmaC2B6VGd
	MC18BOKYM4fKvxlOUuA5nAQ10kmske7IOE7qvOvseDFN/T0eVc96rjbtH1zaKYYmzIB61FfgB4X
	Mqj8gAfHWa/JxDGRSe1baeHMDYJnHW5cH8O6AQH10VCXcrKdGNAdHI1T8gyd3nnk7Jeg5Jch7/v
	KmElzd+q1znDi5OzDMqI32pySLlet0FDEQBU7zyaIqQ==
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr20529293f8f.50.1793628909035;
        Mon, 02 Nov 2026 06:15:09 -0800 (PST)
X-Received: by 2002:a05:6000:25c3:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-48e6e517f2bmr20529177f8f.50.1793628908269;
        Mon, 02 Nov 2026 06:15:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm20775864f8f.1.2026.11.02.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:15:07 -0800 (PST)
Date: Mon, 2 Nov 2026 09:15:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Jason Wang <jaswangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Asias He <asias@redhat.com>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
Message-ID: <20261102091441-mutt-send-email-mst@kernel.org>
References: <20260904005240.502787-1-physicalmtea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260904005240.502787-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l_zxwYxGHAOoLPSxeTFlo8l67pvsFS6MHV5RCVE9-RA_1793628909
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 08:52:40AM +0800, Jia Jia wrote:
> vhost_scsi_do_evt_work() uses vq->iov[out] after vhost_get_vq_desc()
> without checking that the descriptor chain contains an input segment.
> vq->iov has UIO_MAXIOV entries (1024).  A chain of 1024 output-only
> descriptors yields out == 1024 and in == 0, so the length check reads
> one past the end of the array.
> 
> With a host-side harness that sets VHOST_SCSI_SET_EVENTS_MISSED and
> kicks an event queue filled with 1024 OUT descriptors, UBSAN reports:
> 
>   UBSAN: array-index-out-of-bounds in drivers/vhost/scsi.c:611:14
>   index 1024 is out of range for type 'iovec [1024]'
> 
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5f/0x90
>    dump_stack+0x10/0x18
>    ubsan_epilogue+0x9/0x39
>    __ubsan_handle_out_of_bounds.cold+0x50/0x55
>    vhost_scsi_complete_events+0x55f/0x5a0 [vhost_scsi]
>    vhost_scsi_evt_work+0x17/0x30 [vhost_scsi]
>    vhost_run_work_list+0x8e/0xd0 [vhost]
>    vhost_task_fn+0xe1/0x210
>    ret_from_fork+0x348/0x540
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Require at least one input descriptor before indexing iov[out], and
> treat a pure-output chain as a missed event like other invalid event
> buffers.
> 
> Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Applied an alternative more comprehensive patch, credited you.

> ---
>  drivers/vhost/scsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..9b5f07f52b0c 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -608,9 +608,10 @@
>  		return;
>  	}
>  
> -	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
> +	if (!in ||
> +	    vq->iov[out].iov_len != sizeof(struct virtio_scsi_event)) {
>  		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> -				vq->iov[out].iov_len);
> +		       in ? vq->iov[out].iov_len : 0);
>  		vs->vs_events_missed = true;
>  		return;
>  	}
> -- 
> 2.43.0

