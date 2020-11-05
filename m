Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF66C388F9
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 03:26:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B519206C1
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 03:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiomspHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B519206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 772DF84EED;
	Thu,  5 Nov 2020 03:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MEbZOlm6kxE; Thu,  5 Nov 2020 03:26:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 352AF84D6E;
	Thu,  5 Nov 2020 03:26:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17E60C0893;
	Thu,  5 Nov 2020 03:26:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF2BC0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6D91A203F1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4-bUdEkbziA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:26:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 343852039E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604546774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRshB1IOA1Mf1aSFztDMxd/O6v4KPO2Fmpz6wnpNUi0=;
 b=WiomspHLDx3ZyF7lTkTx369B8/f5MAs5PVnXE6dPhjZ33CQSDbcqq+AQ7v042IXTdBrOIc
 lV8F4g9Bt/tz4siHUENjvYLms3tLeBHw27fwdNlQgFYndDDByU97YO/zkvD8UFEaw6XZ4Q
 e6QaMi5b8AxAFNEc3RaXLrQpcuTPOHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516--fVdYd2zMxyenc99WivaXw-1; Wed, 04 Nov 2020 22:26:12 -0500
X-MC-Unique: -fVdYd2zMxyenc99WivaXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51DE31007464;
 Thu,  5 Nov 2020 03:26:11 +0000 (UTC)
