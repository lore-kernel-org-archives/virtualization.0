Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021ACC4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 07:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8434D605E8;
	Fri, 16 Dec 2022 07:29:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8434D605E8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bZJMsf9U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1vH-wggPza9; Fri, 16 Dec 2022 07:29:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 04BEF607FF;
	Fri, 16 Dec 2022 07:29:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04BEF607FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B77A1C0032;
	Fri, 16 Dec 2022 07:29:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A911C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A39E40327
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:29:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A39E40327
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bZJMsf9U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I6DTc5wUzQ5k
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:29:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F7A440143
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F7A440143
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671175760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TW+sv5mYhRvxJF0GOvtPqOs7Ygs+0slBtBfj7fBSikk=;
 b=bZJMsf9UB4UcnuVbxPOn7Kl961c7Ycgc/a+V8wFRIUSFOFjUSIOyL8Qj/VBeVOqDvCkNjX
 H7VOEPvTHlBVRoKKbFeyS9R1zMHVRX8Oyl+6IdUDOyTXia98lCwEoqkgWhiVfNlrZB0DT/
 uWUrEPCIq9ezdz8oKcgNOXVKPmXrEkw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-475-nwWoyqxBMGGORhyL_FsxCw-1; Fri, 16 Dec 2022 02:29:16 -0500
X-MC-Unique: nwWoyqxBMGGORhyL_FsxCw-1
Received: by mail-oo1-f69.google.com with SMTP id
 a9-20020a4a9b09000000b004a0bc0614fdso837980ook.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 23:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW+sv5mYhRvxJF0GOvtPqOs7Ygs+0slBtBfj7fBSikk=;
 b=nlRE8DF+ymXgdCstXmVf3SUTHJNnEC/TVw1EKtJ5pnDhg/SMXXADf3YQHe64UaEWvH
 rh2diKGmfVh0SKU/8J7+UbW0xtMaZ8k/uFA3BHIhtON3cx7I3p+bemkUyqFo0EewCux4
 CTIVOqobkctGPPhWiKN020tcnnO+EyI6JTGV0VCgjWZ8FzX1ui44lPgZdG1/d004Q1aV
 KvWitsNc6Mnd/ohwfkC1K3AkIpwzVqxkHYcOQayRsSJXA8sAjv7F4pHr3w5BnEiRgA+E
 8Dx5dsgmo9CSltn2TJ2lk/Wjj7nJ7rUQshGwrYKRw99ec1Y/GrWzXoxi3FS0huWkXeeo
 hqXQ==
X-Gm-Message-State: AFqh2kpQY/YsWygXJR+JxAgsWfZrTEiheQFAVB7/hcnSEBgtg17JN681
 BBn2xTte8MQfRL8g0DlSY40L5QXk6Y17ZwqrQ3gYdDREZXVrQdu1BovN+ox3zxjybLhwLk2w38Z
 /Rwq56FdaXiUcsFy1KKlQMEfq8IYvv3qaYRJQhTCvoksuo/DMBq7kMyczPQ==
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr872716oab.280.1671175755888; 
 Thu, 15 Dec 2022 23:29:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXusEFPcQUgv8vWQpDBGlYmgo/nVhMOtk5zg4py81ZTLkbfbNHejRxyk1WzIGWqY0Or4Lgg2VyCQoA1j+incrFU=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr872708oab.280.1671175755609; Thu, 15
 Dec 2022 23:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20221215113144.322011-1-eperezma@redhat.com>
 <20221215113144.322011-7-eperezma@redhat.com>
In-Reply-To: <20221215113144.322011-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 15:29:04 +0800
Message-ID: <CACGkMEtE_6nci5zwQZbOMbu3e9gh4aa_88WjTgkWkjKqQBB3Zw@mail.gmail.com>
Subject: Re: [PATCH v9 06/12] vdpa: request iova_range only once
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>,
 Longpeng <longpeng2@huawei.com>
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

