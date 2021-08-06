Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914BBC4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 08:42:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B5460F59
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 08:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21B5460F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BAE0D402C4;
	Fri,  6 Aug 2021 08:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJgsaMHtwc0t; Fri,  6 Aug 2021 08:42:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16BDB40111;
	Fri,  6 Aug 2021 08:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D39B7C001A;
	Fri,  6 Aug 2021 08:42:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3774CC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2516C402BF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qe2vChFpu6Kx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:42:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1BE340111
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628239353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c4Csku1c78Mrj7sNQ2Xw9qFouSxJOuudRfOlOYi9zk=;
 b=KrhQPVJQOFuxUAEbEIepyfEbJpFs8ie5HFCA/0M6tC+Csv8j8tZNHd9+R9uqcfyVoxAEe+
 EJZ09JGpMusJx4zr2qdce1Ev9kb3wPVV6PFm++jiBC0oCCSJkHnmyzl2d8R6vR5LkcclVa
 9mg8+ZGWS4wiKjgK/U2RBqltJIjH9j0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-svXv3gGiM1CNXQQ-T-UX2Q-1; Fri, 06 Aug 2021 04:42:32 -0400
X-MC-Unique: svXv3gGiM1CNXQQ-T-UX2Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 c1-20020aa7df010000b02903bb5c6f746eso4518560edy.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 Aug 2021 01:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8c4Csku1c78Mrj7sNQ2Xw9qFouSxJOuudRfOlOYi9zk=;
 b=lHartOWAlbi9AKEr2GLAc5iom8qDGUim4WyO3GjUpUdRBGFmDo/9jQ6OoodSAuG+If
 Z/83SYvj9OENNeLLQUIXyP0Em0+RAAlOjXoYOBisG/PxWXX6JOaiVpC9KC/jc9lQlUEA
 5Au6kKSmfFCprsIXe6vwVf92oHhrXJigimQeAoqxq0igxr1fuXlPoDls2C8PkV35jbK1
 hLCSPRFos7XMZPBF/OfVJPnKOUopyA/eouyMPFRTwYz8RyHdU18R866v9jzQavkyT3xJ
 VaTKV7Uzz38ucvIp+i8w/5rz9I9HElKCL/G7/4/5/+6dOYkSuPepuDvNy1e6HcdkN0Ig
 lpKg==
X-Gm-Message-State: AOAM532DmByR6B9psRKmQ38bf/h7fpc7/lHEU6T5iWCrgejrDGtIleek
 n5MHMIBqXl6WJqPPdTtRevYqIAnj+EiGlYVgZNWGsj4vZmhhS6cDAJZ8CegNzr6tYXdagHi9DeR
 7xWXFEAY0EQVxsyJyN1xKcRO88EUO51M8BKjBkbOieg==
X-Received: by 2002:a50:ff03:: with SMTP id a3mr1957243edu.100.1628239351189; 
 Fri, 06 Aug 2021 01:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNYIVCHtzOw010C3ok1GQCf5+Qg3kQn0jmKZjzenN3blwwyY++mKhDsFFPHm3DlScSJzhoXg==
X-Received: by 2002:a50:ff03:: with SMTP id a3mr1957235edu.100.1628239351064; 
 Fri, 06 Aug 2021 01:42:31 -0700 (PDT)
Received: from redhat.com ([2.55.145.148])
 by smtp.gmail.com with ESMTPSA id x13sm2634731ejv.64.2021.08.06.01.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Aug 2021 01:42:30 -0700 (PDT)
