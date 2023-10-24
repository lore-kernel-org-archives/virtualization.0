Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C1BC00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 05:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3AD783DAA;
	Tue, 24 Oct 2023 05:45:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3AD783DAA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hC3u+FCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEVMz2fFJgx5; Tue, 24 Oct 2023 05:45:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 756CC83DB4;
	Tue, 24 Oct 2023 05:45:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 756CC83DB4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 474DEC0039;
	Tue, 24 Oct 2023 05:45:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B5EEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 05:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 370B283F01
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 05:45:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 370B283F01
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 65x_nzBtHppt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 05:45:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56E0783DAA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 05:45:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56E0783DAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698126348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QC6NILim0O5ahmzo8j8vm0lOJqAczSGwvR/zz3gIWsM=;
 b=hC3u+FCBRr16cdSm20m4tm6u9zQJMeEegwCuNPUYUXz2MEYGvvXU1dS+QGudyC2IP31Ngf
 iZBG/QqjaCMNG89/Dp+OOgU9zDi/9ZBkxZsT2y+dgvr8AtoNS4QH2rg4cSqGfYLNRxYqFM
 jYIVvKPYwK2rKQF1Ph/pn01ZXKB91sE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-K4Nj70LnMimyIAVl8Xi_pg-1; Tue, 24 Oct 2023 01:45:47 -0400
X-MC-Unique: K4Nj70LnMimyIAVl8Xi_pg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507cc15323aso4064264e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 22:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698126345; x=1698731145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QC6NILim0O5ahmzo8j8vm0lOJqAczSGwvR/zz3gIWsM=;
 b=avo0zSXQsxtHL84/kEfu8bNkndwz9xV5BG69MoGgW8a49GYYSAH5o1RS4qfgQHvOwH
 9vIsS7Yh8gyKF01mxDz8CJKxe6H+UyVUuN+PxFFVdmezo1ie7Q9abtf/Fsc440EXw/EC
 SmNsNTN1WY7HRkN5AkkLmGollEm+7wzqKmzTCthZ3u1qa4avaPDmnM6iHK0WmqeuRiuP
 bIxnjWwubng+vdquweY3lSlo8vd9tkQ5lJaNGYfNyWFrWRalO/8e9RhznsBXtEpkTwzJ
 BITb2rzeeKkmfEva2vZxOfjFtkAp4WQUqe6wxkzdV4MX8ot7IN54LNSMBhru7i44Ko7D
 DftA==
X-Gm-Message-State: AOJu0YwWRUYYTIG/sI7UQ/RYaOSkKkwuETGR5gyLhspaFsmB5O3fyLeR
 KIngDKV1C2mmdcgIjFZ3OZueYSV3t4eblKuJyZuhW8cUqtKLFPSY31V0SXU9/VjLX3lkqhItQaa
 Gadcv0gmtZktUmi3f2mQOm4UCdXSgRCPwTgbYeJxEHKrVitkv/Nh78f80bg==
X-Received: by 2002:a19:740f:0:b0:503:afa:e79 with SMTP id
 v15-20020a19740f000000b005030afa0e79mr8123940lfe.5.1698126345704; 
 Mon, 23 Oct 2023 22:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tubTNrrrRtvVlAu2ve/BiUFt/Pw4V7RB1Ey7CoVGxomUanQsXuQM8RkBUXTBbRneNrPqCjvxRF1p6x5LFe0=
X-Received: by 2002:a19:740f:0:b0:503:afa:e79 with SMTP id
 v15-20020a19740f000000b005030afa0e79mr8123931lfe.5.1698126345374; 
 Mon, 23 Oct 2023 22:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Oct 2023 13:45:34 +0800