T24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgNzozMiBQTSBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBDdXJyZW50bHkgaW92YSByYW5nZSBpcyByZXF1ZXN0ZWQg
b25jZSBwZXIgcXVldWUgcGFpciBpbiB0aGUgY2FzZSBvZgo+IG5ldC4gUmVkdWNlIHRoZSBudW1i
ZXIgb2YgaW9jdGxzIGFza2luZyBpdCBvbmNlIGF0IGluaXRpYWxpemF0aW9uIGFuZAo+IHJldXNp
bmcgdGhhdCB2YWx1ZSBmb3IgZWFjaCB2aG9zdF92ZHBhLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVn
ZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGh3L3ZpcnRpby92aG9z
dC12ZHBhLmMgfCAxNSAtLS0tLS0tLS0tLS0tLS0KPiAgbmV0L3Zob3N0LXZkcGEuYyAgICAgICB8
IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92
aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gaW5kZXggNjkxYmNjODExYS4u
OWI3ZjRlZjA4MyAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gKysrIGIv
aHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IEBAIC0zNjUsMTkgKzM2NSw2IEBAIHN0YXRpYyBpbnQg
dmhvc3RfdmRwYV9hZGRfc3RhdHVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDhfdCBzdGF0
dXMpCj4gICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLXN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfZ2V0
X2lvdmFfcmFuZ2Uoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gLXsKPiAtICAgIGludCByZXQgPSB2
aG9zdF92ZHBhX2NhbGwodi0+ZGV2LCBWSE9TVF9WRFBBX0dFVF9JT1ZBX1JBTkdFLAo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmdi0+aW92YV9yYW5nZSk7Cj4gLSAgICBpZiAocmV0
ICE9IDApIHsKPiAtICAgICAgICB2LT5pb3ZhX3JhbmdlLmZpcnN0ID0gMDsKPiAtICAgICAgICB2
LT5pb3ZhX3JhbmdlLmxhc3QgPSBVSU5UNjRfTUFYOwo+IC0gICAgfQo+IC0KPiAtICAgIHRyYWNl
X3Zob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uodi0+ZGV2LCB2LT5pb3ZhX3JhbmdlLmZpcnN0LAo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2LT5pb3ZhX3JhbmdlLmxhc3Qp
Owo+IC19Cj4gLQo+ICAvKgo+ICAgKiBUaGUgdXNlIG9mIHRoaXMgZnVuY3Rpb24gaXMgZm9yIHJl
cXVlc3RzIHRoYXQgb25seSBuZWVkIHRvIGJlCj4gICAqIGFwcGxpZWQgb25jZS4gVHlwaWNhbGx5
IHN1Y2ggcmVxdWVzdCBvY2N1cnMgYXQgdGhlIGJlZ2lubmluZwo+IEBAIC00NjUsOCArNDUyLDYg
QEAgc3RhdGljIGludCB2aG9zdF92ZHBhX2luaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LCB2b2lk
ICpvcGFxdWUsIEVycm9yICoqZXJycCkKPiAgICAgICAgICBnb3RvIGVycjsKPiAgICAgIH0KPgo+
IC0gICAgdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZSh2KTsKPiAtCj4gICAgICBpZiAoIXZob3N0
X3ZkcGFfZmlyc3RfZGV2KGRldikpIHsKPiAgICAgICAgICByZXR1cm4gMDsKPiAgICAgIH0KPiBk
aWZmIC0tZ2l0IGEvbmV0L3Zob3N0LXZkcGEuYyBiL25ldC92aG9zdC12ZHBhLmMKPiBpbmRleCAy
YzBmZjZkN2IwLi5iNjQ2MmYwMTkyIDEwMDY0NAo+IC0tLSBhL25ldC92aG9zdC12ZHBhLmMKPiAr
KysgYi9uZXQvdmhvc3QtdmRwYS5jCj4gQEAgLTU0MSwxNCArNTQxLDE1IEBAIHN0YXRpYyBjb25z
dCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZU9wcyB2aG9zdF92ZHBhX25ldF9zdnFfb3BzID0gewo+ICB9
Owo+Cj4gIHN0YXRpYyBOZXRDbGllbnRTdGF0ZSAqbmV0X3Zob3N0X3ZkcGFfaW5pdChOZXRDbGll
bnRTdGF0ZSAqcGVlciwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKmRldmljZSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbnQgdmRwYV9kZXZpY2VfZmQsCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcXVldWVfcGFpcl9pbmRleCwKPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBudnFzLAo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpc19kYXRhcGF0aCwK
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc3ZxLAo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVmhvc3RJT1ZBVHJl
ZSAqaW92YV90cmVlKQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCBjaGFyICpkZXZpY2UsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKm5hbWUsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludCB2ZHBhX2RldmljZV9mZCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW50IHF1ZXVlX3BhaXJfaW5kZXgsCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBudnFzLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBib29sIGlzX2RhdGFwYXRoLAo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIHN2cSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlLAo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWaG9zdElPVkFUcmVlICppb3Zh
X3RyZWUpCgpOaXQ6IGl0J3MgYmV0dGVyIG5vdCBtaXggc3R5bGUgY2hhbmdlcy4KCk90aGVyIHRo
YW4gdGhpczoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvbndhbmdAcmVkaGF0LmNvbT4KClRo
YW5rcwoKPiAgewo+ICAgICAgTmV0Q2xpZW50U3RhdGUgKm5jID0gTlVMTDsKPiAgICAgIFZob3N0
VkRQQVN0YXRlICpzOwo+IEBAIC01NjcsNiArNTY4LDcgQEAgc3RhdGljIE5ldENsaWVudFN0YXRl
ICpuZXRfdmhvc3RfdmRwYV9pbml0KE5ldENsaWVudFN0YXRlICpwZWVyLAo+ICAgICAgcy0+dmhv
c3RfdmRwYS5kZXZpY2VfZmQgPSB2ZHBhX2RldmljZV9mZDsKPiAgICAgIHMtPnZob3N0X3ZkcGEu
aW5kZXggPSBxdWV1ZV9wYWlyX2luZGV4Owo+ICAgICAgcy0+dmhvc3RfdmRwYS5zaGFkb3dfdnFz
X2VuYWJsZWQgPSBzdnE7Cj4gKyAgICBzLT52aG9zdF92ZHBhLmlvdmFfcmFuZ2UgPSBpb3ZhX3Jh
bmdlOwo+ICAgICAgcy0+dmhvc3RfdmRwYS5pb3ZhX3RyZWUgPSBpb3ZhX3RyZWU7Cj4gICAgICBp
ZiAoIWlzX2RhdGFwYXRoKSB7Cj4gICAgICAgICAgcy0+Y3ZxX2NtZF9vdXRfYnVmZmVyID0gcWVt
dV9tZW1hbGlnbihxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUoKSwKPiBAQCAtNjQ2LDYgKzY0OCw3
IEBAIGludCBuZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBj
aGFyICpuYW1lLAo+ICAgICAgaW50IHZkcGFfZGV2aWNlX2ZkOwo+ICAgICAgZ19hdXRvZnJlZSBO
ZXRDbGllbnRTdGF0ZSAqKm5jcyA9IE5VTEw7Cj4gICAgICBnX2F1dG9wdHIoVmhvc3RJT1ZBVHJl
ZSkgaW92YV90cmVlID0gTlVMTDsKPiArICAgIHN0cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2Ug
aW92YV9yYW5nZTsKPiAgICAgIE5ldENsaWVudFN0YXRlICpuYzsKPiAgICAgIGludCBxdWV1ZV9w
YWlycywgciwgaSA9IDAsIGhhc19jdnEgPSAwOwo+Cj4gQEAgLTY4OSwxNCArNjkyLDEyIEBAIGlu
dCBuZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpu
YW1lLAo+ICAgICAgICAgIHJldHVybiBxdWV1ZV9wYWlyczsKPiAgICAgIH0KPgo+ICsgICAgdmhv
c3RfdmRwYV9nZXRfaW92YV9yYW5nZSh2ZHBhX2RldmljZV9mZCwgJmlvdmFfcmFuZ2UpOwo+ICAg
ICAgaWYgKG9wdHMtPnhfc3ZxKSB7Cj4gLSAgICAgICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9y
YW5nZSBpb3ZhX3JhbmdlOwo+IC0KPiAgICAgICAgICBpZiAoIXZob3N0X3ZkcGFfbmV0X3ZhbGlk
X3N2cV9mZWF0dXJlcyhmZWF0dXJlcywgZXJycCkpIHsKPiAgICAgICAgICAgICAgZ290byBlcnJf
c3ZxOwo+ICAgICAgICAgIH0KPgo+IC0gICAgICAgIHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uo
dmRwYV9kZXZpY2VfZmQsICZpb3ZhX3JhbmdlKTsKPiAgICAgICAgICBpb3ZhX3RyZWUgPSB2aG9z
dF9pb3ZhX3RyZWVfbmV3KGlvdmFfcmFuZ2UuZmlyc3QsIGlvdmFfcmFuZ2UubGFzdCk7Cj4gICAg
ICB9Cj4KPiBAQCAtNzA1LDcgKzcwNiw3IEBAIGludCBuZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0
IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICAgZm9yIChpID0gMDsgaSA8
IHF1ZXVlX3BhaXJzOyBpKyspIHsKPiAgICAgICAgICBuY3NbaV0gPSBuZXRfdmhvc3RfdmRwYV9p
bml0KHBlZXIsIFRZUEVfVkhPU1RfVkRQQSwgbmFtZSwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZkcGFfZGV2aWNlX2ZkLCBpLCAyLCB0cnVlLCBvcHRzLT54X3N2cSwK
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvdmFfdHJlZSk7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb3ZhX3JhbmdlLCBpb3ZhX3RyZWUp
Owo+ICAgICAgICAgIGlmICghbmNzW2ldKQo+ICAgICAgICAgICAgICBnb3RvIGVycjsKPiAgICAg
IH0KPiBAQCAtNzEzLDcgKzcxNCw3IEBAIGludCBuZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0IE5l
dGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICAgaWYgKGhhc19jdnEpIHsKPiAg
ICAgICAgICBuYyA9IG5ldF92aG9zdF92ZHBhX2luaXQocGVlciwgVFlQRV9WSE9TVF9WRFBBLCBu
YW1lLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZHBhX2RldmljZV9mZCwg
aSwgMSwgZmFsc2UsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wdHMtPnhf
c3ZxLCBpb3ZhX3RyZWUpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcHRz
LT54X3N2cSwgaW92YV9yYW5nZSwgaW92YV90cmVlKTsKPiAgICAgICAgICBpZiAoIW5jKQo+ICAg
ICAgICAgICAgICBnb3RvIGVycjsKPiAgICAgIH0KPiAtLQo+IDIuMzEuMQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