Received: from [10.72.13.154] (ovpn-13-154.pek2.redhat.com [10.72.13.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8093F6CE4E;
 Thu,  5 Nov 2020 03:26:05 +0000 (UTC)
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
Date: Thu, 5 Nov 2020 11:26:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTEvNSDkuIrljYg3OjMzLCBTaS1XZWkgTGl1IHdyb3RlOgo+IFBpbm5lZCBwYWdl
cyBhcmUgbm90IHByb3Blcmx5IGFjY291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+IG1hcHBpbmcg
ZXJyb3Igb2NjdXJzIG9uIElPVExCIHVwZGF0ZS4gQ2xlYW4gdXAgZGFuZ2xpbmcKPiBwaW5uZWQg
cGFnZXMgZm9yIHRoZSBlcnJvciBwYXRoLgo+Cj4gVGhlIG1lbW9yeSB1c2FnZSBmb3IgYm9va2tl
ZXBpbmcgcGlubmVkIHBhZ2VzIGlzIHJldmVydGVkCj4gdG8gd2hhdCBpdCB3YXMgYmVmb3JlOiBv
bmx5IG9uZSBzaW5nbGUgZnJlZSBwYWdlIGlzIG5lZWRlZC4KPiBUaGlzIGhlbHBzIHJlZHVjZSB0
aGUgaG9zdCBtZW1vcnkgZGVtYW5kIGZvciBWTSB3aXRoIGEgbGFyZ2UKPiBhbW91bnQgb2YgbWVt
b3J5LCBvciBpbiB0aGUgc2l0dWF0aW9uIHdoZXJlIGhvc3QgaXMgcnVubmluZwo+IHNob3J0IG9m
IGZyZWUgbWVtb3J5Lgo+Cj4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1Y2Ug
dkRQQS1iYXNlZCBiYWNrZW5kIikKPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MjoKPiAtIERyb3AgdGhlIHJldmVy
c2lvbiBwYXRjaAo+IC0gRml4IHVuaGFuZGxlZCBwYWdlIGxlYWsgdG93YXJkcyB0aGUgZW5kIG9m
IHBhZ2VfbGlzdAo+Cj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDc5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA2MSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggYjZkOTAxNi4u
ZTExMjg1NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4gQEAgLTU2MCw2ICs1NjAsOCBAQCBzdGF0aWMgaW50IHZob3N0X3Zk
cGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCj4gICAJaWYgKHIpCj4gICAJCXZob3N0
X2lvdGxiX2RlbF9yYW5nZShkZXYtPmlvdGxiLCBpb3ZhLCBpb3ZhICsgc2l6ZSAtIDEpOwo+ICsJ
ZWxzZQo+ICsJCWF0b21pYzY0X2FkZChzaXplID4+IFBBR0VfU0hJRlQsICZkZXYtPm1tLT5waW5u
ZWRfdm0pOwo+ICAgCj4gICAJcmV0dXJuIHI7Cj4gICB9Cj4gQEAgLTU5MSwxNCArNTkzLDE2IEBA
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwKPiAgIAl1bnNpZ25lZCBsb25nIGxpc3Rfc2l6ZSA9IFBBR0VfU0laRSAvIHNpemVv
ZihzdHJ1Y3QgcGFnZSAqKTsKPiAgIAl1bnNpZ25lZCBpbnQgZ3VwX2ZsYWdzID0gRk9MTF9MT05H
VEVSTTsKPiAgIAl1bnNpZ25lZCBsb25nIG5wYWdlcywgY3VyX2Jhc2UsIG1hcF9wZm4sIGxhc3Rf
cGZuID0gMDsKPiAtCXVuc2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0LCBwaW5uZWQsIGk7
Cj4gKwl1bnNpZ25lZCBsb25nIGxvY2tfbGltaXQsIHN6MnBpbiwgbmNodW5rcywgaTsKPiAgIAl1
NjQgaW92YSA9IG1zZy0+aW92YTsKPiArCWxvbmcgcGlubmVkOwo+ICAgCWludCByZXQgPSAwOwo+
ICAgCj4gICAJaWYgKHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxiLCBtc2ctPmlvdmEsCj4g
ICAJCQkJICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEpKQo+ICAgCQlyZXR1cm4gLUVFWElT
VDsKPiAgIAo+ICsJLyogTGltaXQgdGhlIHVzZSBvZiBtZW1vcnkgZm9yIGJvb2trZWVwaW5nICov
Cj4gICAJcGFnZV9saXN0ID0gKHN0cnVjdCBwYWdlICoqKSBfX2dldF9mcmVlX3BhZ2UoR0ZQX0tF
Uk5FTCk7Cj4gICAJaWYgKCFwYWdlX2xpc3QpCj4gICAJCXJldHVybiAtRU5PTUVNOwo+IEBAIC02
MDcsNTIgKzYxMSw3NSBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRh
dGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJCWd1cF9mbGFncyB8PSBGT0xMX1dSSVRFOwo+
ICAgCj4gICAJbnBhZ2VzID0gUEFHRV9BTElHTihtc2ctPnNpemUgKyAoaW92YSAmIH5QQUdFX01B
U0spKSA+PiBQQUdFX1NISUZUOwo+IC0JaWYgKCFucGFnZXMpCj4gLQkJcmV0dXJuIC1FSU5WQUw7
Cj4gKwlpZiAoIW5wYWdlcykgewo+ICsJCXJldCA9IC1FSU5WQUw7Cj4gKwkJZ290byBmcmVlOwo+
ICsJfQo+ICAgCj4gICAJbW1hcF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4gICAKPiAtCWxvY2tlZCA9
IGF0b21pYzY0X2FkZF9yZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiAgIAls
b2NrX2xpbWl0ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdFX1NISUZUOwo+IC0KPiAt
CWlmIChsb2NrZWQgPiBsb2NrX2xpbWl0KSB7Cj4gKwlpZiAobnBhZ2VzICsgYXRvbWljNjRfcmVh
ZCgmZGV2LT5tbS0+cGlubmVkX3ZtKSA+IGxvY2tfbGltaXQpIHsKPiAgIAkJcmV0ID0gLUVOT01F
TTsKPiAtCQlnb3RvIG91dDsKPiArCQlnb3RvIHVubG9jazsKPiAgIAl9Cj4gICAKPiAgIAljdXJf
YmFzZSA9IG1zZy0+dWFkZHIgJiBQQUdFX01BU0s7Cj4gICAJaW92YSAmPSBQQUdFX01BU0s7Cj4g
KwluY2h1bmtzID0gMDsKPiAgIAo+ICAgCXdoaWxlIChucGFnZXMpIHsKPiAtCQlwaW5uZWQgPSBt
aW5fdCh1bnNpZ25lZCBsb25nLCBucGFnZXMsIGxpc3Rfc2l6ZSk7Cj4gLQkJcmV0ID0gcGluX3Vz
ZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPiAtCQkJCSAgICAgZ3VwX2ZsYWdzLCBwYWdlX2xp
c3QsIE5VTEwpOwo+IC0JCWlmIChyZXQgIT0gcGlubmVkKQo+ICsJCXN6MnBpbiA9IG1pbl90KHVu
c2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPiArCQlwaW5uZWQgPSBwaW5fdXNlcl9w
YWdlcyhjdXJfYmFzZSwgc3oycGluLAo+ICsJCQkJCWd1cF9mbGFncywgcGFnZV9saXN0LCBOVUxM
KTsKPiArCQlpZiAoc3oycGluICE9IHBpbm5lZCkgewo+ICsJCQlpZiAocGlubmVkIDwgMCkgewo+
ICsJCQkJcmV0ID0gcGlubmVkOwo+ICsJCQl9IGVsc2Ugewo+ICsJCQkJdW5waW5fdXNlcl9wYWdl
cyhwYWdlX2xpc3QsIHBpbm5lZCk7Cj4gKwkJCQlyZXQgPSAtRU5PTUVNOwo+ICsJCQl9Cj4gICAJ
CQlnb3RvIG91dDsKPiArCQl9Cj4gKwkJbmNodW5rcysrOwo+ICAgCj4gICAJCWlmICghbGFzdF9w
Zm4pCj4gICAJCQltYXBfcGZuID0gcGFnZV90b19wZm4ocGFnZV9saXN0WzBdKTsKPiAgIAo+IC0J
CWZvciAoaSA9IDA7IGkgPCByZXQ7IGkrKykgewo+ICsJCWZvciAoaSA9IDA7IGkgPCBwaW5uZWQ7
IGkrKykgewo+ICAgCQkJdW5zaWduZWQgbG9uZyB0aGlzX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2Vf
bGlzdFtpXSk7Cj4gICAJCQl1NjQgY3NpemU7Cj4gICAKPiAgIAkJCWlmIChsYXN0X3BmbiAmJiAo
dGhpc19wZm4gIT0gbGFzdF9wZm4gKyAxKSkgewo+ICAgCQkJCS8qIFBpbiBhIGNvbnRpZ3VvdXMg
Y2h1bmsgb2YgbWVtb3J5ICovCj4gICAJCQkJY3NpemUgPSAobGFzdF9wZm4gLSBtYXBfcGZuICsg
MSkgPDwgUEFHRV9TSElGVDsKPiAtCQkJCWlmICh2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCBjc2l6
ZSwKPiAtCQkJCQkJICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULAo+IC0JCQkJCQkgICBtc2ctPnBl
cm0pKQo+ICsJCQkJcmV0ID0gdmhvc3RfdmRwYV9tYXAodiwgaW92YSwgY3NpemUsCj4gKwkJCQkJ
CSAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULAo+ICsJCQkJCQkgICAgIG1zZy0+cGVybSk7Cj4g
KwkJCQlpZiAocmV0KSB7Cj4gKwkJCQkJLyoKPiArCQkJCQkgKiBVbnBpbiB0aGUgcGFnZXMgdGhh
dCBhcmUgbGVmdCB1bm1hcHBlZAo+ICsJCQkJCSAqIGZyb20gdGhpcyBwb2ludCBvbiBpbiB0aGUg
Y3VycmVudAo+ICsJCQkJCSAqIHBhZ2VfbGlzdC4gVGhlIHJlbWFpbmluZyBvdXRzdGFuZGluZwo+
ICsJCQkJCSAqIG9uZXMgd2hpY2ggbWF5IHN0cmlkZSBhY3Jvc3Mgc2V2ZXJhbAo+ICsJCQkJCSAq
IGNodW5rcyB3aWxsIGJlIGNvdmVyZWQgaW4gdGhlIGNvbW1vbgo+ICsJCQkJCSAqIGVycm9yIHBh
dGggc3Vic2VxdWVudGx5Lgo+ICsJCQkJCSAqLwo+ICsJCQkJCXVucGluX3VzZXJfcGFnZXMoJnBh
Z2VfbGlzdFtpXSwKPiArCQkJCQkJCSBwaW5uZWQgLSBpKTsKCgpDYW4gd2Ugc2ltcGx5IGRvIGxh
c3RfcGZuID0gdGhpc19wZm4gaGVyZT8KCgo+ICAgCQkJCQlnb3RvIG91dDsKPiArCQkJCX0KPiAr
Cj4gICAJCQkJbWFwX3BmbiA9IHRoaXNfcGZuOwo+ICAgCQkJCWlvdmEgKz0gY3NpemU7Cj4gKwkJ
CQluY2h1bmtzID0gMDsKPiAgIAkJCX0KPiAgIAo+ICAgCQkJbGFzdF9wZm4gPSB0aGlzX3BmbjsK
PiAgIAkJfQo+ICAgCj4gLQkJY3VyX2Jhc2UgKz0gcmV0IDw8IFBBR0VfU0hJRlQ7Cj4gLQkJbnBh
Z2VzIC09IHJldDsKPiArCQljdXJfYmFzZSArPSBwaW5uZWQgPDwgUEFHRV9TSElGVDsKPiArCQlu
cGFnZXMgLT0gcGlubmVkOwo+ICAgCX0KPiAgIAo+ICAgCS8qIFBpbiB0aGUgcmVzdCBjaHVuayAq
Lwo+IEBAIC02NjAsMTAgKzY4NywyNiBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19p
b3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJCQkgICAgIG1hcF9wZm4gPDwg
UEFHRV9TSElGVCwgbXNnLT5wZXJtKTsKPiAgIG91dDoKPiAgIAlpZiAocmV0KSB7Cj4gKwkJaWYg
KG5jaHVua3MgJiYgbGFzdF9wZm4pIHsKCgpBbnkgcmVhc29uIGZvciBjaGVja2luZyBsYXN0X3Bm
biBoZXJlPwoKTm90ZSB0aGF0IHdlIGRpZDoKCisJCW5jaHVua3MrKzsKICAKICAJCWlmICghbGFz
dF9wZm4pCiAgCQkJbWFwX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7CgoKVGhhbmtz
CgoKPiArCQkJdW5zaWduZWQgbG9uZyBwZm47Cj4gKwo+ICsJCQkvKgo+ICsJCQkgKiBVbnBpbiB0
aGUgb3V0c3RhbmRpbmcgcGFnZXMgd2hpY2ggYXJlIHlldCB0byBiZQo+ICsJCQkgKiBtYXBwZWQg
YnV0IGhhdmVuJ3QgZHVlIHRvIHZkcGFfbWFwKCkgb3IKPiArCQkJICogcGluX3VzZXJfcGFnZXMo
KSBmYWlsdXJlLgo+ICsJCQkgKgo+ICsJCQkgKiBNYXBwZWQgcGFnZXMgYXJlIGFjY291bnRlZCBp
biB2ZHBhX21hcCgpLCBoZW5jZQo+ICsJCQkgKiB0aGUgY29ycmVzcG9uZGluZyB1bnBpbm5pbmcg
d2lsbCBiZSBoYW5kbGVkIGJ5Cj4gKwkJCSAqIHZkcGFfdW5tYXAoKS4KPiArCQkJICovCj4gKwkJ
CWZvciAocGZuID0gbWFwX3BmbjsgcGZuIDw9IGxhc3RfcGZuOyBwZm4rKykKPiArCQkJCXVucGlu
X3VzZXJfcGFnZShwZm5fdG9fcGFnZShwZm4pKTsKPiArCQl9Cj4gICAJCXZob3N0X3ZkcGFfdW5t
YXAodiwgbXNnLT5pb3ZhLCBtc2ctPnNpemUpOwo+IC0JCWF0b21pYzY0X3N1YihucGFnZXMsICZk
ZXYtPm1tLT5waW5uZWRfdm0pOwo+ICAgCX0KPiArdW5sb2NrOgo+ICAgCW1tYXBfcmVhZF91bmxv
Y2soZGV2LT5tbSk7Cj4gK2ZyZWU6Cj4gICAJZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXBhZ2Vf
bGlzdCk7Cj4gICAJcmV0dXJuIHJldDsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
