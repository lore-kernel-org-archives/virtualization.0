Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC67EB64D9
	for <virtualization@archiver.kernel.org>; Mon, 10 Jul 2023 05:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEFD7402F6;
	Mon, 10 Jul 2023 05:52:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEFD7402F6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SNxSiZnn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_bey47-UWID; Mon, 10 Jul 2023 05:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 740E2400CB;
	Mon, 10 Jul 2023 05:52:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 740E2400CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42E86C0072;
	Mon, 10 Jul 2023 05:52:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E90EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 05:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E214400CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 05:52:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E214400CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p3txMm5KdW5T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 05:52:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54CFE402F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54CFE402F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 05:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688968345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2K52jyfMXQ896NNNb2VdJ1cCkY7IZeKXb4JhCxLXus4=;
 b=SNxSiZnnUfquI0gvJPH3WE9Bv8henUDhK+INhI+6JyRuH9I+ylGxn0l23PVsJ1CSKGdE8R
 wUyGs/T/ECTWFoeBjoJxTVJW9E4aDMf7ZLfV6ot8FT7OFikdlS75S/qbmFiCrPvnh8tN/p
 vYY1XBdtGPbaFhsIvK0PLlGdTjoXpbk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-duQCFlA1PZSRyJw7_pLcPQ-1; Mon, 10 Jul 2023 01:52:24 -0400
X-MC-Unique: duQCFlA1PZSRyJw7_pLcPQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbefe1b402so24242705e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jul 2023 22:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688968343; x=1691560343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2K52jyfMXQ896NNNb2VdJ1cCkY7IZeKXb4JhCxLXus4=;
 b=NAlHpiZ+YVYAZTpO7Vi7fkDu155gFKg55MCtPYctFfJk6xXi8H4UVZ42qQ4110kl1m
 mWlyLnyx16W9ckxeNA2HFNKTlLeSeg/ox/aFzxrugz6pHapzQjgHDJ5xiKy3Vx80RxkP
 +QUUCdDotIdGvr71fix9Ah9o/xE2v7SSMnhnhCvK/OSR4UbKBhM+u5zYdjUrV+zwB+MG
 S043EI9bSRbYAvU/0afsuc3ZBpEmrksplp+W2WhRiFMGm28S86CesflX1Uh3vFWXx374
 nqr6lVY+7lZLkueVUQDQVY11p5r57yGpzZX5DStFXcMcNJriSUo8Aw8QR2HiCDC4FQMM
 iXmg==
X-Gm-Message-State: ABy/qLaa4JWK/TOfDcQ0Toz28b1xs9/do91M2ogJbmOta2jvm/88fElO
 kJiOGH+kK39XRB+Pf1KRVGSLmQoDc1Eeicj4xoqH8ri4epUrH7UnDya6APcMsBljeZaNQisKF0o
 3Ha8FsCwbUYDlMrYb5MHyvxP1vux2tDmU0itOjjCFRg==
X-Received: by 2002:a05:600c:2313:b0:3fc:521:8492 with SMTP id
 19-20020a05600c231300b003fc05218492mr5262418wmo.5.1688968342929; 
 Sun, 09 Jul 2023 22:52:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEX0MBIPIVZb0Ml0+vup7VUgMycj1blZD7PFdfB9Im1EaU1Fa8yaiSZY7CKGQPrbwAQn1eEsQ==
X-Received: by 2002:a05:600c:2313:b0:3fc:521:8492 with SMTP id
 19-20020a05600c231300b003fc05218492mr5262405wmo.5.1688968342576; 
 Sun, 09 Jul 2023 22:52:22 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 i8-20020a5d5588000000b0030fa3567541sm10646951wrv.48.2023.07.09.22.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 22:52:22 -0700 (PDT)
Date: Mon, 10 Jul 2023 01:52:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v2 0/2] vhost-scsi: Fix IO hangs when using windows
Message-ID: <20230710015042-mutt-send-email-mst@kernel.org>
References: <20230709202859.138387-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230709202859.138387-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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

On Sun, Jul 09, 2023 at 03:28:57PM -0500, Mike Christie wrote:
> The following patches were made over Linus's tree and fix an issue
> where windows guests will send iovecs with offset/lengths that result
> in IOs that are not aligned to 512. The LIO layer will then send them
> to Linux's FS/block layer but it requires 512 byte alignment, so
> depending on the FS/block driver being used we will get IO errors or
> hung IO.
> 
> The following patches have vhost-scsi detect when windows sends these
> IOs and copy them to a bounce buffer. It then does some cleanup in
> the related code.


Thanks, tagged!
Mike, you are the main developer on vhost/scsi recently.
Do you want to be listed in MAINTAINERS too?
This implies you will be expected to review patches/bug reports
though.

Thanks,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
