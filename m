Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B5194137
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593538; cv=none; b=IJz/Rxnf9+WGz/n0yMQAE+rtzQZJXI3HbTkTNshogVZVHkORHq5KuZcWbPgn7oWhtEpohHBF/xDJtszHIzYY5dtEhqns9IvjPzN1fS5bHk7eN6YSNRWcfxlqP8volrLT30JrZ5tzGga4JviWDpugUELWJg3RrgWBBDLV1gp46A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593538; c=relaxed/simple;
	bh=r2fTEOjoFnPVv1x53F0vcfkzpwq24TElbV+k62WXsaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WqxcDTP2ljGe9sblCFcPYRDUnGGI8tdNvT1Rzag2xidf5NBeECTypwGVcqsT+aBk382O3zPFD51hnxj0Rq3AU+WJ4NR+MIELg8ubn4YA5vCXQEnZIL3Cqcrj3PTJWR6oLSScBxUN8kBMnrlIGnF9B/tDvToHdsb67F0xSqben6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA3OZZV1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA3OZZV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760593535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hln+Mh7y31shW7LFq2Q8UORyGgt35tPk5kgAnX1J3oc=;
	b=GA3OZZV11ALYcNlCAod7BT2crmTZS8AJxHV2XOHlWlDj45S8FKTJTDRxEtAUseIGH9CaY4
	HQs4RwEFQvDX+GDK6g6dZzviSrXF+15c8lT7sPWqDn1ojmXoNPoVP/CJK0peOObX4JYXOt
	qN7i1j8pampjKLU2/JMhQ7VhYPF475w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-p7xi9PusO-yR2kDJLiwPZw-1; Thu, 16 Oct 2025 01:45:34 -0400
X-MC-Unique: p7xi9PusO-yR2kDJLiwPZw-1
X-Mimecast-MFC-AGG-ID: p7xi9PusO-yR2kDJLiwPZw_1760593533
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso3062795e9.2
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 22:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760593533; x=1761198333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hln+Mh7y31shW7LFq2Q8UORyGgt35tPk5kgAnX1J3oc=;
        b=FLjZWtxBo1/TytFciBagsrAr0jo3lHvyRuer4E0SxmI0pfdO4/6qxN9ZZ6pA8X9RHo
         Dz4ggCJ6iefednXcOcrqILP0L36NPbsZnRWOd3nZLjqXxHhFyNB6M85qTJbwXxn4kvs5
         2V1xZhjI9/C5//Erh/wT+45YqD3VZ4N7C8X1pkIX+pKjBk6CIvtutWkfKoO6GFHbzGB6
         zvdqOUOyOoABWAn4gVRWEpO8c68+7OU0KXgQ4KlBxDt063MeqZ6AaosCmfjy0loj2Cte
         7uCryCEREpqHX/smfP7kdcjy07Jyna1FCa1zhlHcXatCxwZGAUveG5CgbG1R4anjY9JC
         C1fw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1qlcEffA/o/gDjyu/FgXjy93xf74/TrB+ezHth3t5B6Y6N8XauVoih62d9TS3/dZARC7kVf4UG7zbkLpwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi2Ad+AmXr3jH4ypppcGRvOCCz1f7iip4x8Ks4apH1ysvTZh+3
	c4QWO8biIRYGoEXJ4fKDj5OoGTxMMZMgMfAkJWAa1LY7w5AAxkUjlU4xpd/x4WL88g1NqYAy7Gv
	f2o2Cn0/7xHDlxhLhyrGETwhBrAS5Y0+6iL571vn/X++0ozDnmbzappAaQAh1R7i20qMN
X-Gm-Gg: ASbGncuntEg2k85q4c78uQX09ZtuJ4k7Gx+2yvUsyaW6MsP3mOvnazqFN00PixlG1D7
	gXGr+tx10JuVC5IcKfvOCGjVWPcwCZ+xawA6msjNFcdSN2ssJ9dsU/Kg2blGYYA6HWTYlRC7C9g
	nF33HOFLEdkPOkLb0EZaaWcom2IYGzYuJA8+uW0IA0s0B/UcYm0PrdMYvQ/xE5qNuOJyJ9+HMDW
	zD4QwLe1bdd7BwTjtGc/Nwd4IWGKyuI9HDMXus7ujmw0cbC6z+7qf0YTX7Kj81npjGjW2TXqD51
	Yzqa16rBlJWwi2+h4xFMnCP8ojaZ1P84lgpGKgXv3x38kmsQTSA8weUR5hJvxvlAqSay
X-Received: by 2002:a05:600d:a:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-46fb32e4c1bmr146181605e9.1.1760593532914;
        Wed, 15 Oct 2025 22:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm2++Ga7HqP6xO8R+d1IdvHTPsPVi8E4+KUc/IBWMBsgRUIWmXYBIDUaPDdGLmuf07U44bfQ==
X-Received: by 2002:a05:600d:a:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-46fb32e4c1bmr146181465e9.1.1760593532483;
        Wed, 15 Oct 2025 22:45:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm32099660f8f.35.2025.10.15.22.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:45:31 -0700 (PDT)
Date: Thu, 16 Oct 2025 01:45:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251016014328-mutt-send-email-mst@kernel.org>
References: <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3BF3BEtXVkXcNV0sjStwIyitjlmTA-sxPO3_RxmeR-g_1760593533
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > >
> > > Not exactly bufferize, record.  E.g. we do not need to send
> > > 100 messages to enable/disable promisc mode - together they
> > > have no effect.
> 
> Note that there's a case that multiple commands need to be sent, e.g
> set rx mode. And assuming not all the commands are the best effort,
> kernel VDUSE still needs to wait for the usersapce at least for a
> while.

Not wait, record. Generate 1st command, after userspace consumed it -
generate and send second command and so on.
But for each bit of data, at most one command has to be sent,
we do not care if guest tweaked rx mode 3 times, we only care about
the latest state.

-- 
MST

