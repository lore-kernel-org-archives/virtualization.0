Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EC156D1
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhO3qZ24"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33E3C4358D
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33E3C4358D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HhO3qZ24
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.091
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zgmw0fMTMTpC
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 09:52:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 597674359D
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 09:52:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 597674359D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701337961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syzny7hYQCh/DH3BoavsbNlrR+AhgJLrIIbJQwb1FFo=;
	b=HhO3qZ24wD3MjF0c739mmxjtF39YylKWS3PUL8c23wEXiCrJVtGW23ztgldQ3uhB2DtvIJ
	/mpijjAfJMuzz5O56boFwKid6WqTzMcRRWUOV0tvfCfo4GrBYLDAVwbsFjwSX+EQGt4ku0
	yDU7L07BzfT72u5eutfbA4TEiUOEIM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-YclpHTvCMSKNb4I9SU2kVQ-1; Thu, 30 Nov 2023 04:52:39 -0500
X-MC-Unique: YclpHTvCMSKNb4I9SU2kVQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332e06036b5so761813f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 01:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701337958; x=1701942758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syzny7hYQCh/DH3BoavsbNlrR+AhgJLrIIbJQwb1FFo=;
        b=irbE/4W+Rz5PHSZKjVYy54re9mnAHQ6WYeFXXIHIxpOqXtLUwN6mdFpwTb8lzzhcvr
         4mhJzW63TRBbJHrqL57J1gdf2OiaOtodIst8t+Tf85uS/9Q1laZAUeLgf3be8ksxuRYq
         s7Qv4pekAg2oWRYWIhitePf9ri+02F/IF03KjXhvyI2qym9KpF2o66m4oyGdqG62+VBo
         LLvB64NrMj6WPogosiQfIvC1/flYTMrC1Dj74yM26UzKMpV44wlVnsk78ltZahHaEU8b
         b4ZbtJJGbdJtAE2wt6F1vzmXwFvd9f/hojuEQKzDP7wOVokSs8TE5t4YKRc5ZRMjTZyg
         0zxw==
X-Gm-Message-State: AOJu0YxKvzJGO3ZHkWqaed4iD6K15Ks0tmreRLOrJlHk6a2h/Q5QxviZ
	XIajLuj1U/HisvnOwxy8DJNaRIdvtYbpR58zPFETYSh3s5sBJGEDDM2TzMQWU21rsRxemlm8Lfe
	u+bEF59O3OS3JqWD0qBOIAy+/liE+G4ywMISwXXseyA==
X-Received: by 2002:a5d:6750:0:b0:332:ee15:7182 with SMTP id l16-20020a5d6750000000b00332ee157182mr14800390wrw.11.1701337957908;
        Thu, 30 Nov 2023 01:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOAPePhLEf8K1B9QypzK3aIQgJmwveh/+E4piPyr4Plo37pFs9D8biAp8SlmNK5YCWYRNjZA==
X-Received: by 2002:a5d:6750:0:b0:332:ee15:7182 with SMTP id l16-20020a5d6750000000b00332ee157182mr14800369wrw.11.1701337957582;
        Thu, 30 Nov 2023 01:52:37 -0800 (PST)
Received: from redhat.com ([2.55.10.128])
        by smtp.gmail.com with ESMTPSA id w8-20020adfee48000000b0033304787251sm1024857wro.17.2023.11.30.01.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:52:36 -0800 (PST)
Date: Thu, 30 Nov 2023 04:52:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: alex.williamson@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	parav@nvidia.com, feliu@nvidia.com, jiri@nvidia.com,
	kevin.tian@intel.com, joao.m.martins@oracle.com,
	si-wei.liu@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V4 vfio 4/9] virtio-pci: Introduce admin commands
Message-ID: <20231130044910-mutt-send-email-mst@kernel.org>
References: <20231129143746.6153-1-yishaih@nvidia.com>
 <20231129143746.6153-5-yishaih@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231129143746.6153-5-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2023 at 04:37:41PM +0200, Yishai Hadas wrote:
> +/* Transitional device admin command. */
> +#define VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE	0x2
> +#define VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ		0x3
> +#define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE		0x4
> +#define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ		0x5
> +#define VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO		0x6
> +
> +/* Increment MAX_OPCODE to next value when new opcode is added */
> +#define VIRTIO_ADMIN_MAX_CMD_OPCODE			0x6

Does anything need VIRTIO_ADMIN_MAX_CMD_OPCODE? Not in this
patchset...

-- 
MST

