Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49178322B8B
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247759; cv=none; b=j5Yv/ivVaksh0XbW+1xjXjjaPOQIHCjMm9VolpIRZfKAcFfXhl4wJaRraPv6t2+TaDkcAayass4KXKlEdzMw2yrYRp72fPy04IpxZzqcPxl48Alkc3RnZwzo9MwPMBk/PPE4Bdkwx8Q6Hcpp18oI/23k+f6zTAcEohnH1WijhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247759; c=relaxed/simple;
	bh=rlMGampVDp0YIGll1tLTj9NVvm35RvFlPgNesXtWOD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mYjU+KCU3zQWw/XQD1f29gqLREmi6b1oEQdxZPa93/KhxGWRSwSbKAF6kLEUtsct8GAe3x1hArEOstLlPNecxy+8GjmZRPPMu6jMi0kdbL/J/b6ZN9bJQ+2zM8tfgNZC0+PEnsJqyHDnnz/UWhJ1qifFYqW/vM1PJcSFI1O7ylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOTwW674; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOTwW674"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776247755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vvo9PwYF5/HZcVX5ikHCtd0bXq6FhIIgtMUlL4J41UU=;
	b=hOTwW674C8O+DyOPqgvjReqzeG492Mol75Q27hOvodTNbzUWs5YiCOYG8/6PPAtV8S1KRp
	O0PV+CSRbeo8ma54OyMDkiN3g3adpku1KYMJuXqJ2V0KETkqDiJtqe83SMYwHJPC5nc9JZ
	pzqcbUkDvE7+wxF29hjpc3J4qViZX2o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-ZP8nIBU3P7a_SS0mrZffFg-1; Wed, 15 Apr 2026 06:09:14 -0400
X-MC-Unique: ZP8nIBU3P7a_SS0mrZffFg-1
X-Mimecast-MFC-AGG-ID: ZP8nIBU3P7a_SS0mrZffFg_1776247753
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43ea728e38cso1466178f8f.2
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 03:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776247753; x=1776852553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvo9PwYF5/HZcVX5ikHCtd0bXq6FhIIgtMUlL4J41UU=;
        b=KqaKVPm9/WOeVDVkbqqNsrDnFGZ7jqv/djgswwuS+2f6RLlcMfk5M/biwPFNih1slO
         Yg4hr4MSJ597zi3EmJ9WQ3IV9sMY6fS1fa9vddtpFHqi3DMpBbeyR0mK702eCSu9WO34
         F2X4bW4lHfImEpOLNwlFMeyiZO3uyLXuSKtsZYJJpS/0tktma9WiMZGFa/gyOF71pye/
         60Ho0MIYIzYvxcqVcahh130gTAdQq+zhY7cD8MRx+gehWBKhWIVKBTq18ISFRBuybVPW
         3vfnrGIaa6oMgvjGvDDdwN4Dy5Cvu3diZoYKbQNIYf+IWH11Kz1IaChmq6EaOomFrXGS
         EU6A==
X-Forwarded-Encrypted: i=1; AFNElJ9gtLTWTjMHI78l2v22Uc+RMBxV9sPgKfdPL/EJGFlZV7aPiWZj7prB32CKjm/inPkgRAZxeMhQmOhy7TAfiw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+7IKGZWxOLI2W5GPJD1+gJfy4fb6esH7dkanre93oJkbITFqf
	pwLlj8TJJpdbeJAlJa3z2HPTGwiI9a60hnZPfgmSGOmZjnwcRSe116yaf7X6YsEq0v5u493trX+
	hW68f4zbTgR/MRH2VfxughbCsQsrYTnzs3eAoQrKrP+PsfQUn1GrgOFOslwF65RMIrNsY0A4s5J
	Zg
X-Gm-Gg: AeBDieviot2DB2i4kOxxh3CjOynTWmf+Baz7f9aJFO2smAatRb4afle0cqtGssBqp3e
	B+0dHWyGi7X0F5CLTwzWBbceYyp25fCWlO54kk8REOYZvfzwCfXXVn/TanTTtnoiuW7FDQF7AnL
	uRoK+KpGhu9qCI2dwxhTxH0jk6PAGTuS+oN577todxs+j8ikOG9lyhU0D/zlEgY2qTTdl/02CcY
	2IYEorQr6vCPOHq5IaKChO3TWq6QfzbjyajXM+X18Jg2y1lvPoC3xSDpdqyVkDRvdssalyMuhx8
	ycfWUqGN00fPaNc5/LOZIpYoJ+pSuYTnDRVsq4SQlqYXeuJha3XTRYEHo/qcOxiom087YDZ/Elu
	XsSJ/zqJHUfT4RlnMtIagLY4Yni/HCJMBSsO0vVC+Puc=
X-Received: by 2002:a05:6000:24c2:b0:43c:ff58:35c3 with SMTP id ffacd0b85a97d-43d64294ba3mr29697462f8f.10.1776247752612;
        Wed, 15 Apr 2026 03:09:12 -0700 (PDT)
X-Received: by 2002:a05:6000:24c2:b0:43c:ff58:35c3 with SMTP id ffacd0b85a97d-43d64294ba3mr29697407f8f.10.1776247752037;
        Wed, 15 Apr 2026 03:09:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3ebaf1sm3744173f8f.33.2026.04.15.03.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:09:11 -0700 (PDT)
Date: Wed, 15 Apr 2026 06:09:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	marco.crivellari@suse.com, anders.roxell@linaro.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] vduse: Fix race in vduse_dev_msg_sync and
 vduse_dev_read_iter
Message-ID: <20260415060902-mutt-send-email-mst@kernel.org>
References: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EU3NKlw6uhb3e7OMvYpnRjXtrwUMMXSzT2gaYhJ1qnI_1776247753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2026 at 07:55:48PM +0800, Zhang Tianci wrote:
> Changes in v4:
>  - Simplify code.                                 [Jason]
>  - Add comment for rolling back.                  [Jason]
>  - Link to v3: https://lore.kernel.org/lkml/20260202072655.95143-1-zhangtianci.1997@bytedance.com/
> 
> Changes in v3:
>  - Add first patch.
>  - Link to v2: https://lore.kernel.org/lkml/20260202031212.26871-1-zhangtianci.1997@bytedance.com/
> 
> Changes in v2:
>  - Rewrite commit message.                        [Michael]
>  - Add Fixes tag and cc stable email list.        [Eugenio]
>  - Rewrite one comment.                           [Michael]
>  - Link to v1: https://lore.kernel.org/lkml/20260130081524.81271-1-zhangtianci.1997@bytedance.com/


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> 
> Zhang Tianci (2):
>   vduse: Requeue failed read to send_list head
>   vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 43 +++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> -- 
> 2.39.5

