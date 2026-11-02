Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620120;
	b=CsxGFT9ig+mIFPE4xGOP0tQzwg6hOErl/cf55Tb6SVmL5w6erxw2Ttayllk+emDBNQqj
	 XxzIeT7RjcD5BC+Rdtj7AMRLHjbZqKfDhztd+ICyAqTeCsIH+yijfFSuNwsmI3n8iSOjP
	 JJMyX14Yo9MDjxqv3/AXi4m85QNHW+1aMH1LF/Fx8nXA6Excouq7O1xy8HV9iRijzcLdU
	 wTMKUNhAGvUeMuWR1DQzC6pSPZsYHukma1JTA5FTWzDSpjkEgOG23Gp16KFYR9XC65izY
	 Kyb9r2WofnPJkq9+zOKd6gOPQxOW/duJGtAFMidkpJwl9NSMORu9MBbBymM3eJ31xUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620120;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=ziwl8QBf1v7FFJqjlJ23GJJU3dSmhwP3y1Fomlh8GfI=;
	b=a4jDAjb5QEKeS2nWR2qDhprytFERXawT+YHW9FAiD/YftelC2r1IFVL7wq3ZkC6x7Bu/
	 Ka2egJNvDvIrOb9CmRQ+NGKmZ3TKIUnP6ncMb9yTFAU3binY4jVBkkzjmqiWrbTDkETT/
	 rXuKCnPgjg9nTm5gnVbRdLmdNJwnijwnF/cqAX53P21lJrlCLAIHVo7Aksw3uhTJuoMsu
	 ewk9+Jed/2Q5D2bMaq+1iRA50sCeDfrLbj8ww4+SLta/oVqr0NhvgSFUlRrTMgduO0iBa
	 21FxtHBJjkVQxAehKtU+m1OLWrU89dl/VJF4XOoCgzUUQYWTfXqDS6G7XOpa7ir9YPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQii4uzd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB0606A337
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 11:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBB0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQii4uzd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793620119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ziwl8QBf1v7FFJqjlJ23GJJU3dSmhwP3y1Fomlh8GfI=;
	b=aQii4uzdIeGwM+RWfXi2JMTXGzmrbFtmLlbwOuhaYCv5fgrWkVW+ES/hslOmuTV060cU6u
	n4rLjvuFZQ9Y0djMvXDahFAoxUI2R5bLUMyRrzzMAFnGm1Cvuzhqu8+8IWEFPcTHha2YaM
	tYhfksjrmx1c4RzOdjsRRWJyMTeL55E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-dhQKdZnhPeGwcH3rO1wWvg-1; Mon, 02 Nov 2026 06:48:35 -0500
X-MC-Unique: dhQKdZnhPeGwcH3rO1wWvg-1
X-Mimecast-MFC-AGG-ID: dhQKdZnhPeGwcH3rO1wWvg_1793620115
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so28144295e9.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 03:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793620115; x=1794224915;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziwl8QBf1v7FFJqjlJ23GJJU3dSmhwP3y1Fomlh8GfI=;
        b=KwvOzf5mrcgVNyU3TYng0DAIOP3gkOSIlAGU2yav1iqE4+YVTbp/+f1FMDpoPvE/kS
         DM/sI2HRovRzt4wVbICgn6j4FvHoNzIQkyHfmPFt9U900rUkh109a92i3O/TnTWi4Iq9
         gb7IpGRrlIt49WeFwQmCiWkqWRlTX8/DSu4SfN5QGeKth3LU5MV0rCvl0qHZMITUvkQs
         hpyUxfQMOW9H4QzJT52/K036aUBbJuQNnlnrMh6cL9rcOKBzP0KktYJsCV0rDfjAbKgs
         7uMNSImc7a1VawlcFUxKksfE5yNk4Pv0VsgruocHpmC5XhpQRJBX8t14ZM0TOp40UBcz
         ruKQ==
X-Forwarded-Encrypted: i=1; AKwUvBylX1wZeHi8wNR0RpjMoEW+eRhE/jDCDU5cb5mA0W/UnIpJbI35iGoPKYLrNted/gfW0dANjFJKTj3d33Enzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKdYoYe45P/1ZgsCzz7nUzns3qjfeXJSBpuPjENR8ARB2AIh7jr
	mrQqe5fduNPtmp8s4EDm9qDnPFFJX0Sw2o5i4DVDs+ljgb07gf5P5rVOp+ygywcCmakMw2tib+B
	LdULlkkeuBE08YtZV2+0Q5PLNPZ+ZTSbY/0bOTlP/wwsbdluWWGg4479h47DhGSvflHt2euHzlI
	HA
