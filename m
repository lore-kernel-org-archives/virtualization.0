Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E212C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 12:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72F4960EA6;
	Fri, 11 Nov 2022 12:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72F4960EA6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=2yCa1ioj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dy5gE5b_Wbr4; Fri, 11 Nov 2022 12:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2435C60E74;
	Fri, 11 Nov 2022 12:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2435C60E74
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1EE9C0032;
	Fri, 11 Nov 2022 12:20:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32D70C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 12:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3ACC404A6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 12:20:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3ACC404A6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=2yCa1ioj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RnO_R9oV2NUj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 12:20:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2456B40382
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2456B40382
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 12:20:40 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id c129so4796348oia.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 04:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LhzE/MG7FlvtqwDBwWAIq2DiOIlJQYBZW+fAYLZs7cY=;
 b=2yCa1ioj5ia45YwPyyoOGCJyh1lpM7OkoBX5JlSyKH5C4FezozhSIxVaNtLNWAzB5Q
 6cqJ/rRWIdXZ0hlqUds7ElZQuIxROx8Hi1IIRmNRgFh0ls076XGg4jiwwWejFeh6CR2a
 6WCxUV84MBb+psPAl27W4oXhPdO+WamX1mcDJO+xZthi9Um3arpwSdGUsB78Me09YzS5
 REBb0UR4dSIJ7wwZM3FTJPdJQoYuvFaxxCfM9Keyl96+OevnPUJq2dyJ86gRdjmPo946
 xiyCWxax0bGA6trAHIEUUro/Mgp8vpGrfNeW4Yldmyp4g4KnNzuOzkp5CIVVVzjJ7HHm
 fd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhzE/MG7FlvtqwDBwWAIq2DiOIlJQYBZW+fAYLZs7cY=;
 b=5wWhMGqHTN/GN9ho+07pmR4FXs7OqXN6/3K4dwlryCXzxpKJln4tihdrelOF4JKKbA
 OkgPfnkJNLE32run6dMNbXvBFDhP9uykQqBqeAPQvhPj51xdpk24umATppiLqqpMPbNm
 gVqCdq9BfZ6YEToDTv7OqP7GKYfNe1QuiULftIzaTSOHVZOtexIF3gIFro/bLMKrFOA+
 260JpdnZ+aYeRJ03aMP8eL+b9j51LPZK7vFLtoPSbt6rCwZxTRxmgDVRwRvqQ5NL4zew
 Zg/N6R3pLvmtYV86zVnj+sukiQol2L3XcIFjC1w2DuRLr2KzCcHOnFREi0b8k/rJBJNX
 m/KA==
X-Gm-Message-State: ANoB5pl7+Bk5WLx+yZndjqJsXnQHW1fpqr0I1BWhx5GNKgxDtjgoc1vF
 wGt4Y55LDp30mwmtOXmdZCMNAvqSn6HUiBpSrht5PspKVrpzZg==
X-Google-Smtp-Source: AA0mqf5cjS9muKOtXn4H5UsR9bUbNacCUQPjUooU8u6ADpsU907oIO6eMFSK39+bAVfAzVEAWVYES+mCmrjVv7AdjpE=
X-Received: by 2002:aca:1e11:0:b0:35a:6d81:204a with SMTP id
 m17-20020aca1e11000000b0035a6d81204amr594261oic.102.1668169238918; Fri, 11
 Nov 2022 04:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20221108125354.898722-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221108125354.898722-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 11 Nov 2022 14:20:01 +0200
Message-ID: <CAJs=3_AvDxkY-DZCbRUPw08DsHCoNS6s7cCjcjXMiFkq1K-03w@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: virtualization@lists.linux-foundation.org
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

> +       /* The virtio_blk_lifetime struct fields follow virtio spec.
> +        * There is no check/decode on values received from the device.
> +        * The data is sent as is to the user.
> +        */

After more thought, I think that the driver should handle the
virtio_blk_lifetime struct endianness.
Something like:
...
lifetime.pre_eol_info = __le16_to_cpu(lifetime.pre_eol_info);
lifetime. device_lifetime_est_typ_a  = __le16_to_cpu(lifetime.
device_lifetime_est_typ_a);
lifetime. device_lifetime_est_typ_b  = __le16_to_cpu(lifetime.
device_lifetime_est_typ_b);

if (copy_to_user((void __user *)arg, (void *)&lifetime,
...

What do you think?
I'll wait a few days and create a new version.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
