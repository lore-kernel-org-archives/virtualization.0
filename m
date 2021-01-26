Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5727C433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 08:10:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A10206FB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 08:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A10206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D805886713;
	Tue, 26 Jan 2021 08:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PPSPnUisQlmH; Tue, 26 Jan 2021 08:10:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14E008667C;
	Tue, 26 Jan 2021 08:10:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07148C0FA7;
	Tue, 26 Jan 2021 08:10:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 095AFC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E917120386
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id whTIhwb0IYqF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:10:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id CD90F20034
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611648636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djhTRJGJg3J6BeW0ceDPJuujST4T2Jt9ExZ596qYokQ=;
 b=evDxedQj6ZvVB7RZnWuriP/fMNKoZ9lTAlAe2CWemnHDplELSLSXgkgREzt2tC2UlMiJmf
 jL7RQvs1ToIXejBQSh+GGZlCCW6KiHzImSMQ6AqnJqhkvgrTW1ZHkTXnptS25L9y0H5EAU
 ehijplBgPmpOG1FEesNDFfV5BWk4+1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-9NkikARFNxGCYD4QHeGSrw-1; Tue, 26 Jan 2021 03:10:32 -0500
X-MC-Unique: 9NkikARFNxGCYD4QHeGSrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1FF51005D6E;
 Tue, 26 Jan 2021 08:10:17 +0000 (UTC)
Received: from [10.72.12.70] (ovpn-12-70.pek2.redhat.com [10.72.12.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C5EE77BE1;
 Tue, 26 Jan 2021 08:09:48 +0000 (UTC)
Subject: Re: [RFC v3 10/11] vduse: grab the module's references until there is
 no vduse device
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119050756.600-1-xieyongji@bytedance.com>
 <20210119050756.600-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <406479e4-a4f8-63f3-38f5-b1c3bb6e31ab@redhat.com>
Date: Tue, 26 Jan 2021 16:09:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119050756.600-4-xieyongji@bytedance.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8xOSDkuIvljYgxOjA3LCBYaWUgWW9uZ2ppIHdyb3RlOgo+IFRoZSBtb2R1bGUg
c2hvdWxkIG5vdCBiZSB1bmxvYWRlZCBpZiBhbnkgdmR1c2UgZGV2aWNlIGV4aXN0cy4KPiBTbyBp
bmNyZWFzZSB0aGUgbW9kdWxlJ3MgcmVmZXJlbmNlIGNvdW50IHdoZW4gY3JlYXRpbmcgdmR1c2UK
PiBkZXZpY2UuIEFuZCB0aGUgcmVmZXJlbmNlIGNvdW50IGlzIGtlcHQgdW50aWwgdGhlIGRldmlj
ZSBpcwo+IGRlc3Ryb3llZC4KPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdq
aUBieXRlZGFuY2UuY29tPgoKCkxvb2tzIGxpa2UgYSBidWcgZml4LiBJZiB5ZXMsIGxldCdzIHNx
dWFzaCB0aGlzIGludG8gcGF0Y2ggOC4KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEv
dmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2
LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gaW5kZXggNGQyMTIwM2Rh
NWI2Li4wMDNhZWIyODFiY2UgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92
ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBA
QCAtOTc4LDYgKzk3OCw3IEBAIHN0YXRpYyBpbnQgdmR1c2VfZGVzdHJveV9kZXYodTMyIGlkKQo+
ICAgCWtmcmVlKGRldi0+dnFzKTsKPiAgIAl2ZHVzZV9kb21haW5fZGVzdHJveShkZXYtPmRvbWFp
bik7Cj4gICAJdmR1c2VfZGV2X2Rlc3Ryb3koZGV2KTsKPiArCW1vZHVsZV9wdXQoVEhJU19NT0RV
TEUpOwo+ICAgCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gQEAgLTEwMjIsNiArMTAyMyw3IEBAIHN0
YXRpYyBpbnQgdmR1c2VfY3JlYXRlX2RldihzdHJ1Y3QgdmR1c2VfZGV2X2NvbmZpZyAqY29uZmln
KQo+ICAgCj4gICAJZGV2LT5jb25uZWN0ZWQgPSB0cnVlOwo+ICAgCWxpc3RfYWRkKCZkZXYtPmxp
c3QsICZ2ZHVzZV9kZXZzKTsKPiArCV9fbW9kdWxlX2dldChUSElTX01PRFVMRSk7Cj4gICAKPiAg
IAlyZXR1cm4gZmQ7Cj4gICBlcnJfZmQ6CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
