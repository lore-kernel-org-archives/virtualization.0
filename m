Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D3FC433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:08:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EE564F71
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EE564F71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E99754301D;
	Tue, 16 Mar 2021 08:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jaFQ4Jox1_hq; Tue, 16 Mar 2021 08:08:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96DC5400E2;
	Tue, 16 Mar 2021 08:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A541C000C;
	Tue, 16 Mar 2021 08:08:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9221C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B75EE60641
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iRX0-89plhf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 008D3605E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615882111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1nCMh/GdtBAnYHceTwx46TFXLt9IwH9izaAAYsXUH8=;
 b=aHtdAdo6te9xoyg2zx2U4yxc4LO/I1rPKrbPtSUT+Q90Z+WJ5rwR7L/0yjbWGtEG2s4Wl7
 UOmSuQbReBvLOSKN6ST/uHFZjTw+60nNpWVB0Ls6uuM92iUwVp0B0TwHJ7HvQD0xKhjj+k
 ttPpD30AxMbL0VJYF7F9cvVu+Nzp0qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-OYhZaPniP_uW-KgOR_BeAw-1; Tue, 16 Mar 2021 04:08:30 -0400
X-MC-Unique: OYhZaPniP_uW-KgOR_BeAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 795F5180A0A3;
 Tue, 16 Mar 2021 08:08:28 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com
 [10.72.12.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB501B426;
 Tue, 16 Mar 2021 08:08:19 +0000 (UTC)
Subject: Re: [RFC v2 13/13] vhost: Use VRING_AVAIL_F_NO_INTERRUPT at device
 call on shadow virtqueue
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210315194842.277740-1-eperezma@redhat.com>
 <20210315194842.277740-14-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a5a542d-9640-36b3-401a-9208576c6588@redhat.com>
Date: Tue, 16 Mar 2021 16:08:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315194842.277740-14-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guru Prasad <guru.prasad@broadcom.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Michael Lilja <ml@napatech.com>, Jim Harford <jim.harford@broadcom.com>,
 Rob Miller <rob.miller@broadcom.com>
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

CuWcqCAyMDIxLzMvMTYg5LiK5Y2IMzo0OCwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNpZ25l
ZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAg
aHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8IDI4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUu
YyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiBpbmRleCA3ZGY5OGZjNDNm
Li5lMzg3OWE0NjIyIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1
ZXVlLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gQEAgLTcx
LDEwICs3MSwzNSBAQCB0eXBlZGVmIHN0cnVjdCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSB7Cj4gICAg
ICAgLyogTmV4dCBoZWFkIHRvIGNvbnN1bWUgZnJvbSBkZXZpY2UgKi8KPiAgICAgICB1aW50MTZf
dCB1c2VkX2lkeDsKPiAgIAo+ICsgICAgLyogQ2FjaGUgZm9yIHRoZSBleHBvc2VkIG5vdGlmaWNh
dGlvbiBmbGFnICovCj4gKyAgICBib29sIG5vdGlmaWNhdGlvbjsKPiArCj4gICAgICAgLyogRGVz
Y3JpcHRvcnMgY29waWVkIGZyb20gZ3Vlc3QgKi8KPiAgICAgICB2cmluZ19kZXNjX3QgZGVzY3Nb
XTsKPiAgIH0gVmhvc3RTaGFkb3dWaXJ0cXVldWU7Cj4gICAKPiArc3RhdGljIHZvaWQgdmhvc3Rf
c2hhZG93X3ZxX3NldF9ub3RpZmljYXRpb24oVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBlbmFibGUp
Cj4gK3sKPiArICAgIHVpbnQxNl90IG5vdGlmaWNhdGlvbl9mbGFnOwo+ICsKPiArICAgIGlmIChz
dnEtPm5vdGlmaWNhdGlvbiA9PSBlbmFibGUpIHsKPiArICAgICAgICByZXR1cm47Cj4gKyAgICB9
Cj4gKwo+ICsgICAgbm90aWZpY2F0aW9uX2ZsYWcgPSB2aXJ0aW9fdHN3YXAxNihzdnEtPnZkZXYs
IFZSSU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUKTsKPiArCj4gKyAgICBzdnEtPm5vdGlmaWNhdGlv
biA9IGVuYWJsZTsKPiArICAgIGlmIChlbmFibGUpIHsKPiArICAgICAgICBzdnEtPnZyaW5nLmF2
YWlsLT5mbGFncyAmPSB+bm90aWZpY2F0aW9uX2ZsYWc7Cj4gKyAgICB9IGVsc2Ugewo+ICsgICAg
ICAgIHN2cS0+dnJpbmcuYXZhaWwtPmZsYWdzIHw9IG5vdGlmaWNhdGlvbl9mbGFnOwo+ICsgICAg
fQo+ICsKPiArICAgIC8qIE1ha2Ugc3VyZSBkZXZpY2UgcmVhZHMgb3VyIGZsYWcgKi8KPiArICAg
IHNtcF9tYigpOwoKClRoaXMgaXMgYSBoaW50LCBzbyB3ZSBkb24ndCBuZWVkIG1lbW9yeSBiYXJy
aWVyIGhlcmUuCgpUaGFua3MKCgo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgdmhvc3RfdnJpbmdf
d3JpdGVfZGVzY3MoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBpb3ZlYyAqaW92ZWMsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgbnVtLCBib29sIG1vcmVfZGVz
Y3MsIGJvb2wgd3JpdGUpCj4gQEAgLTI1MSw3ICsyNzYsNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF9z
aGFkb3dfdnFfaGFuZGxlX2NhbGxfbm9fdGVzdChFdmVudE5vdGlmaWVyICpuKQo+ICAgICAgIGRv
IHsKPiAgICAgICAgICAgdW5zaWduZWQgaSA9IDA7Cj4gICAKPiAtICAgICAgICAvKiBUT0RPOiBV
c2UgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgKi8KPiArICAgICAgICB2aG9zdF9zaGFkb3df
dnFfc2V0X25vdGlmaWNhdGlvbihzdnEsIGZhbHNlKTsKPiAgICAgICAgICAgd2hpbGUgKHRydWUp
IHsKPiAgICAgICAgICAgICAgIGdfYXV0b2ZyZWUgVmlydFF1ZXVlRWxlbWVudCAqZWxlbSA9IHZo
b3N0X3NoYWRvd192cV9nZXRfYnVmKHN2cSk7Cj4gICAgICAgICAgICAgICBpZiAoIWVsZW0pIHsK
PiBAQCAtMjY5LDYgKzI5NCw3IEBAIHN0YXRpYyB2b2lkIHZob3N0X3NoYWRvd192cV9oYW5kbGVf
Y2FsbF9ub190ZXN0KEV2ZW50Tm90aWZpZXIgKm4pCj4gICAgICAgICAgICAgICBzdnEtPm1hc2tl
ZF9ub3RpZmllci5zaWduYWxlZCA9IHRydWU7Cj4gICAgICAgICAgICAgICBldmVudF9ub3RpZmll
cl9zZXQoc3ZxLT5tYXNrZWRfbm90aWZpZXIubik7Cj4gICAgICAgICAgIH0KPiArICAgICAgICB2
aG9zdF9zaGFkb3dfdnFfc2V0X25vdGlmaWNhdGlvbihzdnEsIHRydWUpOwo+ICAgICAgIH0gd2hp
bGUgKHZob3N0X3NoYWRvd192cV9tb3JlX3VzZWQoc3ZxKSk7Cj4gICAKPiAgICAgICBpZiAobWFz
a2VkX25vdGlmaWVyKSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
