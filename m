Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1761442F7
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461018; cv=none; b=EvWdaGK+Fx8bVpSPcO9GQjvyLByeACromQk8ylYpv2+vYZ52jYPQ7w56GH9LZhNGicmKCZ9H3hkBY+awRyZs2EiB9ms3TN0pfNFTCOTVAxCV9gF61FtX0mA+42CN/F0hTmOi1/IAa5sZMeOV3H0CvAQqBYjnfuk1IPCBavJRX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461018; c=relaxed/simple;
	bh=nDxsQh//zo1y5z5bauVnQVFtzT643YqTMG646rY/zdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qHPYQcPrwu29Vo9Ouf4HSDd09Knyd6jB4v4Xvwip0n0NlJVoLVAaKrY3iZHhb4iGyr5GxSFnXpMtfXZh/MnkjrvRBrX2YRU+j1NvyZp4Q2Z/S1X3aB7k8xUqotl2EbfQWnE0q0gUXlm6yHbGbGyF//lkreZ7Uo8HOan6+ADvQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShFj5H0Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShFj5H0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716461015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbDIGJhvRjqMZ04SQyKdRF9N/GO/OgDidrS2yTufDB8=;
	b=ShFj5H0Z82In5rx1vsD0IVsil5AObZy3DzKpywuJL933vhaad7LiwxjlojQ8dmgA95sYrH
	XfIeFzsLjfbZdNiKUx9h+2nfPAC9x7VYFbB6gi9po4Dh5d7ck8EKPyOqosGUynISbMW/y1
	2bdSrOkiTx73ViQ3ta0J604vMW1butM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-mqn-aelUPTuulZBlwv0eFA-1; Thu, 23 May 2024 06:43:32 -0400
X-MC-Unique: mqn-aelUPTuulZBlwv0eFA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-792e34d2884so935360185a.0
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 03:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461012; x=1717065812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbDIGJhvRjqMZ04SQyKdRF9N/GO/OgDidrS2yTufDB8=;
        b=W0suwnNwydMKHDgdi3WOy9p7jQgMUoAI3BUVY8Jh/scP96Ydz3oLfL/N4e50qcdj20
         ozcmf6FyKLV/GQQbBbJylAfCFG6JgH7FWNA8+xRIJjnn1ROAYa8eyGz7eM6kZDoKiKhM
         SFd/Zh2z7I5nMx39mu9KKfzmR7TQLikgLuYZ4k9jD+wOhQfQujf4ZsZH90j4uahtpTDN
         IhkxzXeknDHoDaEvl3Aqa/1DPTtXzBrIu+Jcdh+xrIhAVlmvxvsv1QAN8Q+qqCSN1ofX
         4XHB7Iej40utywOc6VIBtXTNLXGPa70IEnCGKUbxdKnONIfyl3Zk/rmk4z5qyl30pM0Y
         f2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVBTCVqd1gyMkQGmFrvKzMsuW+h78qSpaoespwNhYBIi1hskZpIWFLuBBF3g2QOFxQielu2F2XHYA2yVo17yCeWaX1mCXoWA6+tC6Ra+rU=
X-Gm-Message-State: AOJu0YwGHMHGQo9fvzB6geS63w6GJrPCNtvvqxyZeKBxNxapl1ecTrZv
	apWKmNAK1FtzFqWRYbWnOiMSThA68YRhhbGWPSUQaOavTPqCzAqIGYCX0cd5ZMGGku3cBokmhvY
	pU5qtdNtz+r95+kk/LflybIktLr89c4HN9iblH4JeXsphT4p4jKQvY9uXHQpluxzO
X-Received: by 2002:a05:620a:f87:b0:792:c037:abc7 with SMTP id af79cd13be357-7949943d681mr399676085a.25.1716461011809;
        Thu, 23 May 2024 03:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyXkeky/hgXWrbr7XrVg67knYOzWxw3YK7pzC7NB1DXzAMHA73585YCgpBWOuQEQKJpllUnQ==
X-Received: by 2002:a05:620a:f87:b0:792:c037:abc7 with SMTP id af79cd13be357-7949943d681mr399674785a.25.1716461011444;
        Thu, 23 May 2024 03:43:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794724bb95dsm531587285a.53.2024.05.23.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:43:30 -0700 (PDT)
Date: Thu, 23 May 2024 12:43:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 1/5] vsock/virtio: Extend virtio-vsock spec with an
 "order" field
Message-ID: <opwx66tvekodbus52cmg4nihiopma46b7fpnnrdzw6l2ij7jai@7rqy3nnl6upn>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
 <20240517144607.2595798-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240517144607.2595798-2-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

As Alyssa suggested, we should discuss spec changes in the virtio ML.
BTW as long as this is an RFC, it's fine. Just be sure, though, to 
remember to merge the change in the specification first versus the 
patches in Linux.
So I recommend that you don't send a non-RFC set into Linux until you 
have agreed on the changes to the specification.

On Fri, May 17, 2024 at 10:46:03PM GMT, Xuewei Niu wrote:
>The "order" field determines the location of the device in the linked list,
>the device with CID 4, having a smallest order, is in the first place, and
>so forth.

Do we really need an order, or would it suffice to just indicate the 
device to be used by default? (as the default gateway in networking)

>
>Rules:
>
>* It doesn’t have to be continuous;
>* It cannot exist conflicts;
>* It is optional for the mode of a single device, but is required for the
>  mode of multiple devices.

We should also add a feature to support this new field.

>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/uapi/linux/virtio_vsock.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 64738838bee5..b62ec7d2ab1e 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -43,6 +43,7 @@
>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>+	__le64 order;

Do we really need 64 bits for the order?

> } __attribute__((packed));
>
> enum virtio_vsock_event_id {
>-- 
>2.34.1
>

