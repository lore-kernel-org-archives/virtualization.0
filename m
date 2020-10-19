Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB43C43457
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:47:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838F621D7F
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOBMTsiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838F621D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA24087597;
	Mon, 19 Oct 2020 15:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gzuUeLOvlWXN; Mon, 19 Oct 2020 15:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 70AB28751B;
	Mon, 19 Oct 2020 15:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D5CC0052;
	Mon, 19 Oct 2020 15:47:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9A1CC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 980DE8751D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RpeT-9sL0q1D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:47:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4E8708751B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603122462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2MEEZ/K/6boUhJVR6fTJ0aMQt927v1axXDlH3hhhjI=;
 b=cOBMTsiEuyySQScGiGquNKErhsm4P931u6UO/+jWxb0s+njFH27SWoYiCHep7eS+CHANLA
 RvO89y1VaO2aIg30heQw61hf0Y5Aw5/y8W9OEfp4AMzx7lz+hDsttx4dl1OcTDCMC+QFMc
 wHKWi5KchI5SOQs4m8NUyK5nDHUArTE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-eqrCSAEaONalTDBKoxiMUQ-1; Mon, 19 Oct 2020 11:47:40 -0400
X-MC-Unique: eqrCSAEaONalTDBKoxiMUQ-1
Received: by mail-wr1-f70.google.com with SMTP id f11so32866wro.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=k2MEEZ/K/6boUhJVR6fTJ0aMQt927v1axXDlH3hhhjI=;
 b=P668RzG+N2JoumKk1EG0/zgz2oHmcCf3XMsHVI5/atJ72okED/TG0McClfgceEW/T0
 KYGJ6XpjKeNLjtQqaiuds2vFu8kbtk8FfV6LZPsXNFMNUr371s0DwJaOtnqcjtsOjzNc
 qJgKYZuYS3A+4xK6I1qpU5BuRXLyOsfbvzooiiq2zae/ptNCsXUmZokHw1LX7tl+6I50
 d0SFRe0pMCTTEIZoaphMVgZFXST6Y8Ig1VMuWy/bAsqikHmiQko5GVpt0nO+7WU7IEZ7
 M7PnL+4VDDxmZrZIRoo8WB1gl58mdo3UIZVlcPfqXfk4/VY6vSltZIGCNJmv74IagY9J
 pWGA==
X-Gm-Message-State: AOAM530cSNW4pXH6WMnYGYyENJCYbXTpZEHLwltmkFDRmveZzn1xpJoR
 c8WngEQnwKG6DkXpu4ej55O7lyuV8SaVf83bEjG8KZZcBPp3IzJcNCh+cf3p88+suipaRkBRanG
 ePB3XoNc8IGrOJCxd/0Ug82N+a6KhqyPv3pslPj5qGg==
X-Received: by 2002:a1c:9d8e:: with SMTP id g136mr66182wme.18.1603122459093;
 Mon, 19 Oct 2020 08:47:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdIRz4VuTBoS8/Q6vEyJSCJtn8rj2adXrZn7kBKrSJM2JfAA7M22ciodXplTR6Hvp/Z8Q2ZQ==
X-Received: by 2002:a1c:9d8e:: with SMTP id g136mr66171wme.18.1603122458923;
 Mon, 19 Oct 2020 08:47:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id h128sm515626wme.38.2020.10.19.08.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:47:38 -0700 (PDT)
Date: Mon, 19 Oct 2020 11:47:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>
Subject: Re: [External] Re: [RFC 3/4] vduse: grab the module's references
 until there is no vduse device
Message-ID: <20201019114701-mutt-send-email-mst@kernel.org>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <20201019145623.671-4-xieyongji@bytedance.com>
 <20201019110359-mutt-send-email-mst@kernel.org>
 <CACycT3sQ-rw+weEktyK5jQTfMNWYR6qSaD1vAUEyCP6x7C9rRQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sQ-rw+weEktyK5jQTfMNWYR6qSaD1vAUEyCP6x7C9rRQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBPY3QgMTksIDIwMjAgYXQgMTE6NDQ6MzZQTSArMDgwMCwg6LCi5rC45ZCJIHdyb3Rl
