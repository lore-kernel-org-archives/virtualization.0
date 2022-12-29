Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15554C4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 12:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F39F4003C;
	Thu, 29 Dec 2022 12:14:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F39F4003C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=gXGGtO4P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gUrnnrk8lma; Thu, 29 Dec 2022 12:14:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA88B4047D;
	Thu, 29 Dec 2022 12:14:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA88B4047D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6CC0C0032;
	Thu, 29 Dec 2022 12:14:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA081C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A148860D65
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:14:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A148860D65
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=gXGGtO4P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4EpVFWGqD9IF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:14:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2109C60A8A
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2109C60A8A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 12:14:34 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 h7-20020a17090aa88700b00225f3e4c992so10131194pjq.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 04:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yUZUcM/bLO06wq3kvKOULQRKoS9k2SB3IQA5HvCZn1Y=;
 b=gXGGtO4PEHrytF5E9/9itQis5a1r/TAfZ56Bi7V4MGXSTvbSsOR40xWPgDbH1utD7/
 TpgDw6P1ltY6n76CgwajzQEzkBUfdsccZI4ztpHbfx8aPmwi3qyORAhD3UbvB7lYPI3R
 EiwTdTszE6l26So18Lk7Ez9VE//2Kqkdiakr+ckf8++97gS1pNql89A1B7QR7dbLS37m
 ZkNIDIkIxKXgO3cCck68VbZZzyQaHTR7gLettK2KlitBKPhpdr149JDIOY0dYdOMts4z
 F0MIpX1aYH9vcWo/BrS28Pvbvw1bnIJ6CU5x0ILv2RGmDdfyzxdfPd5njGmNTYA2SO/z
 Zwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUZUcM/bLO06wq3kvKOULQRKoS9k2SB3IQA5HvCZn1Y=;
 b=IKBzirdfSb3wHu23KhhWdl/hO548nMTO2BEXkej0nr5GNYTPDt9OKhxrjy+3uT3Kq0
 uaoNipRIS95JPONFrCEKKqp8mUJHB7j3ILDKZJeSiNdVs/zJ7sUY1YnxQxUKBWX5QrAc
 rP1lhquFqEsDMlsJ1PSumKXs3NjM8kIFal6kUKvfiTPypzcoV0LR4HfcOiEZLJY3s11e
 TqcOElsaE40cSXblqjROSTeDitrruGbrBGd21ySRUqkFt0rU9bxcMMeZgZMs0SvnmO2W
 UlSBpoekdSOm0tzB/Gbq/Vtpn8/hBswv5BzMzxPpcWTnUI6SPv4MM+cPrksO4gyk06Qr
 wr0Q==
X-Gm-Message-State: AFqh2koaBMzkb7GfOA8ZKYcrsknXVBMw9JM8LnUIzVTIUvMkEBZorz6l
 6n22jwOJ05ZtrPFGrQ2e694qQD042W840UqsPbo6in6ByISX3VKd
X-Google-Smtp-Source: AMrXdXulTg/7W0x7f1xMsfMg/PgJkvImFqQSSWDQfTsnSD9oitcyqn/eONEOfESr41G3SbPcxEs8BfzBKWf6IJ9bXe0=
X-Received: by 2002:a17:903:3014:b0:189:d0d5:e75b with SMTP id
 o20-20020a170903301400b00189d0d5e75bmr2149473pla.163.1672316073474; Thu, 29
 Dec 2022 04:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20221220090732.409004-1-alvaro.karsz@solid-run.com>
 <CACGkMEtpYomDhJ+oKhXROA8NPMwWKvLfK2TQRZ30g=o_vW8cQw@mail.gmail.com>
In-Reply-To: <CACGkMEtpYomDhJ+oKhXROA8NPMwWKvLfK2TQRZ30g=o_vW8cQw@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 29 Dec 2022 14:13:57 +0200
Message-ID: <CAJs=3_C7dGxs6jZjgOGK=gfL-aJh+GJKr5KPE3Q645621mxcWQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: explain the dependency of SNET_VDPA on HWMON
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
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

Hi Michael,

Is this patch ok with you?
Do you have any comments?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
