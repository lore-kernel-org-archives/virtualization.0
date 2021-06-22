Return-Path: <SRS0=aA1Z=LQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1478CC2B9F4
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CDB6112D
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CDB6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B5A282ABE;
	Tue, 22 Jun 2021 07:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mgJGJcKrTWA; Tue, 22 Jun 2021 07:08:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D9C6A82868;
	Tue, 22 Jun 2021 07:08:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A77EC001A;
	Tue, 22 Jun 2021 07:08:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17A1EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E724C4015B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:08:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id US1o_n6fH6uw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:08:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66F00400E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624345699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31L186KJsSwkkaYnZ1m2+9QkZVSPtY5FGcdRJV/iS40=;
 b=YnAS1VApnPVqaU5UWH8tdRkA21xjEyvm36JOXgZ15ZIqvMbf6uvwyIESbfAhuHhwcNNzS5
 BsU2BJ7VS3HL3BNB9E0JDeiMzzMkQT81SSRFp+SjvOv9EK8vi5eDiK4vSfcxlXmZtuvd5w
 LjqerlxkD5R2BuRa3lNR2vjUiLeT3/Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-cnfvjyG9NCiBTjERTpwmXA-1; Tue, 22 Jun 2021 03:08:17 -0400
X-MC-Unique: cnfvjyG9NCiBTjERTpwmXA-1
Received: by mail-pg1-f198.google.com with SMTP id
 17-20020a630b110000b029022064e7cdcfso10859185pgl.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 00:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=31L186KJsSwkkaYnZ1m2+9QkZVSPtY5FGcdRJV/iS40=;
 b=PQz4PNWEToFKOH7Rq6j+eIArCLZBCZ10bMYTUyYLMOsnHdqjEU16b8Txjy6mW4o65x
 Wsl6Vj1M6arV8D+S2wPbOWkzTPp+Gh80RmeSsxIFVD5z6tKujuUzCyH/9rjWyBCd1AZq
 9uch724vhG70AKRYxWR6/17O83XJY9xyoq6mlZxhULgX1mOxoBcXL7b6dQGESAiJh2Br
 AKO8/AMEAmN7oLllqqqsCsRt3uZLieRhE8lz1dyWsi8pfmpX4VK0Yka484rT7rxtgHM4
 Xtu2raRikQ/UU2heBEGYJoCReBGQ+gskmXo/EacR8BKWWfR1n47BCxLfZToMApoXhYYo
 opwg==
X-Gm-Message-State: AOAM5316crwQtyfMc9B0RQ28+uFpQE1Yb26Q0QpeI33xp9TOEaet+uKm
 lYH1RU88N3KuEJLKlU0XJKDiSsjeSfxvgYX+sf1dKnr+GsVxn73DLEox+YWGDGyHh/YlHvVTl3x
 xlvEH9kG3PJLYyr5zlEjH1cXxSqhtWVCqSakSK1FzyQ==
X-Received: by 2002:a17:90b:1c06:: with SMTP id
 oc6mr2246739pjb.112.1624345696582; 
 Tue, 22 Jun 2021 00:08:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIgCTEbtuayYkHgTKWWKp2jsj5CJ9rEK+aJVLANSONK0k0h52Vng4oPUyYT36ZMq5ra9hsow==
