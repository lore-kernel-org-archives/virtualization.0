Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0657EC43334
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 09:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 713144199E;
	Tue, 21 Jun 2022 09:25:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 713144199E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gyHRBRHM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id daK9qHivG7ks; Tue, 21 Jun 2022 09:25:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4E4341993;
	Tue, 21 Jun 2022 09:25:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4E4341993
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86A7EC0032;
	Tue, 21 Jun 2022 09:25:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5BB2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BF9741993
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:25:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BF9741993
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VL2IJ7AI25ho
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:24:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27CEA4194F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27CEA4194F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655803497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4uOuJR7STGmIx6fQpczRT4l2eyJPYIfDBDcZggVppa0=;
 b=gyHRBRHMAmLxX4UNh2TuWuJfpwWSdXFMHTM1CxtRaeNtTK8ywiSGRuFaTh/tP2lYXu0T1N
 Gzh8ysHN/2eSe1ELgAIT4mPRGLcPtjUyV+Q034hPYJDa7TgO2a4BYSL7Zs95lUf6ZZlPyG
 xrEqbGEmHBB0dG0/sBHwDrYuu/deV8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-BHwHeawEO2C4ntZ_LsP_qg-1; Tue, 21 Jun 2022 05:24:51 -0400
X-MC-Unique: BHwHeawEO2C4ntZ_LsP_qg-1
Received: by mail-wm1-f69.google.com with SMTP id
 c187-20020a1c35c4000000b003970013833aso4074313wma.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 02:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=4uOuJR7STGmIx6fQpczRT4l2eyJPYIfDBDcZggVppa0=;
 b=rj77v0sJkCuTZeSxQ5tfUQEz84BKCWIrEXCvQIRLqtJjLnmzo2eaDcolT9bm78psHO
 WVzcwV5cPObc+RFRqHu/6zevkarS7BQc36c3GKwpRbo+dGcIKwD5QwidTn95ynGd/GG3
 UOJMl35L5fD1FNoHOFYVeTV7+dRhR/h4/GhU0Ff908szhd9yKW5X1Qdac65FkWj41Gwc
 i8XlQAWyfI/r53kYeKBPhsEHYQtIrRq+tTdXATggkOXegktjdfMF9Fo9kVgI0drYYnvL
 4Xg2UxtOGgHOMHAfAd2x5LH3ZHas/3nyKaIicK91xL0gkJgRrdtibS34UELSvTECLgDD
 FaGA==
X-Gm-Message-State: AJIora8ujPQVrTOtfdq+qm/HnlKSyYPqgUppD1Hde0hFWmWgtN35IoSM
 i9Z2JnhdqDLmC/8MwNKwiI4KKzGAVceLQfBZoGydcBk7r/W745hcTcrFx/SEgdaFzkWcU/1DWpU
 qN/PLxdEKuFKTSg+74Do4Krq1bvFqNRZTuYlii6HiBg==
X-Received: by 2002:a05:6000:1f8b:b0:219:bee5:6b77 with SMTP id
 bw11-20020a0560001f8b00b00219bee56b77mr26566064wrb.658.1655803490671; 
 Tue, 21 Jun 2022 02:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s+6erjxXHSGyPq8bGo/d8VQdFgC4f89KSV+vkJqsYUEbft9/WR6QZeW1Ie1oo3gNajkAgEqg==
X-Received: by 2002:a05:6000:1f8b:b0:219:bee5:6b77 with SMTP id
 bw11-20020a0560001f8b00b00219bee56b77mr26566037wrb.658.1655803490370; 
 Tue, 21 Jun 2022 02:24:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f?
 (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de.
 [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b0039c7c4a542csm17152700wmj.47.2022.06.21.02.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jun 2022 02:24:49 -0700 (PDT)
Message-ID: <402bb9b5-7d6e-ed69-8b66-3ebefd80ff15@redhat.com>
Date: Tue, 21 Jun 2022 11:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: Ben Hutchings <ben@decadent.org.uk>,
 virtualization@lists.linux-foundation.org
References: <64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: virtio_balloon regression in 5.19-rc3
In-Reply-To: <64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, debian-kernel@lists.debian.org
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

On 20.06.22 20:49, Ben Hutchings wrote:
> I've tested a 5.19-rc3 kernel on top of QEMU/KVM with machine type
> pc-q35-5.2.  It has a virtio balloon device defined in libvirt as:
> 
>     <memballoon model="virtio">
>       <address type="pci" domain="0x0000" bus="0x05" slot="0x00" function="0x0"/>
>     </memballoon>
> 
> but the virtio_balloon driver fails to bind to it:
> 
>     virtio_balloon virtio4: init_vqs: add stat_vq failed
>     virtio_balloon: probe of virtio4 failed with error -5
> 

Hmm, I don't see any recent changes to drivers/virtio/virtio_balloon.c

virtqueue_add_outbuf() fails with -EIO if I'm not wrong. That's the
first call of virtqueue_add_outbuf() when virtio_balloon initializes.


Maybe something in generic virtio code changed?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
