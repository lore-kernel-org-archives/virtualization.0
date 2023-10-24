Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21606C25B67
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 03:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 994F041A52;
	Tue, 24 Oct 2023 03:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 994F041A52
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gR6KK6b9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vVn5wEsMz46; Tue, 24 Oct 2023 03:10:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82FC64052A;
	Tue, 24 Oct 2023 03:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82FC64052A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49F3FC0039;
	Tue, 24 Oct 2023 03:10:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C14CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 144E883D46
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 144E883D46
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=gR6KK6b9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QK9T6ygErR18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:10:43 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D83F783D45
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D83F783D45
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so6087372a12.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698117041; x=1698721841;
 darn=lists.linux-foundation.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hcMR4OV3Qa58zLtXWS6CqD73NZyZ4Zo3HUk8KUykTLs=;
 b=gR6KK6b9Gz1r10yn8WOBdd1ePBDzt4pF0Na34z+xV4qVD8iWpFX9ETvA8fPtD+ImtA
 /dGvydXXTS0qf47gEyil9sl8aYv/ZC/sm7eQAYnMDVATwb0dhZKHP0ORarQ6Whcn02GP
 nmUv9uACl9hMsT/n8DCezmrph7DjhldQql65p1v3mpoHKItv79v0V8rpo1h8oAltXS+g
 SbTDyTspxFnO6dHtMgMSGtY0tqZrY68lOMwAp714DQEAp5v1heWcN7O54F1uLf6wyhQd
 ExSr45iXGaPL3VnJ5q8/8BpmOk4VxNxH4vdN8h9Jb/d/kmMZKkcxsQLRAI/bzgQENzM/
 crJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698117041; x=1698721841;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hcMR4OV3Qa58zLtXWS6CqD73NZyZ4Zo3HUk8KUykTLs=;
 b=EZAvvgmgREhsnOHqJf8YttDWFPWQHbcj12Ybqt7DNS5Yw95tuGznRB63LKw+Tw6bbm
 ZBNm7t3sP73r/3m1a6gwqhEtgm1BOwn2eXT6RUxaAzaAtjZ5cBqKi6ZBFs89SN3QGTnW
 l5FIweLRX4eRRNe2A5gL57ZeVT6bu+Rsj0vF6zguFMff7RAQ5XDLTHyBK6r5cIfD3X6K
 0mgR8Q+RXuWWV4+CDMWShJpffFZD84vrGasI6ODAMtd/8/oJIhqaPWZVVsssMuuloysJ
 GjW2irnp8r4erlnyPfRlDkZ+TWbXK9GH3vBVlnpoqzy/ydx0i0Io15GWNpbLwAbOfSir
 8Ubw==
X-Gm-Message-State: AOJu0YyMRykcEJp7fY2hvgdj//GmG4iLJq0rut2itY7RcjfcoL8WV113
 zp3mTLjjGUmhZlmeqMyqANLyBAkPY78uglAAGUG4paWPf00=
X-Google-Smtp-Source: AGHT+IG7gC0U08NQqruXCW4WAmMAIYNvyBuE/X3kQm5VqQZDZ8M8LIKlvYfztUlkviQAEDh41pif5QR5DczebOAsq/s=
X-Received: by 2002:a05:6402:274e:b0:53e:3b8f:8a58 with SMTP id
 z14-20020a056402274e00b0053e3b8f8a58mr9224090edd.11.1698117040723; Mon, 23
 Oct 2023 20:10:40 -0700 (PDT)
MIME-Version: 1.0
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 24 Oct 2023 11:10:28 +0800
Message-ID: <CAKhg4t+QPszSZnWEnAXEVPL6t44syimO3bm43jmgLPZ7jv5gaQ@mail.gmail.com>
Subject: [RFC] vmap virtio descriptor table
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

The current vhost code uses 'copy_from_user' to copy descriptors from
userspace to vhost. We attempted to 'vmap' the descriptor table to
reduce the overhead associated with 'copy_from_user' during descriptor
access, because it can be accessed quite frequently. This change
resulted in a moderate performance improvement (approximately 3%) in
our pktgen test, as shown below. Additionally, the latency in the
'vhost_get_vq_desc' function shows a noticeable decrease.

current code:
                IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
rxcmp/s   txcmp/s  rxmcst/s   %ifutil
Average:        vnet0      0.31 1330807.03      0.02  77976.98
0.00      0.00      0.00      6.39
# /usr/share/bcc/tools/funclatency -d 10 vhost_get_vq_desc
avg = 145 nsecs, total: 1455980341 nsecs, count: 9985224

kmap:
                IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s
rxcmp/s   txcmp/s  rxmcst/s   %ifutil
Average:        vnet0      0.07 1371870.49      0.00  80383.04
0.00      0.00      0.00      6.58
# /usr/share/bcc/tools/funclatency -d 10 vhost_get_vq_desc
avg = 122 nsecs, total: 1286983929 nsecs, count: 10478134

We are uncertain if there are any aspects we may have overlooked and
would appreciate any advice before we submit an actual patch.


Thanks,
Liang
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
