Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5370CDB46A
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 16:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2315C41E7D;
	Wed, 11 Oct 2023 16:59:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2315C41E7D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWz+P3FJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsVg2BStOuAT; Wed, 11 Oct 2023 16:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D73741695;
	Wed, 11 Oct 2023 16:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D73741695
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E458EC0071;
	Wed, 11 Oct 2023 16:59:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06343C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 16:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D44B94016C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 16:59:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D44B94016C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWz+P3FJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DvOSLuGzYVGX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 16:59:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDAD5400A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 16:59:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDAD5400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697043577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5GbYfUjAH5Td6aPeboRpo17r0mDy+ld8mKJnmcV6AoE=;
 b=iWz+P3FJtJ4k6m7B4Zh/YAIKuhiozaskYEHXEwe03D6kEVHM/qfCj4aqTwAp+TyPE4a4yy
 o/4xA9zdDgGutakD67s+PMce+5aDi2GUasH/rcQKxCTrbNXvDjO0SUrTxVoQAJl6lsVnbD
 2Il3nNZIf/VpQQcn3Z1HCNoSBUwxDqk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-SztW7NlPMMqxUOf5VtGBoA-1; Wed, 11 Oct 2023 12:59:36 -0400
X-MC-Unique: SztW7NlPMMqxUOf5VtGBoA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso29171f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697043575; x=1697648375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GbYfUjAH5Td6aPeboRpo17r0mDy+ld8mKJnmcV6AoE=;
 b=RZEqArxfwu5ZUuxI/Vl1QpvJzLxScHPCYbs4WW9Bfi9SB1KLkeHzhBgZsp9Dn1+fhF
 gznuHuagmGZRIuaFk8AXJkDMQvT9v+5GSW9VDpOs88gNoQykRIpw1bE8LhZqwltv/Nor
 xNiAFLAAUlg69PQDA7049XZvFxshsFjiA9xvpTfJxbWFlp6xyHyZ5CQeUQxObc6R5BEM
 OnYJAO+yUSut1qwZ5IpJSiGHAvdw3U6S2NIJe+Hesj08AxNVYkwVJRR2WelPVNSFoBNO
 KyNbpJQIzNrzAjUKyEBs9A7LcBV07qTmoxU+wssdOvM+tSbzOVj3wznKnLG0PxgcxnuV
 Tqog==
X-Gm-Message-State: AOJu0Yy0+JdC3M+ucRfaBniipudiLJQFMv6wAfFwbB7VGuRZiS0YlahS
 A6YaowdAiQrNNuzJn4usTNxUKUMc5fDd+W6Zkr4aamhdIpmIKxZhtvGBowpsBsw5l52TqENr41x
 MxU49E0y9GxB/kXI25yY70cnagBub/L/HzZVp8mDtqQ==
X-Received: by 2002:adf:fc4c:0:b0:319:785a:fce0 with SMTP id
 e12-20020adffc4c000000b00319785afce0mr19279963wrs.26.1697043574865; 
 Wed, 11 Oct 2023 09:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzyP3mneqxoCjoaVwVlX+/Yn8WcmOL9NWB8EnPdm+OZJhCgzQEYIYDMSGtTDUAjQGUu+JfyA==
X-Received: by 2002:adf:fc4c:0:b0:319:785a:fce0 with SMTP id
 e12-20020adffc4c000000b00319785afce0mr19279953wrs.26.1697043574531; 
 Wed, 11 Oct 2023 09:59:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a5d6a84000000b00327bf4f2f14sm15982214wru.88.2023.10.11.09.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 09:59:32 -0700 (PDT)
Date: Wed, 11 Oct 2023 12:59:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011125426-mutt-send-email-mst@kernel.org>
References: <ZRpjClKM5mwY2NI0@infradead.org>
 <20231002151320.GA650762@nvidia.com>
 <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <ZSZAIl06akEvdExM@infradead.org> <20231011135709.GW3952@nvidia.com>
 <ZSaudclSEHDEsyDP@infradead.org> <20231011145810.GZ3952@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231011145810.GZ3952@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, jiri@nvidia.com, leonro@nvidia.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Oct 11, 2023 at 11:58:10AM -0300, Jason Gunthorpe wrote:
> Trying to put VFIO-only code in virtio is what causes all the
> issues. If you mis-design the API boundary everything will be painful,
> no matter where you put the code.

Are you implying the whole idea of adding these legacy virtio admin
commands to virtio spec was a design mistake?
It was nvidia guys who proposed it, so I'm surprised to hear you say this.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
