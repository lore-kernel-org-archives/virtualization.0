Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAFCC61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 05:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CE3782355;
	Tue, 21 Feb 2023 05:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CE3782355
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/k5pVX6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zqG_cmHBcTOV; Tue, 21 Feb 2023 05:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA7B681FEC;
	Tue, 21 Feb 2023 05:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA7B681FEC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1468C0033;
	Tue, 21 Feb 2023 05:33:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB80CC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEAA181FEC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEAA181FEC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FGosQJeIJs4n
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:33:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBB8481FEB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBB8481FEB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676957605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYDl9vHml7hogYo9zOeHzxGqhCLpoCJSpQhVKgAXXoQ=;
 b=c/k5pVX6LXfTSON4mzucws34yU1crOyaAihzZMMM9Eckz038qBg+crQ/IybjWTKpt6OBIZ
 KshOxqWx2JX5ZCPxL7t4dw/acOdRpRDndcprPxO1VjGARQn6ixFT901pM8cr4JM4RsiK7b
 cV5HYmdD1H084bRV5EUgJmZMw4U+88o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-1H6KdgO4Meq-BnYI4MjzFA-1; Tue, 21 Feb 2023 00:33:22 -0500
X-MC-Unique: 1H6KdgO4Meq-BnYI4MjzFA-1
Received: by mail-pl1-f197.google.com with SMTP id
 lm13-20020a170903298d00b0019a8c8a13dfso1826859plb.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 21:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYDl9vHml7hogYo9zOeHzxGqhCLpoCJSpQhVKgAXXoQ=;
 b=3rwKJw/rOI+9P3g7co7sK2T+kNWqLQLda/NuUT/cyuSIy4BDr0eYaRc5q6zal0pxvc
 bU08sDDSNNUsq+lhjSBgY81ezjJSx0Dt/wnslAH8dYf54wJ46CY4zgNWf/CbX7Kt6oWi
 a8cRXXNsmTzMIZK4VQlPOz/uBu0rnTLiuQnmKvSMGWUj/nXoVXYMMZFbNC7wMU9X/u9a
 tNOcrfS/8MDwygM0I9xW/58xPCjpnm9wxDzmNE4eSw2D9aHwWzwCKmwaZVr6VqcV9RIn
 R+oM/shWPfX6M34k2IypnhMZRRercIUQqm9tkAuMlIoZneCi7GaOjEVbupWyHXnYWDJI
 Hm+w==
X-Gm-Message-State: AO0yUKV9S7MGSVPK4widrPpLGh/XSDNJQNBRY6c2nQPVB5NUxmmruX5o
 9rs+bHeajX7vZOWFPk0GTpyGONyMQ8t/dYN3AVLa4xSJtDG9rISU9+5T79JnakRlCmNTWpst+B7
 gPaR7/J3mB7ki01T7xmuljUiJXmlx0/FtdBAdu7dn8w==
X-Received: by 2002:a62:844e:0:b0:5a8:a56c:6144 with SMTP id
 k75-20020a62844e000000b005a8a56c6144mr3715690pfd.19.1676957601468; 
 Mon, 20 Feb 2023 21:33:21 -0800 (PST)
X-Google-Smtp-Source: AK7set9hZv6z/cN1tcpGGFx5Ks94rmBykzu5W1/iXc5r2Xg/l+0hUInxaxFX9a1zFCDkxaQhpKVf/A==
X-Received: by 2002:a62:844e:0:b0:5a8:a56c:6144 with SMTP id
 k75-20020a62844e000000b005a8a56c6144mr3715679pfd.19.1676957601165; 
 Mon, 20 Feb 2023 21:33:21 -0800 (PST)
