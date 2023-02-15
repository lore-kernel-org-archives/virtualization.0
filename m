Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E54C05027
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 02:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D07781E91;
	Wed, 15 Feb 2023 02:57:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D07781E91
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XDEWIhYz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gw6su2BsiIo3; Wed, 15 Feb 2023 02:57:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69CF081959;
	Wed, 15 Feb 2023 02:57:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69CF081959
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40774C0033;
	Wed, 15 Feb 2023 02:57:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CDCEC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF52540571
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF52540571
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XDEWIhYz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i_cIXYddnjXS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:57:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85C094050F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85C094050F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 02:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676429820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXtgX5Vk2h3WIcUJAdVP4BZOumGxRu9HOZsfurPg6EA=;
 b=XDEWIhYzkC7VF7mywTTuuDRUEhmDv/7Z+TW5ASR0vLOMgAeHswwp0IxxzuEY3sYgCyjh/0
 qSV8W/CKo5Y3tkjn3XNuML2rjzHy5l3Je9bidR/iPmc3tsUwGoEvpfYDh2dCW4MrqQmcG6
 monQe2Ur17Va02RvfLnAV9Y9CQELD40=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-443-SBIf_FnmNhyo5OiuK15tcA-1; Tue, 14 Feb 2023 21:56:58 -0500
X-MC-Unique: SBIf_FnmNhyo5OiuK15tcA-1
Received: by mail-oi1-f199.google.com with SMTP id
 m11-20020aca650b000000b0037b36626937so3477440oim.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 18:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mXtgX5Vk2h3WIcUJAdVP4BZOumGxRu9HOZsfurPg6EA=;
 b=m4//QK1zF8J9efaJiImfvioREMdUzCTwOEsPIl0BxDu/RbH7rw2nudekdLhEhv96I0
 fwztVLCofKQVU1bHb3KkTPR/XdMToJDOCQfks3o3tmn31QT8vtPWsx8/4zSgSo8U7xBk
 LzCLDJba2PIt3H94WItoFxSJlL/qZRwkvTtMnXvcgtWAdWZ3Djmyp0Kbh4mPXnJyVWJi
 3NBOaBXq6E5zmJqAXhVhAo3+G/eCACs6ndc8Tryg/SrZS189W/B9jO9JK6ZxaCGWqsi+
 I30eG9rvw/56HDgZDOWdF+DFofwxyS147xPRyYJmezq8OW06LbNQQsUVFpWt29GAoLQt
 8RnA==
X-Gm-Message-State: AO0yUKXRJtHG+xE49ybXiKfQsEWzL6B4j6bWPGQIyp6C97EVhSlvYj2/
 OSUaZ2brcRKtWcleYXY13qpB9i0TrZRKaur/KFl4Afk0zQAXsfdeYa+2tqaeuMQj9pGjhmKGUWL
 pNqVSEP2SIb9hxWdOYwRqUFL5TXglqxax2uq+M3MnIO0d0gpu6nKzxMikbw==
X-Received: by 2002:a9d:62e:0:b0:68b:cbcf:c24b with SMTP id
 43-20020a9d062e000000b0068bcbcfc24bmr38216otn.4.1676429818138; 
 Tue, 14 Feb 2023 18:56:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+DrpHnZ9E7DqN5CM1RUFJnBP54MzJQLr0RZB9+OZFABcaKeLjC/2nGjj6vR1Zfy1ETJ3ecoA4Ek43x1WjGjeA=
X-Received: by 2002:a9d:62e:0:b0:68b:cbcf:c24b with SMTP id
 43-20020a9d062e000000b0068bcbcfc24bmr38208otn.4.1676429817882; Tue, 14 Feb
 2023 18:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20230131145310.2069-1-longpeng2@huawei.com>
 <db99245c-606a-2f24-52fe-836a6972437f@redhat.com>
 <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
 <CACGkMEt0Rgkcmt9k4dWsp-qqtPvrM40mtgmSERc0A7Ve1wzKHw@mail.gmail.com>
 <ad0ab6b8-1e1e-f686-eb5c-78cc63869c54@huawei.com>
