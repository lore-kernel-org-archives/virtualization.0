Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78609F9E4
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866549; cv=none; b=WMeuqKuOg+705yjIXndTPaH4Efg3RU0jjYmV7mm9DpyeSs8H9oTtc41sv38sOeYQTm6Z6SYdm5Es79f8GvKUz3Wf+DdcIt2tvh3Uyt4eetuc2aZkjMkSrPorRp3LqqvTok9/e8gmrWHemF2RRUQ9itJaxKmoM5FOnR0TnWqFgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866549; c=relaxed/simple;
	bh=v8KHIVowavrReQh6LGJtY46qvZZsa1RSICebZfOLOS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DOIhnVwNKWCzuGkofsHQDEGkQ8u8AzQq3kzEux38GoPay4ebFUwtYNie/vyE8xNCojzxl3VZ3arJqIRCxTjZhmIBG2DyOE3D1AMm8Xi+ux21HpuOSUHqK/r9nTBJE87G3TUxKPLbQZFtN+MfSC3M7Va/JFOVFcJbzO7ZRqSJZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOt/sCoO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOt/sCoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iC4PRtD8q87eeIqoTubF1XQ7P/1Xs4pyx9aYzwfqjx8=;
	b=LOt/sCoO/pL2EExyQ65RB/jajybWefr3aKPbx92QfX2DKEPhKsMWsGZU8JmAKwdmtZX0zE
	oypssz0PRs+xxjEpjjZGoQnn7bNwwyoQJvn6TJXYYKiXnfkvQZwsyFVHZqiQlA/oOXtSBh
	GyZU788Dlh1oYe6MC0KSDeD0WFnvUGU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Tb00BzqDPkKbTNojnSdQng-1; Tue, 19 Mar 2024 12:42:25 -0400
X-MC-Unique: Tb00BzqDPkKbTNojnSdQng-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso149485e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 09:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866543; x=1711471343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC4PRtD8q87eeIqoTubF1XQ7P/1Xs4pyx9aYzwfqjx8=;
        b=ZPJ7PKuzAR3aXZkILVz9FGS5yPtwghvvNxvdZFQkP/XIwTvcjJ/7lVZl0J1tOIEPDi
         RFQ4S+tRDxULIusKbT020SEzUiphRAabzQa4RfIGwiJqYilfNzC03QtzA0iBdOm2VIDl
         AJ3of2e0rvlNxFlzpv3eG78JvzQPUVWl3eIbmgD3MBuhSolLO6cNFW8KjaHpmykIegL1
         KvE2Yj73YnuXvEh6x0Lf7E65J/aTlUq84R30W270U7D+RD8VwcxVAFMkCbIRckqrhnj1
         rqmIRbvTLfa/xZjbkWFdp8qRre4l7GzznomY9IhzmNxgpy34TTIer0zHHR7T7HS/k6Kf
         WyWA==
X-Forwarded-Encrypted: i=1; AJvYcCW8miXmEWf/1wCTC6wIr5QmUKaRfMKI3PTXh9iwlRKhh33WfH6eB533Etp6Akmj4G/h+5ulIubitlEDlEdLzRHNqU1YnLUSzUx2sqEyLXo=
X-Gm-Message-State: AOJu0YzvT53OaM4LxXywNfAMysPtG815jmdTI2hi2DcKJjSmMvBJkPL8
	7iAEqDnhYmWdBEcIt+hFrIjrn14gSRmZs0Q0U1daaS6NrpuxvO1grKeLUuhKTU8yyMATNa64IYN
	GYZYraH+ceNrDSXdd4Wi2K8ouizFQxKSEp05e9ThpMq5U1vuv0W1Gv5AKlOc7Qjf404wnvc+y
X-Received: by 2002:a05:600c:512a:b0:414:61d9:d1f5 with SMTP id o42-20020a05600c512a00b0041461d9d1f5mr3295wms.10.1710866543341;
        Tue, 19 Mar 2024 09:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+mZXbHO3NfRAuEQSBJcUrJ408cXE9+MbCsCwP+Lz+VAKy+qOyXG0eKDmH70U3ASUNJiSUIg==
X-Received: by 2002:a05:600c:512a:b0:414:61d9:d1f5 with SMTP id o42-20020a05600c512a00b0041461d9d1f5mr3277wms.10.1710866543020;
        Tue, 19 Mar 2024 09:42:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b00414659ba8c2sm2388429wmq.37.2024.03.19.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:42:22 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:42:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 10/10] vDPA: report virtio-blk flush info to user space
Message-ID: <6yootszzjfjht3xvi6gtdoyvcxxkg4twvhvk6hpoghyvjbicgh@dgv7vgkiof6v>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-11-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-11-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:56:06AM +0800, Zhu Lingshan wrote:
>This commit reports whether a virtio-blk device
>support cache flush command to user space
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/vdpa.c       | 14 ++++++++++++++
> include/uapi/linux/vdpa.h |  1 +
> 2 files changed, 15 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index d6fd3cadc44f..95e1440dbfaa 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -1095,6 +1095,17 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
> 	return 0;
> }
>
>+static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
>+{
>+	u8 flush;
>+
>+	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
>+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
>+		return -EMSGSIZE;

Ditto about name (VDPA_ATTR_DEV_BLK_FLUSH) and type (flag).

Thanks,
Stefano

>+
>+	return 0;
>+}
>+
> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 				    struct sk_buff *msg)
> {
>@@ -1136,6 +1147,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> 	if (vdpa_dev_blk_ro_config_fill(msg, features_device))
> 		return -EMSGSIZE;
>
>+	if (vdpa_dev_blk_flush_config_fill(msg, features_device))
>+		return -EMSGSIZE;
>+
> 	return 0;
> }
>
>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>index 4be8e3a15874..43c51698195c 100644
>--- a/include/uapi/linux/vdpa.h
>+++ b/include/uapi/linux/vdpa.h
>@@ -71,6 +71,7 @@ enum vdpa_attr {
> 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
> 	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
>+	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
>
> 	/* new attributes must be added above here */
> 	VDPA_ATTR_MAX,
>-- 
>2.39.3
>
>

