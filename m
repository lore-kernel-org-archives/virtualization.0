Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0B8C001B0
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 19:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E746E84001;
	Thu, 10 Aug 2023 19:19:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E746E84001
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZmwnN7f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14ydDEcDniAB; Thu, 10 Aug 2023 19:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A817839E5;
	Thu, 10 Aug 2023 19:19:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A817839E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49769C0071;
	Thu, 10 Aug 2023 19:19:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1619C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CA94611B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:19:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CA94611B5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZmwnN7f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iV7EJgXkvt_m
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:19:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C423C60AB7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C423C60AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691695164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iceQwAQJAl69YtgT3tPL7fTEK9peheXin0UtEwIJz4U=;
 b=hZmwnN7f+RDrfyUO6oRlwgzKMTExpV0izh37QlaaNCWbNXDzyICwjd2+B7xa+3mE7lHPwj
 UN3deQZLPoyYla8kUjYj9AA1NSddfSSFz2Dvh47G2uVe2iKMkhmLr0TvHQUg4Fc936yRWR
 k0jUucinL4+tVaOw6Yis4xf9c1oXZC8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-aj_m2tBPO0aRyJG_PmjBRg-1; Thu, 10 Aug 2023 15:19:23 -0400
X-MC-Unique: aj_m2tBPO0aRyJG_PmjBRg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-317c8fbbd4fso817836f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691695162; x=1692299962;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iceQwAQJAl69YtgT3tPL7fTEK9peheXin0UtEwIJz4U=;
 b=DIBC58+o5qQeoTKbG5wVY+ffuj8tezyee9nx9Rtxrwi3hStcvGkhmIGbZceEbDlYRe
 dtE3zzN0ga3TABS8BTzFVZFQQ8LZ0NTX5DUvXPM8Q+sWQXgXQXf+lQ+1z7qnSwoNKyyt
 7tvm6LZfK5OPwTl0iLmeeNrwY4xThEObLTkPk1inVm20c4HARSVisUEvAAD4t5mAkdoA
 cy7CebJ/RZ+cIm3gfEPwsHFfFtVgEf7JNQ1l6PprB70qk/ii+zp2FVRM7RtPz539nZ9+
 kZ9rQuKv+iO9wydalDK8W7MJwpZmtmHTOBgB0E1z/7F74uLjb75oDCwzYVMCMtj18/Fx
 6/HQ==
X-Gm-Message-State: AOJu0YwTdoTVZS4x7IxWe9oq3ovZOcdHiHi6+lJ3KdNAIM3kleToejxy
 B2HP1NUepLtkOLID1J7WbzB7nEbZRDGHDk+I9HxEWegZ2R2rSuUROvtfofRYWr7K7HMavZtqRtW
 oPbHqKiBqgdzNMQLPj+M6cmI9+p9av3fa15K7VhQ0OQ==
X-Received: by 2002:adf:e5c3:0:b0:314:54f0:df35 with SMTP id
 a3-20020adfe5c3000000b0031454f0df35mr2635487wrn.16.1691695162057; 
 Thu, 10 Aug 2023 12:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz2SgPHeom3N3nUEQAIOwQC+jZPFmkbNwFDaqXXAQqAxgF1D8T52VEBTOiRNUfXExxRDKfTQ==
X-Received: by 2002:adf:e5c3:0:b0:314:54f0:df35 with SMTP id
 a3-20020adfe5c3000000b0031454f0df35mr2635473wrn.16.1691695161750; 
 Thu, 10 Aug 2023 12:19:21 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 b2-20020adfde02000000b0031416362e23sm3022377wrm.3.2023.08.10.12.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 12:19:20 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:19:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuan Yao <yuanyaogoog@chromium.org>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230810151909-mutt-send-email-mst@kernel.org>
References: <20230808083257.3777012-1-yuanyaogoog@chromium.org>
 <CAOJyEHb_KjPawwH+U30iJCDjB-VqH_FR-4qAsUk9T6Sn8FZMBQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOJyEHb_KjPawwH+U30iJCDjB-VqH_FR-4qAsUk9T6Sn8FZMBQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Junichi Uekawa <uekawa@chromium.org>, Tiwei Bie <tiwei.bie@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Takaya Saeki <takayas@chromium.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Aug 08, 2023 at 07:05:38PM +0900, Yuan Yao wrote:
> Sorry, but please ignore=A0this thread.

ok, dropped.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
