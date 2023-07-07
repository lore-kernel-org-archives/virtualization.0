Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BC4EB64D9
	for <virtualization@archiver.kernel.org>; Fri,  7 Jul 2023 07:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49E0E40374;
	Fri,  7 Jul 2023 07:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 49E0E40374
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VsNneTa2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCvt_1pKdmhm; Fri,  7 Jul 2023 07:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC61A40167;
	Fri,  7 Jul 2023 07:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC61A40167
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94A11C0072;
	Fri,  7 Jul 2023 07:37:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF823C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7646461183
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7646461183
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VsNneTa2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5FbggwKgNwUW
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:36:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F9CE6113E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F9CE6113E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688715418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LhsxiuZY4mBvEt1012syKMHY5Dt4ra0a21/EbMyrws=;
 b=VsNneTa29c91qJMA4eKh4zCHbkc1FT0Gtyk8m9B0ZidtzoKSdWsCTgyCfb3m34htJ8Dfwi
 5tXPdZZXiR9UZ2qMDGXHEHOt76QEXx6rtRmxlF7kTX8rK8ly+JZMOEDUCbQD/SMoVohuSE
 qVaqdnWQswn/hW9Kz66aQ8FwGNOt6pU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ETmmPwKCOJOlVg91jSSsBw-1; Fri, 07 Jul 2023 03:36:56 -0400
X-MC-Unique: ETmmPwKCOJOlVg91jSSsBw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b703a04ab5so9615271fa.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jul 2023 00:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688715415; x=1691307415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LhsxiuZY4mBvEt1012syKMHY5Dt4ra0a21/EbMyrws=;
 b=Mh7SlHHApU+ayjnM7gqG6rHcWT/XfHNbqxyzTnlAYMe/dCk4Nu2ebQ+25AwWINOIbi
 RjuiRQApagTv+8lCeDnPzuQhNpjjh/eySFeQLBzdJfE0Ja76NysHGHEwTNE7iK80ioWl
 k8DQfXg2mkwssMWu+nco+bGKvN2+4sezc4+a6VGMy4mONp0NRHMdzXsPKh5QaxP3kJZe
 jyzeNW2R3UCahCOeCcTryYU8sucMuNIPGJFqpzJGvGLhq2s8vZ6Sdx9PZzV2EszQulel
 uJBRnOiJ8redXDuPgtxr6GI6S72nO5grR6BEHkq/TdbC+463Ye8kliBvYMl3nXj1WF5l
 tFmQ==
X-Gm-Message-State: ABy/qLY9a4MYqxAJnS152mAQwB65szvTsqIMueGnu+pQPWHKcPOPL/d4
 mWcAErfChLEqYW2RTNbe/0fS6GBa3zBq9hXQgA8MLJWsLH0E+EbLPqDr67qixpvuJrenrGtLBGN
 vBa5QTY3rExKFmmfW77ATZ0PYVwbmSE0a0CWdqKlGOwhY9vOds2oxdZVqkw==
X-Received: by 2002:a2e:9086:0:b0:2b6:eceb:9b8 with SMTP id
 l6-20020a2e9086000000b002b6eceb09b8mr1791318ljg.10.1688715415500; 
 Fri, 07 Jul 2023 00:36:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGch0OzOrg3eapBwg2rXxr+g9gfz+3Lo4R5GccWTgAA+2qIGrSMQw2CRc6bxPEpItDq+boOOoGkVEirshqFzKw=
X-Received: by 2002:a2e:9086:0:b0:2b6:eceb:9b8 with SMTP id
 l6-20020a2e9086000000b002b6eceb09b8mr1791312ljg.10.1688715415219; Fri, 07 Jul
 2023 00:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-4-shannon.nelson@amd.com>
In-Reply-To: <20230630003609.28527-4-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:36:44 +0800
Message-ID: <CACGkMEtH3u9bKD-49q1HuOaqnOkZc3=t+oirKZC6RZ622nUouQ@mail.gmail.com>
Subject: Re: [PATCH virtio 3/4] pds_vdpa: clean and reset vqs entries
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, drivers@pensando.io,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 mst@redhat.com
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

