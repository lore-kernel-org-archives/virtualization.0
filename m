Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98DCC4332F
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 06:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 622F7605BE;
	Mon, 10 Jan 2022 06:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ROklZ4Q7u4HB; Mon, 10 Jan 2022 06:05:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B8E90605DB;
	Mon, 10 Jan 2022 06:05:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 838EBC002F;
	Mon, 10 Jan 2022 06:05:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86C07C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72FA2405B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYRV9yl59Rsb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:05:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2E7240122
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641794718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSL+kfjhLg5bk+Qk3CvWQSOPostXbc1Kzpo9+pdYbf8=;
 b=J6Wy8mAm0ReP5ntFsRQeUVS9IK3h+1SKrhzyRwRQcaQIm0Gi0TicQnybeIJUzsRNhW7kgo
 aVO3Or98lOLKEAQImEDKuy/81eNgiZ7fmKt8qgE5nzJHwRQf8pbFJ2m7ibs4vu+NhB+GAA
 +zZyVf/kGhUKQPLeNNcAGGU+og+bmQ4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-ZpwozrD3Pl2wNLyXkaFGmw-1; Mon, 10 Jan 2022 01:05:15 -0500
X-MC-Unique: ZpwozrD3Pl2wNLyXkaFGmw-1
Received: by mail-pf1-f197.google.com with SMTP id
 z20-20020aa791d4000000b004bd024eaf19so4937030pfa.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 22:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hSL+kfjhLg5bk+Qk3CvWQSOPostXbc1Kzpo9+pdYbf8=;
 b=PqPso7v2eUY90aJmT3G7Ecs3Tdv6+oKyns/E4zKj75CypJVOhH0gNw9Xyhp3G4EkOv
 3QhS24vMVIf3XTBPSCMdjGeDhn0S0WmwlpRCh3XASL5vdxAW/ABrsd0SGbtAypZejZLS
 q4E+RoS4B/OTQ1Ymo5pFXuFTZDUy5SYgkox8luLZv3uEPt+SG7o1lkayTi0gIT+67hO0
 exPjnxTRUBHamG8gJlJnZ3RyXBMBxbckgq+5qA9hMnU5Rv0ahVfslCjaRBITmj15HJ/6
 8KXOpha53iBk1hzGkrSYDJpSEVpBKWpV5x/kvELgPWrAnnWQfZv2KZlbWO786KS2SsYB
 13Dg==
X-Gm-Message-State: AOAM533AkZ+d/6b7EIlNp+mv/x6Bx0/vH6lKqv1JT4zI0Qj3Hv/3R/Vl
 TeWQK+az7itWERYUII6UV/ofFmmHKFqSxV3UzMoCEvv9M1TZxsjrEW53AVxTvH7eBRaNpgkdrIh
 g46XPR0eTYakuoq5SMx7y+q4Wpnp+9fv6TxXUaIsAKg==
X-Received: by 2002:a63:a10a:: with SMTP id b10mr1578125pgf.539.1641794714007; 
 Sun, 09 Jan 2022 22:05:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7TSDtJff4Ip7SJIe8HxpP3EH8u0fiioY/nobr6uKgNGfBs6ZHLv4EoM5huTULGwVDdLIyGA==
X-Received: by 2002:a63:a10a:: with SMTP id b10mr1578114pgf.539.1641794713745; 
 Sun, 09 Jan 2022 22:05:13 -0800 (PST)
Received: from [10.72.13.131] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 193sm1196439pfz.44.2022.01.09.22.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jan 2022 22:05:13 -0800 (PST)
Message-ID: <3af55c17-49ad-bc9f-1b96-0a59b2ba1856@redhat.com>
Date: Mon, 10 Jan 2022 14:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
To: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
 <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com, eperezma@redhat.com
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

