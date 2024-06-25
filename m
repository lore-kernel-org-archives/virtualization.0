Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57392146D6C
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302263; cv=none; b=UYXLOz6uD98KO1IXyAqp8DQRyb3FevvugoY80QfIVhGGJ0+dRN2kPViWcvorbcbQUh5nzhV0XfEiiYXdkp7L7IRIJRhEPRHyr+LoY9+riM0zyhtMxsTBsI4/GyJAsr53TWas4uJsIPVZTlKOFpfR3vfoiJrc7U2xxAvn9Laospo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302263; c=relaxed/simple;
	bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YAoaA3fn8h+x60D4pvTG+j3OS01WXGlp8b5tU3SkkhbET7ZVCHYDmC8mQ+ZhdTivGAPNkq+CbtoiyW+LT9Y4O8dT1yc6P2IFDzgZ33AWq7rlEJ/9fMNQKLDFX/wixiWBJQ1qNbcQ37zB8agD3xV9hUiRnsyuKP7m9WsU0BHgzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQqcpHBp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQqcpHBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719302261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
	b=DQqcpHBpL3cicGzLHOPKcZCGJ8a88G2abMVvLRlslXqzKLWcMgcezx1SCp5bgxeTsSK0AQ
	ekC6n40G9FgtHK1jyMTV7MiOBFGsTACXJy0M84L0S2jP6A7997JBEUTV43LrJOHxgCeqvT
	8bQ5XoZ7geaw2Povht5wxEFTUIQFaDE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-wwYU9FwQOTCU56vzcjYmQw-1; Tue, 25 Jun 2024 03:57:37 -0400
X-MC-Unique: wwYU9FwQOTCU56vzcjYmQw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52cdea53043so1918123e87.3
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 00:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302256; x=1719907056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wlc36+PGhvjjvSPA9aoelCfxeFiMdalGPnlYKE9au40=;
        b=Xu4DfCU84hzgzspQqLFz2/6wxVo3i33THPJ9it5vDnz+TJdmS7rXu4ulPQHWJAW394
         bmQXsCPDE5WEZExHf+GZjBUmhAFI9svzxG3f55CPyk5K9wNIKXa8ZiI8MU21ve1qpMuH
         nsdyflEWjR+gWkssPlQT28637N7LvzTjBqZTO4zIuXkxf2w4EbNKDGa0kWggZceCsHIc
         R89GhYs4vXI6dfjgqC7IVyyBEncAq9AmNScRDAcd2+NjpWgMaAZigUpgQHDtltWdqu3D
         D5ZWX2Uc7SsdAAYEApZ+/jGxn/qt6xdTCtqNEK3zqbaP2ZBtz5QpYQz1R8E63Zx/1yn+
         izMw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+l5tQhxp/jDmSD9LFJnz547KQ4OZKC4zcxcMR0rC6t3jFdPy+i0t7xooKbDWE4WES7ydgLyCdmr63LCidVgaW0A4T/uOT9jHWYJ6IrE=
X-Gm-Message-State: AOJu0YwEGt1LHMiPlMbKA1WwyjN8OMfJQbiwK3TQLy+H1+2bi2EL1YZn
	DqZKoXJjlLwFdrVtTz79sbdedWHh00vzkZuwjiFln/nofDGjMtD5OJR7KdIHUdHgsWHtzvTAA/y
	k+vM8nWKb32IsQ+czltcTjERr6Nz32qL+A5MdFWhX/dyFO6odgt4Bk7NFJCW7/8Tf
X-Received: by 2002:a05:6512:402a:b0:52c:8051:5799 with SMTP id 2adb3069b0e04-52ce1832b57mr4772809e87.11.1719302256142;
        Tue, 25 Jun 2024 00:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtSiI6MnJMyKcIBakFxsAacJJgrU/9spzJO8lG47UPorN5R3MoQXUk1RYI4fQLSyfsKsVUtQ==
X-Received: by 2002:a05:6512:402a:b0:52c:8051:5799 with SMTP id 2adb3069b0e04-52ce1832b57mr4772784e87.11.1719302255343;
        Tue, 25 Jun 2024 00:57:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248191fac8sm160640555e9.42.2024.06.25.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:57:34 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:57:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625035638-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> Workqueue is used to serialize those so we won't lose any change.

So we don't need to re-read then?

