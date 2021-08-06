Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E2C4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 02:50:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1517161186
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 02:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1517161186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0B31400F3;
	Fri,  6 Aug 2021 02:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aPGvfCuc96yz; Fri,  6 Aug 2021 02:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D181400C9;
	Fri,  6 Aug 2021 02:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE35FC0010;
	Fri,  6 Aug 2021 02:50:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD84CC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96D7F40356
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfNK-aXP1Dt5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:50:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68D434032F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628218234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P++QozkDtqtM5XgcTCEzjmR9hrJRUbmCqTgLw7klyiw=;
 b=UGcMkkmj4vgKu9N74qB/a6YimAoJ5ABV87sPoYvWpPNPKc5lrSVlCaudMyjHSFq/9hfFdQ
 f6CMTkRJqLou4oBOJuUhuHuOysWiT8LBtA8KfI/Z8LRTf8ACSus0NA9FuBqsWatHUeE5TP
 ++PxMEPka4w6zKtzta2ROiStalitAmo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-Ir2R3XjQNBOsjyZQODSrfw-1; Thu, 05 Aug 2021 22:50:32 -0400
X-MC-Unique: Ir2R3XjQNBOsjyZQODSrfw-1
Received: by mail-pj1-f71.google.com with SMTP id
 na18-20020a17090b4c12b0290178153d1c65so9113637pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 19:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=P++QozkDtqtM5XgcTCEzjmR9hrJRUbmCqTgLw7klyiw=;
 b=eB4z1KN9tePGXqBlEoSnL2Lu/JTfFBlHbayMoLnb4yaSj5JyqTEoQK22xq4C+nRU68
 mWpmpkDGIOrfeIgAeV7Rq+cxw9joNfajzRlb+qyLq8s3MU1Y2tbXfi3yxjM1FkcCqeCm
 TGhjK2J9CK9PAsIujA15A2200VI+gbjWumT7aXyj31Gu7QK/QAos3gs9TmXErf3TDHIz
 1mgSvA2oNnSbUqLfnIsg8qwP6onz8eqeOmj7lwIKXutYsxyfbxOt1AkiSEHPWS9gUA0G
 1bv36QHoRiRQpPkgic8XYeyE/AKB/PcqAR1w9dfGenuHiJq9ak+C8PeyXlwnNmQuJjUo
 0KCw==
X-Gm-Message-State: AOAM533oPhXcWq/WNlVA+tdgdg//GJV62awTdFDmfvChp1R0qGTGFL2l
 NeuBxL4/POfsn9qp459/nH8fmgDKCEByI1z7O71U8vMlLDYl2voz3E6DNOufwBVGPWltQ4eKrD4
 dk/86Fo9f6B6aqU1R8K41ewNiKgJuKUTbtp2jZUqG2w==
X-Received: by 2002:a17:90a:428f:: with SMTP id
 p15mr18657280pjg.75.1628218231793; 
 Thu, 05 Aug 2021 19:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQNS8F9VexlPEQRGvfH64mAMoL5q9+7MQVozam++zzz+/f5FN+nB92skSZVtNz2vmi45LaGA==
X-Received: by 2002:a17:90a:428f:: with SMTP id
 p15mr18657259pjg.75.1628218231476; 
 Thu, 05 Aug 2021 19:50:31 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c12sm7930795pfl.56.2021.08.05.19.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 19:50:31 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
