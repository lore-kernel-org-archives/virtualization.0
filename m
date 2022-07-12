Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AC9C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 08:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7EA342220;
	Tue, 12 Jul 2022 08:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7EA342220
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NF3TB8hX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9vbWEggI19A; Tue, 12 Jul 2022 08:09:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F33554183E;
	Tue, 12 Jul 2022 08:09:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F33554183E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4070C0033;
	Tue, 12 Jul 2022 08:09:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E15C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C072740993
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:09:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C072740993
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NF3TB8hX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xg171FnHlCDh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:09:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D06EC401AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D06EC401AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657613350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJcskA/Zg+I54A7KxLAxiRGb8qrTlBqKeeRMZ0ymcfk=;
 b=NF3TB8hXvcEVSErbhcA45YJ3KCRdcJ1zJl4uQgvg40NzZMrKwNVxZxWATPNXtUdgF6zKmE
 2QTGTC56SraZollrrs3/AzVo5c2yUDfYyzOpTvE+ekbdzOozO3FOuqrrsmRUz2bUz/6c1I
 B82n9j/DeF1ccBByYVfW+0nBY49q/Xs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-IaUINT76MaK1uwNsrOYDYw-1; Tue, 12 Jul 2022 04:09:09 -0400
X-MC-Unique: IaUINT76MaK1uwNsrOYDYw-1
Received: by mail-lf1-f70.google.com with SMTP id
 f29-20020a19dc5d000000b004811c8d1918so3269303lfj.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rJcskA/Zg+I54A7KxLAxiRGb8qrTlBqKeeRMZ0ymcfk=;
 b=sBGt4LZURe4vAl7t79Y32CJUrXAM206oevYhtJVoCpINve179xJTvwtTDhrbeGGoa1
 SAfoXZA0M4s4oLhzeIgo7LEvDyhAyXpdcAgvTLOJysyB6bLOvn0cfzGc1RXMfPsvQ/6Y
 5groHs4hbPiDpNiwuEn6QtdsmLCIRFXVkd8H018KfEun9/wYXMMaism9fvN2Y8n13/A5
 hzcTIU6NeZ3CBgj36nN+RRDuV6tC0GIzc07PEgbnQaU6BtmHhgRfZk7AGy1gwISHqpJC
 BS40KPTPJjnqIp/JY8k7TViqrfO5p4iWYl3ZFyt/fbNX8p/Wp9dqsiBVsP1YxoeAab3I
 8SuQ==
X-Gm-Message-State: AJIora9x5KA7NlCwIJCgxNYjEn8VtGvfMdzx2wWCwGlFRwQotBnQqHWg
 mJN0XxEiu4Jywhw9hVBJDiHOI/tSwGAKhDxg911hew37Webq13f89aZlCW4e40NwSnb8hGOj2kA
 lDXhiEoj0xsBbt9WoFpgoF9sa9GeycyJK5EGXOIDZn+ITOHVjWQbsSc9j9w==
X-Received: by 2002:ac2:50d1:0:b0:489:fb36:cde1 with SMTP id
 h17-20020ac250d1000000b00489fb36cde1mr264130lfm.411.1657613347827; 
 Tue, 12 Jul 2022 01:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vjIfYeHw/U8j+flo57s9r09p+WpV9Mywo429Jk8FiV/6lmU1F4kq5TwCDtQJDxdvwRs4LWoN08HBHaUIS+RT0=
X-Received: by 2002:ac2:50d1:0:b0:489:fb36:cde1 with SMTP id
 h17-20020ac250d1000000b00489fb36cde1mr264103lfm.411.1657613347609; Tue, 12
 Jul 2022 01:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-4-eperezma@redhat.com>
 <CACGkMEt6YQvtyYwkYVxmZ01pZJK9PMFM2oPTVttPZ_kZDY-9Jw@mail.gmail.com>
 <CAJaqyWfGXu8k7JN1gCPdUXS2_Dct73w4wS_SdB3aLqVCWJqJQg@mail.gmail.com>
In-Reply-To: <CAJaqyWfGXu8k7JN1gCPdUXS2_Dct73w4wS_SdB3aLqVCWJqJQg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Jul 2022 16:08:56 +0800
Message-ID: <CACGkMEv0W=CYduTV44R71knWwyoEd9VAth0eHuwEFa9T4Njhhg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] vhost-vdpa: uAPI to suspend the device
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>, "Uminski,
 Piotr" <Piotr.Uminski@intel.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

