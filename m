Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070F0C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 947EE60A8A;
	Tue,  8 Feb 2022 03:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 57e5dDdsTw6F; Tue,  8 Feb 2022 03:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B5FA60A77;
	Tue,  8 Feb 2022 03:23:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE5CBC001A;
	Tue,  8 Feb 2022 03:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D299EC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDBA460A8A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7BR72UujCVz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2B2A60A77
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644290608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydJczILdVavz3y35yyfKxSQ2SCCP72HFF5+MVLBFHVE=;
 b=FU2tNgNVttRYcrut9/0kxmEpDoGspjIcDynzrzqHnFG6LKg5nFjDlCtPayAJskzEc1M8oU
 rSpyvc8ug0QFxgvSO8gX9Uq98YF79esXkeCTwMunfaNQ/yJq6HHn2rrmHv4k/L5tCvos9p
 e4vioiTaUI8axuzDVQmUWw3xYpAqF3Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-pDKltwOsODWrz4O-XOJmBw-1; Mon, 07 Feb 2022 22:23:25 -0500
X-MC-Unique: pDKltwOsODWrz4O-XOJmBw-1
Received: by mail-pf1-f198.google.com with SMTP id
 m200-20020a628cd1000000b004c7473d8cb5so8682752pfd.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 19:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ydJczILdVavz3y35yyfKxSQ2SCCP72HFF5+MVLBFHVE=;
 b=Jr5sICPe16F0ET8PZD1QtYC8UIkTvQt9IZwUKPh785rbX2kOhYSHEsYiDxTiUYPs2i
 FbX/AI2FU000MKHiopWYV6uIrFnXdXEVS8PWDA3vhjyzU2L+KUg2KeBrzoNhItfO73jz
 7ZF5TVVzkRJXTm7TsO6flMTq7mpoxGrOkyXGJ+dPchI+TQUoYDsjdqqiIfsmtU+kplnf
 TY3qrOsTIyQ4pK6Lg53+s1pSQCbBcvfnPkLsxAaeDAqj1b9HmVjOTPApPaisXW69l/pH
 mEl4askwMH1x4PK75l88NctkiHFXQElQlL16UHSnRA0iXZpcbCTWIxMt8O+Tkd0s1max
 n1HQ==
X-Gm-Message-State: AOAM533zvBFr5Gkr2U8lc1Jvsf9jc1M2K1DpwEmhGFuatTV6VzW+4Orx
 NuXlHL2Mssrll154SqeNidpVO4iEUPS64CGrW9STD5B7Of1hWC+R6cqwgwcVwwIzyVQUMaL+zPS
 FKZyfZBsZjB6UhZyuPfkDjpkzDJJXfNoeDl9G6XcRkQ==
X-Received: by 2002:a65:63d2:: with SMTP id n18mr1960752pgv.245.1644290604407; 
 Mon, 07 Feb 2022 19:23:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoGEqQinxLg0CYnNJ3JeX18vhIGryha7tSpEUCdT8hNPv8pOIZ40M8QwLioug68xQXM3G7PA==
X-Received: by 2002:a65:63d2:: with SMTP id n18mr1960731pgv.245.1644290604127; 
 Mon, 07 Feb 2022 19:23:24 -0800 (PST)
Received: from [10.72.13.233] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k16sm9136136pgh.45.2022.02.07.19.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 19:23:23 -0800 (PST)
Message-ID: <cbdf79c3-48ed-bac2-a9cc-e5c29729e4af@redhat.com>
Date: Tue, 8 Feb 2022 11:23:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 09/31] vhost-vdpa: Take into account SVQ in
 vhost_vdpa_set_vring_call
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-10-eperezma@redhat.com>
 <cbfbd909-4ee8-8ad2-effd-4b9f60270581@redhat.com>
 <CAJaqyWda5sBw9VGBrz8g60OJ07Eeq45RRYu9vwgOPZFwten9rw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWda5sBw9VGBrz8g60OJ07Eeq45RRYu9vwgOPZFwten9rw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