Date: Fri, 6 Aug 2021 10:50:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805055623-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: elic@nvidia.com, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC81IM/Czuc1OjU3LCBNaWNoYWVsIFMuIFRzaXJraW4g0LS1wDoKPiBPbiBXZWQs
IEp1biAxNiwgMjAyMSBhdCAxMDoxMTo0OVBNICswMzAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+
IEN1cnJlbnRseSB1c2VyIGNhbm5vdCBzZXQgdGhlIG1hYyBhZGRyZXNzIGFuZCBtdHUgb2YgdGhl
IHZkcGEgZGV2aWNlLgo+PiBUaGlzIHBhdGNoc2V0IGVuYWJsZXMgdXNlcnMgdG8gc2V0IHRoZSBt
YWMgYWRkcmVzcyBhbmQgbXR1IG9mIHRoZSB2ZHBhCj4+IGRldmljZSBvbmNlIHRoZSBkZXZpY2Ug
aXMgY3JlYXRlZC4KPj4gSWYgYSB2ZW5kb3IgZHJpdmVyIHN1cHBvcnRzIHN1Y2ggY29uZmlndXJh
dGlvbiB1c2VyIGNhbiBzZXQgaXQgb3RoZXJ3aXNlCj4+IHVzZXIgZ2V0cyB1bnN1cHBvcnRlZCBl
cnJvci4KPiBUaGlzIG1ha2VzIHNlbnNlIHRvIG1lIG92ZXJhbGwuIFBlb3BsZSBhcmUgdXNlZCB0
bwo+IHVzZSBuZXRsaW5rIHRvIHNldCB0aGVzZSBwYXJhbWV0ZXJzLCBhbmQgdmlydGlvIGRvZXMK
PiBub3QgbmVjZXNzYXJpbHkgaGF2ZSBhIHdheSB0byBzZXQgYWxsIGRldmljZQo+IHBhcmFtZXRl
cnMgLSB0aGV5IGNhbiBiZSBSTyBpbiB0aGUgY29uZmlnIHNwYWNlLgoKCkkgZG9uJ3QgZ2V0IGhl
cmUsIHdlIG5lZWQgdG8gY2FyZSBSTyBhcyB3ZWxsIChlLmcgdGhlIG1heF92aXJ0cXVldWVfcGFp
cnMpLgoKQW5kIGRvIHdlIHJlYWxseSB3YW50IG5ldGxpbmsgdUFQSSBmb3IgdmlydGlvIGxpa2U6
CgogIGVudW0gdmRwYV9hdHRyIHsKQEAgLTMzLDYgKzM0LDE2IEBAIGVudW0gdmRwYV9hdHRyIHsK
ICAJVkRQQV9BVFRSX0RFVl9NQVhfVlFTLAkJCS8qIHUzMiAqLwogIAlWRFBBX0FUVFJfREVWX01B
WF9WUV9TSVpFLAkJLyogdTE2ICovCiAgCisJVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIs
CQkvKiBiaW5hcnkgKi8KKwlWRFBBX0FUVFJfREVWX05FVF9TVEFUVVMsCQkvKiB1OCAqLworCVZE
UEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQLAkJLyogdTE2ICovCisJVkRQQV9BVFRSX0RFVl9O
RVRfQ0ZHX01UVSwJCS8qIHUxNiAqLworCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19TUEVFRCwJCS8q
IHUxNiAqLworCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19EVVBMRVgsCQkvKiB1MTYgKi8KKwlWRFBB
X0FUVFJfREVWX05FVF9DRkdfUlNTX01BWF9LRVlfTEVOLAkvKiB1OCAqLworCVZEUEFfQVRUUl9E
RVZfTkVUX0NGR19SU1NfTUFYX0lUX0xFTiwJLyogdTE2ICovCisJVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX1JTU19IQVNIX1RZUEVTLAkvKiB1MzIgKi8KKwogIAkvKiBuZXcgYXR0cmlidXRlcyBtdXN0
IGJlIGFkZGVkIGFib3ZlIGhlcmUgKi8KICAJVkRQQV9BVFRSX01BWCwKICB9OwoKT3IgdmlydGlv
IHVBUEkgYW5kIG1ha2UgbmV0bGluayBhIHRyYW5zcG9ydD8KCkkgcHJlZmVyIHRoZSBsYXR0ZXIg
c2luY2Ugd2Ugd2lsbCBtZWV0IHRoZSBzaW1pbGFyIGlzc3VlIGF0IHRoZSBoYXJkd2FyZSAKbGV2
ZWwgd2hlbiB3ZSB3YW50IHRvIGNyZWF0ZSBhbmQgcHJvdmlzaW9uIHZpcnRpbyBkZXZpY2UgZHlu
YW1pY2FsbHkuCgpUaGFua3MKCgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
