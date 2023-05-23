Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0617CC7EE23
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 07:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88F0060F12;
	Tue, 23 May 2023 07:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88F0060F12
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qwbs87UY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Riwf0Ct16C-b; Tue, 23 May 2023 07:19:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3334F60888;
	Tue, 23 May 2023 07:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3334F60888
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 037CDC0036;
	Tue, 23 May 2023 07:19:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1889AC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA31B60888
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:19:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA31B60888
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtFNbjfSVBkr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:19:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3791A607C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3791A607C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684826389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ScgC+5oSoO0XSO2Sljmbt6Htz7YssvNQobQYyS/rEE=;
 b=Qwbs87UYgRyxOR68sJZt2Ydh45P3irEsxM5dC0MGBD3x5gxyEXom1pSEYLbfDtPYcBNU13
 kxAweSWGgvwROH4ccVaETy7HtZdmRbfVQgPfA1Ia4A+/oeMEyadQINSmqZMdoCKRtnUArR
 OV8BKrljmkEHwvxpFBdegfW34ohJ3Nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-jIzp7xRUM5-wZ8UyjkQFrQ-1; Tue, 23 May 2023 03:19:47 -0400
X-MC-Unique: jIzp7xRUM5-wZ8UyjkQFrQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30a8f0bb295so1265005f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 00:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684826387; x=1687418387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ScgC+5oSoO0XSO2Sljmbt6Htz7YssvNQobQYyS/rEE=;
 b=e+Xpu3haPRecrYXE5m6m6OW7MmgQ2ql7gPv3R+G4nKHY5YrKDy8ymhm4SDEZiLplHG
 CPKc4sqqxvh5+TR2q+tsoK37C6D0POAyIo4ZZnL5tlnZMiCx2YxhVZ3exZwumY2j464i
 DFPsAumvXJPoYzfSGw6u3xQtMKpyt5QBuQj4oSyrnYln78PyYAqOFq/5jSjN9muo3LcZ
 YlTrw8zi8yFNgen2GzwNbmdQMvIeENjBur01dBQ7kksgt/OkxlOmH4qT0VuIIfCwuKZi
 gtouwyjcDHcrykYIFQfTh8FxiWZOzwOTQfuTOMVFYxrHCnpC9wmVNtJ4AQxuGpNIHdk7
 LNsw==
X-Gm-Message-State: AC+VfDx3nn8zfK5bDj8LlH1UcAYE3gOOU3RCytBTc1eAT6ieUBDGaG5A
 kL3UWGTd+WkUWcqDPZhEcG125NobiyMyeSWgoNyGuEE7KvoahKrAGTqVWqz2OYFkezmKL9qpGTe
 wz4QJO6NdxDRYvWJ7uL8T/whx25Hpmkxob9kXxSa6pw==
X-Received: by 2002:adf:e7c8:0:b0:306:462a:b78d with SMTP id
 e8-20020adfe7c8000000b00306462ab78dmr9546168wrn.53.1684826386851; 
 Tue, 23 May 2023 00:19:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Wp+GQ2e57ktcyCX5EUzgWsTQ6gEisuiHcByWy6zpRNCOAW1vRIlHCJYnHWgavQEZQcdmegQ==
X-Received: by 2002:adf:e7c8:0:b0:306:462a:b78d with SMTP id
 e8-20020adfe7c8000000b00306462ab78dmr9546152wrn.53.1684826386549; 
 Tue, 23 May 2023 00:19:46 -0700 (PDT)
Received: from redhat.com ([2.52.20.68]) by smtp.gmail.com with ESMTPSA id
 q16-20020adfdfd0000000b0030642f5da27sm10060140wrn.37.2023.05.23.00.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 00:19:45 -0700 (PDT)
Date: Tue, 23 May 2023 03:19:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v9 04/12] virtio_ring: virtqueue_add() support
 premapped
Message-ID: <20230523031632-mutt-send-email-mst@kernel.org>
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
 <20230517022249.20790-5-xuanzhuo@linux.alibaba.com>
 <ZGxXLpEXlk+sg2BM@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZGxXLpEXlk+sg2BM@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, May 22, 2023 at 11:03:26PM -0700, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 10:22:41AM +0800, Xuan Zhuo wrote:
> > virtuque_add() adds parameter premapped.
> 
> Well, I can see that.  But why?

Assuming it's intentional, it should say something along the lines of
"The parameter is unused for now, and all callers just pass false.
 It will be used by a follow-up patch".

It's not a bad way to split patches, this way actual logic in
the next patch stands out as opposed to being masked by
the code reshuffling following the extra parameter.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
