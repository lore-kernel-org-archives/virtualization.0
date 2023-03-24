Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A0AC6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 14:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CDFA84227;
	Fri, 24 Mar 2023 14:47:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CDFA84227
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vikzut3s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J_tmCkQP_Mzv; Fri, 24 Mar 2023 14:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F274E8421B;
	Fri, 24 Mar 2023 14:47:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F274E8421B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACF4FC0071;
	Fri, 24 Mar 2023 14:47:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C47DC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2657640347
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:47:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2657640347
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vikzut3s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zc4ZA57Wa_e
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:47:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1C5140176
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1C5140176
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679669222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuOjQOzMJu7jhalrvIVzIXLam0VRoOPHkDU+QEY7YhI=;
 b=Vikzut3sSCqsKKhCoweuZlJltz9UGJL07SybbCE72EoKudgwUbwBTgW6JOzmz6UvT8puIC
 2Ybg08azuHYnGFZ6OZPXcfkEyEybw/HeQJXZ4iblp84ZM5r8N2hygNHVfeZnXh1oKl3tRU
 WTcc5ihpIMl0P4/liu/YrkmHoQaAmG0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-nGADIGjzNWe7cbrBnR7_UQ-1; Fri, 24 Mar 2023 10:47:01 -0400
X-MC-Unique: nGADIGjzNWe7cbrBnR7_UQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 r19-20020a50aad3000000b005002e950cd3so3571464edc.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679669220;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AuOjQOzMJu7jhalrvIVzIXLam0VRoOPHkDU+QEY7YhI=;
 b=54+M6DMsuM7Td4V8jHwLBZI3jAi4yjgkdYHhoCb1uy/cHixjlnda657Jdt0YbJ0h3b
 1cxEIF4eKE5SVBL8IHpoBGCWXvKIdeOROQPlJgNnM3MJ/6FW2qr2NUHTyDWlqLR7Ls7f
 IBkRGogdAhscLZFo31N755KiVLV9bSrQdaOkX5W4fdHyx7IfWr0ftcuBIRp0acRqOYSs
 O7+n0GbfeKuIi1vCpkdwEuwThHEoYUQiXrvCslj64oKh6tMrkV70h9O21aZl6a/8RyI9
 QKKkJWV4gdDr160WgzfY6zSAnyiuudcmJVrR48/BINK7gXorNqbAxSVRDFhTVbgoxa2s
 83Hg==
X-Gm-Message-State: AAQBX9cQq/xCS1O15nSXoKFQBs8VOpUNVSIoRm/IyX6VaXysLoWtVdvR
 EOowHOn2X9D3HH0Wwy54OoVHgvWETIEp2FXUY8hDA4ACB7sky5BlPYTKE0/kX2I/VYz1ifnFGSn
 w4296Z4hxvgS9oxeS5IZBdl+lzTSl0gTJEawtpBATtA==
X-Received: by 2002:a17:906:fa1b:b0:922:2ba3:2348 with SMTP id
 lo27-20020a170906fa1b00b009222ba32348mr2995768ejb.7.1679669220708; 
 Fri, 24 Mar 2023 07:47:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZmfFJPCyGmiPR7O9KckKD9I87Kx7AyWLHRPUqCBRX1gMg+6qZWwdI6wSPtk2G3zOFrDNdJyA==
X-Received: by 2002:a17:906:fa1b:b0:922:2ba3:2348 with SMTP id
 lo27-20020a170906fa1b00b009222ba32348mr2995743ejb.7.1679669220454; 
 Fri, 24 Mar 2023 07:47:00 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 c14-20020a509f8e000000b005003fd12eafsm10711203edf.63.2023.03.24.07.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 07:46:59 -0700 (PDT)
Date: Fri, 24 Mar 2023 15:46:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 8/8] vdpa_sim: add support for user VA
Message-ID: <qrnz6o73374x5hio4jkgpj7et4ihym2wniob25so2zbsyjxagp@lwprqyc5xp7n>
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154804.184577-1-sgarzare@redhat.com>
 <20230321154804.184577-4-sgarzare@redhat.com>
 <78c7511a-deab-7e95-fde1-5317a568cf97@redhat.com>