In-Reply-To: <ad0ab6b8-1e1e-f686-eb5c-78cc63869c54@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2023 10:56:46 +0800
Message-ID: <CACGkMEsOWmVGA1RYTNZybmzkz53g5cYEkJeMK_9uuQu-ezZcqg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: cleanup memory maps when closing vdpa fds
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com,
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

T24gV2VkLCBGZWIgMTUsIDIwMjMgYXQgMTA6NDkgQU0gTG9uZ3BlbmcgKE1pa2UsIENsb3VkIElu
ZnJhc3RydWN0dXJlClNlcnZpY2UgUHJvZHVjdCBEZXB0LikgPGxvbmdwZW5nMkBodWF3ZWkuY29t
PiB3cm90ZToKPgo+Cj4KPiDlnKggMjAyMy8yLzE1IDEwOjAwLCBKYXNvbiBXYW5nIOWGmemBkzoK
PiA+IE9uIFR1ZSwgRmViIDE0LCAyMDIzIGF0IDI6MjggUE0gTG9uZ3BlbmcgKE1pa2UsIENsb3Vk
IEluZnJhc3RydWN0dXJlCj4gPiBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pIDxsb25ncGVuZzJAaHVh
d2VpLmNvbT4gd3JvdGU6Cj4gPj4KPiA+Pgo+ID4+Cj4gPj4g5ZyoIDIwMjMvMi8xNCAxNDoxNiwg
SmFzb24gV2FuZyDlhpnpgZM6Cj4gPj4+Cj4gPj4+IOWcqCAyMDIzLzEvMzEgMjI6NTMsIExvbmdw
ZW5nKE1pa2UpIOWGmemBkzoKPiA+Pj4+IEZyb206IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2Vp
LmNvbT4KPiA+Pj4+Cj4gPj4+PiBXZSBtdXN0IGNsZWFudXAgYWxsIG1lbW9yeSBtYXBzIHdoZW4g
Y2xvc2luZyB0aGUgdmRwYSBmZHMsIG90aGVyd2lzZQo+ID4+Pj4gc29tZSBjcml0aWNhbCByZXNv
dXJjZXMgKGUuZy4gbWVtb3J5LCBpb21tdSBtYXApIHdpbGwgbGVha2VkIGlmIHRoZQo+ID4+Pj4g
dXNlcnNwYWNlIGV4aXRzIHVuZXhwZWN0ZWRseSAoZS5nLiBraWxsIC05KS4KPiA+Pj4KPiA+Pj4K
PiA+Pj4gU291bmRzIGxpa2UgYSBidWcgb2YgdGhlIGtlcm5lbCwgc2hvdWxkIHdlIGZpeCB0aGVy
ZT8KPiA+Pj4KPiA+Pgo+ID4+IEZvciBleGFtcGxlLCB0aGUgaW9tbXUgbWFwIGlzIHNldHVwIHdo
ZW4gUUVNVSBjYWxscyBWSE9TVF9JT1RMQl9VUERBVEUKPiA+PiBpb2N0bCBhbmQgaXQnbGwgYmUg
ZnJlZWQgaWYgUUVNVSBjYWxscyBWSE9TVF9JT1RMQl9JTlZBTElEQVRFIGlvY3RsLgo+ID4+Cj4g
Pj4gU28gbWF5YmUgd2UgcmVsZWFzZSB0aGVzZSByZXNvdXJjZXMgaW4gdmRwYSBmcmFtZXdvcmsg
aW4ga2VybmVsIGlzIGEKPiA+PiBzdWl0YWJsZSBjaG9pY2U/Cj4gPgo+ID4gSSB0aGluayBJIG5l
ZWQgdW5kZXJzdGFuZCB3aGF0IGRvZXMgInJlc291cmNlcyIgbWVhbiBoZXJlOgo+ID4KPiA+IEZv
ciBpb21tdSBtYXBwaW5nLCBpdCBzaG91bGQgYmUgZnJlZWQgYnkgdmhvc3RfdmRwYV9mcmVlX2Rv
bWFpbigpIGluCj4gPiB2aG9zdF92ZHBhX3JlbGVhc2UoKT8KPiA+Cj4KPiBQbGVhc2UgY29uc2lk
ZXIgdGhlIGZvbGxvd2luZyBsaWZlY3ljbGUgb2YgdGhlIHZkcGEgZGV2aWNlOgo+Cj4gMS4gdmhv
c3RfdmRwYV9vcGVuCj4gICAgICB2aG9zdF92ZHBhX2FsbG9jX2RvbWFpbgo+Cj4gMi4gdmhvc3Rf
dmRwYV9wYV9tYXAKPiAgICAgIHBpbl91c2VyX3BhZ2VzCj4gICAgICB2aG9zdF92ZHBhX21hcAo+
ICAgICAgICBpb21tdV9tYXAKPgo+IDMuIGtpbGwgUUVNVQo+Cj4gNC4gdmhvc3RfdmRwYV9yZWxl
YXNlCj4gICAgICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluCj4KPiBJbiB0aGlzIGNhc2UsIHdlIGhh
dmUgbm8gb3Bwb3J0dW5pdHkgdG8gaW52b2tlIHVucGluX3VzZXJfcGFnZXMgb3IKPiBpb21tdV91
bm1hcCB0byBmcmVlIHRoZSBtZW1vcnkuCgpXZSBkbzoKCnZob3N0X3ZkcGFfY2xlYW51cCgpCiAg
ICB2aG9zdF92ZHBhX3JlbW92ZV9hcygpCiAgICAgICAgdmhvc3RfdmRwYV9pb3RsYl91bm1hcCgp
CiAgICAgICAgICAgIHZob3N0X3ZkcGFfcGFfdW5tYXAoKQogICAgICAgICAgICAgICAgdW5waW5f
dXNlcl9wYWdlcygpCiAgICAgICAgICAgICAgICB2aG9zdF92ZHBhX2dlbmVyYWxfdW5tYXAoKQog
ICAgICAgICAgICAgICAgICAgIGlvbW11X3VubWFwKCkKPwoKQnR3LCBpdCBsb29rcyBsaWtlIHdl
IHNob3VsZCBjYWxsIHZob3N0X3ZkcGFfZnJlZV9kb21haW4oKSAqYWZ0ZXIqCnZob3N0X3ZkcGFf
Y2xlYW51cCgpIG90aGVyd2lzZSBpdCdzIGEgVUFGPwoKVGhhbmtzCgo+Cj4gPiBzdGF0aWMgaW50
IHZob3N0X3ZkcGFfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmls
ZXApCj4gPiB7Cj4gPiAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2
YXRlX2RhdGE7Cj4gPiAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkID0gJnYtPnZkZXY7Cj4g
Pgo+ID4gICAgICAgICAgbXV0ZXhfbG9jaygmZC0+bXV0ZXgpOwo+ID4gICAgICAgICAgZmlsZXAt
PnByaXZhdGVfZGF0YSA9IE5VTEw7Cj4gPiAgICAgICAgICB2aG9zdF92ZHBhX2NsZWFuX2lycSh2
KTsKPiA+ICAgICAgICAgIHZob3N0X3ZkcGFfcmVzZXQodik7Cj4gPiAgICAgICAgICB2aG9zdF9k
ZXZfc3RvcCgmdi0+dmRldik7Cj4gPiAgICAgICAgICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKHYp
Owo+ID4gICAgICAgICAgdmhvc3RfdmRwYV9jb25maWdfcHV0KHYpOwo+ID4gICAgICAgICAgdmhv
c3RfdmRwYV9jbGVhbnVwKHYpOwo+ID4gICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkLT5tdXRleCk7
Cj4gPgo+ID4gICAgICAgICAgYXRvbWljX2RlYygmdi0+b3BlbmVkKTsKPiA+ICAgICAgICAgIGNv
bXBsZXRlKCZ2LT5jb21wbGV0aW9uKTsKPiA+Cj4gPiAgICAgICAgICByZXR1cm4gMDsKPiA+IH0K
PiA+Cj4gPj4KPiA+PiBCeSB0aGUgd2F5LCBKYXNvbiwgY2FuIHlvdSByZXByb2R1Y2UgdGhlIHBy
b2JsZW0gaW4geW91ciBtYWNoaW5lPwo+ID4+Cj4gPgo+ID4gSGF2ZW4ndCBnb3QgdGltZSBpbiBk
b2luZyB0aGlzIGJ1dCBpdCBzaG91bGQgYmUgdGhlIHJlc3BvbnNpYmlsaXR5IG9mCj4gPiB0aGUg
YXV0aG9yIHRvIHZhbGlkYXRlIHRoaXMgYW55aG93Lgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Pj4g
VGhhbmtzCj4gPj4+Cj4gPj4+Cj4gPj4+Pgo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogTG9uZ3Blbmcg
PGxvbmdwZW5nMkBodWF3ZWkuY29tPgo+ID4+Pj4gLS0tCj4gPj4+PiAgICBkcml2ZXJzL3Zob3N0
L3ZkcGEuYyB8IDEzICsrKysrKysrKysrKysKPiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspCj4gPj4+Pgo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRw
YS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+Pj4+IGluZGV4IGE1MjdlZWVhYzYzNy4uMzc0
NzdjZmZhNWFhIDEwMDY0NAo+ID4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+Pj4+
ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4+PiBAQCAtODIzLDYgKzgyMywxOCBAQCBz
dGF0aWMgdm9pZCB2aG9zdF92ZHBhX3VubWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ID4+Pj4g
ICAgICAgICAgICB2aG9zdF92ZHBhX3JlbW92ZV9hcyh2LCBhc2lkKTsKPiA+Pj4+ICAgIH0KPiA+
Pj4+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX2NsZWFuX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAq
dikKPiA+Pj4+ICt7Cj4gPj4+PiArICAgIHN0cnVjdCB2aG9zdF92ZHBhX2FzICphczsKPiA+Pj4+
ICsgICAgdTMyIGFzaWQ7Cj4gPj4+PiArCj4gPj4+PiArICAgIGZvciAoYXNpZCA9IDA7IGFzaWQg
PCB2LT52ZHBhLT5uYXM7IGFzaWQrKykgewo+ID4+Pj4gKyAgICAgICAgYXMgPSBhc2lkX3RvX2Fz
KHYsIGFzaWQpOwo+ID4+Pj4gKyAgICAgICAgaWYgKGFzKQo+ID4+Pj4gKyAgICAgICAgICAgIHZo
b3N0X3ZkcGFfdW5tYXAodiwgJmFzLT5pb3RsYiwgMFVMTCwgMFVMTCAtIDEpOwo+ID4+Pj4gKyAg
ICB9Cj4gPj4+PiArfQo+ID4+Pj4gKwo+ID4+Pj4gICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Zh
X21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZob3N0X2lvdGxiICppb3RsYiwKPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgdTY0IGlv
dmEsIHU2NCBzaXplLCB1NjQgdWFkZHIsIHUzMiBwZXJtKQo+ID4+Pj4gQEAgLTEyNDcsNiArMTI1
OSw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9kZQo+ID4+Pj4g
Kmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gPj4+PiAgICAgICAgdmhvc3RfdmRwYV9jbGVh
bl9pcnEodik7Cj4gPj4+PiAgICAgICAgdmhvc3RfdmRwYV9yZXNldCh2KTsKPiA+Pj4+ICAgICAg
ICB2aG9zdF9kZXZfc3RvcCgmdi0+dmRldik7Cj4gPj4+PiArICAgIHZob3N0X3ZkcGFfY2xlYW5f
bWFwKHYpOwo+ID4+Pj4gICAgICAgIHZob3N0X3ZkcGFfZnJlZV9kb21haW4odik7Cj4gPj4+PiAg
ICAgICAgdmhvc3RfdmRwYV9jb25maWdfcHV0KHYpOwo+ID4+Pj4gICAgICAgIHZob3N0X3ZkcGFf
Y2xlYW51cCh2KTsKPiA+Pj4KPiA+Pj4gLgo+ID4+Cj4gPgo+ID4gLgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