Date: Fri, 6 Aug 2021 04:42:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Message-ID: <20210806034817-mutt-send-email-mst@kernel.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBBdWcgMDYsIDIwMjEgYXQgMTA6NTA6MjdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS84LzUg5LiL5Y2INTo1NywgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiA+IE9uIFdlZCwgSnVuIDE2LCAyMDIxIGF0IDEwOjExOjQ5UE0gKzAzMDAsIFBhcmF2IFBh
bmRpdCB3cm90ZToKPiA+ID4gQ3VycmVudGx5IHVzZXIgY2Fubm90IHNldCB0aGUgbWFjIGFkZHJl
c3MgYW5kIG10dSBvZiB0aGUgdmRwYSBkZXZpY2UuCj4gPiA+IFRoaXMgcGF0Y2hzZXQgZW5hYmxl
cyB1c2VycyB0byBzZXQgdGhlIG1hYyBhZGRyZXNzIGFuZCBtdHUgb2YgdGhlIHZkcGEKPiA+ID4g
ZGV2aWNlIG9uY2UgdGhlIGRldmljZSBpcyBjcmVhdGVkLgo+ID4gPiBJZiBhIHZlbmRvciBkcml2
ZXIgc3VwcG9ydHMgc3VjaCBjb25maWd1cmF0aW9uIHVzZXIgY2FuIHNldCBpdCBvdGhlcndpc2UK
PiA+ID4gdXNlciBnZXRzIHVuc3VwcG9ydGVkIGVycm9yLgo+ID4gVGhpcyBtYWtlcyBzZW5zZSB0
byBtZSBvdmVyYWxsLiBQZW9wbGUgYXJlIHVzZWQgdG8KPiA+IHVzZSBuZXRsaW5rIHRvIHNldCB0
aGVzZSBwYXJhbWV0ZXJzLCBhbmQgdmlydGlvIGRvZXMKPiA+IG5vdCBuZWNlc3NhcmlseSBoYXZl
IGEgd2F5IHRvIHNldCBhbGwgZGV2aWNlCj4gPiBwYXJhbWV0ZXJzIC0gdGhleSBjYW4gYmUgUk8g
aW4gdGhlIGNvbmZpZyBzcGFjZS4KPiAKPiAKPiBJIGRvbid0IGdldCBoZXJlLCB3ZSBuZWVkIHRv
IGNhcmUgUk8gYXMgd2VsbCAoZS5nIHRoZSBtYXhfdmlydHF1ZXVlX3BhaXJzKS4KClBvaW50IEkg
dHJpZWQgdG8gbWFrZSBpcywgYSB2aXJ0aW8gdHJhbnNwb3J0IHdpbGwgbm90IGFsbG93IHdyaXRp
bmcKbWF4X3ZpcnRxdWV1ZV9wYWlycywgYnV0IHdoZW4gbWFuYWdpbmcgdmlydGlvIFZGcyBmcm9t
IGEgUEYgd2UgZG8gbmVlZAp0byBzZXQgaXQuICBUaHVzIHZpcnRpbyBkZXZpY2VzIG5lZWQgYSBu
ZXcgc2V0IG9mIGludGVyZmFjZXMgZm9yCm1hbmFnaW5nIHRoZW0sIGl0IGlzIG5vdCBqdXN0IGEg
dmlydGlvIHRyYW5zcG9ydC4KCj4gQW5kIGRvIHdlIHJlYWxseSB3YW50IG5ldGxpbmsgdUFQSSBm
b3IgdmlydGlvIGxpa2U6Cj4gCj4gIGVudW0gdmRwYV9hdHRyIHsKPiBAQCAtMzMsNiArMzQsMTYg
QEAgZW51bSB2ZHBhX2F0dHIgewo+ICAJVkRQQV9BVFRSX0RFVl9NQVhfVlFTLAkJCS8qIHUzMiAq
Lwo+ICAJVkRQQV9BVFRSX0RFVl9NQVhfVlFfU0laRSwJCS8qIHUxNiAqLwo+ICsJVkRQQV9BVFRS
X0RFVl9ORVRfQ0ZHX01BQ0FERFIsCQkvKiBiaW5hcnkgKi8KPiArCVZEUEFfQVRUUl9ERVZfTkVU
X1NUQVRVUywJCS8qIHU4ICovCj4gKwlWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCwJCS8q
IHUxNiAqLwo+ICsJVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSwJCS8qIHUxNiAqLwo+ICsJVkRQ
QV9BVFRSX0RFVl9ORVRfQ0ZHX1NQRUVELAkJLyogdTE2ICovCj4gKwlWRFBBX0FUVFJfREVWX05F
VF9DRkdfRFVQTEVYLAkJLyogdTE2ICovCj4gKwlWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01B
WF9LRVlfTEVOLAkvKiB1OCAqLwo+ICsJVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19NQVhfSVRf
TEVOLAkvKiB1MTYgKi8KPiArCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19SU1NfSEFTSF9UWVBFUywJ
LyogdTMyICovCj4gKwo+ICAJLyogbmV3IGF0dHJpYnV0ZXMgbXVzdCBiZSBhZGRlZCBhYm92ZSBo
ZXJlICovCj4gIAlWRFBBX0FUVFJfTUFYLAo+ICB9OwoKVGhlIHBvaW50IGlzIHRvIHRyeSBhbmQg
bm90IHJlaW52ZW50IGEgZGVkaWNhdGVkIHZwZGEgaW50ZXJmYWNlCndoZXJlIGEgZ2VuZXJpYyBv
bmUgZXhpdHMuCkUuZy4gZm9yIHBoeSB0aGluZ3Mgc3VjaCBhcyBtYWMgc3BlZWQgZXRjLCBJIHRo
aW5rIG1vc3QgcGVvcGxlIGFyZSB1c2luZwpldGh0b29sIHRoaW5ncyByaWdodD8KCj4gT3Igdmly
dGlvIHVBUEkgYW5kIG1ha2UgbmV0bGluayBhIHRyYW5zcG9ydD8KPiAKPiBJIHByZWZlciB0aGUg
bGF0dGVyIHNpbmNlIHdlIHdpbGwgbWVldCB0aGUgc2ltaWxhciBpc3N1ZSBhdCB0aGUgaGFyZHdh
cmUKPiBsZXZlbCB3aGVuIHdlIHdhbnQgdG8gY3JlYXRlIGFuZCBwcm92aXNpb24gdmlydGlvIGRl
dmljZSBkeW5hbWljYWxseS4KPiAKPiBUaGFua3MKCkNyZWF0aW5nIGRldmljZXMgZHluYW1pY2Fs
bHkgZXhpc3RzIHdpdGggZS5nLiB2eGxhbi4KVGhhdCBpcyB1c2luZyBJRkxBX01UVSBJRkxBX0FE
RFJFU1MgZXRjLgoKCj4gCj4gPiAKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
