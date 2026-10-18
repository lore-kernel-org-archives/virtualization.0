Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CE41CB5C
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351490; cv=none; b=drfZ+P5Vn3aAXr1SQmquROesV+rrEgj0xJrfzz6KYXeN9i4K2PGFmMUkG+uEfollfvUEGkBtvw+g0kghPm+S0mhIerlg6n8VFxQNH2OEmgIlwGONkBNOljdQDJCV+70y7feT17H/4LK2Jwzwv2xw+uO8b+Ko7867S5xswJxnvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351490; c=relaxed/simple;
	bh=YuTSyzPwXKhPhZHoKxzOloJV3Vz1FrQSyVr0HWn8gug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fxxGBQVWXMGJVSPW5HtV2LDp/GJS3u6YMHapqhRB+Hj0Y1knoFcvlWxdZak8iav2NqZzJBMUXemmroMO2anAraJMwJ4NyM50XRdCOxZpHmFYTnZq47Ju8esBFSlG9B6Xu2Hc0EkVnLZ4ASe8rftkmVkyJFC+3F7mshCp7d3hhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvTmoXMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvTmoXMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792351487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
	b=ZvTmoXMYUpvEjlH1oWzYkHmdsF5OqgAYyqyE+suXUaKHJXlCBSnJKzZJNh5tSghwjm2JA0
	CaE3y+hWJlNPn8DLq49wV2d/swujG+m/YM/LB1ndDuzDZUkPy4NqeSHgwBABQbp71nkfLM
	yNbH8atUBAhSW/kJd3NJSOIGyJXMKPQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-x0l6Ld6TNFaxM_Gg28jF-g-1; Sun, 18 Oct 2026 19:24:46 +0000
X-MC-Unique: x0l6Ld6TNFaxM_Gg28jF-g-1
X-Mimecast-MFC-AGG-ID: x0l6Ld6TNFaxM_Gg28jF-g_1792351485
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1e295b702so5922125e9.2
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 12:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792351485; x=1792956285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
        b=YUr83Mvkst3i4hf2y9EXf2+xY6D83/afiZu611/NwcSiCThNK8Jv4ytGX2f9v3U2Mq
         NWS8OjEhJa4R/voU91IFaEpG0EQr963jMAANKu5rPXEBf2JAueDEOgsYN/kEuBmnTlBN
         t2JIBz8+QuXUecyV9CaFajULJH1lEE36Lwd7wjBvrxLK+nVzYKQOOLXLrXOrmHONbin1
         IvhuAiRmk7OstZzIXCFCV6AeUQv98eKgkP86S8lLnmt6I1OunFLqThj6fuGrkYfuAaZc
         Sdj5gWX2yNZjJaZjMw4PZkcqXGHbSyT8yGX53124KJY/+LuuENV3m/UW/C6h+Rnu822Y
         GfXw==
X-Forwarded-Encrypted: i=1; AKwUvBy7gNimYvwlBql/IIgNvONbOwn9STFNppc4QlYpZtUhJHrLqbdSGM6ajKuTvTFGqV52MbqxhgqoZrfS4GiDxQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYI+xqcdPvzrZ8CQp0ki4f9Bxu8fuLKleFCXxAEVw4akqm/k23ng
	b/WQ6EZx/JBgtabWKENlWewlcAe77lzhHWCtRNxopj9ZmiXqIxXppmTTp3ZXy/LfcLuBovl8GaO
	5UwXGcHqVeQXZRoKnxj7hFOK8g2VA+j/+Z6tHiL59gRZQA4Dvp2HfHRUAzSxUjvOaFmh8
X-Gm-Gg: AYBFou1Vu67NLKpCSew3l6un3yzhH/eaUetXqaZ1LB5kN362jJXmyHw23wmD4JOrgXm
	4YX2LeCyosraxQEYMkXfhIrVJbAORTFRfOt1ubdLfgYcnOzkOMA8lUwDTQKEAsBwU5lN0jXa70u
	ew+K/1d13IR/bJleBZ3Rv1mIo4kIMv3uyiOZBpqyT7JMdJrNQp3kc0YAHEHx+as2lRNorvInf7w
	hff3bIOuGb7CNwzm6v+Q/KiX9SdpMYN7zAb7imupHNI/z6SfKSdOPQ99n2HTl35V2RtjdKt8d97
	REAjU/jtyL9dvIWh/Nx4k7dySklmKZ4B4FogBH0AO1RYrbM7MHMOOdCYYlrywYmrehsm2w==
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr91473575e9.24.1792351485142;
        Sun, 18 Oct 2026 12:24:45 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr91473295e9.24.1792351484626;
        Sun, 18 Oct 2026 12:24:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d30d778bsm207005645e9.9.2026.10.18.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:24:43 -0700 (PDT)
Date: Sun, 18 Oct 2026 15:24:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018152358-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WYb32pzo42WA3w9usExSmz3CEBrMVsMxwLrpdszNRRo_1792351485
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> against the 7.2.10 source tree. I have reproduced the leak on an
> unmodified 7.2.10 kernel.


This should fix it I think? Can you confirm pls?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vringh.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..4b097170bd36 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 		return ret;
 
 	if (vrh->use_va) {
-		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
+
+		if (!access_ok(uaddr, sizeof(*p)))
+			return -EFAULT;
+		ret = __get_user(tmp, uaddr);
 		if (ret)
 			return ret;
 	} else {
@@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	tmp = cpu_to_vringh16(vrh, val);
 
 	if (vrh->use_va) {
-		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
+
+		if (!access_ok(uaddr, sizeof(*p)))
+			return -EFAULT;
+		ret = __put_user(tmp, uaddr);
 		if (ret)
 			return ret;
 	} else {