CuWcqCAyMDIyLzEvOCDkuIrljYg5OjIzLCBTaS1XZWkgTGl1IOWGmemBkzoKPgo+Cj4gT24gMS82
LzIwMjIgOTowOCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMS83IOS4iuWN
iDg6MzMsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Pj4KPj4+Cj4+PiBPbiAxLzUvMjAyMiAzOjQ2IEFN
LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4gQWRkIHdyYXBwZXJzIHRvIGdldC9zZXQgc3RhdHVzIGFu
ZCBwcm90ZWN0IHRoZXNlIG9wZXJhdGlvbnMgd2l0aAo+Pj4+IGNmX211dGV4IHRvIHNlcmlhbGl6
ZSB0aGVzZSBvcGVyYXRpb25zIHdpdGggcmVzcGVjdCB0byBnZXQvc2V0IGNvbmZpZwo+Pj4+IG9w
ZXJhdGlvbnMuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlh
LmNvbT4KPj4+PiAtLS0KPj4+PiDCoCBkcml2ZXJzL3ZkcGEvdmRwYS5jwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+Pj4+IMKgIGRyaXZlcnMvdmhvc3QvdmRwYS5j
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKystLS0tCj4+Pj4gwqAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3ZkcGEuYyB8wqAgMyArLS0KPj4+PiDCoCBpbmNsdWRlL2xpbnV4L3ZkcGEuaMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDMgKysrCj4+Pj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92
ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+Pj4gaW5kZXggNDJkNzFkNjBkNWRjLi41MTM0
YzgzYzRhMjIgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+ICsrKyBi
L2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+PiBAQCAtMjEsNiArMjEsMjUgQEAgc3RhdGljIExJU1Rf
SEVBRChtZGV2X2hlYWQpOwo+Pj4+IMKgIHN0YXRpYyBERUZJTkVfTVVURVgodmRwYV9kZXZfbXV0
ZXgpOwo+Pj4+IMKgIHN0YXRpYyBERUZJTkVfSURBKHZkcGFfaW5kZXhfaWRhKTsKPj4+PiDCoCAr
dTggdmRwYV9nZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4+PiArewo+Pj4+
ICvCoMKgwqAgdTggc3RhdHVzOwo+Pj4+ICsKPj4+PiArwqDCoMKgIG11dGV4X2xvY2soJnZkZXYt
PmNmX211dGV4KTsKPj4+PiArwqDCoMKgIHN0YXR1cyA9IHZkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1
cyh2ZGV2KTsKPj4+PiArwqDCoMKgIG11dGV4X3VubG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+Pj4+
ICvCoMKgwqAgcmV0dXJuIHN0YXR1czsKPj4+PiArfQo+Pj4+ICtFWFBPUlRfU1lNQk9MKHZkcGFf
Z2V0X3N0YXR1cyk7Cj4+Pj4gKwo+Pj4+ICt2b2lkIHZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPj4+PiArewo+Pj4+ICvCoMKgwqAgbXV0ZXhfbG9j
aygmdmRldi0+Y2ZfbXV0ZXgpOwo+Pj4+ICvCoMKgwqAgdmRldi0+Y29uZmlnLT5zZXRfc3RhdHVz
KHZkZXYsIHN0YXR1cyk7Cj4+Pj4gK8KgwqDCoCBtdXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4
KTsKPj4+PiArfQo+Pj4+ICtFWFBPUlRfU1lNQk9MKHZkcGFfc2V0X3N0YXR1cyk7Cj4+Pj4gKwo+
Pj4+IMKgIHN0YXRpYyBzdHJ1Y3QgZ2VubF9mYW1pbHkgdmRwYV9ubF9mYW1pbHk7Cj4+Pj4gwqAg
wqAgc3RhdGljIGludCB2ZHBhX2Rldl9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkKQo+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4g
aW5kZXggZWJhYTM3M2U5YjgyLi5kOWQ0OTk0NjVlMmUgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+IEBAIC0x
NDIsMTAgKzE0Miw5IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2RldmljZV9pZChzdHJ1
Y3QgCj4+Pj4gdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICphcmdwKQo+Pj4+IMKgIHN0YXRpYyBs
b25nIHZob3N0X3ZkcGFfZ2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2Vy
IAo+Pj4+ICpzdGF0dXNwKQo+Pj4+IMKgIHsKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+Pj4gLcKgwqDCoCBjb25zdCBzdHJ1Y3QgdmRwYV9jb25m
aWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4+Pj4gwqDCoMKgwqDCoCB1OCBzdGF0dXM7Cj4+
Pj4gwqAgLcKgwqDCoCBzdGF0dXMgPSBvcHMtPmdldF9zdGF0dXModmRwYSk7Cj4+Pj4gK8KgwqDC
oCBzdGF0dXMgPSB2ZHBhX2dldF9zdGF0dXModmRwYSk7Cj4+PiBOb3Qgc3VyZSB3aHkgd2UgbmVl
ZCB0byB0YWtlIGNmX211dGV4IGhlcmUuIEFwcGVhcnMgdG8gbWUgb25seSAKPj4+IHNldHRlcnMg
KHNldF9zdGF0dXMgYW5kIHJlc2V0KSBuZWVkIHRvIHRha2UgdGhlIGxvY2sgaW4gdGhpcyBmdW5j
dGlvbi4KPj4KPj4KPj4gWW91IG1heSBiZSByaWdodCBidXQgaXQgZG9lc24ndCBoYXJtIGFuZCBp
dCBpcyBndWFyYW50ZWVkIHRvIGJlIAo+PiBjb3JyZWN0IGlmIHdlIHByb3RlY3QgaXQgd2l0aCBt
dXRleCBoZXJlLgo+IElzIGl0IG1vcmUgZm9yIGZ1dHVyZSBwcm9vZj8KCgpJIHRoaW5rIHNvLgoK
Cj4gT2ssIGJ1dCBJTUhPIGl0IG1pZ2h0IGJlIGJldHRlciB0byBnZXQgc29tZSBjb21tZW50IGhl
cmUsIG90aGVyd2lzZSAKPiBpdCdzIHF1aXRlIGNvbmZ1c2luZyB3aHkgdGhlIGxvY2sgbmVlZHMg
dG8gYmUgaGVsZC4gdmhvc3RfdmRwYSBoYWQgCj4gZG9uZSBpdHMgb3duIHNlcmlhbGl6YXRpb24g
aW4gdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bCgpIHRocm91Z2ggCj4gdmhvc3RfZGV2YG11dGV4
LgoKClJpZ2h0LCBidXQgdGhleSBhcmUgZG9uZSBmb3IgZGlmZmVyZW50IGxldmVscywgb25lIGlz
IGZvciB2aG9zdF9kZXYgCmFudG9oZXIgaXMgZm9yIHZkcGFfZGV2LgoKVGhhbmtzCgoKPgo+IC1T
aXdlaQo+Cj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4KPj4+PiDCoCDCoMKgwqDCoMKgIGlmIChjb3B5
X3RvX3VzZXIoc3RhdHVzcCwgJnN0YXR1cywgc2l6ZW9mKHN0YXR1cykpKQo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVGQVVMVDsKPj4+PiBAQCAtMTY0LDcgKzE2Myw3IEBAIHN0YXRp
YyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgCj4+Pj4gdmhvc3RfdmRwYSAqdiwg
dTggX191c2VyICpzdGF0dXNwKQo+Pj4+IMKgwqDCoMKgwqAgaWYgKGNvcHlfZnJvbV91c2VyKCZz
dGF0dXMsIHN0YXR1c3AsIHNpemVvZihzdGF0dXMpKSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FRkFVTFQ7Cj4+Pj4gwqAgLcKgwqDCoCBzdGF0dXNfb2xkID0gb3BzLT5nZXRfc3Rh
dHVzKHZkcGEpOwo+Pj4+ICvCoMKgwqAgc3RhdHVzX29sZCA9IHZkcGFfZ2V0X3N0YXR1cyh2ZHBh
KTsKPj4+IERpdHRvLgo+Pj4KPj4+PiDCoCDCoMKgwqDCoMKgIC8qCj4+Pj4gwqDCoMKgwqDCoMKg
ICogVXNlcnNwYWNlIHNob3VsZG4ndCByZW1vdmUgc3RhdHVzIGJpdHMgdW5sZXNzIHJlc2V0IHRo
ZQo+Pj4+IEBAIC0xODIsNyArMTgxLDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3Rh
dHVzKHN0cnVjdCAKPj4+PiB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHJldDsKPj4+PiDCoMKgwqDCoMKgIH0gZWxzZQo+Pj4+IC3CoMKgwqDCoMKgwqDC
oCBvcHMtPnNldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgdmRw
YV9zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+PiBUaGUgcmVzZXQoKSBjYWxsIGluIHRoZSBp
ZiBicmFuY2ggYWJvdmUgbmVlZHMgdG8gdGFrZSB0aGUgY2ZfbXV0ZXgsIAo+Pj4gdGhlIHNhbWUg
d2F5IGFzIHRoYXQgZm9yIHNldF9zdGF0dXMoKS4gVGhlIHJlc2V0KCkgaXMgZWZmZWN0aXZlbHkg
Cj4+PiBzZXRfc3RhdHVzKHZkcGEsIDApLgo+Pj4KPj4+IFRoYW5rcywKPj4+IC1TaXdlaQo+Pj4K
Pj4+PiDCoCDCoMKgwqDCoMKgIGlmICgoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9P
SykgJiYgIShzdGF0dXNfb2xkICYgCj4+Pj4gVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykpCj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBudnFzOyBpKyspCj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgCj4+Pj4gYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fdmRwYS5jCj4+Pj4gaW5kZXggYTg0YjA0YmEzMTk1Li43NjUwNDU1OWJjMjUg
MTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+Pj4+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPj4+PiBAQCAtOTEsOSArOTEsOCBAQCBzdGF0
aWMgdTggdmlydGlvX3ZkcGFfZ2V0X3N0YXR1cyhzdHJ1Y3QgCj4+Pj4gdmlydGlvX2RldmljZSAq
dmRldikKPj4+PiDCoCBzdGF0aWMgdm9pZCB2aXJ0aW9fdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2LCB1OCAKPj4+PiBzdGF0dXMpCj4+Pj4gwqAgewo+Pj4+IMKgwqDC
oMKgwqAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdmRfZ2V0X3ZkcGEodmRldik7Cj4+Pj4g
LcKgwqDCoCBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7
Cj4+Pj4gwqAgLcKgwqDCoCByZXR1cm4gb3BzLT5zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+
Pj4gK8KgwqDCoCByZXR1cm4gdmRwYV9zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+Pj4gwqAg
fQo+Pj4+IMKgIMKgIHN0YXRpYyB2b2lkIHZpcnRpb192ZHBhX3Jlc2V0KHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2KQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2lu
Y2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4gaW5kZXggOWNjNDI5MWE3OWIzLi5hZTA0N2ZhZTI2MDMg
MTAwNjQ0Cj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+PiArKysgYi9pbmNsdWRl
L2xpbnV4L3ZkcGEuaAo+Pj4+IEBAIC00MDgsNiArNDA4LDkgQEAgdm9pZCB2ZHBhX2dldF9jb25m
aWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCAKPj4+PiB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQg
bGVuKTsKPj4+PiDCoCB2b2lkIHZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKmRl
diwgdW5zaWduZWQgaW50IG9mZnNldCwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnN0IHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbmd0aCk7Cj4+Pj4gK3U4IHZkcGFfZ2V0
X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Pj4+ICt2b2lkIHZkcGFfc2V0X3N0
YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cyk7Cj4+Pj4gKwo+Pj4+IMKg
IC8qKgo+Pj4+IMKgwqAgKiBzdHJ1Y3QgdmRwYV9tZ210ZGV2X29wcyAtIHZkcGEgZGV2aWNlIG9w
cwo+Pj4+IMKgwqAgKiBAZGV2X2FkZDogQWRkIGEgdmRwYSBkZXZpY2UgdXNpbmcgYWxsb2MgYW5k
IHJlZ2lzdGVyCj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