Received: from [10.72.12.235] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v18-20020aa78512000000b005a8ba6e1464sm7104116pfn.38.2023.02.20.21.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Feb 2023 21:33:20 -0800 (PST)
Message-ID: <3c994402-9c09-bbf2-31a1-c8e785674b6b@redhat.com>
Date: Tue, 21 Feb 2023 13:33:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 03/13] vdpa: add vhost_vdpa_suspend
From: Jason Wang <jasowang@redhat.com>
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-4-eperezma@redhat.com>
 <5a4749e4-4cd4-4f07-a4db-665772003058@redhat.com>
In-Reply-To: <5a4749e4-4cd4-4f07-a4db-665772003058@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvMjEgMTM6MjcsIEphc29uIFdhbmcg5YaZ6YGTOgo+Cj4g5ZyoIDIwMjMvMi84
IDE3OjQyLCBFdWdlbmlvIFDDqXJleiDlhpnpgZM6Cj4+IFRoZSBmdW5jdGlvbiB2aG9zdC5jOnZo
b3N0X2Rldl9zdG9wIGZldGNoZXMgdGhlIHZyaW5nIGJhc2Ugc28gdGhlIHZxCj4+IHN0YXRlIGNh
biBiZSBtaWdyYXRlZCB0byBvdGhlciBkZXZpY2VzLsKgIEhvd2V2ZXIsIHRoaXMgaXMgdW5yZWxp
YWJsZSBpbgo+PiB2ZHBhLCBzaW5jZSB3ZSBkaWRuJ3Qgc2lnbmFsIHRoZSBkZXZpY2UgdG8gc3Vz
cGVuZCB0aGUgcXVldWVzLCBtYWtpbmcKPj4gdGhlIHZhbHVlIGZldGNoZWQgdXNlbGVzcy4KPj4K
Pj4gU3VzcGVuZCB0aGUgZGV2aWNlIGlmIHBvc3NpYmxlIGJlZm9yZSBmZXRjaGluZyBmaXJzdCBh
bmQgc3Vic2VxdWVudAo+PiB2cmluZyBiYXNlcy4KPj4KPj4gTW9yZW92ZXIsIHZkcGEgdG90YWxs
eSByZXNldCBhbmQgd2lwZXMgdGhlIGRldmljZSBhdCB0aGUgbGFzdCBkZXZpY2UKPj4gYmVmb3Jl
IGZldGNoIGl0cyB2cmluZ3MgYmFzZSwgbWFraW5nIHRoYXQgb3BlcmF0aW9uIHVzZWxlc3MgaW4g
dGhlIGxhc3QKPj4gZGV2aWNlLiBUaGlzIHdpbGwgYmUgZml4ZWQgaW4gbGF0ZXIgcGF0Y2hlcyBv
ZiB0aGlzIHNlcmllcy4KPgo+Cj4gSXQgd291bGQgYmUgYmV0dGVyIG5vdCBpbnRyb2R1Y2UgYSBi
dWcgZmlyc3QgYW5kIGZpeCBpdCBpbiB0aGUgCj4gZm9sbG93aW5nIHBhdGNoLgo+Cj4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+IC0t
LQo+PiDCoCBody92aXJ0aW8vdmhvc3QtdmRwYS5jIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+
PiDCoCBody92aXJ0aW8vdHJhY2UtZXZlbnRzIHzCoCAxICsKPj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCAyMCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRw
YS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+PiBpbmRleCAyZTc5ZmJlNGIyLi5jYmJlOTJm
ZmU4IDEwMDY0NAo+PiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4+ICsrKyBiL2h3L3Zp
cnRpby92aG9zdC12ZHBhLmMKPj4gQEAgLTExMDgsNiArMTEwOCwyNCBAQCBzdGF0aWMgdm9pZCB2
aG9zdF92ZHBhX3N2cXNfc3RvcChzdHJ1Y3QgCj4+IHZob3N0X2RldiAqZGV2KQo+PiDCoMKgwqDC
oMKgIH0KPj4gwqAgfQo+PiDCoCArc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9zdXNwZW5kKHN0cnVj
dCB2aG9zdF9kZXYgKmRldikKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9
IGRldi0+b3BhcXVlOwo+PiArwqDCoMKgIGludCByOwo+PiArCj4+ICvCoMKgwqAgaWYgKCF2aG9z
dF92ZHBhX2ZpcnN0X2RldihkZXYpIHx8Cj4KPgo+IEFueSByZWFzb24gd2UgbmVlZCB0byB1c2Ug
dmhvc3RfdmRwYV9maXJzdF9kZXYoKSBpbnN0ZWFkIG9mIHJlcGxhY2luZyB0aGUKPgo+IGlmIChz
dGFydGVkKSB7Cj4gfSBlbHNlIHsKPiDCoMKgwqAgdmhvc3RfdmRwYV9yZXNldF9kZXZpY2UoZGV2
KTsKPiDCoMKgwqAgLi4uLgo+IH0KCgpPaywgSSB0aGluayBJIGtpbmQgb2YgdW5kZXJzdGFuZCwg
c28gSSB0aGluayB3ZSBuZWVkIHJlLW9yZGVyIHRoZSAKcGF0Y2hlcywgYXQgbGVhc3QgcGF0Y2gg
NCBzaG91bGQgY29tZSBiZWZvcmUgdGhpcyBwYXRjaD8KClRoYW5rcwoKCj4KPgo+IFdlIGNoZWNr
Cj4KPiBpZiAoZGV2LT52cV9pbmRleCArIGRldi0+bnZxcyAhPSBkZXYtPnZxX2luZGV4X2VuZCkg
aW4gCj4gdmhvc3RfdmRwYV9kZXZfc3RhcnQoKSBidXQgdmhvc3RfdmRwYV9maXJzdF9kZXYoKSBp
bnNpZGUgCj4gdmhvc3RfdmRwYV9zdXNwZW5kKCkuIFRoaXMgd2lsbCByZXN1bHQgY29kZSB0aGF0
IGlzIGhhcmQgdG8gbWFpbnRhaW4uCj4KPiBUaGFua3MKPgo+Cj4+ICvCoMKgwqDCoMKgwqDCoCAh
KGRldi0+YmFja2VuZF9jYXAgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkpIHsK
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCB0
cmFjZV92aG9zdF92ZHBhX3N1c3BlbmQoZGV2KTsKPj4gK8KgwqDCoCByID0gaW9jdGwodi0+ZGV2
aWNlX2ZkLCBWSE9TVF9WRFBBX1NVU1BFTkQpOwo+PiArwqDCoMKgIGlmICh1bmxpa2VseShyKSkg
ewo+PiArwqDCoMKgwqDCoMKgwqAgZXJyb3JfcmVwb3J0KCJDYW5ub3Qgc3VzcGVuZDogJXMoJWQp
IiwgZ19zdHJlcnJvcihlcnJubyksIAo+PiBlcnJubyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBO
b3QgYWJvcnRpbmcgc2luY2Ugd2UncmUgY2FsbGVkIGZyb20gc3RvcCBjb250ZXh0ICovCj4+ICvC
oMKgwqAgfQo+PiArfQo+PiArCj4+IMKgIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9kZXZfc3RhcnQo
c3RydWN0IHZob3N0X2RldiAqZGV2LCBib29sIHN0YXJ0ZWQpCj4+IMKgIHsKPj4gwqDCoMKgwqDC
oCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGRldi0+b3BhcXVlOwo+PiBAQCAtMTEyMiw2ICsxMTQw
LDcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2Rldl9zdGFydChzdHJ1Y3QgCj4+IHZob3N0X2Rl
diAqZGV2LCBib29sIHN0YXJ0ZWQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCB2aG9zdF92ZHBhX3NldF92cmluZ19yZWFkeShkZXYpOwo+PiDCoMKgwqDCoMKg
IH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCB2aG9zdF92ZHBhX3N1c3BlbmQoZGV2KTsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHZob3N0X3ZkcGFfc3Zxc19zdG9wKGRldik7Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX3VuaW5pdChkZXYsIGRldi0+bnZx
cyk7Cj4+IMKgwqDCoMKgwqAgfQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50
cyBiL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKPj4gaW5kZXggYTg3YzVmMzlhMi4uOGY4ZDA1Y2Y5
YiAxMDA2NDQKPj4gLS0tIGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50cwo+PiArKysgYi9ody92aXJ0
aW8vdHJhY2UtZXZlbnRzCj4+IEBAIC01MCw2ICs1MCw3IEBAIHZob3N0X3ZkcGFfc2V0X3ZyaW5n
X3JlYWR5KHZvaWQgKmRldikgImRldjogJXAiCj4+IMKgIHZob3N0X3ZkcGFfZHVtcF9jb25maWco
dm9pZCAqZGV2LCBjb25zdCBjaGFyICpsaW5lKSAiZGV2OiAlcCAlcyIKPj4gwqAgdmhvc3RfdmRw
YV9zZXRfY29uZmlnKHZvaWQgKmRldiwgdWludDMyX3Qgb2Zmc2V0LCB1aW50MzJfdCBzaXplLCAK
Pj4gdWludDMyX3QgZmxhZ3MpICJkZXY6ICVwIG9mZnNldDogJSJQUkl1MzIiIHNpemU6ICUiUFJJ
dTMyIiBmbGFnczogCj4+IDB4JSJQUkl4MzIKPj4gwqAgdmhvc3RfdmRwYV9nZXRfY29uZmlnKHZv
aWQgKmRldiwgdm9pZCAqY29uZmlnLCB1aW50MzJfdCBjb25maWdfbGVuKSAKPj4gImRldjogJXAg
Y29uZmlnOiAlcCBjb25maWdfbGVuOiAlIlBSSXUzMgo+PiArdmhvc3RfdmRwYV9zdXNwZW5kKHZv
aWQgKmRldikgImRldjogJXAiCj4+IMKgIHZob3N0X3ZkcGFfZGV2X3N0YXJ0KHZvaWQgKmRldiwg
Ym9vbCBzdGFydGVkKSAiZGV2OiAlcCBzdGFydGVkOiAlZCIKPj4gwqAgdmhvc3RfdmRwYV9zZXRf
bG9nX2Jhc2Uodm9pZCAqZGV2LCB1aW50NjRfdCBiYXNlLCB1bnNpZ25lZCBsb25nIAo+PiBsb25n
IHNpemUsIGludCByZWZjbnQsIGludCBmZCwgdm9pZCAqbG9nKSAiZGV2OiAlcCBiYXNlOiAweCUi
UFJJeDY0IiAKPj4gc2l6ZTogJWxsdSByZWZjbnQ6ICVkIGZkOiAlZCBsb2c6ICVwIgo+PiDCoCB2
aG9zdF92ZHBhX3NldF92cmluZ19hZGRyKHZvaWQgKmRldiwgdW5zaWduZWQgaW50IGluZGV4LCB1
bnNpZ25lZCAKPj4gaW50IGZsYWdzLCB1aW50NjRfdCBkZXNjX3VzZXJfYWRkciwgdWludDY0X3Qg
dXNlZF91c2VyX2FkZHIsIHVpbnQ2NF90IAo+PiBhdmFpbF91c2VyX2FkZHIsIHVpbnQ2NF90IGxv
Z19ndWVzdF9hZGRyKSAiZGV2OiAlcCBpbmRleDogJXUgZmxhZ3M6IAo+PiAweCV4IGRlc2NfdXNl
cl9hZGRyOiAweCUiUFJJeDY0IiB1c2VkX3VzZXJfYWRkcjogMHglIlBSSXg2NCIgCj4+IGF2YWls
X3VzZXJfYWRkcjogMHglIlBSSXg2NCIgbG9nX2d1ZXN0X2FkZHI6IDB4JSJQUkl4NjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
