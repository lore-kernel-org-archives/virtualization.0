Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F59C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 11:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C9E240022;
	Mon, 12 Dec 2022 11:54:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C9E240022
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=XWtaUwLn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e13Ji-lBH27n; Mon, 12 Dec 2022 11:54:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E23F140253;
	Mon, 12 Dec 2022 11:54:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E23F140253
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A222EC0033;
	Mon, 12 Dec 2022 11:54:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83B47C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 11:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DF5E80C1D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 11:54:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DF5E80C1D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=XWtaUwLn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3HjE0RPkJxKX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 11:54:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9910F80C1C
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9910F80C1C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 11:54:20 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id r18so7992696pgr.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=esv0G9bdFPbCR5DXC1je0ygutCJYp678EUugqYxwu84=;
 b=XWtaUwLnu7+XzTr1fwcSlYnk0hO1TlJKFRRW3rKdfi3rDbkIv3z5PPIBKnX0uuKr9Q
 C6inSko/ZRhmm+b4iDw1sf3+FPghIyLsPgBz+KLinvP6bC8PlMEIRL7yHHzPUnYxhXMF
 3yZPUF6ijYeE+mWuP4sHbC/e5ylPRjgJjmEpVqyaI9G8wSFbMWvn7x5f5AuJHGctw7y2
 I0gEUKy1G80W8G3q1yOhEU6koGXGUVyrAJoQIyNWcb7+5QPidewxcEbOtRxNQgIKZJfI
 lQpQZAZ+ZbwxVChZS4AaxscUu/T0v0U7IRD5wcehVy9kro6VcJCDduqzElMGtrWe1fdf
 c9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esv0G9bdFPbCR5DXC1je0ygutCJYp678EUugqYxwu84=;
 b=xWIQ6s3IkQMBnUzkCwYfdHbiThvH9uCUSEHHQqlEna4G43KzOSbY85x7xybLmJv3yd
 RsJ6U8f0Y+ZmeHnZ2jaSYAdmAHDOzWYvSCrQCX7SzfpUFfzony3n2x2MeWolNhjhuU5q
 4WGp/tzLp1n9d35O7Bjg5OiHv7vUlXYHBhTF1FjKPux7tO0DXevZsw7Pd4IJ8LxREVxK
 GXd7arTS5WJSnBiK2iMERDu8W3Ch4uSZSKLToDsrcAO+fK8l7V7+BEq7/k+zLbcTU6mJ
 MPO+NzjtyLIvjiQNCBzDb67bJc4c5onHMZJY/CpVMS8jzhCZ1W68Nr6Ry9kYqSHZQzjU
 aZDw==
X-Gm-Message-State: ANoB5plEN4oM/zBsgkQhH1ceqB3yKiUtOwdFZa3NlsUJ3ut0w4Jp+UfV
 YROFk3AIMfZAGTQCFTCv3IGjntd5W/kybdmmmFfR5SRy1bpNq1QC
X-Google-Smtp-Source: AA0mqf55peot7sRWc8oT/I9pwnXAjDMvc9eELR6pp84PawhE3+MSLn14QEn1q5UBr4iDRocA1StE5rdTco5I+JBFF28=
X-Received: by 2002:a63:1220:0:b0:478:fbed:3ade with SMTP id
 h32-20020a631220000000b00478fbed3ademr5455167pgl.255.1670846059057; Mon, 12
 Dec 2022 03:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20221206153941.2348775-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221206153941.2348775-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 12 Dec 2022 13:53:42 +0200
Message-ID: <CAJs=3_BkThikqvTZJfZpMv-45tpPx3XbWY5DaeZ8yGnHLOnLAw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: vdpa: new SolidNET DPU driver.
To: virtualization@lists.linux-foundation.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Hi all,
I need to fix this version.
PCIe FLR capability is advertised, but using it may hang the device.

I will create a new version with quirk_no_flr.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
