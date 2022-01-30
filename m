Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22776C433F5
	for <virtualization@archiver.kernel.org>; Sun, 30 Jan 2022 06:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE23B40436;
	Sun, 30 Jan 2022 06:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kUeuL1-c9SsE; Sun, 30 Jan 2022 06:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA5BF40139;
	Sun, 30 Jan 2022 06:53:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CADC001A;
	Sun, 30 Jan 2022 06:53:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABF9FC000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AC9E60655
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhR_jCuiEnx0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:53:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 578A260596
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643525606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XsHCx8jkGWVXzWCc3X6Rxis2vTEQvAEhfGe+XGRe7o=;
 b=HL3cUUdeq5Vxel3HYSOtAvCf4IOBF/51Mqj1Q6ac3+A7jYNZ5E+ZC7QMaf/81V9wAPN1Sy
 IO7EVh0eSJ5mnQ9FDcA0uJrk50hLHc2lZclsXAHR+aSltaO3UTXZ0odIXXA1IBdPJ5cJNH
 lnRpXo/jmHQOyYjUQdiqTwRPF2ap4Rs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-fp2PKOY3NY-wgpHWy9RafQ-1; Sun, 30 Jan 2022 01:53:25 -0500
X-MC-Unique: fp2PKOY3NY-wgpHWy9RafQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 i8-20020a628708000000b004c8b9764ac9so5584972pfe.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 22:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1XsHCx8jkGWVXzWCc3X6Rxis2vTEQvAEhfGe+XGRe7o=;
 b=BIdxvHgWfNBvKR0dd66lxTDrdk43CO2Sa2C8QufAhrGiMjaAkahNUyUfyJ5tW2y3xo
 ubF7AEij7l8nZQAs0H2Ivoh/1u4pN74uIl/xeFW/vJAPUVUThtyrD/iD0pb8fRdKJEdd
 s0bugCnhjbd6XwqWhWp4Otawj5kx0A3S6tT/C25DP/6/LErLo8bDQeTq40I+Ey8XV1fa
 ZCyarwGJkjlkTYRu5ic4nHRAlfx6+7/Ws2pUTT8fdmWQjZN9+0d1X+nt3Q6G0K0JiiVX
 YTEevdTqVYmmDtWYGeZ8hmTQJqNZtboiNjyCqwktf+0l8dPX4O7kHZqOIhEYTvr6U9CZ
 nvtA==
X-Gm-Message-State: AOAM533vLixRb7JKwP7vtpXQhQjm3MAoQHUJeXozOsm8gvnyi5FlPwIY
 6FpIV+YFt2vXwL8/PONXsptsJefupJ+36itAB9J3gtO2tx7JTbXUR1bMrTy26tiv7OGAoK1dWPW
 cFwh71nVyNxpByb7EcAyzg8svU91vsKfpnjN26ngWhw==
X-Received: by 2002:a17:902:c7ca:: with SMTP id
 r10mr15673345pla.158.1643525603897; 
 Sat, 29 Jan 2022 22:53:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyla5QSZaeXmBLMPoNV17DvZDq8eOr2BFCdesIut1Bj2a8bGVEh+MZL0HMG+i0AMtqCzgqKxA==
X-Received: by 2002:a17:902:c7ca:: with SMTP id
 r10mr15673329pla.158.1643525603660; 
 Sat, 29 Jan 2022 22:53:23 -0800 (PST)
