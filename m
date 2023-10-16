Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5326CDB474
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 07:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27CC841516;
	Mon, 16 Oct 2023 07:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27CC841516
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cIvWNhBv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6h_7MAIRWFC; Mon, 16 Oct 2023 07:51:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 574C1400DD;
	Mon, 16 Oct 2023 07:51:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 574C1400DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C882C0039;
	Mon, 16 Oct 2023 07:51:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1282C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6EE94095B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6EE94095B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cIvWNhBv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iuxfzGTNNX4J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:51:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DE984094D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DE984094D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697442690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWJN0w7xWWzsBQvThID80a9TVLPdJu/x6hSW6zNhXtU=;
 b=cIvWNhBvq1E/WNggV/gMsM/j8NP5oYB0dCpFz1ka3h82KqFyGk+4JwuVMF53Q74jGJ8ez+
 hnyDM2SaKBLKsqcfaJjosIPqRhY+7jnagTjs1hHu0HxjK1oCXtDluf0EcNUDms/5O41pM9
 Nx8HbQhlaqLi1Uxq3zN2myXi5/KFd0o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-xPiycSaqP1eDItysKyRqTQ-1; Mon, 16 Oct 2023 03:51:28 -0400
X-MC-Unique: xPiycSaqP1eDItysKyRqTQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d879cac50so2592650f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 00:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697442687; x=1698047487;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iWJN0w7xWWzsBQvThID80a9TVLPdJu/x6hSW6zNhXtU=;
 b=MpRGv7fW6VXzYOeCLCg9HaqlztyypzKimYMRvwxFmekA65PkZ0mhwbG9LTqJPE5blq
 LCp/CAZnsbFWb4hXs5yXweFQfgQFnq1wc2Nv7cD3EOhsf+9t426f+YOtinI0pNKupuFV
 YxJ9XJmTMe3VvUWrD5EoeosuUPB0EyKFV2O2cjGyRHqMp7zduB+XNarsyY5DYlJVmQPL
 QbxnYVYKoZ14rivTLaPgYwGsJsKesyXJ3UVJeZAZkA3aeR3pw/DMLh6zV6GNA7UXk+eJ
 7EQyeoOapPkTljW7s46jul+jLpnaCWrvmUGgsjg4ZuUJIpuhHkY5pHufCuMa80sf2RVC
 r32Q==
X-Gm-Message-State: AOJu0YygdCA8f1HSic3wiIY3opo+mWK5NXoamgVfLVbEvemk1TgZfo12
 /oryyd0nyfyDLouJDq1diBfv7B/C+i0X5lQQmJ220duBg1pLwhsbh9GQWLJT+mKSD6MkUgWBWIf
 VP8qqLmr3y/YTV39xq6k/5Nhg4B0hX5xVheU8E8q1jg==
X-Received: by 2002:a5d:6389:0:b0:32d:b488:8dc3 with SMTP id
 p9-20020a5d6389000000b0032db4888dc3mr1990383wru.62.1697442687729; 
 Mon, 16 Oct 2023 00:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1LXqPDGVCf1m88/1JdZzNWkDf44hKGDFwTs5dPfpIuJTAs3f3C5PNPBlsWn0kJItiQ6A7tQ==
X-Received: by 2002:a5d:6389:0:b0:32d:b488:8dc3 with SMTP id
 p9-20020a5d6389000000b0032db4888dc3mr1990361wru.62.1697442687392; 
 Mon, 16 Oct 2023 00:51:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:f56b:1acf:3cb7:c133:f86d])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a5d5944000000b003247d3e5d99sm7138692wri.55.2023.10.16.00.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:51:26 -0700 (PDT)
Date: Mon, 16 Oct 2023 03:51:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/5] virtio-net: separate rx/tx coalescing
 moderation cmds
Message-ID: <20231016035034-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <dc171e2288d2755b1805afde6b394d2d443a134d.1697093455.git.hengqi@linux.alibaba.com>
 <20231013181148.3fd252dc@kernel.org>
 <06d90cc8-ccc0-4b2f-ad42-2db4a6fb229f@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <06d90cc8-ccc0-4b2f-ad42-2db4a6fb229f@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgMDM6NDU6MzhQTSArMDgwMCwgSGVuZyBRaSB3cm90ZToK
PiAKPiAKPiDlnKggMjAyMy8xMC8xNCDkuIrljYg5OjExLCBKYWt1YiBLaWNpbnNraSDlhpnpgZM6
Cj4gPiBPbiBUaHUsIDEyIE9jdCAyMDIzIDE1OjQ0OjA2ICswODAwIEhlbmcgUWkgd3JvdGU6Cj4g
PiA+ICsKPiA+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF9zZW5kX3J4X25vdGZfY29hbF9jbWRzKHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gPiArCQkJCQkgIHN0cnVjdCBldGh0b29sX2NvYWxl
c2NlICplYykKPiA+ID4gK3sKPiA+ID4gKwlzdHJ1Y3Qgc2NhdHRlcmxpc3Qgc2dzX3J4Owo+ID4g
PiArCj4gPiAuLi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6IEluIGZ1bmN0aW9uIOKAmHZpcnRu
ZXRfc2VuZF9yeF9ub3RmX2NvYWxfY21kc+KAmToKPiA+IC4uL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYzozMzA2OjE0OiBlcnJvcjog4oCYaeKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhp
cyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJh2aeKAmT8KPiA+ICAgMzMwNiB8ICAgICAgICAg
Zm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewo+ID4gICAgICAgIHwg
ICAgICAgICAgICAgIF4KPiA+ICAgICAgICB8ICAgICAgICAgICAgICB2aQo+IAo+IFdpbGwgZml4
IGluIHRoZSBuZXh0IHZlcnNpb24uCj4gCj4gVGhhbmtzIQoKT0ssIGhvd2V2ZXIgcGxzIGRvIHRl
c3QgaW5kaXZpZHVhbCBwYXRjaGVzIGFzIHdlbGwgYXMgdGhlIHdob2xlCnBhdGNoc2V0LgoKLS0g
Ck1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
