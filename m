Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F228313F
	for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646621; cv=none; b=cWt3JGMYH2ima69qjEXIKv6V3aFd4cv3YCeTD16i+M38gLpVn16tvP3SbUBNahQjZv468fDEmQoxmUgFhz8oPlJ1WIcdOIDymHv0yC1uSm5eYcwziHKdtq8glMn+1e69mVaXe7aLaqKEuHiTvm1ghY9FlrMJxGptM8xXnyT3FzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646621; c=relaxed/simple;
	bh=WFBUbKMMnKHZdjkqyPfepwRYRaY3PMbvKPZrZUg2BWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSoFtxo0pQcWv9x2P7AR1eS2Q91t3RGnM5AH0zcG6PljwXGH7gH/w5wCYkgd/nHuuVS4wS/kifi13/ZH50knXwUlDCJN058F/Haf7+ohAtzyEEyt1radCSK8GbczssM3QODjnBD3cJ2fmKhuoFliZU9IusFbO4N4D78XVE+OSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vWW5GLgK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vWW5GLgK"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3db7b3de375so55523395ab.1
        for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749646617; x=1750251417; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=vWW5GLgK8FkFeQ07lLoOrCCYS9l9ZZI3sLHXF+cWKS49RrWeyLYqfDLUJOu7xTiodc
         uZdZWv+0B6c/vSUFAIaZspj1AywZclAzUYK821HeTME9PG+XFsGq+7vMSjw7lA/K5cYw
         vSdviL/ZSQzpq7yymOR0Vg2zL47cjUEqTsgfPJaoTyehtkTGSF0YkqvxtiHszYaN+IIR
         5ImIuER5nN1ZUNBep1Kjt+2YrYIjmJQxhe7zqvO+s/YIuq91Bd52CJpvGMmNXS6ECmH8
         nmxv8qS0Id8TtSWxEPFVc98nKNsyKxoS+tcGRUZkca4c9u6UPMdWNBHzN/CaPVGBzaOw
         qIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646617; x=1750251417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=pFp+YJLqhG2QTEryI2YBjE0sckMevBqNe1ClevqlDUM89VUSHfVcYPWZDIrKso2EQt
         IIxDLWN4j3/Qd1Shy2AP/8rblcU/nbsYCJsOa3/DWzCDa51/ZkWLGfA7ihuixMX/pnOP
         XGnYlf3JJqWB3pDEgqhKLpJ4Vdt9edQF8UcsorUFVTtMRZLNJuBahQdcVleg+wLrv7Nn
         kKlBA98I5txgRozznSuqdxK7x+aVpDFrQ5s4tXbHQLLRRCO2/TmxpjqMwoWf3UpshaGh
         BsJWLO6B2frgTqUOnQRu/qYtFym8jDIKBt5LsIC5l147emI6PG+AGX7t1pvsK4CIcxom
         E5zA==
X-Forwarded-Encrypted: i=1; AJvYcCX5qRrG8X64q+MEv0frfz7ovfGu05e4pDdaHQFdLrCf47UaOz1rzYUciA3zAVFbkD62kNixrkrV6xnvNI2LTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk31mpa0x60DWve9IYg6nYulOx1Yhz9Ayl+Lg0IMG5Yb0XcQ6w
	b2bLmfwVS0otzrVMIbTqFpbwPjW5TYarYj9qwxRF6vdwKqcOrbKImsGaGglA5RH80b4=
X-Gm-Gg: ASbGncsUA96KD5gkibrfnRRzKM93hSYcnI0gnsZriDvoCm1Ug03EPmyzJ74U8Lva2C9
	jySPxllr82YzIo9Y1j3d/WG/bgoIFYy3+IVtxpoEvL5hI/z0fD1pQTc4AO2/q/eymdHDl312C1l
	Jgo2Ct8k0aO0kQCcFB9y9hxBblKCBoaXZxZjKI/HXTTdFvOAK567B0bT2NzBMjn+uHPc/ZSHJ0x
	cnl5DkM7TxgYKr3BKFaIOnx8s4vKdvVtjWyYC3QBIqW9q60/0ggPjj5/9KbGpIgvfKjLGP48cCb
	9dVt+DFSzwUs+rW5yHFHu5159zIaKwU1/BCNGfpa0MB50EmQsCYfjpMHxNWsT5zOkujElA==
X-Google-Smtp-Source: AGHT+IERz9UEhN3gPoO6s9ZO+TGganlwoJirBS1zd34gle1XGHdmdK7NOLrIX/f0q//+H5iwkCSLYQ==
X-Received: by 2002:a05:6e02:12e8:b0:3d9:668c:a702 with SMTP id e9e14a558f8ab-3ddf4d5d68emr25015895ab.9.1749646617386;
        Wed, 11 Jun 2025 05:56:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddf4768c0dsm3851505ab.55.2025.06.11.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:56:56 -0700 (PDT)
Message-ID: <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Date: Wed, 11 Jun 2025 06:56:55 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 6:14 AM, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.

Rather than revert this commit, why not just attempt a tail merge?
Something ala this, totally untested.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..708ded67d52a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -998,6 +998,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
 
+	rq = plug->mq_list.tail;
+	if (rq->q == q)
+		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK;
+
 	rq_list_for_each(&plug->mq_list, rq) {
 		if (rq->q == q) {
 			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==

-- 
Jens Axboe
