Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A5C3A5A7
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 07:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F44D8142F;
	Tue,  6 Dec 2022 07:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F44D8142F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Mcl+f9CI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hlPdsCuU7cKq; Tue,  6 Dec 2022 07:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9585981357;
	Tue,  6 Dec 2022 07:51:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9585981357
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E46BC0032;
	Tue,  6 Dec 2022 07:51:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE01EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 07:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE8D960BFF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 07:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE8D960BFF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=Mcl+f9CI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjIkU0tV795L
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 07:51:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4D9460BF5
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4D9460BF5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 07:51:27 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id p6so179712iod.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 23:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=th13LpKEhaUY0BsYrRcw7Q2meQ4gQag6IPpnyQnL+fY=;
 b=Mcl+f9CI7tQreqZPCUg2mcs6KaQVKGs5FqZLfpx5OdS7ZsshgatBz+xIWPGt9VWJJ+
 614EsRBKiCOpQDxv4iI+1VWipZjsGVtypMqwQPpEM+I9MyIXhjnrhl9QkLAVwwbN+783
 ++67K9FQ2f6a3Fly4V4YxYomyJ7Y03LcawDJPBJTXH0arW58hTNAXMKVd2P77IkJyMY5
 uhkpf2YwWqFeR9kbjYj+OL815K41mk9E3VGIaZD+LLarcQn9HiY+cPLxDA5ac52UoZCN
 fWYFe3g+wRcB999O3mNphhDytxtdIq1XpYwyMffysed3fFxo1o4LOqRqwvCIFiA/saW/
 MvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=th13LpKEhaUY0BsYrRcw7Q2meQ4gQag6IPpnyQnL+fY=;
 b=JNwQ22lw6igYDZNmuRvNvHsJXnET3Y4HDad6nXdZ3EkPuq/CN65Ozu7GDI/CMIyh8f
 /USkr2hPUdvl+kroZU+dyA5BIo6IG+UbZkn/de40kHjJeHNqfjpzkDblT2Be887hgmSe
 t0mavKfyoSiftAECCxPufBJR7pBDWbs1whERRtX0lnic6GFU8kQcpTD6w7Q//HAo7hZu
 7Z91gJ3SnMaiKkoqIKRcAjwv7PWcnDs7Mwyu0TDnAGdNmcHRY0VtFrycWI/qZ5I7BL3L
 7y7rV7GdVk1RpXD63fL6emnc6zsC43yr3SF3WfnC2paYJhhQbVM16WgBi+cYdKCxtgwi
 pBPA==
X-Gm-Message-State: ANoB5pmgrMP1WugQ98g3W1yTKoC3tlvA8A8afuAz9uGbQgOU52HchsgG
 IvBGUGodsmWrdqnnIgL8XTsnqsUv2RePKbY24ohVWH44aApFQA==
X-Google-Smtp-Source: AA0mqf5shy+knpo/bHzarKZkYcIkK6X+0Qb3MkSC7O3uUg9MaCltgt8NR5MQyZoO+QLLs0/KXEk0fceOGCB/W0QMqGs=
X-Received: by 2002:a02:6603:0:b0:375:9e02:b459 with SMTP id
 k3-20020a026603000000b003759e02b459mr39456070jac.30.1670313086822; Mon, 05
 Dec 2022 23:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20221129143335.1902170-1-alvaro.karsz@solid-run.com>
 <9cc0448a-7a69-727c-a27e-32a27b7cd5e4@redhat.com>
 <CAJs=3_AOoY=8GmMEbQfz2LDGPVWHgU5pw5Levs8rBTsSwfUdpg@mail.gmail.com>
 <CAJs=3_A+4hdcrHEiuQv+z_4SHoKNQ8F5qJYDA8SkOBk+SZFwWA@mail.gmail.com>
 <CACGkMEsn2Pcg3fvAFMf01r7VNs3FY8BzYr7ZPQ81f8bzzGHm4Q@mail.gmail.com>
In-Reply-To: <CACGkMEsn2Pcg3fvAFMf01r7VNs3FY8BzYr7ZPQ81f8bzzGHm4Q@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 6 Dec 2022 09:50:51 +0200
Message-ID: <CAJs=3_DxeyCQtKzCWRMiSEaWPxti8Xz4LX2OKJ1hpm-JhRcWWA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: vdpa: new SolidNET DPU driver.
To: Jason Wang <jasowang@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, virtualization@lists.linux-foundation.org
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

Thanks
I'll send a new version.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
