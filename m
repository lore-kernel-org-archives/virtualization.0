Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65F1EFFA5
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992322; cv=none; b=Tm1gqs0bmN+vGbuJs/TvKgaXPh5Fc/NbNCA92ZfwrgEtPkMKfgQQ9Ukj1W3/SNM6JtR3HFRbc5Yma2wkWFcxQXXetphfnWZf+SSCRPKTfavvh1UJqEprG490yJtK2QzCxBW93AUs5QUqF+l2VEbgpmnmupIL4SriTTQygtoxaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992322; c=relaxed/simple;
	bh=trItDQ5V/mkIx/cKE4ZUDuGgE8kApBhRlmDdGwNOul0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ImRSeXtU+kvOO6d87miJoh1s5cHH1rteXd4W8+SMtoU2plG8yOw2nTmnD26T8wLz5D/SKIzq/+aUPzt+lzBhOGa0NNBwzzSTap/fCWX1u7jPZ09gbj7yIHPDKUlafwlfuni0kpD2Vr06uNfGgx3oDzyOFRSyl/Tk6IoTgFvGofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itSaAPvy; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itSaAPvy"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DD8740918
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 08:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mw_88kTuW2nf for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Mar 2025 08:58:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F03D94051D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F03D94051D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=itSaAPvy
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F03D94051D
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740992318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5mIvbymr+I4BfYQ2lCWwQkjM6pyai+CS0CDOiZ31Js=;
	b=itSaAPvym3ZwepwFNqIHW+TR3iqQSWNOGQ3f6RAdWV1FieT2M1LaU+0D6lrjTGAbLFJB8H
	MzbQqMoL1cgfs70ifnl41Jl7vo6lHliEkt1wpXZ1a5+rXr/XTrhzSssQgahkk7lTQgX59y
	Fn4nqj6ZvdBcbVSQhDn6nykjynEpvsU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-hfBA-Y2CNoCdrg87CgDi7w-1; Mon, 03 Mar 2025 03:58:35 -0500
X-MC-Unique: hfBA-Y2CNoCdrg87CgDi7w-1
X-Mimecast-MFC-AGG-ID: hfBA-Y2CNoCdrg87CgDi7w_1740992314
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e073b9cf96so3887137a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 03 Mar 2025 00:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992314; x=1741597114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5mIvbymr+I4BfYQ2lCWwQkjM6pyai+CS0CDOiZ31Js=;
        b=kPjtsCkU/FsE722soV3cwxIVTIoypKHMM0Lvu2BR+9dqDQeC88nJTxRFjFk8v1y4tI
         Vj70XiGcPOq3Uok5tdipPGiJPUrI9ELK8nI1l6GQErXEsazM+9HXW+oJTU4vRVKkqYp3
         4lelkb5xOkIFbKJasgH+QtmqOocQk7X+nY1JQ6seyFYpI1VXmphrvYUhDSF11MQuHL4+
         26ljYPtH53oew1BR5vEzPWg9tvCDqxShrPNFABcBTVaZBhu5TNYTop1ADHRCk1ugFjP/
         heHQnxtLyo1bP+sOtVMyKH43Wi4p1bijqQ5S/OF9OcbSw8lQyNTGE/Irto6Vnh9EuSSA
         GOqg==
X-Forwarded-Encrypted: i=1; AJvYcCW14tqpDfMOiPOhTavrWVa2ok5m/182TEbqXrkIGWv7glYjX4Gpkg34IKQD/31IIEBZ8kKtS1DkDDtiaVcxvQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxMquDBdp8hvH8J8A9n/KAq2HsAbSF88DU8oD4oPJ2JvBkNeWN2
	Zr6Ldid0Tb7SlH0GnhieF+wQ/2y5pQAGmkxbsMy1uhg512b33TmF88J8Ds4pwk2YzFUm/Pe3Tb2
	sQ8eJwsw5+7BEge3x/N1fIuEhFZFVp8tqOViM8sTpWPNkDWRBOO+OpCdVexhx8/wcbSrP35zehp
	jKD00=
X-Gm-Gg: ASbGncuRMlHuSDC3VLuQBLLVMe4owZUidDX+Wxwp5XYL0XFfKuSa+GKkTVNKLf9FzHG
	7udRsrEMCCHdef/DxGdm2KxuprNHy2Uhp6TVAALKb3Z7kCu1K2/B5nWGAfiDJZQTFFLPix+wT8Y
	qgIEgLy23d1RkqfGJ+Mkd/W/h2zEy5GvKf9Uj6gKXapc5lWDqQKGLTUVUHyousYox1AYLWQDBcd
	RM32j2P4M0FVXiDctXWeGe61eV/ShxLCa5gThiuHJlDRVBiwOybECHdEJSHaQQHZThBaVkUX0ui
	z06+Ue47WwnSWj3fsPgQFKDkMMrRLxB/jtFLdl1zAc+iqBzmFk0X0GlLA0rag6wQ
X-Received: by 2002:a05:6402:13ca:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4d6ae3bd8mr12016397a12.11.1740992313683;
        Mon, 03 Mar 2025 00:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1UBws0o6Q6N8Or0I9EH2txIiXNDRTiXCawz1Rn521pIsbUD0YYXL9ZstVZ1QxNwfhidyhMw==
X-Received: by 2002:a05:6402:13ca:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4d6ae3bd8mr12016357a12.11.1740992313071;
        Mon, 03 Mar 2025 00:58:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51e1sm6716034a12.61.2025.03.03.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:58:31 -0800 (PST)
Date: Mon, 3 Mar 2025 09:58:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 6/8] vhost: uapi to control task mode (owner vs
 kthread)
Message-ID: <4rcrc4prhmca5xnmgmyumxj6oh7buewyx5a2iap7rztvuy32z6@c6v63ysjxctx>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-7-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250302143259.1221569-7-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FHjuxlI6onVKoLyfkIz8iOKghtxzTMSYH-299OMrkFw_1740992314
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Mar 02, 2025 at 10:32:08PM +0800, Cindy Lu wrote:
>Add a new UAPI to configure the vhost device to use the kthread mode
>The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
>to choose between owner and kthread mode if necessary
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> include/uapi/linux/vhost.h | 15 +++++++++++++++
> 2 files changed, 35 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index be97028a8baf..ff930c2e5b78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>-
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		u8 inherit_owner;
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+		d->inherit_owner = (bool)inherit_owner;
>+		r = 0;
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..547b4fa4c3bd 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,19 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device

Should we mention that this IOCTL must be called before VHOST_SET_OWNER?

>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1(default value):
>+ *   - Vhost will create tasks similar to processes forked from the owner,
>+ *     inheriting all of the owner's attributes..
                                                   ^
nit: there 2 points here

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - Vhost will create tasks as kernel thread
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>

