Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E31C7619A
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 03:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1A98404EC;
	Mon,  3 Apr 2023 03:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1A98404EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K1pRsBxD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sxNDCBYq9yt; Mon,  3 Apr 2023 03:18:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D9374013D;
	Mon,  3 Apr 2023 03:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D9374013D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F316BC0036;
	Mon,  3 Apr 2023 03:18:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF47EC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 03:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8D2540469
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 03:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8D2540469
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E32AceBz57Ek
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 03:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDA174013D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDA174013D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 03:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680491901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0a2YoCPqdvT7sap4ltftxMthrEI89W8IvG18MozfGLE=;
 b=K1pRsBxDz/qkapSWcXKVrf/6FgViUGL3lvfLFyI5ynqAdaHHVFBL7Jt3DA7LJgqdWnlDFc
 e6xuiP0sG5cQ4PkJan9zUtVB7tiSqqgBWqnNFOK//0de3Q/7sMPPfOLpYEmvxrItGgM8fo
 78Tz1MP5xIv48N8AQCQP1M+ct1SumFA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-4FuCoLOuNV-UfHzveXoaiw-1; Sun, 02 Apr 2023 23:18:15 -0400
X-MC-Unique: 4FuCoLOuNV-UfHzveXoaiw-1
Received: by mail-pg1-f200.google.com with SMTP id
 t2-20020a632d02000000b005075b896422so7900026pgt.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Apr 2023 20:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680491892; x=1683083892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0a2YoCPqdvT7sap4ltftxMthrEI89W8IvG18MozfGLE=;
 b=5sUjs4F+54PKuo2QJfQRmiZHCIkTrKpYRuFFizy01a5+nYgH9izC4vpICXbEitsO8s
 zfaxrdK5oN3haP27/2jGwywz22B+8Zo6HuKDYCle2d3WmX4JSJCsOPIqncg/Sp+cRuTe
 fPg700D4nSONNHANs/1JZJmgYhGkA1r8HD+sF05VqSUsM51aT3XO/Cn2WXEAUUtKUIrS
 RjGnWi10eQcdVWmxRmsB32yyOArV5tYSt1SEo9/WRu4ucP+LHuTo7l4eiapsrsbeYRiq
 ps6cynif4m/+hpIFFDHAgW8UC9nHYFQrTq+dgmPfI5MbeOQIIPk+8TapkAFKw1jg/XMq
 bdVw==
X-Gm-Message-State: AAQBX9fTm4rr7zU0Xq3MS72xqE5dI1ipIQVjbUA/tmJBK1byhMQ+YOC7
 RMlK1gke8sfYJMVtHXnYUK4/9m+AMv4zxgeGlg8Ei5t9S624122xVPLlaVL//+RLKf/XAOKwf6P
 tXpP6p525LJB2ki+C0RbYZNxhw1LwQmwD7WNt30BfVg==
X-Received: by 2002:a17:902:f906:b0:1a1:a7b6:e31e with SMTP id
 kw6-20020a170902f90600b001a1a7b6e31emr31254026plb.7.1680491892429; 
 Sun, 02 Apr 2023 20:18:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350YbGd0sV+9U72JXcUwXqsN0jZa3s1ooFR42QP8dDULUBD9CwCn5QOxWu4o+ScWQuzO1C6pkRQ==
X-Received: by 2002:a17:902:f906:b0:1a1:a7b6:e31e with SMTP id
 kw6-20020a170902f90600b001a1a7b6e31emr31254003plb.7.1680491892099; 
 Sun, 02 Apr 2023 20:18:12 -0700 (PDT)