MIME-Version: 1.0
In-Reply-To: <78c7511a-deab-7e95-fde1-5317a568cf97@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTE6NDk6MzJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+5ZyoIDIwMjMvMy8yMSAyMzo0OCwgU3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPj5U
aGUgbmV3ICJ1c2VfdmEiIG1vZHVsZSBwYXJhbWV0ZXIgKGRlZmF1bHQ6IHRydWUpIGlzIHVzZWQg
aW4KPj52ZHBhX2FsbG9jX2RldmljZSgpIHRvIGluZm9ybSB0aGUgdkRQQSBmcmFtZXdvcmsgdGhh
dCB0aGUgZGV2aWNlCj4+c3VwcG9ydHMgVkEuCj4+Cj4+dnJpbmdoIGlzIGluaXRpYWxpemVkIHRv
IHVzZSBWQSBvbmx5IHdoZW4gInVzZV92YSIgaXMgdHJ1ZSBhbmQgdGhlCj4+dXNlcidzIG1tIGhh
cyBiZWVuIGJvdW5kLiBTbywgb25seSB3aGVuIHRoZSBidXMgc3VwcG9ydHMgdXNlciBWQQo+Pihl
LmcuIHZob3N0LXZkcGEpLgo+Pgo+PnZkcGFzaW1fbW1fd29ya19mbiB3b3JrIGlzIHVzZWQgdG8g
c2VyaWFsaXplIHRoZSBiaW5kaW5nIHRvIGEgbmV3Cj4+YWRkcmVzcyBzcGFjZSB3aGVuIHRoZSAu
YmluZF9tbSBjYWxsYmFjayBpcyBpbnZva2VkLCBhbmQgdW5iaW5kaW5nCj4+d2hlbiB0aGUgLnVu
YmluZF9tbSBjYWxsYmFjayBpcyBpbnZva2VkLgo+Pgo+PkNhbGwgbW1nZXRfbm90X3plcm8oKS9r
dGhyZWFkX3VzZV9tbSgpIGluc2lkZSB0aGUgd29ya2VyIGZ1bmN0aW9uCj4+dG8gcGluIHRoZSBh
ZGRyZXNzIHNwYWNlIG9ubHkgYXMgbG9uZyBhcyBuZWVkZWQsIGZvbGxvd2luZyB0aGUKPj5kb2N1
bWVudGF0aW9uIG9mIG1tZ2V0KCkgaW4gaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oOgo+Pgo+PiAg
ICogTmV2ZXIgdXNlIHRoaXMgZnVuY3Rpb24gdG8gcGluIHRoaXMgYWRkcmVzcyBzcGFjZSBmb3Ig
YW4KPj4gICAqIHVuYm91bmRlZC9pbmRlZmluaXRlIGFtb3VudCBvZiB0aW1lLgo+Pgo+PlNpZ25l
ZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4tLS0K
Pj4KPj5Ob3RlczoKPj4gICAgIHYzOgo+PiAgICAgLSBjYWxsZWQgbW1nZXRfbm90X3plcm8oKSBi
ZWZvcmUga3RocmVhZF91c2VfbW0oKSBbSmFzb25dCj4+ICAgICAgIEFzIHRoZSBkb2N1bWVudGF0
aW9uIG9mIG1tZ2V0KCkgaW4gaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oIHNheXM6Cj4+ICAgICAg
ICogTmV2ZXIgdXNlIHRoaXMgZnVuY3Rpb24gdG8gcGluIHRoaXMgYWRkcmVzcyBzcGFjZSBmb3Ig
YW4KPj4gICAgICAgKiB1bmJvdW5kZWQvaW5kZWZpbml0ZSBhbW91bnQgb2YgdGltZS4KPj4gICAg
ICAgSSBtb3ZlZCBtbWdldF9ub3RfemVyby9rdGhyZWFkX3VzZV9tbSBpbnNpZGUgdGhlIHdvcmtl
ciBmdW5jdGlvbiwKPj4gICAgICAgdGhpcyB3YXkgd2UgcGluIHRoZSBhZGRyZXNzIHNwYWNlIG9u
bHkgYXMgbG9uZyBhcyBuZWVkZWQuCj4+ICAgICAgIFRoaXMgaXMgc2ltaWxhciB0byB3aGF0IHZm
aW9faW9tbXVfdHlwZTFfZG1hX3J3X2NodW5rKCkgZG9lcyBpbgo+PiAgICAgICBkcml2ZXJzL3Zm
aW8vdmZpb19pb21tdV90eXBlMS5jCj4+ICAgICAtIHNpbXBsaWZpZWQgdGhlIG1tIGJpbmQvdW5i
aW5kIFtKYXNvbl0KPj4gICAgIC0gcmVuYW1lZCB2ZHBhc2ltX3dvcmtlcl9jaGFuZ2VfbW1fc3lu
YygpIFtKYXNvbl0KPj4gICAgIC0gZml4IGNvbW1pdCBtZXNzYWdlIChzL2RlZmF1bHQ6IGZhbHNl
L2RlZmF1bHQ6IHRydWUpCj4+ICAgICB2MjoKPj4gICAgIC0gYHVzZV92YWAgc2V0IHRvIHRydWUg
YnkgZGVmYXVsdCBbRXVnZW5pb10KPj4gICAgIC0gc3VwcG9ydGVkIHRoZSBuZXcgdW5iaW5kX21t
IGNhbGxiYWNrIFtKYXNvbl0KPj4gICAgIC0gcmVtb3ZlZCB0aGUgdW5iaW5kX21tIGNhbGwgaW4g
dmRwYXNpbV9kb19yZXNldCgpIFtKYXNvbl0KPj4gICAgIC0gYXZvaWRlZCB0byByZWxlYXNlIHRo
ZSBsb2NrIHdoaWxlIGNhbGwga3RocmVhZF9mbHVzaF93b3JrKCkgc2luY2Ugd2UKPj4gICAgICAg
YXJlIG5vdyB1c2luZyBhIG11dGV4IHRvIHByb3RlY3QgdGhlIGRldmljZSBzdGF0ZQo+Pgo+PiAg
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggfCAgMSArCj4+ICBkcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uYyB8IDgwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
Cj4+ICAyIGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+
Cj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPj5pbmRleCA0Nzc0MjkyZmJhOGMuLjNhNDI4ODdk
MDVkOSAxMDA2NDQKPj4tLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+Pisr
KyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oCj4+QEAgLTU5LDYgKzU5LDcgQEAg
c3RydWN0IHZkcGFzaW0gewo+PiAgCXN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnFzOwo+PiAg
CXN0cnVjdCBrdGhyZWFkX3dvcmtlciAqd29ya2VyOwo+PiAgCXN0cnVjdCBrdGhyZWFkX3dvcmsg
d29yazsKPj4rCXN0cnVjdCBtbV9zdHJ1Y3QgKm1tX2JvdW5kOwo+PiAgCXN0cnVjdCB2ZHBhc2lt
X2Rldl9hdHRyIGRldl9hdHRyOwo+PiAgCS8qIG11dGV4IHRvIHN5bmNocm9uaXplIHZpcnRxdWV1
ZSBzdGF0ZSAqLwo+PiAgCXN0cnVjdCBtdXRleCBtdXRleDsKPj5kaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYwo+PmluZGV4IGFiNGNmYjgyYzIzNy4uMjNjODkxY2RjZDU0IDEwMDY0NAo+Pi0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmMKPj5AQCAtMzUsMTAgKzM1LDQ0IEBAIG1vZHVsZV9wYXJhbShtYXhfaW90
bGJfZW50cmllcywgaW50LCAwNDQ0KTsKPj4gIE1PRFVMRV9QQVJNX0RFU0MobWF4X2lvdGxiX2Vu
dHJpZXMsCj4+ICAJCSAiTWF4aW11bSBudW1iZXIgb2YgaW90bGIgZW50cmllcyBmb3IgZWFjaCBh
ZGRyZXNzIHNwYWNlLiAwIG1lYW5zIHVubGltaXRlZC4gKGRlZmF1bHQ6IDIwNDgpIik7Cj4+K3N0
YXRpYyBib29sIHVzZV92YSA9IHRydWU7Cj4+K21vZHVsZV9wYXJhbSh1c2VfdmEsIGJvb2wsIDA0
NDQpOwo+PitNT0RVTEVfUEFSTV9ERVNDKHVzZV92YSwgIkVuYWJsZS9kaXNhYmxlIHRoZSBkZXZp
Y2UncyBhYmlsaXR5IHRvIHVzZSBWQSIpOwo+PisKPj4gICNkZWZpbmUgVkRQQVNJTV9RVUVVRV9B
TElHTiBQQUdFX1NJWkUKPj4gICNkZWZpbmUgVkRQQVNJTV9RVUVVRV9NQVggMjU2Cj4+ICAjZGVm
aW5lIFZEUEFTSU1fVkVORE9SX0lEIDAKPj4rc3RydWN0IHZkcGFzaW1fbW1fd29yayB7Cj4+Kwlz
dHJ1Y3Qga3RocmVhZF93b3JrIHdvcms7Cj4+KwlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbTsKPj4r
CXN0cnVjdCBtbV9zdHJ1Y3QgKm1tX3RvX2JpbmQ7Cj4+KwlpbnQgcmV0Owo+Pit9Owo+PisKPj4r
c3RhdGljIHZvaWQgdmRwYXNpbV9tbV93b3JrX2ZuKHN0cnVjdCBrdGhyZWFkX3dvcmsgKndvcmsp
Cj4+K3sKPj4rCXN0cnVjdCB2ZHBhc2ltX21tX3dvcmsgKm1tX3dvcmsgPQo+PisJCWNvbnRhaW5l
cl9vZih3b3JrLCBzdHJ1Y3QgdmRwYXNpbV9tbV93b3JrLCB3b3JrKTsKPj4rCXN0cnVjdCB2ZHBh
c2ltICp2ZHBhc2ltID0gbW1fd29yay0+dmRwYXNpbTsKPj4rCj4+KwltbV93b3JrLT5yZXQgPSAw
Owo+PisKPj4rCS8vVE9ETzogc2hvdWxkIHdlIGF0dGFjaCB0aGUgY2dyb3VwIG9mIHRoZSBtbSBv
d25lcj8KPj4rCXZkcGFzaW0tPm1tX2JvdW5kID0gbW1fd29yay0+bW1fdG9fYmluZDsKPj4rfQo+
PisKPj4rc3RhdGljIHZvaWQgdmRwYXNpbV93b3JrZXJfY2hhbmdlX21tX3N5bmMoc3RydWN0IHZk
cGFzaW0gKnZkcGFzaW0sCj4+KwkJCQkJICBzdHJ1Y3QgdmRwYXNpbV9tbV93b3JrICptbV93b3Jr
KQo+Pit7Cj4+KwlzdHJ1Y3Qga3RocmVhZF93b3JrICp3b3JrID0gJm1tX3dvcmstPndvcms7Cj4+
Kwo+PisJa3RocmVhZF9pbml0X3dvcmsod29yaywgdmRwYXNpbV9tbV93b3JrX2ZuKTsKPj4rCWt0
aHJlYWRfcXVldWVfd29yayh2ZHBhc2ltLT53b3JrZXIsIHdvcmspOwo+PisKPj4rCWt0aHJlYWRf
Zmx1c2hfd29yayh3b3JrKTsKPj4rfQo+PisKPj4gIHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRw
YV90b19zaW0oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+PiAgewo+PiAgCXJldHVybiBjb250
YWluZXJfb2YodmRwYSwgc3RydWN0IHZkcGFzaW0sIHZkcGEpOwo+PkBAIC01OSw4ICs5MywxMCBA
QCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3F1ZXVlX3JlYWR5KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2lt
LCB1bnNpZ25lZCBpbnQgaWR4KQo+PiAgewo+PiAgCXN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAq
dnEgPSAmdmRwYXNpbS0+dnFzW2lkeF07Cj4+ICAJdWludDE2X3QgbGFzdF9hdmFpbF9pZHggPSB2
cS0+dnJpbmcubGFzdF9hdmFpbF9pZHg7Cj4+Kwlib29sIHZhX2VuYWJsZWQgPSB1c2VfdmEgJiYg
dmRwYXNpbS0+bW1fYm91bmQ7Cj4+LQl2cmluZ2hfaW5pdF9pb3RsYigmdnEtPnZyaW5nLCB2ZHBh
c2ltLT5mZWF0dXJlcywgdnEtPm51bSwgdHJ1ZSwgZmFsc2UsCj4+Kwl2cmluZ2hfaW5pdF9pb3Rs
YigmdnEtPnZyaW5nLCB2ZHBhc2ltLT5mZWF0dXJlcywgdnEtPm51bSwgdHJ1ZSwKPj4rCQkJICB2
YV9lbmFibGVkLAo+PiAgCQkJICAoc3RydWN0IHZyaW5nX2Rlc2MgKikodWludHB0cl90KXZxLT5k
ZXNjX2FkZHIsCj4+ICAJCQkgIChzdHJ1Y3QgdnJpbmdfYXZhaWwgKikKPj4gIAkJCSAgKHVpbnRw
dHJfdCl2cS0+ZHJpdmVyX2FkZHIsCj4+QEAgLTEzMCw4ICsxNjYsMjAgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmRwYXNpbV9iYXRjaF9jb25maWdfb3BzOwo+PiAgc3Rh
dGljIHZvaWQgdmRwYXNpbV93b3JrX2ZuKHN0cnVjdCBrdGhyZWFkX3dvcmsgKndvcmspCj4+ICB7
Cj4+ICAJc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0
IHZkcGFzaW0sIHdvcmspOwo+PisJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSB2ZHBhc2ltLT5tbV9i
b3VuZDsKPj4rCj4+KwlpZiAobW0pIHsKPj4rCQlpZiAoIW1tZ2V0X25vdF96ZXJvKG1tKSkKPj4r
CQkJcmV0dXJuOwo+Cj4KPkRvIHdlIG5lZWQgdG8gY2hlY2sgdXNlX3ZhIGhlcmUuCgpZZXAsIHJp
Z2h0IQoKPgo+T3RoZXIgdGhhbiB0aGlzCj4KPkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3cywKU3RlZmFubwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