Message-ID: <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gU2F0LCBPY3QgMjEsIDIwMjMgYXQgNToyOOKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBVc2luZyAuY29tcGF0X3Jlc2V0IG9wIGZyb20gdGhlIHBy
ZXZpb3VzIHBhdGNoLCB0aGUgYnVnZ3kgLnJlc2V0Cj4gYmVoYXZpb3VyIGNhbiBiZSBrZXB0IGFz
LWlzIG9uIG9sZGVyIHVzZXJzcGFjZSBhcHBzLCB3aGljaCBkb24ndCBhY2sgdGhlCj4gSU9UTEJf
UEVSU0lTVCBiYWNrZW5kIGZlYXR1cmUuIEFzIHRoaXMgY29tcGF0aWJpbGl0eSBxdWlyayBpcyBs
aW1pdGVkIHRvCj4gdGhvc2UgZHJpdmVycyB0aGF0IHVzZWQgdG8gYmUgYnVnZ3kgaW4gdGhlIHBh
c3QsIGl0IHdvbid0IGFmZmVjdCBjaGFuZ2UKPiB0aGUgYmVoYXZpb3VyIG9yIGFmZmVjdCBBQkkg
b24gdGhlIHNldHVwcyB3aXRoIEFQSSBjb21wbGlhbnQgZHJpdmVyLgo+Cj4gVGhlIHNlcGFyYXRp
b24gb2YgLmNvbXBhdF9yZXNldCBmcm9tIHRoZSByZWd1bGFyIC5yZXNldCBhbGxvd3MKPiB2aG9z
dC12ZHBhIGFibGUgdG8ga25vdyB3aGljaCBkcml2ZXIgaGFkIGJyb2tlbiBiZWhhdmlvdXIgYmVm
b3JlLCBzbyBpdAo+IGNhbiBhcHBseSB0aGUgY29ycmVzcG9uZGluZyBjb21wYXRpYmlsaXR5IHF1
aXJrIHRvIHRoZSBpbmRpdmlkdWFsIGRyaXZlcgo+IHdoZW5ldmVyIG5lZWRlZC4gIENvbXBhcmVk
IHRvIG92ZXJsb2FkaW5nIHRoZSBleGlzdGluZyAucmVzZXQgd2l0aAo+IGZsYWdzLCAuY29tcGF0
X3Jlc2V0IHdvbid0IGNhdXNlIGFueSBleHRyYSBidXJkZW4gdG8gdGhlIGltcGxlbWVudGF0aW9u
Cj4gb2YgZXZlcnkgY29tcGxpYW50IGRyaXZlci4KPgo+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aG9zdC92ZHBhLmMg
ICAgICAgICB8IDE3ICsrKysrKysrKysrKystLS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMgfCAgMiArLQo+ICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgIHwgIDcgKysrKyst
LQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+IGluZGV4IGFjYzdjNzRiYTdkNi4uOWNlNDAwMDM3OTNiIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtMjI3LDEz
ICsyMjcsMjIgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV91bnNldHVwX3ZxX2lycShzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiwgdTE2IHFpZCkKPiAgICAgICAgIGlycV9ieXBhc3NfdW5yZWdpc3Rlcl9w
cm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKPiAgfQo+Cj4gLXN0YXRpYyBpbnQgdmhv
c3RfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiArc3RhdGljIGludCBfY29tcGF0
X3ZkcGFfcmVzZXQoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gKyAgICAgICB1MzIgZmxhZ3MgPSAwOwo+Cj4g
LSAgICAgICB2LT5pbl9iYXRjaCA9IDA7Cj4gKyAgICAgICBmbGFncyB8PSAhdmhvc3RfYmFja2Vu
ZF9oYXNfZmVhdHVyZSh2LT52ZGV2LnZxc1swXSwKPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKSA/Cj4gKyAg
ICAgICAgICAgICAgICBWRFBBX1JFU0VUX0ZfQ0xFQU5fTUFQIDogMDsKPiArCj4gKyAgICAgICBy
ZXR1cm4gdmRwYV9yZXNldCh2ZHBhLCBmbGFncyk7Cj4gK30KPgo+IC0gICAgICAgcmV0dXJuIHZk
cGFfcmVzZXQodmRwYSk7Cj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZXNldChzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdikKPiArewo+ICsgICAgICAgdi0+aW5fYmF0Y2ggPSAwOwo+ICsgICAgICAgcmV0
dXJuIF9jb21wYXRfdmRwYV9yZXNldCh2KTsKPiAgfQo+Cj4gIHN0YXRpYyBsb25nIHZob3N0X3Zk
cGFfYmluZF9tbShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiBAQCAtMzEyLDcgKzMyMSw3IEBAIHN0
YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTgg
X191c2VyICpzdGF0dXNwKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHZob3N0X3ZkcGFfdW5z
ZXR1cF92cV9pcnEodiwgaSk7Cj4KPiAgICAgICAgIGlmIChzdGF0dXMgPT0gMCkgewo+IC0gICAg
ICAgICAgICAgICByZXQgPSB2ZHBhX3Jlc2V0KHZkcGEpOwo+ICsgICAgICAgICAgICAgICByZXQg
PSBfY29tcGF0X3ZkcGFfcmVzZXQodik7Cj4gICAgICAgICAgICAgICAgIGlmIChyZXQpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPiAgICAgICAgIH0gZWxzZQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3ZkcGEuYwo+IGluZGV4IDA2Y2U2ZDhjMmUwMC4uOGQ2M2U1OTIzZDI0IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fdmRwYS5jCj4gQEAgLTEwMCw3ICsxMDAsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fdmRw
YV9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgewo+ICAgICAgICAgc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhID0gdmRfZ2V0X3ZkcGEodmRldik7Cj4KPiAtICAgICAgIHZkcGFf
cmVzZXQodmRwYSk7Cj4gKyAgICAgICB2ZHBhX3Jlc2V0KHZkcGEsIDApOwo+ICB9Cj4KPiAgc3Rh
dGljIGJvb2wgdmlydGlvX3ZkcGFfbm90aWZ5KHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5k
ZXggNmI4Y2JmNzU3MTJkLi5kYjE1YWMwN2Y4YTYgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IEBAIC01MTksMTQgKzUxOSwx
NyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBkZXZpY2UgKnZkcGFfZ2V0X2RtYV9kZXYoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2KQo+ICAgICAgICAgcmV0dXJuIHZkZXYtPmRtYV9kZXY7Cj4gIH0K
Pgo+IC1zdGF0aWMgaW5saW5lIGludCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
dikKPiArc3RhdGljIGlubGluZSBpbnQgdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHUzMiBmbGFncykKPiAgewo+ICAgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29w
cyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICAgICAgICAgaW50IHJldDsKPgo+ICAgICAgICAgZG93
bl93cml0ZSgmdmRldi0+Y2ZfbG9jayk7Cj4gICAgICAgICB2ZGV2LT5mZWF0dXJlc192YWxpZCA9
IGZhbHNlOwo+IC0gICAgICAgcmV0ID0gb3BzLT5yZXNldCh2ZGV2KTsKPiArICAgICAgIGlmIChv
cHMtPmNvbXBhdF9yZXNldCAmJiBmbGFncykKPiArICAgICAgICAgICAgICAgcmV0ID0gb3BzLT5j
b21wYXRfcmVzZXQodmRldiwgZmxhZ3MpOwo+ICsgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAg
ICByZXQgPSBvcHMtPnJlc2V0KHZkZXYpOwoKSW5zdGVhZCBvZiBpbnZlbnRpbmcgYSBuZXcgQVBJ
IHRoYXQgY2FycmllcyB0aGUgZmxhZ3MuIFR3ZWFrIHRoZQpleGlzdGluZyBvbmUgc2VlbXMgdG8g
YmUgc2ltcGxlciBhbmQgYmV0dGVyPwoKQXMgY29tcGF0X3Jlc2V0KHZkZXYsIDApID09IHJlc2V0
KHZkZXYpCgpUaGVuIHlvdSBkb24ndCBuZWVkIHRoZSBzd2l0Y2ggaW4gdGhlIHBhcmVudCBhcyB3
ZWxsCgorc3RhdGljIGludCB2ZHBhc2ltX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkK
K3sKKyAgICAgICByZXR1cm4gdmRwYXNpbV9jb21wYXRfcmVzZXQodmRwYSwgMCk7Cit9CgpUaGFu
a3MKCgo+ICAgICAgICAgdXBfd3JpdGUoJnZkZXYtPmNmX2xvY2spOwo+ICAgICAgICAgcmV0dXJu
IHJldDsKPiAgfQo+IC0tCj4gMi4zOS4zCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
