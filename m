Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76D6EB64DB
	for <virtualization@archiver.kernel.org>; Thu, 15 Jun 2023 07:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12FE041F2C;
	Thu, 15 Jun 2023 07:46:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12FE041F2C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fjSs/P1l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7EFfY8e5SMMQ; Thu, 15 Jun 2023 07:46:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03B6F41F20;
	Thu, 15 Jun 2023 07:46:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03B6F41F20
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EAC2C0037;
	Thu, 15 Jun 2023 07:46:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2A79C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jun 2023 07:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C442760B0E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jun 2023 07:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C442760B0E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fjSs/P1l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ce1nP7_aReTe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jun 2023 07:46:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAEA960ADE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAEA960ADE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jun 2023 07:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686815182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8EMxgmvCedlr34NWfOFFqqcuBtr+S8AEgU6UUC5NPw=;
 b=fjSs/P1l5CazQuJ3MWMrQd40uqiKZs/hqIMKag497+DUi42lIyD+DyWskaMyA4CsDYhk3/
 zRtcItBaz1bKnt0Ra0t9yosMvqYzXbAeAKvXdH8dvItdZJUo2tO0w4DvWvC2EJ7y/qBO1k
 rkjxBQijJxYFEvlPDQESSNBPsr/ZaUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-GBhkLc3sPJWBmbYmJ_1ELg-1; Thu, 15 Jun 2023 03:46:18 -0400
X-MC-Unique: GBhkLc3sPJWBmbYmJ_1ELg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89E6835152;
 Thu, 15 Jun 2023 07:46:17 +0000 (UTC)