T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgODozNuKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IE1ha2Ugc3VyZSB0aGF0IHdlIGluaXRpYWxpemUg
dGhlIHZxc1tdIGVudHJpZXMgdGhlIHNhbWUKPiB3YXkgYm90aCBmb3IgaW5pdGlhbCBzZXR1cCBh
bmQgYWZ0ZXIgYSB2cSByZXNldC4KPgo+IEZpeGVzOiAxNTFjYzgzNGYzZGQgKCJwZHNfdmRwYTog
YWRkIHN1cHBvcnQgZm9yIHZkcGEgYW5kIHZkcGFtZ210IGludGVyZmFjZXMiKQo+IFNpZ25lZC1v
ZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+IFJldmlld2Vk
LWJ5OiBCcmV0dCBDcmVlbGV5IDxicmV0dC5jcmVlbGV5QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZl
cnMvdmRwYS9wZHMvdmRwYV9kZXYuYyB8IDI0ICsrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvcGRzL3Zk
cGFfZGV2LmMKPiBpbmRleCA1ZTc2MWQ2MjVlZjMuLjVlMTA0NmM5YWYzZCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvcGRzL3Zk
cGFfZGV2LmMKPiBAQCAtNDI5LDYgKzQyOSwxOCBAQCBzdGF0aWMgdm9pZCBwZHNfdmRwYV9zZXRf
c3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHU4IHN0YXR1cykKPiAgICAgICAg
IH0KPiAgfQo+Cj4gK3N0YXRpYyB2b2lkIHBkc192ZHBhX2luaXRfdnFzX2VudHJ5KHN0cnVjdCBw
ZHNfdmRwYV9kZXZpY2UgKnBkc3YsIGludCBxaWQpCj4gK3sKPiArICAgICAgIG1lbXNldCgmcGRz
di0+dnFzW3FpZF0sIDAsIHNpemVvZihwZHN2LT52cXNbMF0pKTsKPiArICAgICAgIHBkc3YtPnZx
c1txaWRdLnFpZCA9IHFpZDsKPiArICAgICAgIHBkc3YtPnZxc1txaWRdLnBkc3YgPSBwZHN2Owo+
ICsgICAgICAgcGRzdi0+dnFzW3FpZF0ucmVhZHkgPSBmYWxzZTsKPiArICAgICAgIHBkc3YtPnZx
c1txaWRdLmlycSA9IFZJUlRJT19NU0lfTk9fVkVDVE9SOwo+ICsgICAgICAgcGRzdi0+dnFzW3Fp
ZF0ubm90aWZ5ID0KPiArICAgICAgICAgICAgICAgdnBfbW9kZXJuX21hcF92cV9ub3RpZnkoJnBk
c3YtPnZkcGFfYXV4LT52ZF9tZGV2LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBxaWQsICZwZHN2LT52cXNbcWlkXS5ub3RpZnlfcGEpOwoKTml0OiBJdCBsb29rcyB0
byBtZSB0aGlzIHdvdWxkIG5vdCBjaGFuZ2UuIFNvIHdlIHByb2JhYmx5IGRvbid0IG5lZWQKdGhp
cyBkdXJpbmcgcmVzZXQ/CgpUaGFua3MKCj4gK30KPiArCj4gIHN0YXRpYyBpbnQgcGRzX3ZkcGFf
cmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPiAgewo+ICAgICAgICAgc3RydWN0
IHBkc192ZHBhX2RldmljZSAqcGRzdiA9IHZkcGFfdG9fcGRzdih2ZHBhX2Rldik7Cj4gQEAgLTQ1
MSw4ICs0NjMsNyBAQCBzdGF0aWMgaW50IHBkc192ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYV9kZXYpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwgIiVzOiByZXNldF92cSBmYWlsZWQgcWlkICVkOiAlcGVcbiIsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpLCBFUlJfUFRSKGVycikpOwo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHBkc192ZHBhX3JlbGVhc2VfaXJxKHBkc3YsIGkpOwo+IC0g
ICAgICAgICAgICAgICAgICAgICAgIG1lbXNldCgmcGRzdi0+dnFzW2ldLCAwLCBzaXplb2YocGRz
di0+dnFzWzBdKSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLnJlYWR5
ID0gZmFsc2U7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcGRzX3ZkcGFfaW5pdF92cXNfZW50
cnkocGRzdiwgaSk7Cj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPgo+IEBAIC02NDAs
MTMgKzY1MSw4IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210
X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgICAgICAgIH0KPiAgICAgICAgIHBkc192
ZHBhX2NtZF9zZXRfbWFjKHBkc3YsIHBkc3YtPm1hYyk7Cj4KPiAtICAgICAgIGZvciAoaSA9IDA7
IGkgPCBwZHN2LT5udW1fdnFzOyBpKyspIHsKPiAtICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ld
LnFpZCA9IGk7Cj4gLSAgICAgICAgICAgICAgIHBkc3YtPnZxc1tpXS5wZHN2ID0gcGRzdjsKPiAt
ICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLmlycSA9IFZJUlRJT19NU0lfTk9fVkVDVE9SOwo+
IC0gICAgICAgICAgICAgICBwZHN2LT52cXNbaV0ubm90aWZ5ID0gdnBfbW9kZXJuX21hcF92cV9u
b3RpZnkoJnBkc3YtPnZkcGFfYXV4LT52ZF9tZGV2LAo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSwgJnBkc3YtPnZxc1tpXS5u
b3RpZnlfcGEpOwo+IC0gICAgICAgfQo+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IHBkc3YtPm51
bV92cXM7IGkrKykKPiArICAgICAgICAgICAgICAgcGRzX3ZkcGFfaW5pdF92cXNfZW50cnkocGRz
diwgaSk7Cj4KPiAgICAgICAgIHBkc3YtPnZkcGFfZGV2Lm1kZXYgPSAmdmRwYV9hdXgtPnZkcGFf
bWRldjsKPgo+IC0tCj4gMi4xNy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
