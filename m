Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E76EB64DC
	for <virtualization@archiver.kernel.org>; Sun, 25 Jun 2023 07:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEFEC40131;
	Sun, 25 Jun 2023 07:19:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEFEC40131
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMslYb5v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOwsROM3dEcZ; Sun, 25 Jun 2023 07:19:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F9FE400D2;
	Sun, 25 Jun 2023 07:19:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F9FE400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F2D6C007A;
	Sun, 25 Jun 2023 07:19:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28A54C0029
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E30924182B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:19:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E30924182B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMslYb5v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K7-IMn_J486K
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:19:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8787141828
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8787141828
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 07:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687677574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crvYJVJpTbYTunCiIEUekC9+YM4D9xRjLajPL7dk4PA=;
 b=QMslYb5vRHwCh8l52KRWHlIYk+PVfZjP1ZHnqlPCZ1aLYVJkZ+9I3t4ZCqw3ZLujhr5J07
 OWuH0/61RJyLB45SGVTOkAjR3CpMMSJtns9aTXKAn4f1bw5D9mm2cWyHtNQj8jJc8TAZgI
 GUCSlcSzMrqujOyN+xPsnpyVGZZQAFw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-OKZcPpgyMxCqZ8PAau_hJg-1; Sun, 25 Jun 2023 03:19:33 -0400
X-MC-Unique: OKZcPpgyMxCqZ8PAau_hJg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso1390842e87.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 00:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687677571; x=1690269571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crvYJVJpTbYTunCiIEUekC9+YM4D9xRjLajPL7dk4PA=;
 b=B71h0/ECnjMewI8RopGb3g9W5/HO9+GuJeESCG3EOTOz4/1PAW4Y5VRH59QgaZJfdH
 6vhvyAV2SRMv9zP8t4eD5/D9D17YAMkn4nCS/deR2VW/zQ3NoE8swTHV4SijdYXXJbIr
 bFF+f2gZWeb6Rv6fqjCXTc/re874mQ9HO76zDyOY+jObyRxNyc8KvU4kd0vffeklyXsv
 pPGrjR4FFkJrkL3CNwpijipDoFuULP2+dSh0k465tGM6/Udc9Usi3oElXPTIlnOqkhF/
 Y9zPCRGsKc3yfHDrvNiigerJsbie4GmZr6fy6LVM0uujUd4kryczZ7mAFftevjsUccNL
 Ns9A==
X-Gm-Message-State: AC+VfDyWLts8jwD1hjwuZAYnIt9WMEOq6oKVqHCudmT++xDgiiFRoFIr
 2NFfSNrrPfAWWFxA9ysc/0TC4RW2b6koyv2xFqGx3DMD/77F3sdss6n0bXlgKOJeg0Dn6dmQMH1
 gbqJaULFmonr6oF3RGeheUPXWBuagfNHNkUPcYq5rwo3QiMukL3Bn+Zkrsg==
X-Received: by 2002:a19:6707:0:b0:4f9:570c:7b28 with SMTP id
 b7-20020a196707000000b004f9570c7b28mr8024954lfc.32.1687677571714; 
 Sun, 25 Jun 2023 00:19:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TgoGtKPYE2HSayNlGMZC/cfCWA138bcv26/89XSaCn7BDOGhY9nOX2R0SMVgiHTEoVQUlFSg/uM40fccKi2k=
X-Received: by 2002:a19:6707:0:b0:4f9:570c:7b28 with SMTP id
 b7-20020a196707000000b004f9570c7b28mr8024939lfc.32.1687677571423; Sun, 25 Jun
 2023 00:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <1687329734.4588535-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687329734.4588535-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 25 Jun 2023 15:19:20 +0800
Message-ID: <CACGkMEvUM3JgcX72OFCQKuPT4M7a8Gtsd68_QMzBUJBg8=h2+A@mail.gmail.com>
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBKdW4gMjEsIDIwMjMgYXQgMjo0M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSGkgSmFzb24sCj4KPiBEbyB5b3UgaGF2ZSBwbGFu
IHRvIHJldmlldyB0aGlzPwoKSnVzdCBjYW1lIGJhY2sgZnJvbSB2YWNhdGlvbiwgd2lsbCBkbyB0
aGlzIG5leHQgd2Vlay4KClRoYW5rcwoKPgo+IFRoYW5rcy4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