X-Gm-Gg: AYBFou1BAC8UYlzhXjbtQALpTyM2KnyQV4IFL/gkVdPMtz/z4nIaY4bK4hsQNk1Xs9z
	QO5+X7yczBJDdq4aOGDiEMic9fwRHElJg9Zeiw8rvipGoKw43hud19jV6h5Ijbt/SPFwi16tgW7
	fPXrwaOpeTyhLostw3vJ7yHaecIlEpnvYBwrBSFvOKYrtq7KuGMFn/fAiWnhMiGpqWNwByVS/Ra
	VI99F/ZayMct9pltFnQ/k2jB/0kpjvaXYDxS1haQobjNgVOqPNrpathofjxJLoawu+zwdV+Zwi2
	jhjjWFFkuVGzO4usTVGN2UlmNbY6dFk+hmQP4okbZuUR6ksr6TM0jaJ0UGvhhpqQ013vuJNsfsH
	7XPYW8/kvmon1UnmHAmeVjPLxG7md5GWobz9VjzwZwA==
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ac18a88fa6mr234177065e9.32.1793620114465;
        Mon, 02 Nov 2026 03:48:34 -0800 (PST)
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ac18a88fa6mr234176455e9.32.1793620113987;
        Mon, 02 Nov 2026 03:48:33 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a66caefsm216985365e9.5.2026.11.02.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:48:33 -0800 (PST)
Date: Mon, 2 Nov 2026 06:48:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, jasowangio@gmail.com, mkp@kernel.org,
	James.Bottomley@hansenpartnership.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v2] scsi: virtio_scsi: implement eh_host_reset_handler
Message-ID: <20261102064501-mutt-send-email-mst@kernel.org>
References: <20260911164417.33860-1-ngocthang2710.1999@gmail.com>
 <28865bba-ac60-4c6e-aec8-64b1fcdb1c8f@suse.de>
 <20260914133144.15509-1-ngocthang2710.1999@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260914133144.15509-1-ngocthang2710.1999@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zxg3nCmw_t_aFt_3tuQUUIb6lrTsIbspqhKn3bWDPUA_1793620115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2026 at 08:31:44PM +0700, Nguyen Ngoc Thang wrote:
> Once virtscsi_eh_timed_out() lets SCSI EH run on an unresponsive host,
> abort and device reset both fail the same way (same dead ctrl vq), and
> since virtio_scsi implements neither target nor bus reset, EH falls
> through to scsi_eh_offline_sdevs(), which frees the stuck commands' DMA
> buffers without any guarantee the device has actually stopped touching
> them. If bus mastering (or whatever broke the transport) comes back
> later, the device can still write into memory the kernel has already
> reused.
> 
> Add a real eh_host_reset_handler instead. virtio_reset_device() is the
> guarantee scsi_eh_offline_sdevs() was missing: once it returns, the
> device will not touch guest memory again, so it is safe to hand
> outstanding commands' buffers back. Reuse virtscsi_remove_vqs() +
> virtscsi_init() -- the exact sequence already used across
> suspend/resume -- to tear the virtqueues down and rebuild them.
> 
> Verified with a QEMU virtio-scsi repro (PCI_COMMAND_MASTER cleared
> mid-write): EH now runs abort -> device reset -> host reset -> abort ->
> device reset -> host reset -> offline, then dd's stuck fsync returns
> EIO and D-state drains to 0, in ~244s total. No task remains
> uninterruptibly blocked.
> 
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>


This is not posted correctly:

- start a nbew thread do not reply
- against some tree which is not upstream

I papered over it


> ---
> v1 -> v2: implemented eh_host_reset_handler as suggested by Hannes
> Reinecke in review of the original RFC, instead of relying solely on
> the EH loop falling through to offline.
> ---
>  drivers/scsi/virtio_scsi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index b4f20c487718..9698f4f91cc6 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -833,6 +833,8 @@ static enum scsi_timeout_action virtscsi_eh_timed_out(struct scsi_cmnd *scmnd)
>  	return SCSI_EH_NOT_HANDLED;
>  }
>  
> +static int virtscsi_host_reset(struct scsi_cmnd *sc);
> +

so move the function here?

>  static const struct scsi_host_template virtscsi_host_template = {
>  	.module = THIS_MODULE,
>  	.name = "Virtio SCSI HBA",
> @@ -846,6 +848,7 @@ static const struct scsi_host_template virtscsi_host_template = {
>  	.eh_abort_handler = virtscsi_abort,
>  	.eh_device_reset_handler = virtscsi_device_reset,
>  	.eh_timed_out = virtscsi_eh_timed_out,
> +	.eh_host_reset_handler = virtscsi_host_reset,
>  	.sdev_init = virtscsi_device_alloc,
>  
>  	.dma_boundary = UINT_MAX,
> @@ -947,6 +950,27 @@ static int virtscsi_init(struct virtio_device *vdev,
>  	return err;
>  }
>  
> +/*
> + * No bus/target reset in virtio-scsi, so EH lands here after device
> + * reset also times out. A virtio reset guarantees the device won't
> + * touch guest memory again, so stuck commands can be freed safely.
> + * Same teardown/rebuild already used for suspend/resume.
> + */
> +static int virtscsi_host_reset(struct scsi_cmnd *sc)
> +{
> +	struct virtio_scsi *vscsi = shost_priv(sc->device->host);
> +	struct virtio_device *vdev = vscsi->vdev;
> +
> +	scmd_printk(KERN_INFO, sc, "host reset\n");
> +
> +	virtscsi_remove_vqs(vdev);
> +	if (virtscsi_init(vdev, vscsi))
> +		return FAILED;
> +
> +	virtio_device_ready(vdev);
> +	return SUCCESS;
> +}
> +
>  static int virtscsi_probe(struct virtio_device *vdev)
>  {
>  	struct Scsi_Host *shost;
> -- 
> 2.43.0
> 

