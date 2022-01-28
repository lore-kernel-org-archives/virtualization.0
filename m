Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FBDC433F5
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 05:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E32FF60AD8;
	Fri, 28 Jan 2022 05:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvwU3Fe5rcVG; Fri, 28 Jan 2022 05:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5558E606ED;
	Fri, 28 Jan 2022 05:59:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1538BC001A;
	Fri, 28 Jan 2022 05:59:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49C5AC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2438F60A80
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qLy7U_qk5toC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:59:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49403606ED
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643349565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oitSK9I3YZG1rWLNMuU6LMoA46dX5KaaI4ppmXJErZM=;
 b=RcTEPguiPUsJwzdrxWerpIXPLUMAPcmbIDryYMWSUyNFgGctfRlrSp9S5WMmBjqTKJ/9JU
 B5fiaW2NsAwsPnmm19oCvxnVFSmherWs7yOiKKz7ZIx4hSAXWmyz8TFA42y2GkHhzzeYHs
 99VdHMZ/dCXa0kLge3WnE+jBOCMJzG0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-xLD0djCXOI23rbcblINsiQ-1; Fri, 28 Jan 2022 00:59:18 -0500
X-MC-Unique: xLD0djCXOI23rbcblINsiQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 l9-20020a170903120900b0014a4205ebe3so2690306plh.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 21:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oitSK9I3YZG1rWLNMuU6LMoA46dX5KaaI4ppmXJErZM=;
 b=WOIM4wWTZvzQS3rPkv/PG05gZD4KT0kSi6VsXug7zdbtEiIyKIsV2907Nw9u+9EGMN
 wt2bXRr1s1OTmDo5kM2hRjIxT9OQeaRF5EDq4DY/E53faDc93Ar1W1oeI+6tqj5s4GMo
 fQO+yb8RCuRJ93DcKxdtgEFLhI4v2aJux7g6Q/ogISe7VMbigNFmt5jCJGPp8xZCIHym
 nOP+y81EyRbGjoBMxsoUCOoQ7viOwPMJpN1ydQcXZzTfaI+rvZs4iW7miHC3J39J5YOi
 SAR2mt4yLZbPP8FBLNaXy/vIGGqCHqIrSF70jJV1aD1zCeHJXcMYHtwJEUrTr56IoLB4
 Hmsg==
X-Gm-Message-State: AOAM533fO5myITDkQ3y5tBGoeJakqzYmm/Sr9pr6RKsooK1HHGXuV+PK
 tlhoF65E/SoAWEwLfLfhCIy+C8Q1y3el/dLqIdW6wYq4hzGp+Vp++s4C9r7he+q9cX3ThRpEePv
 x6ND/8Njd07o083m2ZOqUxOtjAll8pH5PJQjCUdv4Jw==
X-Received: by 2002:a05:6a00:1312:: with SMTP id
 j18mr6250489pfu.61.1643349557202; 
 Thu, 27 Jan 2022 21:59:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxM7GtklXiZln7FjKCq9nZUq3JnD3OmTjctC2A2YbpD3k9gYpSmt6jUwUaiKrDlDwzoMg+EuQ==
X-Received: by 2002:a05:6a00:1312:: with SMTP id
 j18mr6250443pfu.61.1643349556884; 
 Thu, 27 Jan 2022 21:59:16 -0800 (PST)
