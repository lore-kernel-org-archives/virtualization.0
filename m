Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B62C43217
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 13:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F21DC40A42;
	Mon, 14 Nov 2022 13:06:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F21DC40A42
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlcZ/fUI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9gL9xcCkttb7; Mon, 14 Nov 2022 13:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 882D04019D;
	Mon, 14 Nov 2022 13:06:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 882D04019D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EA47C0032;
	Mon, 14 Nov 2022 13:06:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DB11C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 13:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AC1B40412
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 13:06:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AC1B40412
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NTdaa7NUYkDu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 13:06:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAED54019D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAED54019D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668431202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEm7C/vnsowGS3lJGInXxy/xe3gXl1h34wCMVqBZRfo=;
 b=WlcZ/fUIC4Yhq4TW6y2WFUtq3xR15LoyLukbc9E+yoLWVagnzfzq+1DOwukQoVCVSVEsL9
 IzCLSR2N3XJMMBAPiN9mgowquFPhF42lvPe0oNPMigdUbmV5rQE399Gyvb6/R9na2VIYWJ
 hmQYz3QNLWVK/NJ+zhBmJqxry6U9vTo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-284-cSWyOE_kPGeuDwCFz74IAg-1; Mon, 14 Nov 2022 08:06:41 -0500
X-MC-Unique: cSWyOE_kPGeuDwCFz74IAg-1
Received: by mail-qt1-f200.google.com with SMTP id
 s14-20020a05622a1a8e00b00397eacd9c1aso8052066qtc.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 05:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEm7C/vnsowGS3lJGInXxy/xe3gXl1h34wCMVqBZRfo=;
 b=Q/7kO//LEqdwfJ9s3goeJyb1yY36h7XrxzVmvzHpmQIVuta1hQpu4BV/yS5KfWEOIC
 XH/QpTKInbJn97VwvyJLH38z5ZgTh4hRfjCNcGTmIpl9Qtc2zAOmoTVkvPLEoSfXs3VG
 x68IYWDtN0pvc4arlWbmQn6Oo9TJrada2L3zdHzJOIuBdXhBggITjRuwPCibIC1mjVb7
 7bQ4pqcWRbm+AB//83JTFXdJaj7Vrp67JJNcnNFpJDdpEC0Rj5AorhNAIEh7DO5Hqwi8
 WZyYohxNdgfrKBlwyOv98/7iFa+vvdkJaVmu+BlX5Yy+xMAUj1mAyBknwNX7YFXgSUZ6
 NlSA==
X-Gm-Message-State: ANoB5pk57u2MV8x2W1uVZijxgQdwFeAWS8iJS6BW8zeRUTAeZOBkIR+0
 OOAxIzlSueUuvBnMBvhbJIEkwPgIULrmDLCe1INVcwnV5AyBV9zUIS+xfXl/Hbfa9BMdQFhGNm+
 GRfb3tde17U5lvjLaMfj1YqKWFeOyYomXKuesPZP4nw==
X-Received: by 2002:a0c:e84b:0:b0:4b4:4f9:1776 with SMTP id
 l11-20020a0ce84b000000b004b404f91776mr12171769qvo.116.1668431200994; 
 Mon, 14 Nov 2022 05:06:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf44L6DL5kmVI/2Dg11DzAR1WZ8kxVc6IKac2m2UGyVOx32ouQKnt+DwNyafJMFlhwuvkKVCAQ==
X-Received: by 2002:a0c:e84b:0:b0:4b4:4f9:1776 with SMTP id
 l11-20020a0ce84b000000b004b404f91776mr12171752qvo.116.1668431200784; 
 Mon, 14 Nov 2022 05:06:40 -0800 (PST)
Received: from redhat.com ([37.19.196.93]) by smtp.gmail.com with ESMTPSA id
 q184-20020a378ec1000000b006ecb9dfdd15sm6378984qkd.92.2022.11.14.05.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 05:06:40 -0800 (PST)
Date: Mon, 14 Nov 2022 08:06:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH/RFC] virtio_test: A module for testing virtio via userspace
Message-ID: <20221114080345-mutt-send-email-mst@kernel.org>
References: <200906190927.34831.borntraeger@de.ibm.com>
 <20221112161942.3197544-1-dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <20221112161942.3197544-1-dvyukov@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
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

On Sat, Nov 12, 2022 at 05:19:42PM +0100, Dmitry Vyukov wrote:
> I am looking for a test module that allows
> to create a transient virtio device that can be used to activate a virtio
> driver are communicate with it as if from the host.
> Does such thing exist already?
> Or how are virtio transports/drivers tested/fuzzed nowadays?
> 
> Thanks

Just coding it up in qemu is probably easiest.  This is how we test
most things.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
