Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A3C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 05:25:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D031022280
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 05:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P16pmZju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D031022280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 45B5D20431;
	Mon, 16 Nov 2020 05:25:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSyy279vSp5K; Mon, 16 Nov 2020 05:25:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 10AB52042D;
	Mon, 16 Nov 2020 05:25:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9B14C0800;
	Mon, 16 Nov 2020 05:25:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11574C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 05:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F20648681B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 05:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zW-A8SOrZhZG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 05:25:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C1AD586851
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 05:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605504348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idWyoh7qRbmkwmAn0b59fT2mdkgJ00GkL/2MJYUzIjo=;
 b=P16pmZju7Wj2nOe3/cR+PsSfNzK+hngQFIlgqlFM/YPpX2/VZ99OTRMbmql5aYYTuApLtx
 pW+iM0YAw0fI6UH2fP0PmmClp4fm0mPy/c/Va2NZTKUdpJ1qasQKp2Pf6DNsUIfEqR3oNy
 I93BTHrpE1YkR+0n8HPsKtdmjTZN+Y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-4WXemXDFM6qUD7zKhShcKw-1; Mon, 16 Nov 2020 00:25:44 -0500
X-MC-Unique: 4WXemXDFM6qUD7zKhShcKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CF5710074C5;
 Mon, 16 Nov 2020 05:25:43 +0000 (UTC)
