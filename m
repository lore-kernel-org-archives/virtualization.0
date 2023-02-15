Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3671C6379F
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 11:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5566481EB3;
	Wed, 15 Feb 2023 11:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5566481EB3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+4w98R2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rn7PBdJFrXV7; Wed, 15 Feb 2023 11:45:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BFF4D81E95;
	Wed, 15 Feb 2023 11:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFF4D81E95
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E02EC0033;
	Wed, 15 Feb 2023 11:45:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D904C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76EEB40184
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76EEB40184
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+4w98R2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IA7KFzdRoIpD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:45:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20A15400BB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20A15400BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676461554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx6lloEADLK78/decfvNuOIH7Z76rhDLA1nc7SYA9k8=;
 b=i+4w98R29+6POkF+evXYpaVViOdJ/idasPb1lXdESa5/riW24m5E2lZOcM98vHperxPjSI
 XHIlnDvZfGqiVkoQaEYshpT3rT0CQZFsI1MaHhl8g9rn89WTxDZlCm7m96aWEgwWNDtMnG
 bCKwioCy0G9r4QMXZPILnAa2kHqp0Ug=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-5ntUbzemMyuQTIrZ7dkWew-1; Wed, 15 Feb 2023 06:45:53 -0500
X-MC-Unique: 5ntUbzemMyuQTIrZ7dkWew-1
Received: by mail-wm1-f72.google.com with SMTP id
 l38-20020a05600c1d2600b003ddff4b9a40so993818wms.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 03:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gx6lloEADLK78/decfvNuOIH7Z76rhDLA1nc7SYA9k8=;
 b=jb52w2ds0Foz8K3ebzsIu3dgjT8Pwy7RTzsuebsxD68zoibB6aOzVOLD42ung9Gp4d
 ETZudpUiAQQ33xR+iSFH8HdaiM7X8c6QLHQOcyfKZbKZUHdqJi0ygUFZTHoZ5bCz8YYK
 EUhYOgobRKZjS8Cy9a17QI4zJ9faCsRyaXpE6DB/A5T14PP4tEyqfVBrTVRxxe7ZWWJQ
 oXr9adXVcTr7zfZu+fEWkh5lcOowTWac06CnCTLLNQadYUC4ZBuvX/AVxGINyb5+56gD
 9H+9dTgvfqMurcXtBtVdZL0RYgQ2UIl0j561cUAH81TMEyN7Tqx/JDH7Y1BW86TVKFHB
 Hgdg==
X-Gm-Message-State: AO0yUKV2SPhDm+Kekx77f/V21xTZu0qjH/N78FKCpFrJGb5pFbyuhRdU
 O9yT0s3TW0kDo9n8K6rLNYySlqPmrdJM0UNGi8cZwA/DeVLtDnEnVlIe0mxtkHH7w4KEVBAnA83
 tDkB52FXrS4po5jKUEtiP+U7zvvVvb2lakQaBlxRmSQ==
X-Received: by 2002:a05:600c:2b46:b0:3df:f85a:472f with SMTP id
 e6-20020a05600c2b4600b003dff85a472fmr1810819wmf.13.1676461552354; 
 Wed, 15 Feb 2023 03:45:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8nZozTolWM0zXwr30WCnlRjDTIljGjpf4il41K3/g5Ih7zAXVQocFbwFd0cPMbnJUphz/2fw==
X-Received: by 2002:a05:600c:2b46:b0:3df:f85a:472f with SMTP id
 e6-20020a05600c2b4600b003dff85a472fmr1810808wmf.13.1676461552152; 
 Wed, 15 Feb 2023 03:45:52 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 w8-20020a05600c474800b003de2fc8214esm1967316wmo.20.2023.02.15.03.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Feb 2023 03:45:51 -0800 (PST)
Date: Wed, 15 Feb 2023 06:45:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
Subject: Re: [PATCH] vhost-vdpa: cleanup memory maps when closing vdpa fds
Message-ID: <20230215064454-mutt-send-email-mst@kernel.org>
References: <20230131145310.2069-1-longpeng2@huawei.com>
 <db99245c-606a-2f24-52fe-836a6972437f@redhat.com>
 <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
 <CACGkMEt0Rgkcmt9k4dWsp-qqtPvrM40mtgmSERc0A7Ve1wzKHw@mail.gmail.com>
 <ad0ab6b8-1e1e-f686-eb5c-78cc63869c54@huawei.com>
 <CACGkMEsOWmVGA1RYTNZybmzkz53g5cYEkJeMK_9uuQu-ezZcqg@mail.gmail.com>
 <af95c38d-fdca-aef0-55ae-bbb0baee6029@huawei.com>
MIME-Version: 1.0
In-Reply-To: <af95c38d-fdca-aef0-55ae-bbb0baee6029@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, huangzhichao@huawei.com,
 yechuan@huawei.com
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