CuWcqCAyMDIyLzEvMzEg5LiL5Y2IMTE6MzQsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoK
PiBPbiBTYXQsIEphbiAyOSwgMjAyMiBhdCA5OjA2IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiDlnKggMjAyMi8xLzIyIOS4iuWNiDQ6MjcsIEV1Z2VuaW8g
UMOpcmV6IOWGmemBkzoKPj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXpt
YUByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiAgICBody92aXJ0aW8vdmhvc3QtdmRwYS5jIHwgMjAg
KysrKysrKysrKysrKysrKysrLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qt
dmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4gaW5kZXggMThkZTE0ZjBmYi4uMDI5
Zjk4ZmVlZSAxMDA2NDQKPj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+ICsrKyBi
L2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+IEBAIC02ODcsMTMgKzY4NywyOSBAQCBzdGF0aWMg
aW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2tpY2soc3RydWN0IHZob3N0X2RldiAqZGV2LAo+Pj4g
ICAgICAgIH0KPj4+ICAgIH0KPj4+Cj4+PiAtc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmlu
Z19jYWxsKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfZmlsZSAqZmlsZSkKPj4+ICtzdGF0
aWMgaW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Rldl9jYWxsKHN0cnVjdCB2aG9zdF9kZXYgKmRl
diwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aG9zdF92cmluZ19maWxlICpmaWxlKQo+Pj4gICAgewo+Pj4gICAgICAgIHRyYWNlX3Zob3N0X3Zk
cGFfc2V0X3ZyaW5nX2NhbGwoZGV2LCBmaWxlLT5pbmRleCwgZmlsZS0+ZmQpOwo+Pj4gICAgICAg
IHJldHVybiB2aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9TRVRfVlJJTkdfQ0FMTCwgZmlsZSk7
Cj4+PiAgICB9Cj4+Pgo+Pj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbChz
dHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCB2aG9zdF92cmluZ19maWxlICpmaWxlKQo+Pj4gK3sKPj4+ICsgICAgc3Ry
dWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPj4+ICsKPj4+ICsgICAgaWYgKHYtPnNo
YWRvd192cXNfZW5hYmxlZCkgewo+Pj4gKyAgICAgICAgaW50IHZkcGFfaWR4ID0gdmhvc3RfdmRw
YV9nZXRfdnFfaW5kZXgoZGV2LCBmaWxlLT5pbmRleCk7Cj4+PiArICAgICAgICBWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxID0gZ19wdHJfYXJyYXlfaW5kZXgodi0+c2hhZG93X3ZxcywgdmRwYV9p
ZHgpOwo+Pj4gKwo+Pj4gKyAgICAgICAgdmhvc3Rfc3ZxX3NldF9ndWVzdF9jYWxsX25vdGlmaWVy
KHN2cSwgZmlsZS0+ZmQpOwo+Pgo+PiBUd28gcXVlc3Rpb25zIGhlcmUgKGhhZCBzaW1pbGFyIHF1
ZXN0aW9ucyBmb3IgdnJpbmcga2ljayk6Cj4+Cj4+IDEpIEFueSByZWFzb24gdGhhdCB3ZSBzZXR1
cCB0aGUgZXZlbnRmZCBmb3Igdmhvc3QtdmRwYSBpbgo+PiB2aG9zdF92ZHBhX3N2cV9zZXR1cCgp
IG5vdCBoZXJlPwo+Pgo+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuLgo+Cj4gVGhlIGd1ZXN0
LT5TVlEgY2FsbCBhbmQga2ljayBmZHMgYXJlIHNldCBoZXJlIGFuZCBhdAo+IHZob3N0X3ZkcGFf
c2V0X3ZyaW5nX2tpY2suIFRoZSBldmVudCBub3RpZmllciBoYW5kbGVyIG9mIHRoZSBndWVzdCAt
Pgo+IFNWUSBraWNrX2ZkIGlzIHNldCBhdCB2aG9zdF92ZHBhX3NldF92cmluZ19raWNrIC8KPiB2
aG9zdF9zdnFfc2V0X3N2cV9raWNrX2ZkLiBUaGUgZ3Vlc3QgLT4gU1ZRIGNhbGwgZmQgaGFzIG5v
IGV2ZW50Cj4gbm90aWZpZXIgaGFuZGxlciBzaW5jZSB3ZSBkb24ndCBwb2xsIGl0Lgo+Cj4gT24g
dGhlIG90aGVyIGhhbmQsIHRoZSBjb25uZWN0aW9uIFNWUSA8LT4gZGV2aWNlIHVzZXMgdGhlIHNh
bWUgZmRzCj4gZnJvbSB0aGUgYmVnaW5uaW5nIHRvIHRoZSBlbmQsIGFuZCB0aGV5IHdpbGwgbm90
IGNoYW5nZSB3aXRoLCBmb3IKPiBleGFtcGxlLCBjYWxsIGZkIG1hc2tpbmcuIFRoYXQncyB3aHkg
aXQncyBzZXR1cCBmcm9tCj4gdmhvc3RfdmRwYV9zdnFfc2V0dXAuIERlbGF5aW5nIHRvIHZob3N0
X3ZkcGFfc2V0X3ZyaW5nX2NhbGwgd291bGQgbWFrZQo+IHVzIGFkZCB3YXkgbW9yZSBsb2dpYyB0
aGVyZS4KCgpNb3JlIGxvZ2ljIGluIGdlbmVyYWwgc2hhZG93IHZxIGNvZGUgYnV0IGxlc3MgY29k
ZXMgZm9yIHZob3N0LXZkcGEgCnNwZWNpZmljIGNvZGUgSSB0aGluay4KCkUuZyBmb3Igd2UgY2Fu
IG1vdmUgdGhlIGtpY2sgc2V0IGxvZ2ljIGZyb20gdmhvc3RfdmRwYV9zdnFfc2V0X2ZkcygpIHRv
IApoZXJlLgoKVGhhbmtzCgoKPgo+PiAyKSBUaGUgY2FsbCBjb3VsZCBiZSBkaXNhYmxlZCBieSB1
c2luZyAtMSBhcyB0aGUgZmQsIEkgZG9uJ3Qgc2VlIGFueQo+PiBjb2RlIHRvIGRlYWwgd2l0aCB0
aGF0Lgo+Pgo+IFJpZ2h0LCBJIGRpZG4ndCB0YWtlIHRoYXQgaW50byBhY2NvdW50LiB2aG9zdC1r
ZXJuZWwgdGFrZXMgYWxzbyAtMSBhcwo+IGtpY2tfZmQgdG8gdW5iaW5kLCBzbyBTVlEgY2FuIGJl
IHJld29ya2VkIHRvIHRha2UgdGhhdCBpbnRvIGFjY291bnQKPiBmb3Igc3VyZS4KPgo+IFRoYW5r
cyEKPgo+PiBUaGFua3MKPj4KPj4KPj4+ICsgICAgICAgIHJldHVybiAwOwo+Pj4gKyAgICB9IGVs
c2Ugewo+Pj4gKyAgICAgICAgcmV0dXJuIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Rldl9jYWxsKGRl
diwgZmlsZSk7Cj4+PiArICAgIH0KPj4+ICt9Cj4+PiArCj4+PiAgICAvKioKPj4+ICAgICAqIFNl
dCBzaGFkb3cgdmlydHF1ZXVlIGRlc2NyaXB0b3JzIHRvIHRoZSBkZXZpY2UKPj4+ICAgICAqCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