Received: from [10.72.13.92] (ovpn-13-92.pek2.redhat.com [10.72.13.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A83466B8E5;
 Mon, 16 Nov 2020 05:25:33 +0000 (UTC)
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <56d8c992-44ca-f365-fb92-f5da94896680@redhat.com>
Date: Mon, 16 Nov 2020 13:25:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-13-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
ZSBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiB3cm90ZSBvbmx5IHRoZSBzdGF0dXMgb2YgZWFjaCBy
ZXF1ZXN0Lgo+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBhIG1vcmUgYWNjdXJhdGUgYmxvY2sgZGV2
aWNlIHNpbXVsYXRvciwKPiBwcm92aWRpbmcgYSByYW1kaXNrLWxpa2UgYmVoYXZpb3IuCj4KPiBB
bHNvIGhhbmRsZSBWSVJUSU9fQkxLX1RfR0VUX0lEIHJlcXVlc3QsIGFsd2F5cyBhbnN3ZXJpbmcg
dGhlCj4gInZkcGFfYmxrX3NpbSIgc3RyaW5nLgoKCkxldCdzIHVzZSBhIHNlcGFyYXRlIHBhdGNo
IGZvciB0aGlzLgoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1f
YmxrLmMgfCAxNTEgKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTMzIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbV9ibGsuYwo+IGluZGV4IDhlNDFiM2FiOThkNS4uNjhlNzQzODMzMjJmIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+IEBAIC03LDYgKzcsNyBAQAo+ICAg
ICovCj4gICAKPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPiArI2luY2x1ZGUgPGxpbnV4
L2Jsa2Rldi5oPgo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2Jsay5oPgo+ICAgCj4g
ICAjaW5jbHVkZSAidmRwYV9zaW0uaCIKPiBAQCAtMjQsMTAgKzI1LDEzNyBAQAo+ICAgCj4gICBz
dGF0aWMgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fYmxrX2RldjsKPiAgIAo+ICtzdGF0aWMgaW50
IHZkcGFzaW1fYmxrX2hhbmRsZV9yZXEoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sCj4gKwkJCQkg
IHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXNpemVfdCB3cm90ZSA9IDAs
IHRvX3JlYWQgPSAwLCB0b193cml0ZSA9IDA7Cj4gKwlzdHJ1Y3QgdmlydGlvX2Jsa19vdXRoZHIg
aGRyOwo+ICsJdWludDhfdCBzdGF0dXM7Cj4gKwl1aW50MzJfdCB0eXBlOwo+ICsJc3NpemVfdCBi
eXRlczsKPiArCWxvZmZfdCBvZmZzZXQ7Cj4gKwlpbnQgaSwgcmV0Owo+ICsKPiArCXZyaW5naF9r
aW92X2NsZWFudXAoJnZxLT5yaW92KTsKPiArCXZyaW5naF9raW92X2NsZWFudXAoJnZxLT53aW92
KTsKCgpJdCBsb29rcyB0byBtZSB3ZSBzaG91bGQgZG8gdGhvc2UgYWZ0ZXIgdnJpbmdoX2dldF9k
ZXNjX2lvdGxiKCk/IFNlZSAKY29tbWVudCBhYm92ZSB2cmluZ2hfZ2V0ZGVzY19rZXJuKCkuCgoK
PiArCj4gKwlyZXQgPSB2cmluZ2hfZ2V0ZGVzY19pb3RsYigmdnEtPnZyaW5nLCAmdnEtPnJpb3Ys
ICZ2cS0+d2lvdiwKPiArCQkJCSAgICZ2cS0+aGVhZCwgR0ZQX0FUT01JQyk7Cj4gKwlpZiAocmV0
ICE9IDEpCj4gKwkJcmV0dXJuIHJldDsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgdnEtPndpb3Yu
dXNlZDsgaSsrKQo+ICsJCXRvX3dyaXRlICs9IHZxLT53aW92LmlvdltpXS5pb3ZfbGVuOwoKCkl0
J3MgYmV0dGVyIHRvIGludHJvZHVjZSBhIGhlbHBlciBmb3IgdGhpcyAob3IgY29uc2lkZXIgdG8g
dXNlIGlvdiAKaXRlcmF0b3IpLgoKCj4gKwl0b193cml0ZSAtPSAxOyAvKiBsYXN0IGJ5dGUgaXMg
dGhlIHN0YXR1cyAqLwo+ICsKPiArCWZvciAoaSA9IDA7IGkgPCB2cS0+cmlvdi51c2VkOyBpKysp
Cj4gKwkJdG9fcmVhZCArPSB2cS0+cmlvdi5pb3ZbaV0uaW92X2xlbjsKPiArCj4gKwlieXRlcyA9
IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigmdnEtPnZyaW5nLCAmdnEtPnJpb3YsICZoZHIsIHNpemVv
ZihoZHIpKTsKPiArCWlmIChieXRlcyAhPSBzaXplb2YoaGRyKSkKPiArCQlyZXR1cm4gMDsKPiAr
Cj4gKwl0b19yZWFkIC09IGJ5dGVzOwo+ICsKPiArCXR5cGUgPSBsZTMyX3RvX2NwdShoZHIudHlw
ZSk7Cj4gKwlvZmZzZXQgPSBsZTY0X3RvX2NwdShoZHIuc2VjdG9yKSA8PCBTRUNUT1JfU0hJRlQ7
Cj4gKwlzdGF0dXMgPSBWSVJUSU9fQkxLX1NfT0s7Cj4gKwo+ICsJc3dpdGNoICh0eXBlKSB7Cj4g
KwljYXNlIFZJUlRJT19CTEtfVF9JTjoKPiArCQlpZiAob2Zmc2V0ICsgdG9fd3JpdGUgPiBWRFBB
U0lNX0JMS19DQVBBQ0lUWSA8PCBTRUNUT1JfU0hJRlQpIHsKPiArCQkJZGV2X2VycigmdmRwYXNp
bS0+dmRwYS5kZXYsCj4gKwkJCQkicmVhZGluZyBvdmVyIHRoZSBjYXBhY2l0eSAtIG9mZnNldDog
MHglbGx4IGxlbjogMHglbHhcbiIsCj4gKwkJCQlvZmZzZXQsIHRvX3dyaXRlKTsKPiArCQkJc3Rh
dHVzID0gVklSVElPX0JMS19TX0lPRVJSOwo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwo+ICsJCWJ5
dGVzID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+d2lvdiwKPiArCQkJ
CQkgICAgICB2ZHBhc2ltLT5idWZmZXIgKyBvZmZzZXQsCj4gKwkJCQkJICAgICAgdG9fd3JpdGUp
Owo+ICsJCWlmIChieXRlcyA8IDApIHsKPiArCQkJZGV2X2VycigmdmRwYXNpbS0+dmRwYS5kZXYs
Cj4gKwkJCQkidnJpbmdoX2lvdl9wdXNoX2lvdGxiKCkgZXJyb3I6ICVsZCBvZmZzZXQ6IDB4JWxs
eCBsZW46IDB4JWx4XG4iLAo+ICsJCQkJYnl0ZXMsIG9mZnNldCwgdG9fd3JpdGUpOwo+ICsJCQlz
dGF0dXMgPSBWSVJUSU9fQkxLX1NfSU9FUlI7Cj4gKwkJCWJyZWFrOwo+ICsJCX0KPiArCj4gKwkJ
d3JvdGUgKz0gYnl0ZXM7Cj4gKwkJYnJlYWs7Cj4gKwo+ICsJY2FzZSBWSVJUSU9fQkxLX1RfT1VU
Ogo+ICsJCWlmIChvZmZzZXQgKyB0b19yZWFkID4gVkRQQVNJTV9CTEtfQ0FQQUNJVFkgPDwgU0VD
VE9SX1NISUZUKSB7Cj4gKwkJCWRldl9lcnIoJnZkcGFzaW0tPnZkcGEuZGV2LAo+ICsJCQkJIndy
aXRpbmcgb3ZlciB0aGUgY2FwYWNpdHkgLSBvZmZzZXQ6IDB4JWxseCBsZW46IDB4JWx4XG4iLAo+
ICsJCQkJb2Zmc2V0LCB0b19yZWFkKTsKPiArCQkJc3RhdHVzID0gVklSVElPX0JMS19TX0lPRVJS
Owo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwo+ICsJCWJ5dGVzID0gdnJpbmdoX2lvdl9wdWxsX2lv
dGxiKCZ2cS0+dnJpbmcsICZ2cS0+cmlvdiwKPiArCQkJCQkgICAgICB2ZHBhc2ltLT5idWZmZXIg
KyBvZmZzZXQsCj4gKwkJCQkJICAgICAgdG9fcmVhZCk7Cj4gKwkJaWYgKGJ5dGVzIDwgMCkgewo+
ICsJCQlkZXZfZXJyKCZ2ZHBhc2ltLT52ZHBhLmRldiwKPiArCQkJCSJ2cmluZ2hfaW92X3B1bGxf
aW90bGIoKSBlcnJvcjogJWxkIG9mZnNldDogMHglbGx4IGxlbjogMHglbHhcbiIsCj4gKwkJCQli
eXRlcywgb2Zmc2V0LCB0b19yZWFkKTsKPiArCQkJc3RhdHVzID0gVklSVElPX0JMS19TX0lPRVJS
Owo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwkJYnJlYWs7Cj4gKwo+ICsJY2FzZSBWSVJUSU9fQkxL
X1RfR0VUX0lEOiB7Cj4gKwkJY2hhciBpZFtWSVJUSU9fQkxLX0lEX0JZVEVTXSA9ICJ2ZHBhX2Js
a19zaW0iOwoKCkxldCdzIHVzZSBhIGdsb2JhbCBzdGF0aWMgb25lPwoKCj4gKwo+ICsJCWJ5dGVz
ID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+dnJpbmcsCj4gKwkJCQkJICAgICAgJnZxLT53
aW92LCBpZCwKPiArCQkJCQkgICAgICBWSVJUSU9fQkxLX0lEX0JZVEVTKTsKPiArCQlpZiAoYnl0
ZXMgPCAwKSB7Cj4gKwkJCWRldl9lcnIoJnZkcGFzaW0tPnZkcGEuZGV2LAo+ICsJCQkJInZyaW5n
aF9pb3ZfcHVzaF9pb3RsYigpIGVycm9yOiAlbGRcbiIsIGJ5dGVzKTsKPiArCQkJc3RhdHVzID0g
VklSVElPX0JMS19TX0lPRVJSOwo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwo+ICsJCXdyb3RlICs9
IGJ5dGVzOwo+ICsJCWJyZWFrOwo+ICsJfQo+ICsKPiArCWRlZmF1bHQ6Cj4gKwkJZGV2X3dhcm4o
JnZkcGFzaW0tPnZkcGEuZGV2LAo+ICsJCQkgIlVuc3VwcG9ydGVkIHJlcXVlc3QgdHlwZSAlZFxu
IiwgdHlwZSk7Cj4gKwkJc3RhdHVzID0gVklSVElPX0JMS19TX0lPRVJSOwo+ICsJCWJyZWFrOwo+
ICsJfQo+ICsKPiArCS8qIGlmIFZJUlRJT19CTEtfVF9JTiBvciBWSVJUSU9fQkxLX1RfR0VUX0lE
IGZhaWwsIHdlIG5lZWQgdG8gc2tpcAo+ICsJICogdGhlIHJlbWFpbmluZyBieXRlcyB0byBwdXQg
dGhlIHN0YXR1cyBpbiB0aGUgbGFzdCBieXRlCj4gKwkgKi8KPiArCWlmICh0b193cml0ZSAtIHdy
b3RlID4gMCkgewo+ICsJCXZyaW5naF9pb3ZfcHVzaF9pb3RsYigmdnEtPnZyaW5nLCAmdnEtPndp
b3YsIE5VTEwsCj4gKwkJCQkgICAgICB0b193cml0ZSAtIHdyb3RlKTsKPiArCX0KPiArCj4gKwkv
KiBsYXN0IGJ5dGUgaXMgdGhlIHN0YXR1cyAqLwo+ICsJYnl0ZXMgPSB2cmluZ2hfaW92X3B1c2hf
aW90bGIoJnZxLT52cmluZywgJnZxLT53aW92LCAmc3RhdHVzLCAxKTsKPiArCWlmIChieXRlcyAh
PSAxKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCXdyb3RlICs9IGJ5dGVzOwo+ICsKPiArCS8qIE1h
a2Ugc3VyZSBkYXRhIGlzIHdyb3RlIGJlZm9yZSBhZHZhbmNpbmcgaW5kZXggKi8KPiArCXNtcF93
bWIoKTsKPiArCj4gKwl2cmluZ2hfY29tcGxldGVfaW90bGIoJnZxLT52cmluZywgdnEtPmhlYWQs
IHdyb3RlKTsKPiArCj4gKwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgdmRw
YXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gICB7Cj4gICAJc3RydWN0
IHZkcGFzaW0gKnZkcGFzaW0gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHZkcGFzaW0sIHdv
cmspOwo+IC0JdTggc3RhdHVzID0gVklSVElPX0JMS19TX09LOwo+ICAgCWludCBpOwo+ICAgCj4g
ICAJc3Bpbl9sb2NrKCZ2ZHBhc2ltLT5sb2NrKTsKPiBAQCAtNDEsMjEgKzE2OSw3IEBAIHN0YXRp
YyB2b2lkIHZkcGFzaW1fYmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCQlp
ZiAoIXZxLT5yZWFkeSkKPiAgIAkJCWNvbnRpbnVlOwo+ICAgCj4gLQkJd2hpbGUgKHZyaW5naF9n
ZXRkZXNjX2lvdGxiKCZ2cS0+dnJpbmcsICZ2cS0+cmlvdiwgJnZxLT53aW92LAo+IC0JCQkJCSAg
ICAmdnEtPmhlYWQsIEdGUF9BVE9NSUMpID4gMCkgewo+IC0KPiAtCQkJaW50IHdyaXRlOwo+IC0K
PiAtCQkJdnEtPndpb3YuaSA9IHZxLT53aW92LnVzZWQgLSAxOwo+IC0JCQl3cml0ZSA9IHZyaW5n
aF9pb3ZfcHVzaF9pb3RsYigmdnEtPnZyaW5nLCAmdnEtPndpb3YsICZzdGF0dXMsIDEpOwo+IC0J
CQlpZiAod3JpdGUgPD0gMCkKPiAtCQkJCWJyZWFrOwo+IC0KPiAtCQkJLyogTWFrZSBzdXJlIGRh
dGEgaXMgd3JvdGUgYmVmb3JlIGFkdmFuY2luZyBpbmRleCAqLwo+IC0JCQlzbXBfd21iKCk7Cj4g
LQo+IC0JCQl2cmluZ2hfY29tcGxldGVfaW90bGIoJnZxLT52cmluZywgdnEtPmhlYWQsIHdyaXRl
KTsKPiAtCj4gKwkJd2hpbGUgKHZkcGFzaW1fYmxrX2hhbmRsZV9yZXEodmRwYXNpbSwgdnEpID4g
MCkgewo+ICAgCQkJLyogTWFrZSBzdXJlIHVzZWQgaXMgdmlzaWJsZSBiZWZvcmUgcmFzaW5nIHRo
ZSBpbnRlcnJ1cHQuICovCj4gICAJCQlzbXBfd21iKCk7Cj4gICAKPiBAQCAtNjcsNiArMTgxLDcg
QEAgc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
Cj4gICAJCQkJdnEtPmNiKHZxLT5wcml2YXRlKTsKPiAgIAkJCWxvY2FsX2JoX2VuYWJsZSgpOwo+
ICAgCQl9Cj4gKwoKClVubmVjZXNzYXJ5IGNoYW5nZS4KClRoYW5rcwoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
