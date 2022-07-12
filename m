Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0780C43334
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 08:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52EA783E75;
	Tue, 12 Jul 2022 08:46:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52EA783E75
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P49X28+l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DArA_3gXVt7H; Tue, 12 Jul 2022 08:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CBE6583E66;
	Tue, 12 Jul 2022 08:46:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBE6583E66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EDE4C0033;
	Tue, 12 Jul 2022 08:46:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10272C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C83F060F89
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C83F060F89
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P49X28+l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ga2xBwZBGJTb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:46:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFBFC60F3E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFBFC60F3E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657615559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5viHAMgMI6jui+cYPhD/VCPPSMBqFNLNZorgYl625U=;
 b=P49X28+lyBjfeOtbPFyF1yoFhJIuUuJGWndqLdjGpOQ193rTGHIKse0MKW/E2Iw52Gc9TR
 oniJLIvL7wRMWxtxctpOmPYp4sYxVHQ1GtC5yVUmwmGEQHkcm+NzcfNs0lc4Dpn0XIHdXN
 n61GfxXezQf+9fl7KwQx0CDfXm9mKBQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-plrF2y_DMuqNSlez6oRG3g-1; Tue, 12 Jul 2022 04:45:58 -0400
X-MC-Unique: plrF2y_DMuqNSlez6oRG3g-1
Received: by mail-qv1-f71.google.com with SMTP id
 ln2-20020a0562145a8200b0047301e9bc53so1426309qvb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 01:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/5viHAMgMI6jui+cYPhD/VCPPSMBqFNLNZorgYl625U=;
 b=0vz3hCvYZfpCdQeEmvT3uD7Y2TQ6Bkr9RHjNE7ZgdhtyJom3XPV2YJEZ75bL+7vkho
 O2OODEnVTKxR8879Iyb/2jBDDf1zA4ozem++4glA0AEm/8CbFQEh8+eSdKiQd7+n6bGv
 7ewbVEZS0Uvq+WN3cVCzhqUPVp0YRILZ43XeGclGOPNebEC1wUk+M7JSwL0UAlAAMgeg
 98kkxo65QIDJgC2xoPXLjmSuiI+5Um2imR2bXpEaAzOcnfkrpMzctSkeX562LVi9XeCU
 8MRXlxJye6MULmWh8EyhMFdLsF4pSMkN9Hdtb763rHyRh8F+pZQCbubaApcLb+98syW/
 nuFA==
X-Gm-Message-State: AJIora/k/PqqIdvjXDzAvOIYsT4Ey2IPLw/2OkNctP6jgPU+cuA1Yso2
 kNRAhhkg40UMUlvz8HzqpKxtjAKNEmvuuTKamlra7MjJ6ZGlsKb9pRJGMd81ylVg1MulYCFpRwG
 QhsMSOgkrVJ2/QfdwmYaKGiEunO7eoOk76pU3s3ap2w==
X-Received: by 2002:a05:6214:2465:b0:472:fcc9:1dcd with SMTP id
 im5-20020a056214246500b00472fcc91dcdmr16963096qvb.78.1657615557882; 
 Tue, 12 Jul 2022 01:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUTQ99MFxlI2VwBl7zvyJVXCGsmZNH1yRbY+f7aA3VJw4iVjvfnEC2GZTTk2GKSBne6wfjlQ==
X-Received: by 2002:a05:6214:2465:b0:472:fcc9:1dcd with SMTP id
 im5-20020a056214246500b00472fcc91dcdmr16963088qvb.78.1657615557707; 
 Tue, 12 Jul 2022 01:45:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 bl29-20020a05620a1a9d00b006af45243e15sm8774185qkb.114.2022.07.12.01.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 01:45:53 -0700 (PDT)
Date: Tue, 12 Jul 2022 10:45:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
Message-ID: <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBKdWwgMTIsIDIwMjIgYXQgMDQ6MzQ6MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+5ZyoIDIwMjIvNy81IDAxOjE2LCBTdGVmYW5vIEdhcnphcmVsbGEg5YaZ6YGTOgo+PlRo
ZSBmaXJzdCAzIHBhdGNoZXMgZml4IHZhcmlvdXMgcHJvYmxlbXMgSSBoYXZlIGVuY291bnRlcmVk
IHdpdGgKPj52aXJ0aW9fdGVzdCAodGhleSBtYXkgZ28gd2l0aG91dCB0aGlzIHNlcmllcywgYnV0
IEkgaW5jbHVkZWQgdG8gYWxsb3cgeW91Cj4+dG8gdGVzdCB0aGUgc2VyaWVzKS4KPj4KPj5QYXRj
aCA0IGlzIGluIHByZXBhcmF0aW9uIG9mIHBhdGNoIDUsIG1vdmluZyB0aGUgZmVhdHVyZSBuZWdv
dGlhdGlvbiB3aGVuCj4+d2UgaW5pdGlhbGl6ZSB0aGUgZGV2aWNlLgo+Pgo+PlBhdGNoIDUgYWRk
IHRoZSBzdXBwb3J0IG9mIHZob3N0LXZkcGEgaW4gdmlydGlvX3Rlc3QKPj4KPj5QYXRjaCA2IGFk
ZCB2ZHBhX3Rlc3Qua28gYmFzZWQgb24gdmRwYV9zaW1fdGVzdC5jLCBzbyB3ZSBjYW4gcmV1c2Ug
bW9zdCBvZgo+PnRoZSBjb2RlIGNvbWluZyBmcm9tIHRoZSB2ZHBhX3NpbSBmcmFtZXdvcmsuCj4+
Cj4+SSB0ZXN0ZWQgaW4gdGhpcyB3YXk6Cj4+Cj4+ICAgJCBtb2Rwcm9iZSB2ZHBhX3NpbQo+PiAg
ICQgbW9kcHJvYmUgdmhvc3QtdmRwYQo+Pgo+PiAgICMgbG9hZCB0aGUgdmRwYXNpbV90ZXN0IGRl
dmljZQo+PiAgICQgaW5zbW9kIHZkcGFfdGVzdC5rbwo+Pgo+PiAgICMgY3JlYXRlIGEgbmV3IHZk
cGFzaW1fdGVzdCBkZXZpY2UKPj4gICAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHZkcGFzaW1fdGVz
dCBuYW1lIGRldjAKPgo+Cj5JIHdvbmRlciB3aGF0J3MgdGhlIGJlbmVmaXQgb2YgdXNpbmcgYSBk
ZWRpY2F0ZWQgdGVzdCBkZXZpY2Ugb3RoZXIgCj50aGFuIG5ldHdvcmtpbmc/IChhbHJlYWR5IGEg
bG9vcGJhY2sgZGV2aWNlIGFueWhvdykuCj4KClRoZSBtYWluIGFkdmFudGFnZSBJIHdhcyB0aGlu
a2luZyBpcyB0aGF0IHdlIGNhbiBleHRlbmQgaXQgYXQgd2lsbCB0byAKdHJ5IHRvIGNvdmVyIGFz
IG11Y2ggYXMgcG9zc2libGUgYWxsIHRoZSBwYXRocyB0aGF0IG1heWJlIHdpdGggbmV0IHdlIApj
YW4ndCAoaW5kaXJlY3QsIHJlc2V0LCBldGMuKS4KClBsdXMgaXQgc2hvdWxkIGJlIGVhc2llciB0
byB0ZXN0IHZob3N0LXZkcGEgdGhpcyB3YXkgd2l0aG91dCB1c2luZyBRRU1VLgoKRG8geW91IHRo
aW5rIHRoaXMgaXMgcmVkdW5kYW50PwoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