X-Received: by 2002:a17:90b:1c06:: with SMTP id
 oc6mr2246707pjb.112.1624345696278; 
 Tue, 22 Jun 2021 00:08:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b21sm18926598pgj.74.2021.06.22.00.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 00:08:15 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 1/6] vdpa: Introduce and use vdpa device
 get, set config helpers
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-2-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b17a9a6b-04eb-af29-949e-a3bc8ab7c132@redhat.com>
Date: Tue, 22 Jun 2021 15:08:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616191155.102303-2-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: elic@nvidia.com, mst@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8xNyDJz87nMzoxMSwgUGFyYXYgUGFuZGl0INC0tcA6Cj4gU3Vic2VxdWVudCBw
YXRjaGVzIGVuYWJsZSBnZXQgYW5kIHNldCBjb25maWd1cmF0aW9uIGVpdGhlcgo+IHZpYSBtYW5h
Z2VtZW50IGRldmljZSBvciB2aWEgdmRwYSBkZXZpY2UnIGNvbmZpZyBvcHMuCj4KPiBUaGlzIHJl
cXVpcmVzIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuIG11bHRpcGxlIGNhbGxlcnMgdG8gZ2V0IGFu
ZCBzZXQKPiBjb25maWcgY2FsbGJhY2tzLiBGZWF0dXJlcyBzZXR0aW5nIGFsc28gaW5mbHVlbmNl
IHRoZSBsYXlvdXQgb2YgdGhlCj4gY29uZmlndXJhdGlvbiBmaWVsZHMgZW5kaWFubmVzcy4KPgo+
IFRvIGF2b2lkIGV4cG9zaW5nIHN5bmNocm9uaXphdGlvbiBwcmltaXRpdmVzIHRvIGNhbGxlcnMs
IGludHJvZHVjZQo+IGhlbHBlciBmb3Igc2V0dGluZyB0aGUgY29uZmlndXJhdGlvbiBhbmQgdXNl
IGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+
IFJldmlld2VkLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+IGNoYW5nZWxvZzoKPiB2MS0+
djIKPiAgIC0gbmV3IHBhdGNoIHRvIGhhdmUgc3luY2hyb25pemVkIGFjY2VzcyB0byBmZWF0dXJl
cyBhbmQgY29uZmlnIHNwYWNlCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jICB8IDM2ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy92aG9zdC92ZHBh
LmMgfCAgMyArLS0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgMTggKysrKy0tLS0tLS0tLS0t
LS0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRw
YS5jCj4gaW5kZXggYmIzZjFkMWYwNDIyLi5iYzQ0Y2RjMzQxMTQgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiBAQCAtMjg0LDYg
KzI4NCw0MiBAQCB2b2lkIHZkcGFfbWdtdGRldl91bnJlZ2lzdGVyKHN0cnVjdCB2ZHBhX21nbXRf
ZGV2ICptZGV2KQo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmRwYV9tZ210ZGV2X3VucmVn
aXN0ZXIpOwo+ICAgCj4gKy8qKgo+ICsgKiB2ZHBhX2dldF9jb25maWcgLSBHZXQgb25lIG9yIG1v
cmUgZGV2aWNlIGNvbmZpZ3VyYXRpb24gZmllbGRzLgo+ICsgKiBAdmRldjogdmRwYSBkZXZpY2Ug
dG8gb3BlcmF0ZSBvbgo+ICsgKiBAb2Zmc2V0OiBzdGFydGluZyBieXRlIG9mZnNldCBvZiB0aGUg
ZmllbGQKPiArICogQGJ1ZjogYnVmZmVyIHBvaW50ZXIgdG8gcmVhZCB0bwo+ICsgKiBAbGVuOiBs
ZW5ndGggb2YgdGhlIGNvbmZpZ3VyYXRpb24gZmllbGRzIGluIGJ5dGVzCj4gKyAqLwo+ICt2b2lk
IHZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBv
ZmZzZXQsCj4gKwkJICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pCj4gK3sKPiArCWNv
bnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiArCj4gKwkv
Kgo+ICsJICogQ29uZmlnIGFjY2Vzc2VzIGFyZW4ndCBzdXBwb3NlZCB0byB0cmlnZ2VyIGJlZm9y
ZSBmZWF0dXJlcyBhcmUgc2V0Lgo+ICsJICogSWYgaXQgZG9lcyBoYXBwZW4gd2UgYXNzdW1lIGEg
bGVnYWN5IGd1ZXN0Lgo+ICsJICovCj4gKwlpZiAoIXZkZXYtPmZlYXR1cmVzX3ZhbGlkKQo+ICsJ
CXZkcGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+ICsJb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9m
ZnNldCwgYnVmLCBsZW4pOwo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZkcGFfZ2V0X2NvbmZp
Zyk7Cj4gKwo+ICsvKioKPiArICogdmRwYV9zZXRfY29uZmlnIC0gU2V0IG9uZSBvciBtb3JlIGRl
dmljZSBjb25maWd1cmF0aW9uIGZpZWxkcy4KPiArICogQHZkZXY6IHZkcGEgZGV2aWNlIHRvIG9w
ZXJhdGUgb24KPiArICogQG9mZnNldDogc3RhcnRpbmcgYnl0ZSBvZmZzZXQgb2YgdGhlIGZpZWxk
Cj4gKyAqIEBidWY6IGJ1ZmZlciBwb2ludGVyIHRvIHJlYWQgZnJvbQo+ICsgKiBAbGVuZ3RoOiBs
ZW5ndGggb2YgdGhlIGNvbmZpZ3VyYXRpb24gZmllbGRzIGluIGJ5dGVzCj4gKyAqLwo+ICt2b2lk
IHZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBv
ZmZzZXQsCj4gKwkJICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW5ndGgpCj4gK3sKPiAr
CXZkZXYtPmNvbmZpZy0+c2V0X2NvbmZpZyh2ZGV2LCBvZmZzZXQsIGJ1ZiwgbGVuZ3RoKTsKPiAr
fQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2ZHBhX3NldF9jb25maWcpOwo+ICsKPiAgIHN0YXRpYyBi
b29sIG1nbXRkZXZfaGFuZGxlX21hdGNoKGNvbnN0IHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2
LAo+ICAgCQkJCSBjb25zdCBjaGFyICpidXNuYW1lLCBjb25zdCBjaGFyICpkZXZuYW1lKQo+ICAg
ewo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4gaW5kZXggZmI0MWRiM2RhNjExLi45MDhiNGZiMjUxYjMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0yMzEs
NyArMjMxLDYgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfY29uZmlnKHN0cnVjdCB2aG9z
dF92ZHBhICp2LAo+ICAgCQkJCSAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnIF9fdXNlciAqYykK
PiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+IC0JY29uc3Qg
c3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ICAgCXN0cnVjdCB2
aG9zdF92ZHBhX2NvbmZpZyBjb25maWc7Cj4gICAJdW5zaWduZWQgbG9uZyBzaXplID0gb2Zmc2V0
b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+ICAgCXU4ICpidWY7Cj4gQEAgLTI0
NSw3ICsyNDQsNyBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9jb25maWcoc3RydWN0IHZo
b3N0X3ZkcGEgKnYsCj4gICAJaWYgKElTX0VSUihidWYpKQo+ICAgCQlyZXR1cm4gUFRSX0VSUihi
dWYpOwo+ICAgCj4gLQlvcHMtPnNldF9jb25maWcodmRwYSwgY29uZmlnLm9mZiwgYnVmLCBjb25m
aWcubGVuKTsKPiArCXZkcGFfc2V0X2NvbmZpZyh2ZHBhLCBjb25maWcub2ZmLCBidWYsIGNvbmZp
Zy5sZW4pOwo+ICAgCj4gICAJa3ZmcmVlKGJ1Zik7Cj4gICAJcmV0dXJuIDA7Cj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCBm
MzExZDIyN2FhMWIuLjk5M2Q5OTUxOTQ1MiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTMzMiwyMCArMzMyLDEwIEBA
IHN0YXRpYyBpbmxpbmUgaW50IHZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgICAgICAgICByZXR1cm4gb3BzLT5zZXRfZmVhdHVyZXMo
dmRldiwgZmVhdHVyZXMpOwo+ICAgfQo+ICAgCj4gLQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgdmRw
YV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgb2Zmc2V0LAo+
IC0JCQkJICAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuKQo+IC17Cj4gLSAgICAgICAgY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+IC0KPiAtCS8q
Cj4gLQkgKiBDb25maWcgYWNjZXNzZXMgYXJlbid0IHN1cHBvc2VkIHRvIHRyaWdnZXIgYmVmb3Jl
IGZlYXR1cmVzIGFyZSBzZXQuCj4gLQkgKiBJZiBpdCBkb2VzIGhhcHBlbiB3ZSBhc3N1bWUgYSBs
ZWdhY3kgZ3Vlc3QuCj4gLQkgKi8KPiAtCWlmICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCj4gLQkJ
dmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gLQlvcHMtPmdldF9jb25maWcodmRldiwgb2Zm
c2V0LCBidWYsIGxlbik7Cj4gLX0KPiArdm9pZCB2ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICsJCSAgICAgdm9pZCAqYnVmLCB1
bnNpZ25lZCBpbnQgbGVuKTsKPiArdm9pZCB2ZHBhX3NldF9jb25maWcoc3RydWN0IHZkcGFfZGV2
aWNlICpkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gKwkJICAgICB2b2lkICpidWYsIHVuc2ln
bmVkIGludCBsZW5ndGgpOwo+ICAgCj4gICAvKioKPiAgICAqIHN0cnVjdCB2ZHBhX21nbXRkZXZf
b3BzIC0gdmRwYSBkZXZpY2Ugb3BzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