Received: from [10.72.12.243] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 204sm2481400pfu.91.2022.01.29.22.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 22:53:23 -0800 (PST)
Message-ID: <a05fe05e-ff20-5f2b-ef95-c7db0e7b2670@redhat.com>
Date: Sun, 30 Jan 2022 14:53:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 30/31] vdpa: Move vhost_vdpa_get_iova_range to
 net/vhost-vdpa.c
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-31-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-31-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNpbmNl
IGl0J3MgYSBkZXZpY2UgcHJvcGVydHksIGl0IGNhbiBiZSBkb25lIGluIG5ldC8uIFRoaXMgaGVs
cHMgU1ZRIHRvCj4gYWxsb2NhdGUgdGhlIHJpbmdzIGluIHZkcGEgZGV2aWNlIGluaXRpYWxpemF0
aW9uLCByYXRoZXIgdGhhbiBkZWxheQo+IHRoYXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC12
ZHBhLmMgfCAxNSAtLS0tLS0tLS0tLS0tLS0KPiAgIG5ldC92aG9zdC12ZHBhLmMgICAgICAgfCAz
MiArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQoKCkkgZG9uJ3QgdW5kZXJzdGFuZCBo
ZXJlLCBzaW5jZSB3ZSB3aWxsIHN1cHBvcnQgZGV2aWNlIG90aGVyIHRoYW4gbmV0PwoKCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5j
Cj4gaW5kZXggNzUwOTBkNjVlOC4uMjQ5MWMwNWQyOSAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8v
dmhvc3QtdmRwYS5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IEBAIC0zNTAsMTkg
KzM1MCw2IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9hZGRfc3RhdHVzKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwgdWludDhfdCBzdGF0dXMpCj4gICAgICAgcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiAt
c3RhdGljIHZvaWQgdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZShzdHJ1Y3Qgdmhvc3RfdmRwYSAq
dikKPiAtewo+IC0gICAgaW50IHJldCA9IHZob3N0X3ZkcGFfY2FsbCh2LT5kZXYsIFZIT1NUX1ZE
UEFfR0VUX0lPVkFfUkFOR0UsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2LT5p
b3ZhX3JhbmdlKTsKPiAtICAgIGlmIChyZXQgIT0gMCkgewo+IC0gICAgICAgIHYtPmlvdmFfcmFu
Z2UuZmlyc3QgPSAwOwo+IC0gICAgICAgIHYtPmlvdmFfcmFuZ2UubGFzdCA9IFVJTlQ2NF9NQVg7
Cj4gLSAgICB9Cj4gLQo+IC0gICAgdHJhY2Vfdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZSh2LT5k
ZXYsIHYtPmlvdmFfcmFuZ2UuZmlyc3QsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHYtPmlvdmFfcmFuZ2UubGFzdCk7Cj4gLX0KCgpMZXQncyBqdXN0IGV4cG9ydCB0aGlz
IGluc3RlYWQ/CgpUaGFua3MKCgo+IC0KPiAgIHN0YXRpYyBib29sIHZob3N0X3ZkcGFfb25lX3Rp
bWVfcmVxdWVzdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICB7Cj4gICAgICAgc3RydWN0IHZo
b3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiBAQCAtMTI5NSw4ICsxMjgyLDYgQEAgc3RhdGlj
IGludCB2aG9zdF92ZHBhX2luaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LCB2b2lkICpvcGFxdWUs
IEVycm9yICoqZXJycCkKPiAgICAgICAgICAgZ290byBlcnI7Cj4gICAgICAgfQo+ICAgCj4gLSAg
ICB2aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKHYpOwo+IC0KPiAgICAgICBpZiAodmhvc3RfdmRw
YV9vbmVfdGltZV9yZXF1ZXN0KGRldikpIHsKPiAgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAg
fQo+IGRpZmYgLS1naXQgYS9uZXQvdmhvc3QtdmRwYS5jIGIvbmV0L3Zob3N0LXZkcGEuYwo+IGlu
ZGV4IDRiZWZiYTVjYzcuLmNjOWNlY2Y4ZDEgMTAwNjQ0Cj4gLS0tIGEvbmV0L3Zob3N0LXZkcGEu
Ywo+ICsrKyBiL25ldC92aG9zdC12ZHBhLmMKPiBAQCAtMjIsNiArMjIsNyBAQAo+ICAgI2luY2x1
ZGUgPHN5cy9pb2N0bC5oPgo+ICAgI2luY2x1ZGUgPGVyci5oPgo+ICAgI2luY2x1ZGUgInN0YW5k
YXJkLWhlYWRlcnMvbGludXgvdmlydGlvX25ldC5oIgo+ICsjaW5jbHVkZSAic3RhbmRhcmQtaGVh
ZGVycy9saW51eC92aG9zdF90eXBlcy5oIgo+ICAgI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5o
Igo+ICAgI2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC5oIgo+ICAgCj4gQEAgLTE4NywxMyArMTg4
LDI1IEBAIHN0YXRpYyBOZXRDbGllbnRJbmZvIG5ldF92aG9zdF92ZHBhX2luZm8gPSB7Cj4gICAg
ICAgICAgIC5jaGVja19wZWVyX3R5cGUgPSB2aG9zdF92ZHBhX2NoZWNrX3BlZXJfdHlwZSwKPiAg
IH07Cj4gICAKPiArc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZShpbnQgZmQs
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3Zk
cGFfaW92YV9yYW5nZSAqaW92YV9yYW5nZSkKPiArewo+ICsgICAgaW50IHJldCA9IGlvY3RsKGZk
LCBWSE9TVF9WRFBBX0dFVF9JT1ZBX1JBTkdFLCBpb3ZhX3JhbmdlKTsKPiArCj4gKyAgICBpZiAo
cmV0IDwgMCkgewo+ICsgICAgICAgIGlvdmFfcmFuZ2UtPmZpcnN0ID0gMDsKPiArICAgICAgICBp
b3ZhX3JhbmdlLT5sYXN0ID0gVUlOVDY0X01BWDsKPiArICAgIH0KPiArfQo+ICsKPiAgIHN0YXRp
YyBOZXRDbGllbnRTdGF0ZSAqbmV0X3Zob3N0X3ZkcGFfaW5pdChOZXRDbGllbnRTdGF0ZSAqcGVl
ciwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNo
YXIgKmRldmljZSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IGNoYXIgKm5hbWUsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgdmRwYV9kZXZpY2VfZmQsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgcXVldWVfcGFpcl9pbmRleCwKPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBudnFzLAo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpc19kYXRhcGF0aCkKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZGV2aWNlLAo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lLAo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgdmRwYV9kZXZpY2VfZmQs
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBxdWV1ZV9wYWly
X2luZGV4LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbnZx
cywKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpc19kYXRh
cGF0aCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZo
b3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlKQo+ICAgewo+ICAgICAgIE5ldENsaWVudFN0
YXRlICpuYyA9IE5VTEw7Cj4gICAgICAgVmhvc3RWRFBBU3RhdGUgKnM7Cj4gQEAgLTIxMSw2ICsy
MjQsNyBAQCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9zdF92ZHBhX2luaXQoTmV0Q2xp
ZW50U3RhdGUgKnBlZXIsCj4gICAKPiAgICAgICBzLT52aG9zdF92ZHBhLmRldmljZV9mZCA9IHZk
cGFfZGV2aWNlX2ZkOwo+ICAgICAgIHMtPnZob3N0X3ZkcGEuaW5kZXggPSBxdWV1ZV9wYWlyX2lu
ZGV4Owo+ICsgICAgcy0+dmhvc3RfdmRwYS5pb3ZhX3JhbmdlID0gaW92YV9yYW5nZTsKPiAgICAg
ICByZXQgPSB2aG9zdF92ZHBhX2FkZChuYywgKHZvaWQgKikmcy0+dmhvc3RfdmRwYSwgcXVldWVf
cGFpcl9pbmRleCwgbnZxcyk7Cj4gICAgICAgaWYgKHJldCkgewo+ICAgICAgICAgICBxZW11X2Rl
bF9uZXRfY2xpZW50KG5jKTsKPiBAQCAtMjY3LDYgKzI4MSw3IEBAIGludCBuZXRfaW5pdF92aG9z
dF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICAgIGdf
YXV0b2ZyZWUgTmV0Q2xpZW50U3RhdGUgKipuY3MgPSBOVUxMOwo+ICAgICAgIE5ldENsaWVudFN0
YXRlICpuYzsKPiAgICAgICBpbnQgcXVldWVfcGFpcnMsIGksIGhhc19jdnEgPSAwOwo+ICsgICAg
c3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlOwo+ICAgCj4gICAgICAgYXNz
ZXJ0KG5ldGRldi0+dHlwZSA9PSBORVRfQ0xJRU5UX0RSSVZFUl9WSE9TVF9WRFBBKTsKPiAgICAg
ICBvcHRzID0gJm5ldGRldi0+dS52aG9zdF92ZHBhOwo+IEBAIC0yODYsMTkgKzMwMSwyMCBAQCBp
bnQgbmV0X2luaXRfdmhvc3RfdmRwYShjb25zdCBOZXRkZXYgKm5ldGRldiwgY29uc3QgY2hhciAq
bmFtZSwKPiAgICAgICAgICAgcWVtdV9jbG9zZSh2ZHBhX2RldmljZV9mZCk7Cj4gICAgICAgICAg
IHJldHVybiBxdWV1ZV9wYWlyczsKPiAgICAgICB9Cj4gKyAgICB2aG9zdF92ZHBhX2dldF9pb3Zh
X3JhbmdlKHZkcGFfZGV2aWNlX2ZkLCAmaW92YV9yYW5nZSk7Cj4gICAKPiAgICAgICBuY3MgPSBn
X21hbGxvYzAoc2l6ZW9mKCpuY3MpICogcXVldWVfcGFpcnMpOwo+ICAgCj4gICAgICAgZm9yIChp
ID0gMDsgaSA8IHF1ZXVlX3BhaXJzOyBpKyspIHsKPiAgICAgICAgICAgbmNzW2ldID0gbmV0X3Zo
b3N0X3ZkcGFfaW5pdChwZWVyLCBUWVBFX1ZIT1NUX1ZEUEEsIG5hbWUsCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2ZHBhX2RldmljZV9mZCwgaSwgMiwgdHJ1ZSk7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZHBhX2RldmljZV9mZCwgaSwg
MiwgdHJ1ZSwgaW92YV9yYW5nZSk7Cj4gICAgICAgICAgIGlmICghbmNzW2ldKQo+ICAgICAgICAg
ICAgICAgZ290byBlcnI7Cj4gICAgICAgfQo+ICAgCj4gICAgICAgaWYgKGhhc19jdnEpIHsKPiAg
ICAgICAgICAgbmMgPSBuZXRfdmhvc3RfdmRwYV9pbml0KHBlZXIsIFRZUEVfVkhPU1RfVkRQQSwg
bmFtZSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmRwYV9kZXZpY2VfZmQs
IGksIDEsIGZhbHNlKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmRwYV9k
ZXZpY2VfZmQsIGksIDEsIGZhbHNlLCBpb3ZhX3JhbmdlKTsKPiAgICAgICAgICAgaWYgKCFuYykK
PiAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+ICAgICAgIH0KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
