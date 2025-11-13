Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2880334C36
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026497; cv=none; b=iBeDpwI7ow07Gxs1QUDkQUBkScIEjWNXNxkE1SGRrWfmFFlnL1xKHQ57aZr4bvGvO4ccOdxYwIzLn3vK/X9rG/vPQZIOvQXwR7GTADNJsKJYJF/+INzN+zUv8Jraqt/rZGVxgShID2a/QbNKnbnT6JUAUy52mOG8a5/uuLt1WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026497; c=relaxed/simple;
	bh=PsMX5azptoPCiLjD3aMiz5hio74WlY1qb2dfxYCfrpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uZr6WxX6i6QK89Ba2rNjMP9wPHc0K7lKKQmsaPMccCQcssHGnaKQmKU2n/B+CIAKqHFGLk9iAqTb4TePvS8aV6sb7dhRGagkCQNw0dXKxnFeL2jkynVQPEO3gOeO0NgEUaKek3OvQq0KbA7k0hPt8h7bJJU40E6MLGtmgx7lYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ex8aTVOo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ex8aTVOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmEXxMQNcr7Ao680eVcUDXmbzW6uxx+W3/652jHTtt8=;
	b=Ex8aTVOoVg0rNozNKZqh59jwaU0NqSGcMFYTYV4y9sNLhxilZH8tVoL5V2nRtAdADOw88Z
	qgpu0g8XUS5B8AbkjgqAyLmafRL8Jfy088Hfg8a6mq8Eb6nGT4Kl/iZMBwx3v8rqERll8d
	jpA5BN/D8isWQpj29EMezQcbUm/yWgA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-VmOUkUu-NCu-PhmWjn-xrw-1; Thu, 13 Nov 2025 04:34:53 -0500
X-MC-Unique: VmOUkUu-NCu-PhmWjn-xrw-1
X-Mimecast-MFC-AGG-ID: VmOUkUu-NCu-PhmWjn-xrw_1763026492
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b366a76ffso441208f8f.1
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026492; x=1763631292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmEXxMQNcr7Ao680eVcUDXmbzW6uxx+W3/652jHTtt8=;
        b=sHNFv7gQ5zUke1+PsINoa9Ehumi5xvk6A5T38C1u0VMzJiKWqYnDX/inJkYurGabbA
         msKSA1VAsTbmb+ZkugjOGo38WeSwKWPcsehLMfTdk5b58yEHGewbHX7LZGEBS4SWSa4x
         ZllDnRXca5+hU4Z7Ygi8E1vhvAIweEUj915kVoTyAlQcvS9T60/+1+qArZLuEATVK2Yi
         3nKrxknrS7pkKyoHJhqqp7LXUwCcHxTxQA+FZifJJ88kjPypnwCJK3QtpoyPayiEdd1O
         PzpbiU6BxUnImMtZTVX4y0ySbhdVRq/sWXWqktiln04vAb0blH1neKhykjTK0MKmkG8W
         75rw==
X-Forwarded-Encrypted: i=1; AJvYcCWuYi60pftN7etCFzUARYwtvj0rJp260Hqni3rDGlzehZUr2pRD9hLx2W/2Wt9l8jrR0o/vSVG/0uTUrfiCvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmh4qB0WuAyMPmhY1cUVHJtNDd9WJLF7oRxjgqDmxZqGAwP37X
	YWuqXD3mmVhaBzrlNhulb78iDilwsKR/4xBOQIn7Agqoc1WTtRSWFj8pLIEsOUlDlemUWKmKcJr
	7c3IBMrJce8b8Ki5UnAfVWG+AJxiG+mHCyTjdmnr3TKxVjVX1yKzvmvV5JoCIPE1jlAmz
X-Gm-Gg: ASbGncshrmNw99hua1f2Hg7qx86pMB6lcZINxQeM4AWw4etZI3aqOpxlcYAf9847nRD
	4TM7IwiufxrJTNb2NQwhEl2oTyzRMTnD+RIv+AqrrYf2M33foGtFgd8v2XoCoRqADN1XzDlve5s
	wCQoJLIg5kguzKNjx8z3rwH10sSWW2BKNBhfmJogQG88a4hAvr5aSm/vPqnsqqwkx4FMUtqmjK0
	oMgoKq+y3p16s/PlAjMoWkutgJGySU6e6zJeMkJJ9cHh4jQCrd/5BU2S3mb9qex2bj6E2Q+R4ww
	CVivNnafhBVEQ6VNXdGtB+28T03R9Ityvo93pdkY+mMz9crOGyCAF5xceLxDTEsrUhzFMKgzpZ3
	zxciNYvUxWd1qQFGcxD0=
X-Received: by 2002:a05:600c:19c7:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-477870c5352mr55490895e9.19.1763026492353;
        Thu, 13 Nov 2025 01:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1jtRWVnrdLUlv4C9KrYAs72euPMIvvFiYX1nC4u6hRuLMPr91T8iFR0bzArS1Cipzq/HwXQ==
X-Received: by 2002:a05:600c:19c7:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-477870c5352mr55490545e9.19.1763026491858;
        Thu, 13 Nov 2025 01:34:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7aea7sm2724783f8f.1.2025.11.13.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:51 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 8/8] virtio: fix map ops comment
Message-ID: <f6ff1c7aff8401900bf362007d7fb52dfdb6a15b.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QVQIMKDMH9_ZZXsjYqFPD_at9yJoPDwUd_ssZghOfAA_1763026492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

@free will free the map handle not sync it. Fix the doc to match.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 1a019a1f168d..a1af2676bbe6 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -177,7 +177,7 @@ struct virtio_config_ops {
  *      map: metadata for performing mapping
  *      size: the size of the buffer
  *      vaddr: virtual address of the buffer
- *      map_handle: the mapping address to sync
+ *      map_handle: the mapping address that needs to be freed
  *      attrs: unmapping attributes
  * @need_sync: if the buffer needs synchronization
  *      map: metadata for performing mapping
-- 
MST