Received: from [10.72.13.185] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f16sm8147510pfa.147.2022.01.27.21.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 21:59:16 -0800 (PST)
Message-ID: <bb5490a4-8fae-0cc8-56dd-0953a2b40922@redhat.com>
Date: Fri, 28 Jan 2022 13:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 01/31] vdpa: Reorder virtio/vhost-vdpa.c functions
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-2-eperezma@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IHZob3N0
X3ZkcGFfc2V0X2ZlYXR1cmVzIGFuZCB2aG9zdF92ZHBhX2luaXQgbmVlZCB0byB1c2UKPiB2aG9z
dF92ZHBhX2dldF9mZWF0dXJlcyBpbiBzdnEgbW9kZS4KPgo+IHZob3N0X3ZkcGFfZGV2X3N0YXJ0
IG5lZWRzIHRvIHVzZSBhbG1vc3QgYWxsIF9zZXRfIGZ1bmN0aW9uczoKPiB2aG9zdF92ZHBhX3Nl
dF92cmluZ19kZXZfa2ljaywgdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2NhbGwsCj4gdmhvc3Rf
dmRwYV9zZXRfZGV2X3ZyaW5nX2Jhc2UgYW5kIHZob3N0X3ZkcGFfc2V0X2Rldl92cmluZ19udW0u
Cj4KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4KCgpJcyBpdCByZWxhdGVkIChhIG11
c3QpIHRvIHRoZSBTVlEgY29kZT8KClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3L3ZpcnRpby92aG9zdC12
ZHBhLmMgfCAxNjQgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCA4MiBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEu
Ywo+IGluZGV4IDA0ZWE0MzcwNGYuLjZjMTBhN2YwNWYgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlv
L3Zob3N0LXZkcGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtMzQyLDQx
ICszNDIsNiBAQCBzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX29uZV90aW1lX3JlcXVlc3Qoc3RydWN0
IHZob3N0X2RldiAqZGV2KQo+ICAgICAgIHJldHVybiB2LT5pbmRleCAhPSAwOwo+ICAgfQo+ICAg
Cj4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9pbml0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdm9p
ZCAqb3BhcXVlLCBFcnJvciAqKmVycnApCj4gLXsKPiAtICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2
Owo+IC0gICAgYXNzZXJ0KGRldi0+dmhvc3Rfb3BzLT5iYWNrZW5kX3R5cGUgPT0gVkhPU1RfQkFD
S0VORF9UWVBFX1ZEUEEpOwo+IC0gICAgdHJhY2Vfdmhvc3RfdmRwYV9pbml0KGRldiwgb3BhcXVl
KTsKPiAtICAgIGludCByZXQ7Cj4gLQo+IC0gICAgLyoKPiAtICAgICAqIFNpbWlsYXIgdG8gVkZJ
Tywgd2UgZW5kIHVwIHBpbm5pbmcgYWxsIGd1ZXN0IG1lbW9yeSBhbmQgaGF2ZSB0bwo+IC0gICAg
ICogZGlzYWJsZSBkaXNjYXJkaW5nIG9mIFJBTS4KPiAtICAgICAqLwo+IC0gICAgcmV0ID0gcmFt
X2Jsb2NrX2Rpc2NhcmRfZGlzYWJsZSh0cnVlKTsKPiAtICAgIGlmIChyZXQpIHsKPiAtICAgICAg
ICBlcnJvcl9yZXBvcnQoIkNhbm5vdCBzZXQgZGlzY2FyZGluZyBvZiBSQU0gYnJva2VuIik7Cj4g
LSAgICAgICAgcmV0dXJuIHJldDsKPiAtICAgIH0KPiAtCj4gLSAgICB2ID0gb3BhcXVlOwo+IC0g
ICAgdi0+ZGV2ID0gZGV2Owo+IC0gICAgZGV2LT5vcGFxdWUgPSAgb3BhcXVlIDsKPiAtICAgIHYt
Pmxpc3RlbmVyID0gdmhvc3RfdmRwYV9tZW1vcnlfbGlzdGVuZXI7Cj4gLSAgICB2LT5tc2dfdHlw
ZSA9IFZIT1NUX0lPVExCX01TR19WMjsKPiAtCj4gLSAgICB2aG9zdF92ZHBhX2dldF9pb3ZhX3Jh
bmdlKHYpOwo+IC0KPiAtICAgIGlmICh2aG9zdF92ZHBhX29uZV90aW1lX3JlcXVlc3QoZGV2KSkg
ewo+IC0gICAgICAgIHJldHVybiAwOwo+IC0gICAgfQo+IC0KPiAtICAgIHZob3N0X3ZkcGFfYWRk
X3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19BQ0tOT1dMRURHRSB8Cj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPiAtCj4gLSAgICBy
ZXR1cm4gMDsKPiAtfQo+IC0KPiAgIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfaG9zdF9ub3RpZmll
cl91bmluaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQgcXVldWVfaW5kZXgpCj4gICB7Cj4gQEAgLTUwNiwy
NCArNDcxLDYgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9tZW1fdGFibGUoc3RydWN0IHZo
b3N0X2RldiAqZGV2LAo+ICAgICAgIHJldHVybiAwOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQg
dmhvc3RfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGZlYXR1cmVzKQo+IC17Cj4gLSAg
ICBpbnQgcmV0Owo+IC0KPiAtICAgIGlmICh2aG9zdF92ZHBhX29uZV90aW1lX3JlcXVlc3QoZGV2
KSkgewo+IC0gICAgICAgIHJldHVybiAwOwo+IC0gICAgfQo+IC0KPiAtICAgIHRyYWNlX3Zob3N0
X3ZkcGFfc2V0X2ZlYXR1cmVzKGRldiwgZmVhdHVyZXMpOwo+IC0gICAgcmV0ID0gdmhvc3RfdmRw
YV9jYWxsKGRldiwgVkhPU1RfU0VUX0ZFQVRVUkVTLCAmZmVhdHVyZXMpOwo+IC0gICAgaWYgKHJl
dCkgewo+IC0gICAgICAgIHJldHVybiByZXQ7Cj4gLSAgICB9Cj4gLQo+IC0gICAgcmV0dXJuIHZo
b3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19GRUFUVVJFU19PSyk7Cj4g
LX0KPiAtCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X2JhY2tlbmRfY2FwKHN0cnVjdCB2
aG9zdF9kZXYgKmRldikKPiAgIHsKPiAgICAgICB1aW50NjRfdCBmZWF0dXJlczsKPiBAQCAtNjQ2
LDM1ICs1OTMsNiBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYsIHVpbnQ4X3QgKmNvbmZpZywKPiAgICAgICByZXR1cm4gcmV0Owo+ICAgIH0K
PiAgIAo+IC1zdGF0aWMgaW50IHZob3N0X3ZkcGFfZGV2X3N0YXJ0KHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwgYm9vbCBzdGFydGVkKQo+IC17Cj4gLSAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGRl
di0+b3BhcXVlOwo+IC0gICAgdHJhY2Vfdmhvc3RfdmRwYV9kZXZfc3RhcnQoZGV2LCBzdGFydGVk
KTsKPiAtCj4gLSAgICBpZiAoc3RhcnRlZCkgewo+IC0gICAgICAgIHZob3N0X3ZkcGFfaG9zdF9u
b3RpZmllcnNfaW5pdChkZXYpOwo+IC0gICAgICAgIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX3JlYWR5
KGRldik7Cj4gLSAgICB9IGVsc2Ugewo+IC0gICAgICAgIHZob3N0X3ZkcGFfaG9zdF9ub3RpZmll
cnNfdW5pbml0KGRldiwgZGV2LT5udnFzKTsKPiAtICAgIH0KPiAtCj4gLSAgICBpZiAoZGV2LT52
cV9pbmRleCArIGRldi0+bnZxcyAhPSBkZXYtPnZxX2luZGV4X2VuZCkgewo+IC0gICAgICAgIHJl
dHVybiAwOwo+IC0gICAgfQo+IC0KPiAtICAgIGlmIChzdGFydGVkKSB7Cj4gLSAgICAgICAgbWVt
b3J5X2xpc3RlbmVyX3JlZ2lzdGVyKCZ2LT5saXN0ZW5lciwgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5
KTsKPiAtICAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9hZGRfc3RhdHVzKGRldiwgVklSVElPX0NP
TkZJR19TX0RSSVZFUl9PSyk7Cj4gLSAgICB9IGVsc2Ugewo+IC0gICAgICAgIHZob3N0X3ZkcGFf
cmVzZXRfZGV2aWNlKGRldik7Cj4gLSAgICAgICAgdmhvc3RfdmRwYV9hZGRfc3RhdHVzKGRldiwg
VklSVElPX0NPTkZJR19TX0FDS05PV0xFREdFIHwKPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPiAtICAgICAgICBtZW1vcnlfbGlz
dGVuZXJfdW5yZWdpc3Rlcigmdi0+bGlzdGVuZXIpOwo+IC0KPiAtICAgICAgICByZXR1cm4gMDsK
PiAtICAgIH0KPiAtfQo+IC0KPiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfbG9nX2Jhc2Uo
c3RydWN0IHZob3N0X2RldiAqZGV2LCB1aW50NjRfdCBiYXNlLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9sb2cgKmxvZykKPiAgIHsKPiBAQCAt
NzM1LDYgKzY1MywzNSBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGwoc3Ry
dWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgIHJldHVybiB2aG9zdF92ZHBhX2NhbGwoZGV2LCBW
SE9TVF9TRVRfVlJJTkdfQ0FMTCwgZmlsZSk7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aG9z
dF92ZHBhX2Rldl9zdGFydChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJvb2wgc3RhcnRlZCkKPiAr
ewo+ICsgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiArICAgIHRyYWNl
X3Zob3N0X3ZkcGFfZGV2X3N0YXJ0KGRldiwgc3RhcnRlZCk7Cj4gKwo+ICsgICAgaWYgKHN0YXJ0
ZWQpIHsKPiArICAgICAgICB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX2luaXQoZGV2KTsKPiAr
ICAgICAgICB2aG9zdF92ZHBhX3NldF92cmluZ19yZWFkeShkZXYpOwo+ICsgICAgfSBlbHNlIHsK
PiArICAgICAgICB2aG9zdF92ZHBhX2hvc3Rfbm90aWZpZXJzX3VuaW5pdChkZXYsIGRldi0+bnZx
cyk7Cj4gKyAgICB9Cj4gKwo+ICsgICAgaWYgKGRldi0+dnFfaW5kZXggKyBkZXYtPm52cXMgIT0g
ZGV2LT52cV9pbmRleF9lbmQpIHsKPiArICAgICAgICByZXR1cm4gMDsKPiArICAgIH0KPiArCj4g
KyAgICBpZiAoc3RhcnRlZCkgewo+ICsgICAgICAgIG1lbW9yeV9saXN0ZW5lcl9yZWdpc3Rlcigm
di0+bGlzdGVuZXIsICZhZGRyZXNzX3NwYWNlX21lbW9yeSk7Cj4gKyAgICAgICAgcmV0dXJuIHZo
b3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spOwo+ICsg
ICAgfSBlbHNlIHsKPiArICAgICAgICB2aG9zdF92ZHBhX3Jlc2V0X2RldmljZShkZXYpOwo+ICsg
ICAgICAgIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19BQ0tOT1dM
RURHRSB8Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0NPTkZJ
R19TX0RSSVZFUik7Cj4gKyAgICAgICAgbWVtb3J5X2xpc3RlbmVyX3VucmVnaXN0ZXIoJnYtPmxp
c3RlbmVyKTsKPiArCj4gKyAgICAgICAgcmV0dXJuIDA7Cj4gKyAgICB9Cj4gK30KPiArCj4gICBz
dGF0aWMgaW50IHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqZmVhdHVy
ZXMpCj4gICB7Cj4gQEAgLTc0NSw2ICs2OTIsMjQgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2dl
dF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAgICAgcmV0dXJuIHJldDsKPiAg
IH0KPiAgIAo+ICtzdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9z
dF9kZXYgKmRldiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRf
dCBmZWF0dXJlcykKPiArewo+ICsgICAgaW50IHJldDsKPiArCj4gKyAgICBpZiAodmhvc3RfdmRw
YV9vbmVfdGltZV9yZXF1ZXN0KGRldikpIHsKPiArICAgICAgICByZXR1cm4gMDsKPiArICAgIH0K
PiArCj4gKyAgICB0cmFjZV92aG9zdF92ZHBhX3NldF9mZWF0dXJlcyhkZXYsIGZlYXR1cmVzKTsK
PiArICAgIHJldCA9IHZob3N0X3ZkcGFfY2FsbChkZXYsIFZIT1NUX1NFVF9GRUFUVVJFUywgJmZl
YXR1cmVzKTsKPiArICAgIGlmIChyZXQpIHsKPiArICAgICAgICByZXR1cm4gcmV0Owo+ICsgICAg
fQo+ICsKPiArICAgIHJldHVybiB2aG9zdF92ZHBhX2FkZF9zdGF0dXMoZGV2LCBWSVJUSU9fQ09O
RklHX1NfRkVBVFVSRVNfT0spOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Nl
dF9vd25lcihzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICB7Cj4gICAgICAgaWYgKHZob3N0X3Zk
cGFfb25lX3RpbWVfcmVxdWVzdChkZXYpKSB7Cj4gQEAgLTc3Miw2ICs3MzcsNDEgQEAgc3RhdGlj
IGJvb2wgIHZob3N0X3ZkcGFfZm9yY2VfaW9tbXUoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICAg
ICAgIHJldHVybiB0cnVlOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9pbml0
KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApCj4gK3sK
PiArICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2Owo+ICsgICAgYXNzZXJ0KGRldi0+dmhvc3Rfb3Bz
LT5iYWNrZW5kX3R5cGUgPT0gVkhPU1RfQkFDS0VORF9UWVBFX1ZEUEEpOwo+ICsgICAgdHJhY2Vf
dmhvc3RfdmRwYV9pbml0KGRldiwgb3BhcXVlKTsKPiArICAgIGludCByZXQ7Cj4gKwo+ICsgICAg
LyoKPiArICAgICAqIFNpbWlsYXIgdG8gVkZJTywgd2UgZW5kIHVwIHBpbm5pbmcgYWxsIGd1ZXN0
IG1lbW9yeSBhbmQgaGF2ZSB0bwo+ICsgICAgICogZGlzYWJsZSBkaXNjYXJkaW5nIG9mIFJBTS4K
PiArICAgICAqLwo+ICsgICAgcmV0ID0gcmFtX2Jsb2NrX2Rpc2NhcmRfZGlzYWJsZSh0cnVlKTsK
PiArICAgIGlmIChyZXQpIHsKPiArICAgICAgICBlcnJvcl9yZXBvcnQoIkNhbm5vdCBzZXQgZGlz
Y2FyZGluZyBvZiBSQU0gYnJva2VuIik7Cj4gKyAgICAgICAgcmV0dXJuIHJldDsKPiArICAgIH0K
PiArCj4gKyAgICB2ID0gb3BhcXVlOwo+ICsgICAgdi0+ZGV2ID0gZGV2Owo+ICsgICAgZGV2LT5v
cGFxdWUgPSAgb3BhcXVlIDsKPiArICAgIHYtPmxpc3RlbmVyID0gdmhvc3RfdmRwYV9tZW1vcnlf
bGlzdGVuZXI7Cj4gKyAgICB2LT5tc2dfdHlwZSA9IFZIT1NUX0lPVExCX01TR19WMjsKPiArCj4g
KyAgICB2aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKHYpOwo+ICsKPiArICAgIGlmICh2aG9zdF92
ZHBhX29uZV90aW1lX3JlcXVlc3QoZGV2KSkgewo+ICsgICAgICAgIHJldHVybiAwOwo+ICsgICAg
fQo+ICsKPiArICAgIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19B
Q0tOT1dMRURHRSB8Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fQ09O
RklHX1NfRFJJVkVSKTsKPiArCj4gKyAgICByZXR1cm4gMDsKPiArfQo+ICsKPiAgIGNvbnN0IFZo
b3N0T3BzIHZkcGFfb3BzID0gewo+ICAgICAgICAgICAuYmFja2VuZF90eXBlID0gVkhPU1RfQkFD
S0VORF9UWVBFX1ZEUEEsCj4gICAgICAgICAgIC52aG9zdF9iYWNrZW5kX2luaXQgPSB2aG9zdF92
ZHBhX2luaXQsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