Ogo+IAo+IAo+IE9uIE1vbiwgT2N0IDE5LCAyMDIwIGF0IDExOjA1IFBNIE1pY2hhZWwgUy4gVHNp
cmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+IAo+ICAgICBPbiBNb24sIE9jdCAxOSwgMjAy
MCBhdCAxMDo1NjoyMlBNICswODAwLCBYaWUgWW9uZ2ppIHdyb3RlOgo+ICAgICA+IFRoZSBtb2R1
bGUgc2hvdWxkIG5vdCBiZSB1bmxvYWRlZCBpZiBhbnkgdmR1c2UgZGV2aWNlIGV4aXN0cy4KPiAg
ICAgPiBTbyBpbmNyZWFzZSB0aGUgbW9kdWxlJ3MgcmVmZXJlbmNlIGNvdW50IHdoZW4gY3JlYXRp
bmcgdmR1c2UKPiAgICAgPiBkZXZpY2UuIEFuZCB0aGUgcmVmZXJlbmNlIGNvdW50IGlzIGtlcHQg
dW50aWwgdGhlIGRldmljZSBpcwo+ICAgICA+IGRlc3Ryb3llZC4KPiAgICAgPgo+ICAgICA+IFNp
Z25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+ICAgICA+
IC0tLQo+ICAgICA+wqAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDIgKysK
PiAgICAgPsKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiAgICAgPgo+ICAgICA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfdXNlci8KPiAgICAgdmR1c2VfZGV2LmMKPiAgICAgPiBpbmRleCA2Nzg3YmE2
NjcyNWMuLmYwNGFhMDJkZThjMSAxMDA2NDQKPiAgICAgPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jCj4gICAgID4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92
ZHVzZV9kZXYuYwo+ICAgICA+IEBAIC04ODcsNiArODg3LDcgQEAgc3RhdGljIGludCB2ZHVzZV9k
ZXN0cm95X2Rldih1MzIgaWQpCj4gICAgID7CoCDCoCDCoCDCoGtmcmVlKGRldi0+dnFzKTsKPiAg
ICAgPsKgIMKgIMKgIMKgdmR1c2VfaW92YV9kb21haW5fZGVzdHJveShkZXYtPmRvbWFpbik7Cj4g
ICAgID7CoCDCoCDCoCDCoHZkdXNlX2Rldl9kZXN0cm95KGRldik7Cj4gICAgID4gK8KgIMKgIMKg
bW9kdWxlX3B1dChUSElTX01PRFVMRSk7Cj4gICAgID7CoAo+ICAgICA+wqAgwqAgwqAgwqByZXR1
cm4gMDsKPiAgICAgPsKgIH0KPiAgICAgPiBAQCAtOTMxLDYgKzkzMiw3IEBAIHN0YXRpYyBpbnQg
dmR1c2VfY3JlYXRlX2RldihzdHJ1Y3QgdmR1c2VfZGV2X2NvbmZpZwo+ICAgICAqY29uZmlnKQo+
ICAgICA+wqAKPiAgICAgPsKgIMKgIMKgIMKgZGV2LT5jb25uZWN0ZWQgPSB0cnVlOwo+ICAgICA+
wqAgwqAgwqAgwqBsaXN0X2FkZCgmZGV2LT5saXN0LCAmdmR1c2VfZGV2cyk7Cj4gICAgID4gK8Kg
IMKgIMKgX19tb2R1bGVfZ2V0KFRISVNfTU9EVUxFKTsKPiAgICAgPsKgCj4gICAgID7CoCDCoCDC
oCDCoHJldHVybiBmZDsKPiAgICAgPsKgIGVycl9mZDoKPiAKPiAgICAgVGhpcyBraW5kIG9mIHRo
aW5nIGlzIHVzdWFsbHkgYW4gaW5kaWNhdG9yIG9mIGEgYnVnLiBFLmcuCj4gICAgIGlmIHRoZSBy
ZWZjb3VudCBkcm9wcyB0byAwIG9uIG1vZHVsZV9wdXQoVEhJU19NT0RVTEUpIGl0Cj4gICAgIHdp
bGwgYmUgdW5sb2FkZWQgYW5kIHRoZSBmb2xsb3dpbmcgcmV0dXJuIHdpbGwgbm90IHJ1bi4KPiAK
PiAKPiAKPiBTaG91bGQgdGhpcyBoYXBwZW4/wqAgVGhlIHJlZmNvdW50IHNob3VsZCBiZSBvbmx5
IGRlY3JlYXNlZCB0byAwIGFmdGVyIHRoZQo+IG1pc2NfZGV2aWNlIGlzIGNsb3NlZD8KPiAKPiBU
aGFua3MsCj4gWW9uZ2ppCj4gCgpPVE9IIGlmIGl0IG5ldmVyIGRyb3BzIHRvIDAgYW55d2F5IHRo
ZW4gd2h5IGRvIHlvdSBuZWVkIHRvIGluY3JlYXNlIGl0PwoKPiAKPiAKPiAgICAgPiAtLQo+ICAg
ICA+IDIuMjUuMQo+IAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
