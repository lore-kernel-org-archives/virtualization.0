Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2A4C25B6B
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 03:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC50383E04;
	Tue, 24 Oct 2023 03:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC50383E04
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ri5gYH7g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Nv7pFnRpECA; Tue, 24 Oct 2023 03:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5ED6283D76;
	Tue, 24 Oct 2023 03:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5ED6283D76
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2279AC0039;
	Tue, 24 Oct 2023 03:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16571C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D843642DBB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D843642DBB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=Ri5gYH7g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id trKD5781OK3E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:17:35 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA08D42D6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 03:17:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA08D42D6A
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso6095115a12.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698117453; x=1698722253;
 darn=lists.linux-foundation.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j7+5QUAo2UOt8izQ1SjPKPLQvvl/vw27MMIOfZgGyFo=;
 b=Ri5gYH7gP9Eo91qQ27w/29B1XW3xRsn9TTjvQIYS1gv5gDTRmdCSHBEmSAKKtYveet
 XhHBJeeVZiBIEXuIgulHZOA232d9glQVhU/P08u2j9dcm+r0gsSxpvcpyTnVVPyd2B68
 RCrd2R5y4kopuXDxyOHDwYftAAHE09GvruMvo2YzD7Enh+wIAN+aVekh3FODvjG2mTad
 PAmiytGb2+gfYdO3O2/J184MRZaxJXd04V/uha6chU5cLAKRiQo+L7xQJIvQBYrPQSux
 JqfEzV8LXGWbKHd2r4tlQJfpFcySVT524bgnJU35Q7kY2GacW1BSDgqezvGr/ZxF2VLy
 Tl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698117453; x=1698722253;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j7+5QUAo2UOt8izQ1SjPKPLQvvl/vw27MMIOfZgGyFo=;
 b=gwxv3QqAf1i5KvR78GmC/K/jFaqrhEaUmFIzx2BSTakO6GzozzPovIg6SM+QK6FRxs
 M009O29YqZQ8JkwvbGWn61+VxbuHjhLFp62lnwBtniE300p1BZGfdG82GI8IbrKvRw3k
 Xt+1lzXeO/6V7a99KZ5Y6MKavTp+p5IZZlAwcf7PDkYK2RzqOwzok5twEZzwoMF/CHzg
 y4sFVdb746F70SeD4xWk+tPBotU8qi1MQrgOTQlirgc+Wpn5QtHnlAaGeZ1Dkc3XxaGG
 TkxoOiJY4cB88YF5NSABeXPhGMpN92iBySThEOQ5SWI8y9jEq/7eY5oRExAbXqbhjhDu
 CTJQ==
X-Gm-Message-State: AOJu0YxvBr/+OwFM1pC8/0McNnGcBy5N1E9m1j42vESEU+MOoB5EQuWZ
 Wk8HMqPZ7WQN0Z9lz0nryd/hdw8QFrBxOByVWuM=
X-Google-Smtp-Source: AGHT+IG8tJnulcq9aalq3wkuxo47FPUL6DR+V3ke9GypTtRossSLtW9VLw3Lkp0jZxXFk6nhJwYgVt3HLPGNZkBVuOQ=
X-Received: by 2002:a50:d094:0:b0:53e:df4:fe72 with SMTP id
 v20-20020a50d094000000b0053e0df4fe72mr7228173edd.32.1698117452658; Mon, 23
 Oct 2023 20:17:32 -0700 (PDT)
MIME-Version: 1.0
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 24 Oct 2023 11:17:20 +0800
Message-ID: <CAKhg4tKSWLood9aFo7r1j-a3sXvf+WraFV_xUcKOMLq9sxrPXA@mail.gmail.com>
Subject: [RFC] vhost: vmap virtio descriptor table kernel/kvm
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

vmap:
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