Received: from [10.39.208.37] (unknown [10.39.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 011A61400AFC;
 Thu, 15 Jun 2023 07:46:15 +0000 (UTC)
Message-ID: <be8a4e6b-e6e1-7952-ab63-9668dbc7d4af@redhat.com>
Date: Thu, 15 Jun 2023 09:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Yongji Xie <xieyongji@bytedance.com>
References: <20230614115206.800118-1-maxime.coquelin@redhat.com>
 <CACycT3t_Lea_g0T4sx8MR+r3ziNFyBOY5jozEmYFgOZ0eG8Kwg@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] vduse: fix NULL pointer dereference
In-Reply-To: <CACycT3t_Lea_g0T4sx8MR+r3ziNFyBOY5jozEmYFgOZ0eG8Kwg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Sheng Zhao <sheng.zhao@bytedance.com>
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

CgpPbiA2LzE1LzIzIDA5OjI1LCBZb25namkgWGllIHdyb3RlOgo+IE9uIFdlZCwgSnVuIDE0LCAy
MDIzIGF0IDc6NTLigK9QTSBNYXhpbWUgQ29xdWVsaW4KPiA8bWF4aW1lLmNvcXVlbGluQHJlZGhh
dC5jb20+IHdyb3RlOgo+Pgo+PiB2ZHVzZV92ZHBhX3NldF92cV9hZmZpbml0eSBjYWxsYmFjayBj
YW4gYmUgY2FsbGVkCj4+IHdpdGggTlVMTCB2YWx1ZSBhcyBjcHVfbWFzayB3aGVuIGRlbGV0aW5n
IHRoZSB2ZHVzZQo+PiBkZXZpY2UuCj4+Cj4+IFRoaXMgcGF0Y2ggY2xlYXJzIHZpcnRxdWV1ZSdz
IElSUSBhZmZpbml0eSBtYXNrIHZhbHVlCj4+IGluc3RlYWQgb2YgZGVyZWZlcmVuY2luZyBOVUxM
IGNwdV9tYXNrLgo+Pgo+PiBbIDQ3NjAuOTUyMTQ5XSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMDAKPj4gWyA0NzYwLjk1OTExMF0g
I1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlCj4+IFsgNDc2MC45NjQy
NDddICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQo+PiBbIDQ3NjAu
OTY5Mzg1XSBQR0QgMCBQNEQgMAo+PiBbIDQ3NjAuOTcxOTI3XSBPb3BzOiAwMDAwIFsjMV0gUFJF
RU1QVCBTTVAgUFRJCj4+IFsgNDc2MC45NzYxMTJdIENQVTogMTMgUElEOiAyMzQ2IENvbW06IHZk
cGEgTm90IHRhaW50ZWQgNi40LjAtcmM2KyAjNAo+PiBbIDQ3NjAuOTgyMjkxXSBIYXJkd2FyZSBu
YW1lOiBEZWxsIEluYy4gUG93ZXJFZGdlIFI2NDAvMFcyM0g4LCBCSU9TIDIuOC4xIDA2LzI2LzIw
MjAKPj4gWyA0NzYwLjk4OTc2OV0gUklQOiAwMDEwOm1lbWNweV9vcmlnKzB4YzUvMHgxMzAKPj4g
WyA0NzYwLjk5NDA0OV0gQ29kZTogMTYgZjggNGMgODkgMDcgNGMgODkgNGYgMDggNGMgODkgNTQg
MTcgZjAgNGMgODkgNWMgMTcgZjggYzMgY2MgY2MgY2MgY2MgNjYgNjYgMmUgMGYgMWYgODQgMDAg
MDAgMDAgMDAgMDAgNjYgOTAgODMgZmEgMDggNzIgMWIgPDRjPiA4YiAwNiA0YyA4YiA0YyAxNiBm
OCA0YyA4OSAwNyA0YyA4OSA0YyAxNyBmOCBjMyBjYyBjYyBjYyBjYyA2Ngo+PiBbIDQ3NjEuMDEy
NzkzXSBSU1A6IDAwMTg6ZmZmZmIxZDU2NWFiYjgzMCBFRkxBR1M6IDAwMDEwMjQ2Cj4+IFsgNDc2
MS4wMTgwMjBdIFJBWDogZmZmZjlmNGJmNmIyNzg5OCBSQlg6IGZmZmY5ZjRiZTIzOTY5YzAgUkNY
OiBmZmZmOWY0YmNhZGY2NDAwCj4+IFsgNDc2MS4wMjUxNTJdIFJEWDogMDAwMDAwMDAwMDAwMDAw
OCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiBmZmZmOWY0YmY2YjI3ODk4Cj4+IFsgNDc2MS4w
MzIyODZdIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDggUjA5OiAw
MDAwMDAwMDAwMDAwMDAwCj4+IFsgNDc2MS4wMzk0MTZdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBS
MTE6IDAwMDAwMDAwMDAwMDA2MDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwCj4+IFsgNDc2MS4wNDY1
NDldIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwODAgUjE1OiBmZmZm
YjFkNTY1YWJiYjEwCj4+IFsgNDc2MS4wNTM2ODBdIEZTOiAgMDAwMDdmNjRjMmVjMjc0MCgwMDAw
KSBHUzpmZmZmOWY2MzVmOTgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKPj4gWyA0
NzYxLjA2MTc2NV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMwo+PiBbIDQ3NjEuMDY3NTEzXSBDUjI6IDAwMDAwMDAwMDAwMDAwMDAgQ1IzOiAwMDAwMDAx
ODc1MjcwMDA2IENSNDogMDAwMDAwMDAwMDc3MDZlMAo+PiBbIDQ3NjEuMDc0NjQ1XSBEUjA6IDAw
MDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAw
MAo+PiBbIDQ3NjEuMDgxNzc1XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZm
ZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMAo+PiBbIDQ3NjEuMDg4OTA5XSBQS1JVOiA1NTU1
NTU1NAo+PiBbIDQ3NjEuMDkxNjIwXSBDYWxsIFRyYWNlOgo+PiBbIDQ3NjEuMDk0MDc0XSAgPFRB
U0s+Cj4+IFsgNDc2MS4wOTYxODBdICA/IF9fZGllKzB4MWYvMHg3MAo+PiBbIDQ3NjEuMDk5MjM4
XSAgPyBwYWdlX2ZhdWx0X29vcHMrMHgxNzEvMHg0ZjAKPj4gWyA0NzYxLjEwMzM0MF0gID8gZXhj
X3BhZ2VfZmF1bHQrMHg3Yi8weDE4MAo+PiBbIDQ3NjEuMTA3MjY1XSAgPyBhc21fZXhjX3BhZ2Vf
ZmF1bHQrMHgyMi8weDMwCj4+IFsgNDc2MS4xMTE0NjBdICA/IG1lbWNweV9vcmlnKzB4YzUvMHgx
MzAKPj4gWyA0NzYxLjExNTEyNl0gIHZkdXNlX3ZkcGFfc2V0X3ZxX2FmZmluaXR5KzB4M2UvMHg1
MCBbdmR1c2VdCj4+IFsgNDc2MS4xMjA1MzNdICB2aXJ0bmV0X2NsZWFuX2FmZmluaXR5LnBhcnQu
MCsweDNkLzB4OTAgW3ZpcnRpb19uZXRdCj4+IFsgNDc2MS4xMjY2MzVdICByZW1vdmVfdnFfY29t
bW9uKzB4MWE0LzB4MjUwIFt2aXJ0aW9fbmV0XQo+PiBbIDQ3NjEuMTMxNzgxXSAgdmlydG5ldF9y
ZW1vdmUrMHg1ZC8weDcwIFt2aXJ0aW9fbmV0XQo+PiBbIDQ3NjEuMTM2NTgwXSAgdmlydGlvX2Rl
dl9yZW1vdmUrMHgzYS8weDkwCj4+IFsgNDc2MS4xNDA1MDldICBkZXZpY2VfcmVsZWFzZV9kcml2
ZXJfaW50ZXJuYWwrMHgxOWIvMHgyMDAKPj4gWyA0NzYxLjE0NTc0Ml0gIGJ1c19yZW1vdmVfZGV2
aWNlKzB4YzIvMHgxMzAKPj4gWyA0NzYxLjE0OTc1NV0gIGRldmljZV9kZWwrMHgxNTgvMHgzZTAK
Pj4gWyA0NzYxLjE1MzI0NV0gID8ga2VybmZzX2ZpbmRfbnMrMHgzNS8weGMwCj4+IFsgNDc2MS4x
NTcwODZdICBkZXZpY2VfdW5yZWdpc3RlcisweDEzLzB4NjAKPj4gWyA0NzYxLjE2MTAxMF0gIHVu
cmVnaXN0ZXJfdmlydGlvX2RldmljZSsweDExLzB4MjAKPj4gWyA0NzYxLjE2NTU0M10gIGRldmlj
ZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE5Yi8weDIwMAo+PiBbIDQ3NjEuMTcwNzcwXSAg
YnVzX3JlbW92ZV9kZXZpY2UrMHhjMi8weDEzMAo+PiBbIDQ3NjEuMTc0NzgyXSAgZGV2aWNlX2Rl
bCsweDE1OC8weDNlMAo+PiBbIDQ3NjEuMTc4Mjc2XSAgPyBfX3BmeF92ZHBhX25hbWVfbWF0Y2gr
MHgxMC8weDEwIFt2ZHBhXQo+PiBbIDQ3NjEuMTgzMzM2XSAgZGV2aWNlX3VucmVnaXN0ZXIrMHgx
My8weDYwCj4+IFsgNDc2MS4xODcyNjBdICB2ZHBhX25sX2NtZF9kZXZfZGVsX3NldF9kb2l0KzB4
NjMvMHhlMCBbdmRwYV0KPj4KPj4gRml4ZXM6IDI4ZjYyODhlYjYzZCAoInZkdXNlOiBTdXBwb3J0
IHNldF92cV9hZmZpbml0eSBjYWxsYmFjayIpCj4+IENjOiB4aWV5b25namlAYnl0ZWRhbmNlLmNv
bQo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWUgQ29xdWVsaW4gPG1heGltZS5jb3F1ZWxpbkBy
ZWRoYXQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5j
IHwgNiArKysrKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+PiBpbmRleCA1ZjVjMjE2
NzRmZGMuLmNkY2E5NGU4NTc2MiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNl
ci92ZHVzZV9kZXYuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5j
Cj4+IEBAIC03MjYsNyArNzI2LDExIEBAIHN0YXRpYyBpbnQgdmR1c2VfdmRwYV9zZXRfdnFfYWZm
aW5pdHkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYgaWR4LAo+PiAgIHsKPj4gICAgICAg
ICAgc3RydWN0IHZkdXNlX2RldiAqZGV2ID0gdmRwYV90b192ZHVzZSh2ZHBhKTsKPj4KPj4gLSAg
ICAgICBjcHVtYXNrX2NvcHkoJmRldi0+dnFzW2lkeF0tPmlycV9hZmZpbml0eSwgY3B1X21hc2sp
Owo+PiArICAgICAgIGlmIChjcHVfbWFzaykKPj4gKyAgICAgICAgICAgICAgIGNwdW1hc2tfY29w
eSgmZGV2LT52cXNbaWR4XS0+aXJxX2FmZmluaXR5LCBjcHVfbWFzayk7Cj4+ICsgICAgICAgZWxz
ZQo+PiArICAgICAgICAgICAgICAgY3B1bWFza19jbGVhcigmZGV2LT52cXNbaWR4XS0+aXJxX2Fm
ZmluaXR5KTsKPiAKPiBJIHRoaW5rIHdlIHNob3VsZCBzZXQgYWxsIHRoZSBiaXRzIG9mIGlycSBh
ZmZpbml0eSBpbnN0ZWFkOgo+IGNwdW1hc2tfc2V0YWxsKCZkZXYtPnZxc1tpZHhdLT5pcnFfYWZm
aW5pdHkpOwoKSSBoZXNpdGF0ZWQgYmV0d2VlbiBib3RoLgpNeSB1bmRlcnN0YW5kaW5nIGlzIGl0
IG9ubHkgaGFwcGVucyBvbiByZW1vdmFsLCBzbyBlaXRoZXIgd291bGQgd29yay4KQnV0IGluIGNh
c2UgaXQgY2FuIGhhcHBlbiBvbiBvdGhlciBjYXNlcywgaXQgaXMgaW5kZWVkIGJldHRlciB0byB1
c2UKY3B1bWFza19zZXRhbGwoKS4KCkkgd2lsbCBwb3N0IGEgdjIgdG9kYXkuCgpUaGFua3MsCk1h
eGltZQoKPiBUaGFua3MsCj4gWW9uZ2ppCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
