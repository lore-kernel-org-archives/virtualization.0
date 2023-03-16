Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11DAC6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 09:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3514F607C0;
	Thu, 16 Mar 2023 09:18:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3514F607C0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jtdmv0Pl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EES7LXuBkGWG; Thu, 16 Mar 2023 09:18:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A4C7860F7F;
	Thu, 16 Mar 2023 09:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4C7860F7F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75A55C0035;
	Thu, 16 Mar 2023 09:18:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1309C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BFF260A9D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:18:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BFF260A9D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90ZU_Xwvs9ZD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E356B607C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E356B607C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678958278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prBcxf91iIZL3MAy2qfBrYESz+EF2f9sqhQG3HhwSlg=;
 b=Jtdmv0PldWp0ZpiNSZI7fCaLOrYHWg+PfHKXhOBkmJ83C3OcE/ASHBhjOR6apc/Yyai1PC
 KJDSb+VBbzEW+h9STudQyoqGZoDYs/WDZisJTmJA6NocNdgo8kzwnsrwZVM6PZIqSjzes7
 bwv9ZfawVQMULnEO1yat6lEaaEYKF/4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-coMN4Qb1Ng-fOMg-BeKbIA-1; Thu, 16 Mar 2023 05:17:57 -0400
X-MC-Unique: coMN4Qb1Ng-fOMg-BeKbIA-1
Received: by mail-wm1-f70.google.com with SMTP id
 bi27-20020a05600c3d9b00b003e9d0925341so477757wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678958276;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=prBcxf91iIZL3MAy2qfBrYESz+EF2f9sqhQG3HhwSlg=;
 b=qTlXUr5FbM0UXQCahGiGax7+YT/qqxPpzY+yOMruGxN7xLOkvvgZksy60CMUIshrrR
 UEOSPrw5lEBgyeOC10TMEEMkbNpG2tnlEd/CZBOYWTYGAx0Wdq/wmd4YA6kqlxN7DV0P
 rscMPplaVgSopNNGhtb74EgWywU+tp5rNSVyn2h2Jrhc5gAr22zkMsrKcUvv+kcbjlB0
 WATeN6Cxb0L4sqEfVIj3ya6p3+fbszObfe8Axv0vcF89HmfQ01ZH5l8yP04G+sgl9fzu
 K/bqgv988BfeeEduZ0yf+RWMUxjuuFv6serRGVtfpjUg5UrPZNgKxA/FIZLzYf+EVqPS
 5IBg==
X-Gm-Message-State: AO0yUKWSWeJC0f7ZJ594UeYDOjys85/v2SRERwBXe0J1H4Sob0C3wMSm
 5TdaBqzSUcTP9V1ql+4caBu1ooYMmAPYZ9g1ekmfYqWNbTwUaJEMxp6BvYEkJeT8qyS8ZgvNNP8
 ElBv4QPMmEXhYfjokwIGTbtxCqLDqSF9uA75pzXz5lQ==
X-Received: by 2002:a05:600c:5398:b0:3eb:3945:d3f1 with SMTP id
 hg24-20020a05600c539800b003eb3945d3f1mr21253329wmb.5.1678958276094; 
 Thu, 16 Mar 2023 02:17:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set8fhHoxdUgxfHeMeJXHA71ZQrPDPTCxpB6BsggyeBHtylQKQSQtG2s7krQMIYt/khl/atW99A==
X-Received: by 2002:a05:600c:5398:b0:3eb:3945:d3f1 with SMTP id
 hg24-20020a05600c539800b003eb3945d3f1mr21253316wmb.5.1678958275835; 
 Thu, 16 Mar 2023 02:17:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c1c8600b003e209b45f6bsm4763800wms.29.2023.03.16.02.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Mar 2023 02:17:55 -0700 (PDT)
Date: Thu, 16 Mar 2023 10:17:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2 3/8] vringh: replace kmap_atomic() with
 kmap_local_page()
Message-ID: <20230316091752.vskzw5trzz772s3n@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-4-sgarzare@redhat.com>
 <5675662.DvuYhMxLoT@suse>
MIME-Version: 1.0
In-Reply-To: <5675662.DvuYhMxLoT@suse>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 16, 2023 at 10:13:39AM +0100, Fabio M. De Francesco wrote:
>On gioved=EC 2 marzo 2023 12:34:16 CET Stefano Garzarella wrote:
>> kmap_atomic() is deprecated in favor of kmap_local_page().
>>
>> With kmap_local_page() the mappings are per thread, CPU local, can take
>> page-faults, and can be called from any context (including interrupts).
>> Furthermore, the tasks can be preempted and, when they are scheduled to
>> run again, the kernel virtual addresses are restored and still valid.
>>
>> kmap_atomic() is implemented like a kmap_local_page() which also disables
>> page-faults and preemption (the latter only for !PREEMPT_RT kernels,
>> otherwise it only disables migration).
>>
>> The code within the mappings/un-mappings in getu16_iotlb() and
>> putu16_iotlb() don't depend on the above-mentioned side effects of
>> kmap_atomic(), so that mere replacements of the old API with the new one
>> is all that is required (i.e., there is no need to explicitly add calls
>> to pagefault_disable() and/or preempt_disable()).
>
>It seems that my commit message is quite clear and complete and therefore =
has
>already been reused by others who have somehow given me credit.
>
>I would really appreciate it being mentioned here that you are reusing a
>"boiler plate" commit message of my own making and Cc me :-)

Yes of course, sorry for not doing this previously!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
