Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91100266B4D
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730902; cv=none; b=nRKg6FBFtQIrQCW3k3ESPzeG2e8rE/tK8XJp057HR68HUGsVD0xaPyC3wapcWiMTQ7R+EeEoES7XilPVE2v3r970XXLsfEFUslmbEKwGqZXyumDOX8theP+sBmtSzJXpxfRGMK4uKppN0h0AygHn9nY0A55zgmt4DPAIBLeUbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730902; c=relaxed/simple;
	bh=nr7R7Fg4ot8hKPSC611voSLfEni8RCjYfnpL6ZiLWEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rx5OhmFgVradLGGvvoeoTgfoSIqsk88OJMdLa+bxPBA2gSkMsA6xlV2eiEe3l45t7AIyHe96+tVX0CNkEXKOUk6NVqvGlWF+EtmxkT60mUjDZ/c5idhkfLiXzaGHvFhZMAEA7S92PXdynNxlF6WPzzlyZKkjC9z2dGxP8G5gCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ad+UN3aS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ad+UN3aS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747730898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Jdw+1ZYszJBt4wLErRESKCGA4uJXq+gclnU2fYPdK0=;
	b=ad+UN3aSJgGIU+GyTHcqbwSosk9YnsWYOQt3Cjn106Uel9seaN4nOg5Fsx2AYDXBlgCXsX
	ZqLOe/c29Fc/wxXk13/9SGkB3QWICiAKjt7Iazp8KtxPDySiQZZd6qWUbpQUJJrTt7TEe9
	x3vpcTtKfANqK7nLCRDEiOWhAZs3GXU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-acAh6a2oMlm-uBEJV8I8kg-1; Tue, 20 May 2025 04:48:17 -0400
X-MC-Unique: acAh6a2oMlm-uBEJV8I8kg-1
X-Mimecast-MFC-AGG-ID: acAh6a2oMlm-uBEJV8I8kg_1747730896
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acbbb000796so386964466b.2
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 01:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747730896; x=1748335696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Jdw+1ZYszJBt4wLErRESKCGA4uJXq+gclnU2fYPdK0=;
        b=VYpioNghKwPxLli/WasmeSe2RmBWrd3foFjcO/plyXnUpO1UquVfSq7JVjNXbYI0xM
         SczjvrlT8EfgvFbnIkPRRdPG78o4SG2tUC4r6qSAFty9QcvoPE5OsHNE3VMXFeRGnung
         k21rcnxofh2HIOHRAOuZIKAq6SZO3QG5ymtRHQUDo20EkvCnSSM55gTslz1liUFWPBR7
         b930NR7At1hdTqdUA81c/aSlyX9FbU9vgtI5jnkCsTWMSSwGH7DDJmVUrkOKdPOpUkWH
         oYGz4WimhwLqHEsmiXyxDS7lJdAtvNLxNFYkFQ9Pnkz+ofU69CAbDa5vheseK1cYoId8
         xuLA==
X-Forwarded-Encrypted: i=1; AJvYcCXR7ICbuQppi0MAWin5xK8yTm0FvwC6G2ZaPV0I467HFHt19STZg0GSmPnLK71NG7v1spP8BF2OeVR3znwpZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCufAsbliJpq0aaogzjJpGMeBVf09FbuGCEp5E/bLJysNK6aEh
	qtiDCMKeqAOgMIn7QW3WPZ59ff44wrM8KQr7n98mDh0RgALu55phHscXf6S1k1oavaEH016f3UJ
	olA7t2tXe7M8rQvLxk7pVoLOrDWugriPvxQKjtO4YGYIEP52JiHtUBGpmYAIZQ4p4wPOm
X-Gm-Gg: ASbGnctFWrYp7EyG81N+WRPOybLJE15y5rwD6noJoXv8nmJ6MWJOTrLT2GQi2sdxkBR
	aQ8lMSvB5yWP+YIPmxkOgvUuWG8ytVDBDuuasWoVT8kCnRyOlkRKcmcCWZftZ2dK2LGYMvWZiFu
	CQ3Pvdi1go3/jsK+yigjmDyxY8yNAx48S3ZXYRlcLu58Ocnzx03sPNsoQZrcEB9RptvlSRZiHv4
	KJ8nqw3cU1JM/jvYlFa9+hXo6YwOYLrVvZcIqwBsDWkc/C/a1KDm7urY88eh3P/nNMpqGd+YEUM
	/a44hKc9JUVFhlxLNN5ZsbR77Tszo2PEQi8ttceZiVI13KX1EVxOHs8IakF5
X-Received: by 2002:a17:907:7b97:b0:ad2:50ef:4933 with SMTP id a640c23a62f3a-ad536bca532mr1376485266b.31.1747730895753;
        Tue, 20 May 2025 01:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2BHWScPxNpfhTKIVE/UH/c9qw0sXakELnUkTcCcer3v4L/X1iHFZvbAf5Qer6tD/v8Uho5Q==
X-Received: by 2002:a17:907:7b97:b0:ad2:50ef:4933 with SMTP id a640c23a62f3a-ad536bca532mr1376482466b.31.1747730895174;
        Tue, 20 May 2025 01:48:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ac327d5sm6862353a12.63.2025.05.20.01.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:48:14 -0700 (PDT)
Date: Tue, 20 May 2025 10:48:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, fupan.lfp@antgroup.com, pabeni@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	stefanha@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH 0/3] vsock: Introduce SIOCINQ ioctl support
Message-ID: <27pwterjsrrvgzcdwgkrfkthbqdaqptj6lj75gzfmhuouilexp@jg4t54gsnw2h>
References: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OXZBp5-RrWsfvbc2o_yivoyxeYf1vSq19f1p0tbfIak_1747730896
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 19, 2025 at 03:06:46PM +0800, Xuewei Niu wrote:
>This patchset introduces SIOCINQ ioctl support for vsock, indicating the
>number of unread bytes.

Thanks for this work, but please use net-next tree since this is a new 
feature: 
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev

Thanks,
Stefano

>
>Similar to SIOCOUTQ ioctl, the information is transport-dependent. The
>first patch introduces a new callback, unread_bytes, in vsock transport,
>and adds ioctl support in AF_VSOCK.
>
>The second patch implements the SIOCINQ ioctl for all virtio-based transports.
>
>The last one adds two test cases to check the functionality. The changes
>have been tested, and the results are as expected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>
>Xuewei Niu (3):
>  vsock: Add support for SIOCINQ ioctl
>  vsock/virtio: Add SIOCINQ support for all virtio based transports
>  test/vsock: Add ioctl SIOCINQ tests
>
> drivers/vhost/vsock.c                   |   1 +
> include/linux/virtio_vsock.h            |   2 +
> include/net/af_vsock.h                  |   2 +
> net/vmw_vsock/af_vsock.c                |  22 +++++
> net/vmw_vsock/virtio_transport.c        |   1 +
> net/vmw_vsock/virtio_transport_common.c |  17 ++++
> net/vmw_vsock/vsock_loopback.c          |   1 +
> tools/testing/vsock/vsock_test.c        | 102 ++++++++++++++++++++++++
> 8 files changed, 148 insertions(+)
>
>-- 
>2.34.1
>

