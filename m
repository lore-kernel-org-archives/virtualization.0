Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C9AC53210
	for <virtualization@archiver.kernel.org>; Sun,  8 Jan 2023 08:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2411F40329;
	Sun,  8 Jan 2023 08:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2411F40329
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=nu5Eherg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fC3hDIwfFb7; Sun,  8 Jan 2023 08:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA5CF40157;
	Sun,  8 Jan 2023 08:59:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA5CF40157
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C926C0032;
	Sun,  8 Jan 2023 08:59:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2112DC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E305B81490
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E305B81490
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=nu5Eherg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vkCi4qoYNPig
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C4068144C
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C4068144C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:26 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so6292868plb.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Jan 2023 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tMlBO3y3CxlZJo8Ox92Yrn0PDl2CnBqv0Ki8egTi1Y4=;
 b=nu5EhergkeBH1AEheFa6zwWTd3B2J35WHTn/6/xij42SbogRJnzwkyaFpYmsSQXyeF
 tsXB+t3mPgMASedM8w9vBwP3SOPOwZ3YHIRz4jNezwco4xXrQ9cw3fUhxaXhSUw/hr7F
 kgRIZMBYSYQkWLofflEYLK/dtBrXzds6QFD4vmrSN7IecUJWKjMYM/UA6kUGvfe5/Wej
 i0AAOSx6/RvQ63hk+7SGr+NgRPvUjJKmX7ff6IlGbXDVX7LxYzttrHrpGqWcDkRQzXGW
 Dm/REnmjOB2fphtBYoD7BMWWfcPHYm4r/WG5W94E86vbo/jP9CpDY6P7LJQYo2POwr34
 9/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMlBO3y3CxlZJo8Ox92Yrn0PDl2CnBqv0Ki8egTi1Y4=;
 b=J13/U0bGhM1ExjhATxRufEgha5+q2U+tOVeLAujQPisZOtefL9WvQiAMwFXErORbjk
 gSgKcwSjj5c25zw+uupjJwIk/rx2MZk0unkYBT2RhU+wXE7KZ/UyyPq3d9HrD3UCTjBo
 mEa14AAcZbRqSEW0vPAwQTNNaN0WjnCi+qa5gYgs24tymqAp84AsNQKCb6FxXfvRdWax
 ekVYGcWJLJtE6kah/qA1GmwQEIvqVzPsuM98X2CD0e/lrtj6helbgXwvh7ywcoVEMqTy
 s8QRwRK4wJxauOzh6bCcobZcYPLsyuVnMP92YQT+Yc+q1AdWCGTtZjfRKjjp2GUc6Stu
 JdTw==
X-Gm-Message-State: AFqh2kpE505CmrTOXN7vSXBdzH9y01cyT3CSvz6As2eZGM/ep6G0yqnd
 XXn4wPdJXe9F9K36NbIttdgdh5E2pb8GzA9D9N0pnNyQS+pGU+JO
X-Google-Smtp-Source: AMrXdXtxTvsC8DQCsvJwFlLfmdiLBAWwtSIqoVYeKuww+TXyl/cT9STWQQhM6WAQT1iC79R1NumAy1T5rHo2ec1Dm14=
X-Received: by 2002:a17:902:7592:b0:192:b77f:c4fa with SMTP id
 j18-20020a170902759200b00192b77fc4famr2686554pll.106.1673168365757; Sun, 08
 Jan 2023 00:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20221220090732.409004-1-alvaro.karsz@solid-run.com>
 <CACGkMEtpYomDhJ+oKhXROA8NPMwWKvLfK2TQRZ30g=o_vW8cQw@mail.gmail.com>
 <CAJs=3_C7dGxs6jZjgOGK=gfL-aJh+GJKr5KPE3Q645621mxcWQ@mail.gmail.com>
 <20221229083155-mutt-send-email-mst@kernel.org>
 <CAJs=3_BRczfcHCpvV-j3xFM50FUy_c9YOZzYUuXOctUKrXznXQ@mail.gmail.com>
In-Reply-To: <CAJs=3_BRczfcHCpvV-j3xFM50FUy_c9YOZzYUuXOctUKrXznXQ@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 8 Jan 2023 10:58:49 +0200
Message-ID: <CAJs=3_BqWW0PkMqhYMY+CCuYW+AEptgeVSWjnZMyBZUQBhrsoQ@mail.gmail.com>
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
This patch was merged into:
[PATCH v7] virtio: vdpa: new SolidNET DPU driver.
So it can be ignored.
Thank you.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
