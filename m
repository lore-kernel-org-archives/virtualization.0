Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D06C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 03:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 859EA400F1;
	Thu, 24 Feb 2022 03:45:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CsPMBQcco59n; Thu, 24 Feb 2022 03:45:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76EFF400AF;
	Thu, 24 Feb 2022 03:45:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42946C001A;
	Thu, 24 Feb 2022 03:45:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6459CC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51CFF83118
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUYj0kn6G6lh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:45:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4629583104
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 03:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645674345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlyCYYWO+bFQxATNj+9uSCUV+uwf9bZAR7cI+BC5YII=;
 b=gaq60amJRhX5ACXZflfelBZDx4ZpQMaR2r8lRxo2AzZ8kGkvi4gqQy1BQmy6aJhlZ3o6vH
 8ZpYRQ45vFhq7p7aAtG7f/3Er4c1QbAY4pWZWUZL2NsqZZhClnROe/hOGhn1OR6iPC6XJo
 bZ//xQF8zEqMLW2tjanA2kwENrXodUc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-7SYd0tevMqG5EiXZoIn4PA-1; Wed, 23 Feb 2022 22:45:44 -0500
X-MC-Unique: 7SYd0tevMqG5EiXZoIn4PA-1
Received: by mail-lf1-f72.google.com with SMTP id
 a5-20020ac25205000000b00443a34a9472so79727lfl.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 19:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MlyCYYWO+bFQxATNj+9uSCUV+uwf9bZAR7cI+BC5YII=;
 b=Imo/DLaO7cVIL7tEIbiz7/eTnfiIwAuaBY2J/BELiimQg71vh33BUh6Igcx5RX4YS7
 Wm+eQAvYTiK04Jz4uoE0zB6Bk2j/VGngyqERZil8qyq4HQ8+fPrtJaItKgDH82UqGWFF
 h0c5CmffOj/qiaMWFMd+cVS0+WPCBhVX5tBLU54vwdEo4C534dFwEM8SwYzmTcrxj3h+
 iBX69isdpny4qdSfV6um+sENIM22vjEAt7tMlAbVSSUsxj9si5bPIPAsNI2ucJ9Z0elz
 esWkJnVTvsPl8hwyJ0HmwwJVZH4wAoW+VZPZE2GJhos/4pwO5e2miqZb7bcQ/CPcWHf/
 9Q4Q==
X-Gm-Message-State: AOAM5308rqq5XToM4gRK98JRpwN3/md9+JTaO8p0EzKv+wVDM89awxJW
 kL76Y+PJ6JNOqdrnOCtxFNEtbaiCZ6xRF/jqvVZ1inj5VlrV+cAUbmnRIFhsAkY/vbzCy4hn0kQ
 bYcxlieMir6vKTXUAR9MRFSHLQw+EPaxHJaphozxxKK08FzyJRuH4uS70mQ==
X-Received: by 2002:ac2:508a:0:b0:443:169a:b27 with SMTP id
 f10-20020ac2508a000000b00443169a0b27mr564255lfm.257.1645674342469; 
 Wed, 23 Feb 2022 19:45:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4S0gyT5i8GJsMEhchNIn1a+cgAfIXEogTf9Mj7wnAyHyTReLgqY+kfFxUxZBS6Ut+KNWv46PrQsEgVbZ1vNA=
X-Received: by 2002:ac2:508a:0:b0:443:169a:b27 with SMTP id
 f10-20020ac2508a000000b00443169a0b27mr564233lfm.257.1645674342219; Wed, 23
 Feb 2022 19:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-29-eperezma@redhat.com>
 <42664143-6d0c-b107-ec90-8e6336bae29b@redhat.com>
 <CAJaqyWdBLU+maEhByepzeH7iwLmqUba0rRb8PM4VwBy2P8Vtow@mail.gmail.com>
 <9b32f664-56a9-3718-cf48-49003f87d430@redhat.com>
 <CAJaqyWcvWjPas0=xp+U-c-kG+e6k73jg=C4phFD7S-tZY=niSQ@mail.gmail.com>
 <CACGkMEtbd9RsE9f-HLnwmhJEFsK++uBHnqG4N0c6qJG0PxDdzw@mail.gmail.com>
 <CAJaqyWdhHmD+tB_bY_YEMnBU1p7-LW=LP8f+3e_ZXDcOfSRiNA@mail.gmail.com>
 <0f0204f1-8b7f-a21e-495e-24443a63f026@redhat.com>
 <CAJaqyWfFC4SgxQ4zQeHgtDDJSd0tBa-W4HmtW0UASA2cVDWDUg@mail.gmail.com>
 <CACGkMEukmf35163EDFQ2YQo2g2N0Diby7ffr9=UmOwGPEKj-Eg@mail.gmail.com>
 <CAJaqyWds=97TjEpORiqhsj57KNxJ482jwcRS8TN59a4aank7-w@mail.gmail.com>
