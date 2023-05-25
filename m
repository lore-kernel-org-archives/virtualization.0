Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EE3C7EE2C
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 07:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F9CD61316;
	Thu, 25 May 2023 07:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F9CD61316
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WX+QPlhB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFgX3A0zuck0; Thu, 25 May 2023 07:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD14461300;
	Thu, 25 May 2023 07:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD14461300
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A39F2C0035;
	Thu, 25 May 2023 07:59:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 734C0C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4069161302
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4069161302
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSOlOFKSj1jJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:59:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E9F261300
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E9F261300
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685001587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwwIZJaZmyN29dYpZnR8aKcXxLup1p21dC4SUQQJNdM=;
 b=WX+QPlhBiVNtP+1XDv4NZ+Db2Trke857lOY7dsrvFBEkIKXXuop70dEeVwA7twb0OrBcbR
 e+g98jM37pXF7U6JOo8K5B3OaEZ5J8TVN1TaFoAQ+AdJ0j/TLUzab+PXF6pkiqqU6sVp8A
 +JjJTTzIHOxieLho9dhnbUXi8QflyvI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-hvDsyelkMnuWTlHeYWXVVQ-1; Thu, 25 May 2023 03:59:46 -0400
X-MC-Unique: hvDsyelkMnuWTlHeYWXVVQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f51ea554a8so8158331cf.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 00:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685001586; x=1687593586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwwIZJaZmyN29dYpZnR8aKcXxLup1p21dC4SUQQJNdM=;
 b=VZ44jEMwySuHqaPcrV0LQg/f5xlhBlPtZaX8MKH04YBhRryhR38cYsiTT97f6vJ1wh
 oxPGMpo8wn5/sIdErps+rnazqANUHtVVAm2Sins+HBKNscDE1a8sG23NPkXy2SU/GqXA
 s1r1mUEQST2wIiJuOJNz2R4P2HW8PieP9XP5zEKZoNV2/0sr2yrsAI283aW7ldw3XyiL
 Ws8wl8TJbESWIVZMfTZSY+e7m7n4eBRxcdjq61RAHaaQKeVDPoHqpFK5T5Akb+7T1pr0
 Z/ECAd8AYyQ0EizSo4QEp/vYEpCic9vOVnEBkbM4ZpqMzgcx50lHotjO638RaEa61Uux
 +K3w==
X-Gm-Message-State: AC+VfDyWVcnqWIGNYwPU1qpPqyY00PaADUX+qWKU4o7Yz/cB70yH9pAD
 k/azqkVzbRhD1vp+zQYSM4NJQTSSuuxWc8MrSxnBpYU44cRDQqysEhxkYnKOPvAbTdSFYegqvaY
 kKr4za88LvLSM17Wm7NV4j0jpjJu/NRP4pY93wVXGKQ==
X-Received: by 2002:a05:622a:34a:b0:3f2:f35:8e6f with SMTP id
 r10-20020a05622a034a00b003f20f358e6fmr29397746qtw.25.1685001585834; 
 Thu, 25 May 2023 00:59:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zl0dYCxYxkI+YVsbHmeWTGNczau5rHDnkpRLez3qsWsVlCM5yo3Zal8EdbIG0yQ8bNC7y6Q==
X-Received: by 2002:a05:622a:34a:b0:3f2:f35:8e6f with SMTP id
 r10-20020a05622a034a00b003f20f358e6fmr29397737qtw.25.1685001585600; 
 Thu, 25 May 2023 00:59:45 -0700 (PDT)
Received: from redhat.com ([191.101.160.247]) by smtp.gmail.com with ESMTPSA id
 d3-20020a0cf6c3000000b00625b2f59d3fsm223966qvo.96.2023.05.25.00.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:59:45 -0700 (PDT)
Date: Thu, 25 May 2023 03:59:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 0/3] vhost-scsi: Fix IO hangs when using windows
Message-ID: <20230525035847-mutt-send-email-mst@kernel.org>
References: <20230524233407.41432-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230524233407.41432-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com
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

On Wed, May 24, 2023 at 06:34:04PM -0500, Mike Christie wrote:
> The following patches were made over Linus's tree and fix an issue
> where windows guests will send iovecs with offset/lengths that result
> in IOs that are not aligned to 512. The LIO layer will then send them
> to Linux's block layer but it requires 512 byte alignment, so depending
> on the block driver being used we will get IO errors or hung IO.
> 
> The following patches have vhost-scsi detect when windows sends these
> IOs and copy them to a bounce buffer. It then does some cleanup in
> the related code.

Normally with virtio we'd have a feature bit that allows skipping alignment
checks. Teach linux to set it. Stefan, WDYT?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
