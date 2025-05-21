Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2C242D98
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819378; cv=none; b=hCoScbvbyo3KXROIrdcRr7gcnJPgRHCi05Hi+sOhEPFHBHFZ7q3kYdi+w5WBYF1D/D+kcxVHtZMz7JdSzuW7R3Sdt86FhBTLt34nZR9fuYL5M7Al8uKzQyXL2ZrFPRSOv6UNq/onrvM5ZXz2u1w4nssJbWWW/NMaULA8xGaO5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819378; c=relaxed/simple;
	bh=tWfk79mnWvNL/spZ1+LGfZxsdLe4Y1lpLgD/tXkao7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FG9rrU4Pg9Xw4LabBERgytjfQyGHJOzPFggoCnPDGZW64UTiEiUhBuRccy+E8LDO6dZA89rDhfW8cV/M5KebDx0zwZvac6NnZhsaazmZ/OBSIG7UBqCN1gGtAIKNd5cTO5Gvmh6R35H0vrHcKVnzrwPbWyEcgPciBGY56g4WMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTZAdXFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTZAdXFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747819375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZvTzAYTyZqWBe4fK/MLr2gUojvCNcxaE6qBL5ZF0mM=;
	b=KTZAdXFv4b/ouND3fh7Ue0CLDKHHYBB3WnQ3EOHpB0oL0c2i6V+XhQZ3E0DT7KdpcROK0C
	PTm62DbhpKK5bfggQqtasjwsadEj9KxzOMF2ppC/EMOzHU55VCWXFtd+TeBbG2n04BH1Rt
	Pq6zzZIuFfp+qw0cH5nrOI1+IEvkhPo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-inzIWkFfMo2cUdjBfBN7Vw-1; Wed, 21 May 2025 05:22:53 -0400
X-MC-Unique: inzIWkFfMo2cUdjBfBN7Vw-1
X-Mimecast-MFC-AGG-ID: inzIWkFfMo2cUdjBfBN7Vw_1747819373
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43f251dc364so14859565e9.2
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 02:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747819372; x=1748424172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZvTzAYTyZqWBe4fK/MLr2gUojvCNcxaE6qBL5ZF0mM=;
        b=Q+D2ku6Tkc1V0Qq8BXvH3iPd/lxO6rL9zFbg9lkQZ5YDRWBecZQgHsg/DMfT474OSA
         zlOyz9So1gDEaQGhlQ8C69xfa0CkQWCMo2K3RCBBAI06087Frd5IBslzLubpNyi6w4Al
         CigIfY9CO/cX+VBwVg18PWeWCRECAVmHUXQfbQPsGtP8AiiJ1KS2QKPVRIAia76Xn4xi
         qG4aGXA7+U/tWUYCBzLYCO3s4dVS9QHl7+4ayAdWLcaA+3VB5orvIDitlGHSBQe24GeN
         a06rT8X+f0A6NRVZ07A+L5hUN+qrshLqnTYYQx1C9T4Lrf6i3SDE2AWwXKgKBBjVQ2n1
         0kYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW34hkeE2Ug856DE2iTQONt7H6zszgRlRbZPh3aA1BUzBAsCOlMjEv2LUIMTs/m/8zcut3tI9U3h3eiZgkIdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymnXabpMuiO/Ne/jaHYqAPSlll0Dbo0W7aA671IU00B56QgdgJ
	HW+J3g3JwNRGacPvXhxztdQ4G6LBuJQcYx5xOBPX1Ai3tVBYhihz92EfKXAHmqVizzwFn4UsPL8
	dRUOfyexBMwO2kGcNac8LT3+jvZjE7jWruJJzlkC5/TvC0SFQuXK6CVg7YCclCFvLVck3
X-Gm-Gg: ASbGnct39aA4zPXxzEsmQg5e4o8kota0eWI4FiA/gBzY8eine5fb/9y7Pm/TFAcz752
	suJ74w0Pzyh3qxWDGPeeR0I5z2kCjggKT4jqtAtVrCz53Z6GyT0LwNhe0gu6CHxz35cKZBAyOi/
	TYPYXMTT+wJmcF3lXw1a0JDfsYt7fbPDwEFmdZlRlTNepJBrbezaXWnYKw2fRRXWMspI/Nw2PGf
	de+exi3xfvpA86QCoJ4uEQhRBI7E4Hik2oQ7E0jxPBLLmwqILvjw1iygRhgzcgPHVJvfMcJs+VO
	J0sgrQ==
X-Received: by 2002:a05:600c:4706:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-442fd63b22cmr176798045e9.18.1747819372634;
        Wed, 21 May 2025 02:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBL57AdpBfDWr4rRpAMfgCHlomkA0vufcKUCfL7Opz3DpoDLZ6aZkFarWHJc8jzn11c6FS3A==
X-Received: by 2002:a05:600c:4706:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-442fd63b22cmr176797765e9.18.1747819372285;
        Wed, 21 May 2025 02:22:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm66003115e9.3.2025.05.21.02.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 02:22:51 -0700 (PDT)
Date: Wed, 21 May 2025 05:22:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521052213-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CY8PR12MB719585BEB8E62DDB228942BDDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB719585BEB8E62DDB228942BDDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ehB8tGQIN3Gl74ChXuFy0_eO0nYRSwlu4lb_6BJtiw_1747819373
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2025 at 09:18:29AM +0000, Parav Pandit wrote:
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Wednesday, May 21, 2025 2:45 PM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: stefanha@redhat.com; axboe@kernel.dk; virtualization@lists.linux.dev;
> > linux-block@vger.kernel.or; 
> 
> I had a typo in the addressing block driver's mailing list.
> Will resend with right email shortly.

let's figure out what this does first. it looks ATM like it papers over
some kind of bug elsewhere.