In-Reply-To: <CAJaqyWds=97TjEpORiqhsj57KNxJ482jwcRS8TN59a4aank7-w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Feb 2022 11:45:30 +0800
Message-ID: <CACGkMEtHvvWGYqDpQ1idpyYSqOMM9u8zXUjhZpW19pWAu1Z=_w@mail.gmail.com>
Subject: Re: [PATCH 28/31] vdpa: Expose VHOST_F_LOG_ALL on SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBGZWIgMjMsIDIwMjIgYXQgNDowNiBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEZlYiAyMywgMjAyMiBhdCA0OjQ3
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1
ZSwgRmViIDIyLCAyMDIyIGF0IDQ6MDYgUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4KPiA+IDxlcGVy
ZXptYUByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVlLCBGZWIgMjIsIDIwMjIg
YXQgODo0MSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4g5ZyoIDIwMjIvMi8xNyDkuIvljYg0OjIyLCBFdWdlbmlvIFBlcmV6
IE1hcnRpbiDlhpnpgZM6Cj4gPiA+ID4gPiBPbiBUaHUsIEZlYiAxNywgMjAyMiBhdCA3OjAyIEFN
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4+IE9uIFdl
ZCwgRmViIDE2LCAyMDIyIGF0IDExOjU0IFBNIEV1Z2VuaW8gUGVyZXogTWFydGluCj4gPiA+ID4g
Pj4gPGVwZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4+PiBPbiBUdWUsIEZlYiA4
LCAyMDIyIGF0IDk6MjUgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4+Pj4g5ZyoIDIwMjIvMi8xIOS4i+WNiDc6NDUsIEV1Z2Vu
aW8gUGVyZXogTWFydGluIOWGmemBkzoKPiA+ID4gPiA+Pj4+PiBPbiBTdW4sIEphbiAzMCwgMjAy
MiBhdCA3OjUwIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4g
PiA+ID4+Pj4+PiDlnKggMjAyMi8xLzIyIOS4iuWNiDQ6MjcsIEV1Z2VuaW8gUMOpcmV6IOWGmemB
kzoKPiA+ID4gPiA+Pj4+Pj4+IFNWUSBpcyBhYmxlIHRvIGxvZyB0aGUgZGlydHkgYml0cyBieSBp
dHNlbGYsIHNvIGxldCdzIHVzZSBpdCB0byBub3QKPiA+ID4gPiA+Pj4+Pj4+IGJsb2NrIG1pZ3Jh
dGlvbi4KPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPj4+Pj4+PiBBbHNvLCBpZ25vcmUgc2V0IGFu
ZCBjbGVhciBvZiBWSE9TVF9GX0xPR19BTEwgb24gc2V0X2ZlYXR1cmVzIGlmIFNWUSBpcwo+ID4g
PiA+ID4+Pj4+Pj4gZW5hYmxlZC4gRXZlbiBpZiB0aGUgZGV2aWNlIHN1cHBvcnRzIGl0LCB0aGUg
cmVwb3J0cyB3b3VsZCBiZSBub25zZW5zZQo+ID4gPiA+ID4+Pj4+Pj4gYmVjYXVzZSBTVlEgbWVt
b3J5IGlzIGluIHRoZSBxZW11IHJlZ2lvbi4KPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPj4+Pj4+
PiBUaGUgbG9nIHJlZ2lvbiBpcyBzdGlsbCBhbGxvY2F0ZWQuIEZ1dHVyZSBjaGFuZ2VzIG1pZ2h0
IHNraXAgdGhhdCwgYnV0Cj4gPiA+ID4gPj4+Pj4+PiB0aGlzIHNlcmllcyBpcyBhbHJlYWR5IGxv
bmcgZW5vdWdoLgo+ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPiA+ID4+Pj4+Pj4gLS0t
Cj4gPiA+ID4gPj4+Pj4+PiAgICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDIwICsrKysrKysr
KysrKysrKysrKysrCj4gPiA+ID4gPj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKykKPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4gPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiA+ID4gPiA+Pj4+
Pj4+IGluZGV4IGZiMGEzMzhiYWEuLjc1MDkwZDY1ZTggMTAwNjQ0Cj4gPiA+ID4gPj4+Pj4+PiAt
LS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gPiA+ID4gPj4+Pj4+PiArKysgYi9ody92aXJ0
aW8vdmhvc3QtdmRwYS5jCj4gPiA+ID4gPj4+Pj4+PiBAQCAtMTAyMiw2ICsxMDIyLDkgQEAgc3Rh
dGljIGludCB2aG9zdF92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVp
bnQ2NF90ICpmZWF0dXJlcykKPiA+ID4gPiA+Pj4+Pj4+ICAgICAgICAgaWYgKHJldCA9PSAwICYm
IHYtPnNoYWRvd192cXNfZW5hYmxlZCkgewo+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgLyog
RmlsdGVyIG9ubHkgZmVhdHVyZXMgdGhhdCBTVlEgY2FuIG9mZmVyIHRvIGd1ZXN0ICovCj4gPiA+
ID4gPj4+Pj4+PiAgICAgICAgICAgICB2aG9zdF9zdnFfdmFsaWRfZ3Vlc3RfZmVhdHVyZXMoZmVh
dHVyZXMpOwo+ID4gPiA+ID4+Pj4+Pj4gKwo+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgLyogQWRk
IFNWUSBsb2dnaW5nIGNhcGFiaWxpdGllcyAqLwo+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgKmZl
YXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfRl9MT0dfQUxMKTsKPiA+ID4gPiA+Pj4+Pj4+ICAgICAg
ICAgfQo+ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+Pj4+Pj4+ICAgICAgICAgcmV0dXJuIHJldDsK
PiA+ID4gPiA+Pj4+Pj4+IEBAIC0xMDM5LDggKzEwNDIsMjUgQEAgc3RhdGljIGludCB2aG9zdF92
ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gPiA+ID4gPj4+Pj4+Pgo+
ID4gPiA+ID4+Pj4+Pj4gICAgICAgICBpZiAodi0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gPiA+
ID4gPj4+Pj4+PiAgICAgICAgICAgICB1aW50NjRfdCBkZXZfZmVhdHVyZXMsIHN2cV9mZWF0dXJl
cywgYWNrZWRfZmVhdHVyZXM7Cj4gPiA+ID4gPj4+Pj4+PiArICAgICAgICB1aW50OF90IHN0YXR1
cyA9IDA7Cj4gPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICBib29sIG9rOwo+ID4gPiA+ID4+Pj4+
Pj4KPiA+ID4gPiA+Pj4+Pj4+ICsgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfY2FsbChkZXYsIFZI
T1NUX1ZEUEFfR0VUX1NUQVRVUywgJnN0YXR1cyk7Cj4gPiA+ID4gPj4+Pj4+PiArICAgICAgICBp
ZiAodW5saWtlbHkocmV0KSkgewo+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgICAgIHJldHVybiBy
ZXQ7Cj4gPiA+ID4gPj4+Pj4+PiArICAgICAgICB9Cj4gPiA+ID4gPj4+Pj4+PiArCj4gPiA+ID4g
Pj4+Pj4+PiArICAgICAgICBpZiAoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykg
ewo+ID4gPiA+ID4+Pj4+Pj4gKyAgICAgICAgICAgIC8qCj4gPiA+ID4gPj4+Pj4+PiArICAgICAg
ICAgICAgICogdmhvc3QgaXMgdHJ5aW5nIHRvIGVuYWJsZSBvciBkaXNhYmxlIF9GX0xPRywgYW5k
IHRoZSBkZXZpY2UKPiA+ID4gPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgKiB3b3VsZCByZXBvcnQg
d3JvbmcgZGlydHkgcGFnZXMuIFNWUSBoYW5kbGVzIGl0Lgo+ID4gPiA+ID4+Pj4+Pj4gKyAgICAg
ICAgICAgICAqLwo+ID4gPiA+ID4+Pj4+PiBJIGZhaWwgdG8gdW5kZXJzdGFuZCB0aGlzIGNvbW1l
bnQsIEknZCB0aGluayB0aGVyZSdzIG5vIHdheSB0byBkaXNhYmxlCj4gPiA+ID4gPj4+Pj4+IGRp
cnR5IHBhZ2UgdHJhY2tpbmcgZm9yIFNWUS4KPiA+ID4gPiA+Pj4+Pj4KPiA+ID4gPiA+Pj4+PiB2
aG9zdF9sb2dfZ2xvYmFsX3tzdGFydCxzdG9wfSBhcmUgY2FsbGVkIGF0IHRoZSBiZWdpbm5pbmcg
YW5kIGVuZCBvZgo+ID4gPiA+ID4+Pj4+IG1pZ3JhdGlvbi4gVG8gaW5mb3JtIHRoZSBkZXZpY2Ug
dGhhdCBpdCBzaG91bGQgc3RhcnQgbG9nZ2luZywgdGhleSBzZXQKPiA+ID4gPiA+Pj4+PiBvciBj
bGVhbiBWSE9TVF9GX0xPR19BTEwgYXQgdmhvc3RfZGV2X3NldF9sb2cuCj4gPiA+ID4gPj4+Pgo+
ID4gPiA+ID4+Pj4gWWVzLCBidXQgZm9yIFNWUSwgd2UgY2FuJ3QgZGlzYWJsZSBkaXJ0eSBwYWdl
IHRyYWNraW5nLCBpc24ndCBpdD8gVGhlCj4gPiA+ID4gPj4+PiBvbmx5IHRoaW5nIGlzIHRvIGln
bm9yZSBvciBmaWx0ZXIgb3V0IHRoZSBGX0xPR19BTEwgYW5kIHByZXRlbmQgdG8gYmUKPiA+ID4g
PiA+Pj4+IGVuYWJsZWQgYW5kIGRpc2FibGVkLgo+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+Pj4gWWVz
LCB0aGF0J3Mgd2hhdCB0aGlzIHBhdGNoIGRvZXMuCj4gPiA+ID4gPj4+Cj4gPiA+ID4gPj4+Pj4g
V2hpbGUgU1ZRIGRvZXMgbm90IHVzZSBWSE9TVF9GX0xPR19BTEwsIGl0IGV4cG9ydHMgdGhlIGZl
YXR1cmUgYml0IHNvCj4gPiA+ID4gPj4+Pj4gdmhvc3QgZG9lcyBub3QgYmxvY2sgbWlncmF0aW9u
LiBNYXliZSB3ZSBuZWVkIHRvIGxvb2sgZm9yIGFub3RoZXIgd2F5Cj4gPiA+ID4gPj4+Pj4gdG8g
ZG8gdGhpcz8KPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPj4+PiBJJ20gZmluZSB3aXRoIGZpbHRlcmlu
ZyBzaW5jZSBpdCdzIG11Y2ggbW9yZSBzaW1wbGVyLCBidXQgSSBmYWlsIHRvCj4gPiA+ID4gPj4+
PiB1bmRlcnN0YW5kIHdoeSB3ZSBuZWVkIHRvIGNoZWNrIERSSVZFUl9PSy4KPiA+ID4gPiA+Pj4+
Cj4gPiA+ID4gPj4+IE9rIG1heWJlIEkgY2FuIG1ha2UgdGhhdCBwYXJ0IG1vcmUgY2xlYXIsCj4g
PiA+ID4gPj4+Cj4gPiA+ID4gPj4+IFNpbmNlIGJvdGggb3BlcmF0aW9ucyB1c2Ugdmhvc3RfdmRw
YV9zZXRfZmVhdHVyZXMgd2UgbXVzdCBqdXN0IGZpbHRlcgo+ID4gPiA+ID4+PiB0aGUgb25lIHRo
YXQgYWN0dWFsbHkgc2V0cyBvciByZW1vdmVzIFZIT1NUX0ZfTE9HX0FMTCwgd2l0aG91dAo+ID4g
PiA+ID4+PiBhZmZlY3Rpbmcgb3RoZXIgZmVhdHVyZXMuCj4gPiA+ID4gPj4+Cj4gPiA+ID4gPj4+
IEluIHByYWN0aWNlLCB0aGF0IG1lYW5zIHRvIG5vdCBmb3J3YXJkIHRoZSBzZXQgZmVhdHVyZXMg
YWZ0ZXIKPiA+ID4gPiA+Pj4gRFJJVkVSX09LLiBUaGUgZGV2aWNlIGlzIG5vdCBleHBlY3Rpbmcg
dGhlbSBhbnltb3JlLgo+ID4gPiA+ID4+IEkgd29uZGVyIHdoYXQgaGFwcGVucyBpZiB3ZSBkb24n
dCBkbyB0aGlzLgo+ID4gPiA+ID4+Cj4gPiA+ID4gPiBJZiB3ZSBzaW1wbHkgZGVsZXRlIHRoZSBj
aGVjayB2aG9zdF9kZXZfc2V0X2ZlYXR1cmVzIHdpbGwgcmV0dXJuIGFuCj4gPiA+ID4gPiBlcnJv
ciwgZmFpbGluZyB0aGUgc3RhcnQgb2YgdGhlIG1pZ3JhdGlvbi4gTW9yZSBvbiB0aGlzIGJlbG93
Lgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBPay4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+ID4+IFNvIGtlcm5lbCBoYWQgdGhpcyBjaGVjazoKPiA+ID4gPiA+Pgo+ID4gPiA+ID4+
ICAgICAgICAgIC8qCj4gPiA+ID4gPj4gICAgICAgICAgICogSXQncyBub3QgYWxsb3dlZCB0byBj
aGFuZ2UgdGhlIGZlYXR1cmVzIGFmdGVyIHRoZXkgaGF2ZQo+ID4gPiA+ID4+ICAgICAgICAgICAq
IGJlZW4gbmVnb3RpYXRlZC4KPiA+ID4gPiA+PiAgICAgICAgICAgKi8KPiA+ID4gPiA+PiBpZiAo
b3BzLT5nZXRfc3RhdHVzKHZkcGEpICYgVklSVElPX0NPTkZJR19TX0ZFQVRVUkVTX09LKQo+ID4g
PiA+ID4+ICAgICAgICAgIHJldHVybiAtRUJVU1k7Cj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBTbyBp
cyBpdCBGRUFUVVJFU19PSyBhY3R1YWxseT8KPiA+ID4gPiA+Pgo+ID4gPiA+ID4gWWVzLCBGRUFU
VVJFU19PSyBzZWVtcyBtb3JlIGFwcHJvcHJpYXRlIGFjdHVhbGx5IHNvIEkgd2lsbCBzd2l0Y2gg
dG8KPiA+ID4gPiA+IGl0IGZvciB0aGUgbmV4dCB2ZXJzaW9uLgo+ID4gPiA+ID4KPiA+ID4gPiA+
IEJ1dCBpdCBzaG91bGQgYmUgZnVuY3Rpb25hbGx5IGVxdWl2YWxlbnQsIHNpbmNlCj4gPiA+ID4g
PiB2aG9zdC5jOnZob3N0X2Rldl9zdGFydCBzZXRzIGJvdGggYW5kIHRoZSBzZXR0aW5nIG9mIF9G
X0xPR19BTEwgY2Fubm90Cj4gPiA+ID4gPiBiZSBjb25jdXJyZW50IHdpdGggaXQuCj4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+IFJpZ2h0Lgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4g
Pj4gRm9yIHRoaXMgcGF0Y2gsIEkgd29uZGVyIGlmIHRoZSB0aGluZyB3ZSBuZWVkIHRvIGRvIGlz
IHRvIHNlZSB3aGV0aGVyCj4gPiA+ID4gPj4gaXQgaXMgYSBlbmFibGUvZGlzYWJsZSBGX0xPR19B
TEwgYW5kIHNpbXBseSByZXR1cm4uCj4gPiA+ID4gPj4KPiA+ID4gPiA+IFllcywgdGhhdCdzIHRo
ZSBpbnRlbnRpb24gb2YgdGhlIHBhdGNoLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFdlIGhhdmUgNCBj
YXNlcyBoZXJlOgo+ID4gPiA+ID4gYSkgV2UncmUgYmVpbmcgY2FsbGVkIGZyb20gdmhvc3RfZGV2
X3N0YXJ0LCB3aXRoIGVuYWJsZV9sb2cgPSBmYWxzZQo+ID4gPiA+ID4gYikgV2UncmUgYmVpbmcg
Y2FsbGVkIGZyb20gdmhvc3RfZGV2X3N0YXJ0LCB3aXRoIGVuYWJsZV9sb2cgPSB0cnVlCj4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+IEFuZCB0aGlzIGNhc2UgbWFrZXMgdXMgY2FuJ3Qgc2ltcGx5IHJl
dHVybiB3aXRob3V0IGNhbGxpbmcgdmhvc3QtdmRwYS4KPiA+ID4gPgo+ID4gPgo+ID4gPiBJdCBj
YWxscyBiZWNhdXNlIHtGRUFUVVJFUyxEUklWRVJ9X09LIGlzIHN0aWxsIG5vdCBzZXQgYXQgdGhh
dCBwb2ludC4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gYykgV2UncmUgYmVpbmcgY2FsbGVkIGZy
b20gdmhvc3RfZGV2X3NldF9sb2csIHdpdGggZW5hYmxlX2xvZyA9IGZhbHNlCj4gPiA+ID4gPiBk
KSBXZSdyZSBiZWluZyBjYWxsZWQgZnJvbSB2aG9zdF9kZXZfc2V0X2xvZywgd2l0aCBlbmFibGVf
bG9nID0gdHJ1ZQo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZSB3YXkgdG8gdGVsbCB0aGUgZGlmZmVy
ZW5jZSBiZXR3ZWVuIGEvYiBhbmQgYy9kIGlzIHRvIGNoZWNrIGlmCj4gPiA+ID4gPiB7RkVBVFVS
RVMsRFJJVkVSfV9PSyBpcyBzZXQuIEFuZCwgYXMgeW91IHBvaW50IG91dCBpbiBwcmV2aW91cyBt
YWlscywKPiA+ID4gPiA+IEZfTE9HX0FMTCBtdXN0IGJlIGZpbHRlcmVkIHVuY29uZGl0aW9uYWxs
eSBzaW5jZSBTVlEgdHJhY2tzIGRpcnR5Cj4gPiA+ID4gPiBtZW1vcnkgdGhyb3VnaCB0aGUgbWVt
b3J5IHVubWFwcGluZywgc28gd2UgY2xlYXIgdGhlIGJpdAo+ID4gPiA+ID4gdW5jb25kaXRpb25h
bGx5IGlmIHdlIGRldGVjdCB0aGF0IFZIT1NUX1NFVF9GRUFUVVJFUyB3aWxsIGJlIGNhbGxlZAo+
ID4gPiA+ID4gKGNhc2VzIGEgYW5kIGIpLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFub3RoZXIgcG9z
c2liaWxpdHkgaXMgdG8gdHJhY2sgaWYgZmVhdHVyZXMgaGF2ZSBiZWVuIHNldCB3aXRoIGEgYm9v
bAo+ID4gPiA+ID4gaW4gdmhvc3RfdmRwYSBvciBzb21ldGhpbmcgbGlrZSB0aGF0LiBCdXQgaXQg
c2VlbXMgY2xlYW5lciB0byBtZSB0bwo+ID4gPiA+ID4gb25seSBzdG9yZSB0aGF0IGluIHRoZSBh
Y3R1YWwgZGV2aWNlLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBTbyBJIHN1Z2dlc3QgdG8gbWFr
ZSBzdXJlIGNvZGVzIG1hdGNoIHRoZSBjb21tZW50Ogo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICAg
aWYgKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spIHsKPiA+ID4gPiAgICAgICAg
ICAgICAgLyoKPiA+ID4gPiAgICAgICAgICAgICAgICogdmhvc3QgaXMgdHJ5aW5nIHRvIGVuYWJs
ZSBvciBkaXNhYmxlIF9GX0xPRywgYW5kIHRoZSBkZXZpY2UKPiA+ID4gPiAgICAgICAgICAgICAg
ICogd291bGQgcmVwb3J0IHdyb25nIGRpcnR5IHBhZ2VzLiBTVlEgaGFuZGxlcyBpdC4KPiA+ID4g
PiAgICAgICAgICAgICAgICovCj4gPiA+ID4gICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gPiA+
ICAgICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+IEl0IHdvdWxkIGJlIGJldHRlciB0byBjaGVjayB3
aGV0aGVyIHRoZSBjYWxsZXIgaXMgdG9nZ2xpbmcgX0ZfTE9HX0FMTCBpbgo+ID4gPiA+IHRoaXMg
Y2FzZS4KPiA+ID4gPgo+ID4gPgo+ID4gPiBIb3cgdG8gZGV0ZWN0PyBXZSBjYW4gc2F2ZSBmZWF0
dXJlIGZsYWdzIGFuZCBjb21wYXJlLCBidXQgaWdub3JpbmcgYWxsCj4gPiA+IHNldF9mZWF0dXJl
cyBhZnRlciBGRUFUVVJFU19PSyBzZWVtcyBzaW1wbGVyIHRvIG1lLgo+ID4KPiA+IFNvbWV0aGlu
ZyBsaWtlOgo+ID4KPiA+IChzdGF0dXMgXiBzdGF0dXNfb2xkID09IF9GX0xPR19BTEwpID8KPiA+
Cj4KPiBzL3N0YXR1cy9mZWF0dXJlcy8gPwoKUmlnaHQuCgo+Cj4gPiBJdCBoZWxwcyB1cyB0byBy
ZXR1cm4gZXJyb3JzIG9uIHdyb25nIGZlYXR1cmVzIHNldCBkdXJpbmcgRFJJVkVSX09LLgo+ID4K
Pgo+IERvIHlvdSBtZWFuIHRvIHJldHVybiBlcnJvcnMgaW4gY2FzZSBvZiB0b2dnbGluZyBvdGhl
ciBmZWF0dXJlcyB0aGFuCj4gX0ZfTE9HX0FMTCwgaXNuJ3QgaXQ/IFRoYXQncyBpbnRlcmVzdGlu
ZyBhY3R1YWxseSwgYnV0IGl0IHNlZW1zIGl0Cj4gZm9yY2VzIHZob3N0X3ZkcGEgdG8gdHJhY2sg
YWNrZWRfZmVhdHVyZXMgdG9vLgoKSSBtZWFudCB3ZSBjYW4gY2hhbmdlIHRoZSBjaGVjayBhIGxp
dHRsZSBiaXQgbGlrZToKCmlmIChmZWF0dXJzIF4gZmVhdHVyZXNfb2xkID09IF9GX0xPR19BTEwg
JiYgc3RhdHVzICYKVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgewogICAgcmV0dXJuIDA7Cn0K
CkZvciBvdGhlciBmZWF0dXJlcyBjaGFuZ2luZyB3ZSBhbmQgbGV0IGl0IGdvIGRvd24gdGhlIGxv
Z2ljIGFzIHlvdQpwcm9wb3NlZCBpbiB0aGlzIHBhdGNoLgoKVGhhbmtzCgo+Cj4gQWN0dWFsbHks
IGl0IHNlZW1zIHRvIG1lIHZob3N0X2Rldi0+YWNrZWRfZmVhdHVyZXMgd2lsbCByZXRhaW4gdGhl
IGJhZAo+IGZlYXR1cmVzIGV2ZW4gb24gZXJyb3IuIEknbGwgaW52ZXN0aWdhdGUgaXQuCj4KPiBU
aGFua3MhCj4KPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBXb3VsZCBjaGFuZ2luZyB0aGUg
Y29tbWVudCB3b3JrPyBTb21ldGhpbmcgbGlrZSAic2V0X2ZlYXR1cmVzIGFmdGVyCj4gPiA+IF9T
X0ZFQVRVUkVTX09LIG1lYW5zIHZob3N0IGlzIHRyeWluZyB0byBlbmFibGUgb3IgZGlzYWJsZSBf
Rl9MT0csIGFuZAo+ID4gPiB0aGUgZGV2aWNlIHdvdWxkIHJlcG9ydCB3cm9uZyBkaXJ0eSBwYWdl
cy4gU1ZRIGhhbmRsZXMgaXQuIgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
