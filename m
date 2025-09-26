Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08802045B7
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900428; cv=none; b=oHyrPktoG6yWwIeSHRjImxpGzAMsVhtjsJ/Law/lwvI9PnRNYUtqyVgQXWxqlvws992I9/EIHTJlzE6yN04324GFFw1d6ZNchZuLaPq6OviNXgUz4+eOXE8iPZnmbDiORe1HR9qW9STat/y+D5XdmZBxT6c1dv/4+V/gYt1ORco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900428; c=relaxed/simple;
	bh=putA4/rNeFIhlYlD+QDvpcYKjCxUsRvh0XJi+VVJIXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IPyZjdphTPYoW0oGQSwgUSUc1fqDqv/4Rdqy5LJ23HDeGFLXZyqsL/w1ysm8FIh7laau8QxfKencT5WEetTJktfmNlKyAqC+z1AoGLN9zXlUn9wM3FOLjtMvp9eHPh6sI+DmI6qT1JWNTPYAFyMbYmTG+0Gzk+/Qv493luyRYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQa7fBCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQa7fBCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758900425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7wPkmWYHKYykuMdWFSPz0kKuHgglDc4DfacU/AAzVA=;
	b=jQa7fBCpV9BKxjDHQ6k31939MxuoY7dC0MvAe8cGmOb3KjiD71H32yC18HIOAYBEqiOZMc
	cQaihB1h5FiqLsLs09WMlVJETNqH1cWYsC0KUbs7twd4X2rzaycrpveKNddtUJ7wEnqzUx
	+MEoo5WvXuYoPUtpEa8U31qj54IRDUA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-ddL1DKcLNI2ILg0RDzun0A-1; Fri, 26 Sep 2025 11:27:01 -0400
X-MC-Unique: ddL1DKcLNI2ILg0RDzun0A-1
X-Mimecast-MFC-AGG-ID: ddL1DKcLNI2ILg0RDzun0A_1758900420
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e38957979so8250405e9.3
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 08:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900420; x=1759505220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7wPkmWYHKYykuMdWFSPz0kKuHgglDc4DfacU/AAzVA=;
        b=NN/LaGsrjIQwJpaREA5Vu75lYLiLKDeizOa84xJZ+qslpzCi/3ejVDPfb6si2cJ1Wg
         LanG/SH0snwYQi4qhNJt9aHwyvaEDAmAx4TpFrOCMoITkSAlwizG8fhMfoKWqIhhg7yg
         dqeBjMB6Wga/MvduX2Ki/cTgdkVjbpUTM5Bd6ugU9P5jt77E4kL3Cr6RUdMheYyYIiz/
         8uqAuOtn/0aeb/mx6PzXtkbU/5M/5VaUqLxmdsyUmLhZb2XNx4/hM1mwICe/cjLcQECu
         DeylfArdo8Yp2IuX4RrktCEcA+ppqxfP/kCBBr1zT8NKksjRld1ls0xXlWmyeEdavWOf
         sh0g==
X-Forwarded-Encrypted: i=1; AJvYcCUe7OT/DiHLWlyqUh/xxBjrYAt1RDqUR4MOwrpOYNMq9epN9iQ7kyvOC9SsKp04my9wfSZE0KHnDFCYqaN8tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN7eSvHO48gGg9QPP6uNXGhEl6SY5R/0XfU/KHKvBt8jXj8X/l
	vujePxmNouuIxvRfT+8TD/LvIHisp3zus217bmx38Fvy59yosZUNtEHMAc0XyIL3VA6GOeJ7gDI
	CfrQcCb6lIRcipye2qe8rLnH2m5ECXFnkUkEVT32NKuxCuxwIKSjXQ1DjlD4RsAYnflEZ
X-Gm-Gg: ASbGncuv1ddp8EygiGvqxOCc9327jQzlpCQUIWO/klUfE5p1ustsWMl4pLqCpMYZkN/
	RSzvWU1Sz2uc8K/ECMR9kWWQshDZbhioINntDL4CDa9OECh3+WJji4+uPx9eP0MFsInaZc5BrYO
	Ui6I8lPGqwCRcbMeEvzMTPj0WLd1i7KcXDo37BfFup+tUZLEz3LF7RB0ieYMR6Ev6rhtgsC0FIf
	rknuIgPsp3NnVvGMZGKHc+XGPMYOJFSVscBPozoYUvyV073qq0Xps2g1+/v7E7LXYAiblhOZef4
	0bnHvrm+rwKFIeky/tfwkE3/rQV3JeACtOU=
X-Received: by 2002:a05:600c:4f16:b0:46c:fc4b:89bb with SMTP id 5b1f17b1804b1-46e32a03464mr75193895e9.29.1758900420410;
        Fri, 26 Sep 2025 08:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEslyH9QMUF46P8aeQxsw5sQc6pwKJ1e4Ko7lKaWkOwfzXLsLJGOUtTaV5VlvftGoYlXC0gFA==
X-Received: by 2002:a05:600c:4f16:b0:46c:fc4b:89bb with SMTP id 5b1f17b1804b1-46e32a03464mr75193585e9.29.1758900419963;
        Fri, 26 Sep 2025 08:26:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33e3b300sm39364095e9.1.2025.09.26.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:26:59 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:26:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250926112622-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250926101432.2251301-4-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ye9CrfBbS2gV60KzFmJzYa8Sw2uO4-_gLlNa2r0ROKA_1758900420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	dev->device_features = config->features;
>  	dev->device_id = config->device_id;
>  	dev->vendor_id = config->vendor_id;
> +	dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;

Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?