T24gRnJpLCBKdWwgOCwgMjAyMiBhdCA3OjUzIFBNIEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVy
ZXptYUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDY6MTYg
QU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJp
LCBKdW4gMjQsIDIwMjIgYXQgMTI6MDggQU0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBUaGUgaW9jdGwgYWRkcyBzdXBwb3J0IGZvciBzdXNw
ZW5kaW5nIHRoZSBkZXZpY2UgZnJvbSB1c2Vyc3BhY2UuCj4gPiA+Cj4gPiA+IFRoaXMgaXMgYSBt
dXN0IGJlZm9yZSBnZXR0aW5nIHZpcnRxdWV1ZSBpbmRleGVzIChiYXNlKSBmb3IgbGl2ZSBtaWdy
YXRpb24sCj4gPiA+IHNpbmNlIHRoZSBkZXZpY2UgY291bGQgbW9kaWZ5IHRoZW0gYWZ0ZXIgdXNl
cmxhbmQgZ2V0cyB0aGVtLiBUaGVyZSBhcmUKPiA+ID4gaW5kaXZpZHVhbCB3YXlzIHRvIHBlcmZv
cm0gdGhhdCBhY3Rpb24gZm9yIHNvbWUgZGV2aWNlcwo+ID4gPiAoVkhPU1RfTkVUX1NFVF9CQUNL
RU5ELCBWSE9TVF9WU09DS19TRVRfUlVOTklORywgLi4uKSBidXQgdGhlcmUgd2FzIG5vCj4gPiA+
IHdheSB0byBwZXJmb3JtIGl0IGZvciBhbnkgdmhvc3QgZGV2aWNlIChhbmQsIGluIHBhcnRpY3Vs
YXIsIHZob3N0LXZkcGEpLgo+ID4gPgo+ID4gPiBBZnRlciBhIHN1Y2Nlc3NmdWwgcmV0dXJuIG9m
IHRoZSBpb2N0bCBjYWxsIHRoZSBkZXZpY2UgbXVzdCBub3QgcHJvY2Vzcwo+ID4gPiBtb3JlIHZp
cnRxdWV1ZSBkZXNjcmlwdG9ycy4gVGhlIGRldmljZSBjYW4gYW5zd2VyIHRvIHJlYWQgb3Igd3Jp
dGVzIG9mCj4gPiA+IGNvbmZpZyBmaWVsZHMgYXMgaWYgaXQgd2VyZSBub3Qgc3VzcGVuZGVkLiBJ
biBwYXJ0aWN1bGFyLCB3cml0aW5nIHRvCj4gPiA+ICJxdWV1ZV9lbmFibGUiIHdpdGggYSB2YWx1
ZSBvZiAxIHdpbGwgbm90IG1ha2UgdGhlIGRldmljZSBzdGFydAo+ID4gPiBwcm9jZXNzaW5nIGJ1
ZmZlcnMgb2YgdGhlIHZpcnRxdWV1ZS4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5p
byBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy92
aG9zdC92ZHBhLmMgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCj4gPiA+ICBpbmNsdWRl
L3VhcGkvbGludXgvdmhvc3QuaCB8IDE0ICsrKysrKysrKysrKysrCj4gPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDMzIGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gaW5kZXggM2Q2MzZlMTky
MDYxLi43ZmE2NzFhYzRiZGYgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+IEBAIC00NzgsNiArNDc4LDIy
IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X3Zxc19jb3VudChzdHJ1Y3Qgdmhvc3RfdmRw
YSAqdiwgdTMyIF9fdXNlciAqYXJncCkKPiA+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ID4gIH0K
PiA+ID4KPiA+ID4gKy8qIEFmdGVyIGEgc3VjY2Vzc2Z1bCByZXR1cm4gb2YgaW9jdGwgdGhlIGRl
dmljZSBtdXN0IG5vdCBwcm9jZXNzIG1vcmUKPiA+ID4gKyAqIHZpcnRxdWV1ZSBkZXNjcmlwdG9y
cy4gVGhlIGRldmljZSBjYW4gYW5zd2VyIHRvIHJlYWQgb3Igd3JpdGVzIG9mIGNvbmZpZwo+ID4g
PiArICogZmllbGRzIGFzIGlmIGl0IHdlcmUgbm90IHN1c3BlbmRlZC4gSW4gcGFydGljdWxhciwg
d3JpdGluZyB0byAicXVldWVfZW5hYmxlIgo+ID4gPiArICogd2l0aCBhIHZhbHVlIG9mIDEgd2ls
bCBub3QgbWFrZSB0aGUgZGV2aWNlIHN0YXJ0IHByb2Nlc3NpbmcgYnVmZmVycy4KPiA+ID4gKyAq
Lwo+ID4gPiArc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zdXNwZW5kKHN0cnVjdCB2aG9zdF92ZHBh
ICp2KQo+ID4gPiArewo+ID4gPiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYt
PnZkcGE7Cj4gPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0g
dmRwYS0+Y29uZmlnOwo+ID4gPiArCj4gPiA+ICsgICAgICAgaWYgKCFvcHMtPnN1c3BlbmQpCj4g
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPiA+ICsKPiA+ID4gKyAg
ICAgICByZXR1cm4gb3BzLT5zdXNwZW5kKHZkcGEpOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICBz
dGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1
bnNpZ25lZCBpbnQgY21kLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZvaWQgX191c2VyICphcmdwKQo+ID4gPiAgewo+ID4gPiBAQCAtNjU0LDYgKzY3MCw5IEBAIHN0
YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+
ID4gPiAgICAgICAgIGNhc2UgVkhPU1RfVkRQQV9HRVRfVlFTX0NPVU5UOgo+ID4gPiAgICAgICAg
ICAgICAgICAgciA9IHZob3N0X3ZkcGFfZ2V0X3Zxc19jb3VudCh2LCBhcmdwKTsKPiA+ID4gICAg
ICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiArICAgICAgIGNhc2UgVkhPU1RfVkRQQV9TVVNQRU5E
Ogo+ID4gPiArICAgICAgICAgICAgICAgciA9IHZob3N0X3ZkcGFfc3VzcGVuZCh2KTsKPiA+ID4g
KyAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiAgICAgICAgIGRlZmF1bHQ6Cj4gPiA+ICAgICAg
ICAgICAgICAgICByID0gdmhvc3RfZGV2X2lvY3RsKCZ2LT52ZGV2LCBjbWQsIGFyZ3ApOwo+ID4g
PiAgICAgICAgICAgICAgICAgaWYgKHIgPT0gLUVOT0lPQ1RMQ01EKQo+ID4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3Qu
aAo+ID4gPiBpbmRleCBjYWI2NDVkNGE2NDUuLjZkOWY0NTE2MzE1NSAxMDA2NDQKPiA+ID4gLS0t
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgKPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3Zob3N0LmgKPiA+ID4gQEAgLTE3MSw0ICsxNzEsMTggQEAKPiA+ID4gICNkZWZpbmUgVkhP
U1RfVkRQQV9TRVRfR1JPVVBfQVNJRCAgICAgIF9JT1coVkhPU1RfVklSVElPLCAweDdDLCBcCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aG9zdF92cmluZ19zdGF0ZSkKPiA+ID4KPiA+ID4gKy8qIFN1c3BlbmQgb3IgcmVzdW1lIGEgZGV2
aWNlIHNvIGl0IGRvZXMgbm90IHByb2Nlc3MgdmlydHF1ZXVlIHJlcXVlc3RzIGFueW1vcmUKPiA+
ID4gKyAqCj4gPiA+ICsgKiBBZnRlciB0aGUgcmV0dXJuIG9mIGlvY3RsIHdpdGggc3VzcGVuZCAh
PSAwLCB0aGUgZGV2aWNlIG11c3QgZmluaXNoIGFueQo+ID4gPiArICogcGVuZGluZyBvcGVyYXRp
b25zIGxpa2UgaW4gZmxpZ2h0IHJlcXVlc3RzLgo+ID4KPiA+IEknbSBub3Qgc3VyZSB3ZSBzaG91
bGQgbWFuZGF0ZSB0aGUgZmx1c2ggaGVyZS4gVGhpcyBwcm9iYWJseSBibG9ja3MgdXMKPiA+IGZy
b20gYWRkaW5nIGluZmxpZ2h0IGRlc2NyaXB0b3IgcmVwb3J0aW5nIGluIHRoZSBmdXR1cmUuCj4g
Pgo+Cj4gVGhhdCdzIHJpZ2h0LiBNYXliZSB3ZSBzaG91bGQgYWRkIGEgZmxhZ3MgYXJndW1lbnQg
dG8gYWxsb3cgbm90IHRvCj4gZmx1c2ggaW4gZmxpZ2h0IGRlc2NyaXB0b3JzIGluIHRoZSBmdXR1
cmU/IE9yIG1heWJlIHRoZSByaWdodCBzb2x1dGlvbgo+IGlzIHRvIGRpc2NhcmQgdGhhdCByZXF1
aXJlbWVudCBhbmQgdG8gbWFuZGF0ZSBpbl9vcmRlciB0byBiZQo+IG1pZ3JhdGFibGUgYXQgdGhl
IG1vbWVudD8KCkkgdGhpbmsgaXQncyBiZXR0ZXIgbm90IHRvIGxpbWl0IHRoZSBkZXZpY2UgYmVo
YXZpb3VyIGxpa2UgZmx1c2ggb3IKaW5fb3JkZXIgaGVyZS4gVGhpcyBtYXkgc2ltcGxpZnkgdGhl
IHdvcmsgZm9yIGFkZGluZyBpbmZsaWdodApkZXNjcmlwdG9yIHN1cHBvcnQuCgpGb3IgdGhlIGRl
dmljZSB0aGF0IGRvZXNuJ3QgY2FyZSBhYm91dCB0aGUgaW5mbGlnaHQgZGVzY3JpcHRvciwgdGhp
cwpwYXRjaCBpcyBzdWZmaWNpZW50IGZvciBkb2luZyBsaXZlIG1pZ3JhdGlvbi4KRm9yIHRoZSBk
ZXZpY2UgdGhhdCByZXF1aXJlcyBhbiBpbmZsaWdodCBkZXNjcmlwdG9yLCB0aGlzIHBhdGNoIGlz
Cmluc3VmZmljaWVudCwgaXQgcmVxdWlyZXMgZnV0dXJlIGV4dGVuc2lvbiB0byBnZXQgdGhvc2Ug
ZGVzY3JpcHRvcnMuCkluIHRoaXMgY2FzZSwgZGV2aWNlIGhhcyB0aGUgZmxleGliaWxpdHkgdG8g
Zmx1c2ggb3Igbm90IHNvOgoKMSkgaWYgd2UgZG9uJ3QgZ2V0IGFueSBpbmZsaWdodCBkZXNjcmlw
dG9ycywgdGhlIGRldmljZSBtYXkgZG8gdGhlIGZsdXNoIGJlZm9yZQoyKSBpZiB3ZSBnZXQgaW5m
bGlnaHQgZGVzY3JpcHRvcnMsIHdlIG5lZWQgdG8gcmVzdG9yZSB0aGVtCgpUaGFua3MKCj4KPiBU
aGFua3MhCj4KPiA+IFRoYW5rcwo+ID4KPiA+IEl0IG11c3QgYWxzbyBwcmVzZXJ2ZSBhbGwgdGhl
Cj4gPiA+ICsgKiBuZWNlc3Nhcnkgc3RhdGUgKHRoZSB2aXJ0cXVldWUgdnJpbmcgYmFzZSBwbHVz
IHRoZSBwb3NzaWJsZSBkZXZpY2Ugc3BlY2lmaWMKPiA+ID4gKyAqIHN0YXRlcykgdGhhdCBpcyBy
ZXF1aXJlZCBmb3IgcmVzdG9yaW5nIGluIHRoZSBmdXR1cmUuIFRoZSBkZXZpY2UgbXVzdCBub3QK
PiA+ID4gKyAqIGNoYW5nZSBpdHMgY29uZmlndXJhdGlvbiBhZnRlciB0aGF0IHBvaW50Lgo+ID4g
PiArICoKPiA+ID4gKyAqIEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwgd2l0aCBzdXNwZW5kID09
IDAsIHRoZSBkZXZpY2UgY2FuIGNvbnRpbnVlCj4gPiA+ICsgKiBwcm9jZXNzaW5nIGJ1ZmZlcnMg
YXMgbG9uZyBhcyB0eXBpY2FsIGNvbmRpdGlvbnMgYXJlIG1ldCAodnEgaXMgZW5hYmxlZCwKPiA+
ID4gKyAqIERSSVZFUl9PSyBzdGF0dXMgYml0IGlzIGVuYWJsZWQsIGV0YykuCj4gPiA+ICsgKi8K
PiA+ID4gKyNkZWZpbmUgVkhPU1RfVkRQQV9TVVNQRU5EICAgICAgICAgICAgIF9JT1coVkhPU1Rf
VklSVElPLCAweDdELCBpbnQpCj4gPiA+ICsKPiA+ID4gICNlbmRpZgo+ID4gPiAtLQo+ID4gPiAy
LjMxLjEKPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