Received: from [10.72.13.175] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902a40a00b001a01bb92273sm5388287plq.279.2023.04.02.20.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Apr 2023 20:18:11 -0700 (PDT)
Message-ID: <5f48c497-1831-40cf-a4b5-5d283204d7a6@redhat.com>
Date: Mon, 3 Apr 2023 11:18:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH net-next 6/8] virtio_net: auto release xdp shinfo
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230328120412.110114-7-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIzLzMvMjggMjA6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gdmlydG5ldF9idWlsZF94
ZHBfYnVmZl9tcmcoKSBhbmQgdmlydG5ldF94ZHBfaGFuZGxlcigpIGF1dG8KCgpJIHRoaW5rIHlv
dSBtZWFudCB2aXJ0bmV0X3hkcF9oYW5kbGVyKCkgYWN0dWFsbHk/CgoKPiByZWxlYXNlIHhkcCBz
aGluZm8gdGhlbiB0aGUgY2FsbGVyIG5vIG5lZWQgdG8gY2FyZWZ1bCB0aGUgeGRwIHNoaW5mby4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyOSArKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IGEzZjJiY2IzZGIyNy4uMTM2MTMxYTc4Njhh
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+IEBAIC04MzMsMTQgKzgzMywxNCBAQCBzdGF0aWMgaW50IHZpcnRu
ZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZm
ICp4ZHAsCj4gICAJCXN0YXRzLT54ZHBfdHgrKzsKPiAgIAkJeGRwZiA9IHhkcF9jb252ZXJ0X2J1
ZmZfdG9fZnJhbWUoeGRwKTsKPiAgIAkJaWYgKHVubGlrZWx5KCF4ZHBmKSkKPiAtCQkJcmV0dXJu
IFZJUlRORVRfWERQX1JFU19EUk9QOwo+ICsJCQlnb3RvIGRyb3A7Cj4gICAKPiAgIAkJZXJyID0g
dmlydG5ldF94ZHBfeG1pdChkZXYsIDEsICZ4ZHBmLCAwKTsKPiAgIAkJaWYgKHVubGlrZWx5KCFl
cnIpKSB7Cj4gICAJCQl4ZHBfcmV0dXJuX2ZyYW1lX3J4X25hcGkoeGRwZik7Cj4gICAJCX0gZWxz
ZSBpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsKPiAgIAkJCXRyYWNlX3hkcF9leGNlcHRpb24oZGV2
LCB4ZHBfcHJvZywgYWN0KTsKPiAtCQkJcmV0dXJuIFZJUlRORVRfWERQX1JFU19EUk9QOwo+ICsJ
CQlnb3RvIGRyb3A7Cj4gICAJCX0KPiAgIAo+ICAgCQkqeGRwX3htaXQgfD0gVklSVElPX1hEUF9U
WDsKPiBAQCAtODUwLDcgKzg1MCw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfaGFuZGxlcihz
dHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCwKPiAgIAkJc3Rh
dHMtPnhkcF9yZWRpcmVjdHMrKzsKPiAgIAkJZXJyID0geGRwX2RvX3JlZGlyZWN0KGRldiwgeGRw
LCB4ZHBfcHJvZyk7Cj4gICAJCWlmIChlcnIpCj4gLQkJCXJldHVybiBWSVJUTkVUX1hEUF9SRVNf
RFJPUDsKPiArCQkJZ290byBkcm9wOwo+ICAgCj4gICAJCSp4ZHBfeG1pdCB8PSBWSVJUSU9fWERQ
X1JFRElSOwo+ICAgCQlyZXR1cm4gVklSVE5FVF9YRFBfUkVTX0NPTlNVTUVEOwo+IEBAIC04NjIs
OCArODYyLDEyIEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3By
b2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCwKPiAgIAkJdHJhY2VfeGRwX2V4Y2Vw
dGlvbihkZXYsIHhkcF9wcm9nLCBhY3QpOwo+ICAgCQlmYWxsdGhyb3VnaDsKPiAgIAljYXNlIFhE
UF9EUk9QOgo+IC0JCXJldHVybiBWSVJUTkVUX1hEUF9SRVNfRFJPUDsKPiArCQlnb3RvIGRyb3A7
CgoKVGhpcyBnb3RvIGlzIGtpbmQgb2YgbWVhbmluZ2xlc3MuCgpUaGFua3MKCgo+ICAgCX0KPiAr
Cj4gK2Ryb3A6Cj4gKwlwdXRfeGRwX2ZyYWdzKHhkcCk7Cj4gKwlyZXR1cm4gVklSVE5FVF9YRFBf
UkVTX0RST1A7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgdmlydG5ldF9nZXRf
aGVhZHJvb20oc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gQEAgLTExOTksNyArMTIwMyw3IEBA
IHN0YXRpYyBpbnQgdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwKPiAgIAkJCQkgZGV2LT5uYW1lLCAqbnVtX2J1ZiwKPiAgIAkJCQkgdmlydGlvMTZfdG9f
Y3B1KHZpLT52ZGV2LCBoZHItPm51bV9idWZmZXJzKSk7Cj4gICAJCQlkZXYtPnN0YXRzLnJ4X2xl
bmd0aF9lcnJvcnMrKzsKPiAtCQkJcmV0dXJuIC1FSU5WQUw7Cj4gKwkJCWdvdG8gZXJyOwo+ICAg
CQl9Cj4gICAKPiAgIAkJc3RhdHMtPmJ5dGVzICs9IGxlbjsKPiBAQCAtMTIxOCw3ICsxMjIyLDcg
QEAgc3RhdGljIGludCB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2LAo+ICAgCQkJcHJfZGVidWcoIiVzOiByeCBlcnJvcjogbGVuICV1IGV4Y2VlZHMgdHJ1
ZXNpemUgJWx1XG4iLAo+ICAgCQkJCSBkZXYtPm5hbWUsIGxlbiwgKHVuc2lnbmVkIGxvbmcpKHRy
dWVzaXplIC0gcm9vbSkpOwo+ICAgCQkJZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4g
LQkJCXJldHVybiAtRUlOVkFMOwo+ICsJCQlnb3RvIGVycjsKPiAgIAkJfQo+ICAgCj4gICAJCWZy
YWcgPSAmc2hpbmZvLT5mcmFnc1tzaGluZm8tPm5yX2ZyYWdzKytdOwo+IEBAIC0xMjMzLDYgKzEy
MzcsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LAo+ICAgCj4gICAJKnhkcF9mcmFnc190cnVlc2l6ZSA9IHhkcF9mcmFnc190
cnVlc3o7Cj4gICAJcmV0dXJuIDA7Cj4gKwo+ICtlcnI6Cj4gKwlwdXRfeGRwX2ZyYWdzKHhkcCk7
Cj4gKwlyZXR1cm4gLUVJTlZBTDsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgKm1lcmdlYWJs
ZV94ZHBfcHJlcGFyZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiBAQCAtMTM2MSw3ICsxMzY5
LDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LAo+ICAgCQllcnIgPSB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhkZXYs
IHZpLCBycSwgJnhkcCwgZGF0YSwgbGVuLCBmcmFtZV9zeiwKPiAgIAkJCQkJCSAmbnVtX2J1Ziwg
JnhkcF9mcmFnc190cnVlc3osIHN0YXRzKTsKPiAgIAkJaWYgKHVubGlrZWx5KGVycikpCj4gLQkJ
CWdvdG8gZXJyX3hkcF9mcmFnczsKPiArCQkJZ290byBlcnJfeGRwOwo+ICAgCj4gICAJCWFjdCA9
IHZpcnRuZXRfeGRwX2hhbmRsZXIoeGRwX3Byb2csICZ4ZHAsIGRldiwgeGRwX3htaXQsIHN0YXRz
KTsKPiAgIAo+IEBAIC0xMzY5LDcgKzEzNzcsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJl
Y2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJCWNhc2UgVklSVE5F
VF9YRFBfUkVTX1BBU1M6Cj4gICAJCQloZWFkX3NrYiA9IGJ1aWxkX3NrYl9mcm9tX3hkcF9idWZm
KGRldiwgdmksICZ4ZHAsIHhkcF9mcmFnc190cnVlc3opOwo+ICAgCQkJaWYgKHVubGlrZWx5KCFo
ZWFkX3NrYikpCj4gLQkJCQlnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gKwkJCQlnb3RvIGVycl94ZHA7
Cj4gICAKPiAgIAkJCXJjdV9yZWFkX3VubG9jaygpOwo+ICAgCQkJcmV0dXJuIGhlYWRfc2tiOwo+
IEBAIC0xMzc5LDExICsxMzg3LDggQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21l
cmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgCQkJZ290byB4ZHBfeG1pdDsKPiAg
IAo+ICAgCQljYXNlIFZJUlRORVRfWERQX1JFU19EUk9QOgo+IC0JCQlnb3RvIGVycl94ZHBfZnJh
Z3M7Cj4gKwkJCWdvdG8gZXJyX3hkcDsKPiAgIAkJfQo+IC1lcnJfeGRwX2ZyYWdzOgo+IC0JCXB1
dF94ZHBfZnJhZ3MoJnhkcCk7Cj4gLQkJZ290byBlcnJfeGRwOwo+ICAgCX0KPiAgIAlyY3VfcmVh
ZF91bmxvY2soKTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