T24gV2VkLCBGZWIgMTUsIDIwMjMgYXQgMDE6MTU6NTVQTSArMDgwMCwgTG9uZ3BlbmcgKE1pa2Us
IENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0Likgd3JvdGU6Cj4gCj4g
Cj4g5ZyoIDIwMjMvMi8xNSAxMDo1NiwgSmFzb24gV2FuZyDlhpnpgZM6Cj4gPiBPbiBXZWQsIEZl
YiAxNSwgMjAyMyBhdCAxMDo0OSBBTSBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1
cmUKPiA+IFNlcnZpY2UgUHJvZHVjdCBEZXB0LikgPGxvbmdwZW5nMkBodWF3ZWkuY29tPiB3cm90
ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiAKPiA+ID4g5ZyoIDIwMjMvMi8xNSAxMDowMCwgSmFzb24g
V2FuZyDlhpnpgZM6Cj4gPiA+ID4gT24gVHVlLCBGZWIgMTQsIDIwMjMgYXQgMjoyOCBQTSBMb25n
cGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUKPiA+ID4gPiBTZXJ2aWNlIFByb2R1Y3Qg
RGVwdC4pIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+
IAo+ID4gPiA+ID4gCj4gPiA+ID4gPiDlnKggMjAyMy8yLzE0IDE0OjE2LCBKYXNvbiBXYW5nIOWG
memBkzoKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IOWcqCAyMDIzLzEvMzEgMjI6NTMsIExvbmdw
ZW5nKE1pa2UpIOWGmemBkzoKPiA+ID4gPiA+ID4gPiBGcm9tOiBMb25ncGVuZyA8bG9uZ3Blbmcy
QGh1YXdlaS5jb20+Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gV2UgbXVzdCBjbGVhbnVw
IGFsbCBtZW1vcnkgbWFwcyB3aGVuIGNsb3NpbmcgdGhlIHZkcGEgZmRzLCBvdGhlcndpc2UKPiA+
ID4gPiA+ID4gPiBzb21lIGNyaXRpY2FsIHJlc291cmNlcyAoZS5nLiBtZW1vcnksIGlvbW11IG1h
cCkgd2lsbCBsZWFrZWQgaWYgdGhlCj4gPiA+ID4gPiA+ID4gdXNlcnNwYWNlIGV4aXRzIHVuZXhw
ZWN0ZWRseSAoZS5nLiBraWxsIC05KS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiBTb3VuZHMgbGlrZSBhIGJ1ZyBvZiB0aGUga2VybmVsLCBzaG91bGQgd2UgZml4IHRoZXJl
Pwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gRm9yIGV4YW1wbGUsIHRoZSBpb21t
dSBtYXAgaXMgc2V0dXAgd2hlbiBRRU1VIGNhbGxzIFZIT1NUX0lPVExCX1VQREFURQo+ID4gPiA+
ID4gaW9jdGwgYW5kIGl0J2xsIGJlIGZyZWVkIGlmIFFFTVUgY2FsbHMgVkhPU1RfSU9UTEJfSU5W
QUxJREFURSBpb2N0bC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU28gbWF5YmUgd2UgcmVsZWFzZSB0
aGVzZSByZXNvdXJjZXMgaW4gdmRwYSBmcmFtZXdvcmsgaW4ga2VybmVsIGlzIGEKPiA+ID4gPiA+
IHN1aXRhYmxlIGNob2ljZT8KPiA+ID4gPiAKPiA+ID4gPiBJIHRoaW5rIEkgbmVlZCB1bmRlcnN0
YW5kIHdoYXQgZG9lcyAicmVzb3VyY2VzIiBtZWFuIGhlcmU6Cj4gPiA+ID4gCj4gPiA+ID4gRm9y
IGlvbW11IG1hcHBpbmcsIGl0IHNob3VsZCBiZSBmcmVlZCBieSB2aG9zdF92ZHBhX2ZyZWVfZG9t
YWluKCkgaW4KPiA+ID4gPiB2aG9zdF92ZHBhX3JlbGVhc2UoKT8KPiA+ID4gPiAKPiA+ID4gCj4g
PiA+IFBsZWFzZSBjb25zaWRlciB0aGUgZm9sbG93aW5nIGxpZmVjeWNsZSBvZiB0aGUgdmRwYSBk
ZXZpY2U6Cj4gPiA+IAo+ID4gPiAxLiB2aG9zdF92ZHBhX29wZW4KPiA+ID4gICAgICAgdmhvc3Rf
dmRwYV9hbGxvY19kb21haW4KPiA+ID4gCj4gPiA+IDIuIHZob3N0X3ZkcGFfcGFfbWFwCj4gPiA+
ICAgICAgIHBpbl91c2VyX3BhZ2VzCj4gPiA+ICAgICAgIHZob3N0X3ZkcGFfbWFwCj4gPiA+ICAg
ICAgICAgaW9tbXVfbWFwCj4gPiA+IAo+ID4gPiAzLiBraWxsIFFFTVUKPiA+ID4gCj4gPiA+IDQu
IHZob3N0X3ZkcGFfcmVsZWFzZQo+ID4gPiAgICAgICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluCj4g
PiA+IAo+ID4gPiBJbiB0aGlzIGNhc2UsIHdlIGhhdmUgbm8gb3Bwb3J0dW5pdHkgdG8gaW52b2tl
IHVucGluX3VzZXJfcGFnZXMgb3IKPiA+ID4gaW9tbXVfdW5tYXAgdG8gZnJlZSB0aGUgbWVtb3J5
Lgo+ID4gCj4gPiBXZSBkbzoKPiA+IAo+ID4gdmhvc3RfdmRwYV9jbGVhbnVwKCkKPiA+ICAgICAg
dmhvc3RfdmRwYV9yZW1vdmVfYXMoKQo+ID4gICAgICAgICAgdmhvc3RfdmRwYV9pb3RsYl91bm1h
cCgpCj4gPiAgICAgICAgICAgICAgdmhvc3RfdmRwYV9wYV91bm1hcCgpCj4gPiAgICAgICAgICAg
ICAgICAgIHVucGluX3VzZXJfcGFnZXMoKQo+ID4gICAgICAgICAgICAgICAgICB2aG9zdF92ZHBh
X2dlbmVyYWxfdW5tYXAoKQo+ID4gICAgICAgICAgICAgICAgICAgICAgaW9tbXVfdW5tYXAoKQo+
ID4gPwo+ID4gCj4gT2gsIG15IGNvZGViYXNlIGlzIGxpbnV4LTYuMi1yYzIgYW5kIHRoZSBjb21t
aXQgYzA3MGMxOTEyYTggKHZob3N0LXZkcGE6IGZpeAo+IGFuIGlvdGxiIG1lbW9yeSBsZWFrKSBh
bHJlYWR5IGZpeGVkIHRoaXMgYnVnIGluIGxpbnV4LTYuMi1yYzMuCj4gCj4gPiBCdHcsIGl0IGxv
b2tzIGxpa2Ugd2Ugc2hvdWxkIGNhbGwgdmhvc3RfdmRwYV9mcmVlX2RvbWFpbigpICphZnRlcioK
PiA+IHZob3N0X3ZkcGFfY2xlYW51cCgpIG90aGVyd2lzZSBpdCdzIGEgVUFGPwo+ID4gCj4gSSB0
aGluayBzbywgdGhlIHYtPmRvbWFpbiBpcyBzZXQgdG8gTlVMTCBpbiB2aG9zdF92ZHBhX2ZyZWVf
ZG9tYWluKCksIGl0Cj4gc2VlbXMgd291bGQgdHJpZ2dlciBudWxsLXBvaW50ZXIgYWNjZXNzIGlu
IG15IGNhc2UuCgoKT0sgSSdsbCBkcm9wIHRoaXMgcGF0Y2ggZm9yIG5vdyB0aGVuPwoKPiA+IFRo
YW5rcwo+ID4gCj4gPiA+IAo+ID4gPiA+IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPiA+ID4gPiB7Cj4gPiA+ID4g
ICAgICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0gZmlsZXAtPnByaXZhdGVfZGF0YTsKPiA+
ID4gPiAgICAgICAgICAgc3RydWN0IHZob3N0X2RldiAqZCA9ICZ2LT52ZGV2Owo+ID4gPiA+IAo+
ID4gPiA+ICAgICAgICAgICBtdXRleF9sb2NrKCZkLT5tdXRleCk7Cj4gPiA+ID4gICAgICAgICAg
IGZpbGVwLT5wcml2YXRlX2RhdGEgPSBOVUxMOwo+ID4gPiA+ICAgICAgICAgICB2aG9zdF92ZHBh
X2NsZWFuX2lycSh2KTsKPiA+ID4gPiAgICAgICAgICAgdmhvc3RfdmRwYV9yZXNldCh2KTsKPiA+
ID4gPiAgICAgICAgICAgdmhvc3RfZGV2X3N0b3AoJnYtPnZkZXYpOwo+ID4gPiA+ICAgICAgICAg
ICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKHYpOwo+ID4gPiA+ICAgICAgICAgICB2aG9zdF92ZHBh
X2NvbmZpZ19wdXQodik7Cj4gPiA+ID4gICAgICAgICAgIHZob3N0X3ZkcGFfY2xlYW51cCh2KTsK
PiA+ID4gPiAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkLT5tdXRleCk7Cj4gPiA+ID4gCj4gPiA+
ID4gICAgICAgICAgIGF0b21pY19kZWMoJnYtPm9wZW5lZCk7Cj4gPiA+ID4gICAgICAgICAgIGNv
bXBsZXRlKCZ2LT5jb21wbGV0aW9uKTsKPiA+ID4gPiAKPiA+ID4gPiAgICAgICAgICAgcmV0dXJu
IDA7Cj4gPiA+ID4gfQo+ID4gPiA+IAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBCeSB0aGUgd2F5LCBK
YXNvbiwgY2FuIHlvdSByZXByb2R1Y2UgdGhlIHByb2JsZW0gaW4geW91ciBtYWNoaW5lPwo+ID4g
PiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gSGF2ZW4ndCBnb3QgdGltZSBpbiBkb2luZyB0aGlzIGJ1
dCBpdCBzaG91bGQgYmUgdGhlIHJlc3BvbnNpYmlsaXR5IG9mCj4gPiA+ID4gdGhlIGF1dGhvciB0
byB2YWxpZGF0ZSB0aGlzIGFueWhvdy4KPiA+ID4gPiAKPiA+ID4gPiBUaGFua3MKPiA+ID4gPiAK
PiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdl
aS5jb20+Cj4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gICAgIGRyaXZlcnMvdmhvc3Qv
dmRwYS5jIHwgMTMgKysrKysrKysrKysrKwo+ID4gPiA+ID4gPiA+ICAgICAxIGZpbGUgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4g
PiA+ID4gaW5kZXggYTUyN2VlZWFjNjM3Li4zNzQ3N2NmZmE1YWEgMTAwNjQ0Cj4gPiA+ID4gPiA+
ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiA+IEBAIC04MjMsNiArODIzLDE4IEBAIHN0YXRpYyB2
b2lkIHZob3N0X3ZkcGFfdW5tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgdmhvc3RfdmRwYV9yZW1vdmVfYXModiwgYXNpZCk7Cj4gPiA+ID4gPiA+ID4g
ICAgIH0KPiA+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9jbGVhbl9tYXAoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYpCj4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiArICAgIHN0
cnVjdCB2aG9zdF92ZHBhX2FzICphczsKPiA+ID4gPiA+ID4gPiArICAgIHUzMiBhc2lkOwo+ID4g
PiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiArICAgIGZvciAoYXNpZCA9IDA7IGFzaWQgPCB2LT52
ZHBhLT5uYXM7IGFzaWQrKykgewo+ID4gPiA+ID4gPiA+ICsgICAgICAgIGFzID0gYXNpZF90b19h
cyh2LCBhc2lkKTsKPiA+ID4gPiA+ID4gPiArICAgICAgICBpZiAoYXMpCj4gPiA+ID4gPiA+ID4g
KyAgICAgICAgICAgIHZob3N0X3ZkcGFfdW5tYXAodiwgJmFzLT5pb3RsYiwgMFVMTCwgMFVMTCAt
IDEpOwo+ID4gPiA+ID4gPiA+ICsgICAgfQo+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gPiA+ICAgICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfdmFfbWFwKHN0cnVjdCB2
aG9zdF92ZHBhICp2LAo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aG9zdF9pb3RsYiAqaW90bGIsCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgdTY0
IGlvdmEsIHU2NCBzaXplLCB1NjQgdWFkZHIsIHUzMiBwZXJtKQo+ID4gPiA+ID4gPiA+IEBAIC0x
MjQ3LDYgKzEyNTksNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVsZWFzZShzdHJ1Y3QgaW5v
ZGUKPiA+ID4gPiA+ID4gPiAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPiA+ID4gPiA+ID4g
PiAgICAgICAgIHZob3N0X3ZkcGFfY2xlYW5faXJxKHYpOwo+ID4gPiA+ID4gPiA+ICAgICAgICAg
dmhvc3RfdmRwYV9yZXNldCh2KTsKPiA+ID4gPiA+ID4gPiAgICAgICAgIHZob3N0X2Rldl9zdG9w
KCZ2LT52ZGV2KTsKPiA+ID4gPiA+ID4gPiArICAgIHZob3N0X3ZkcGFfY2xlYW5fbWFwKHYpOwo+
ID4gPiA+ID4gPiA+ICAgICAgICAgdmhvc3RfdmRwYV9mcmVlX2RvbWFpbih2KTsKPiA+ID4gPiA+
ID4gPiAgICAgICAgIHZob3N0X3ZkcGFfY29uZmlnX3B1dCh2KTsKPiA+ID4gPiA+ID4gPiAgICAg
ICAgIHZob3N0X3ZkcGFfY2xlYW51cCh2KTsKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IC4KPiA+
ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IC4KPiA+ID4gCj4gPiAKPiA+IC4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
