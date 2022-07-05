Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51AFC43334
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 03:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CC1582C21;
	Tue,  5 Jul 2022 03:11:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CC1582C21
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QeEsyh3s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ww4HNhkdKl2g; Tue,  5 Jul 2022 03:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E369182D57;
	Tue,  5 Jul 2022 03:11:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E369182D57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C57D6C0032;
	Tue,  5 Jul 2022 03:11:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07E7DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE43A82CF9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE43A82CF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rihreFRON29
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:11:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DADEA82D57
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DADEA82D57
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656990707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQCCvyEDOrmKMdgwu+myg3JTmuJjhTgWFLZCYX16vSI=;
 b=QeEsyh3s4G6y2896q3bKO2OUO5Cu7FDqfzNYTDruKSk5OqRLihEqN26V5PP/jzTen8BHaH
 PdvQfqOUfk60lU+WaqNGkUBxt+PFs/PDBQdrdr/Oy6vZZ1gMonTGORIJSJF2DAXp0lK1RM
 KVEOYBa3sSFB6IMJELMhkEhulJnoftA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-7amx55qCPYCgNG1Z7HwI6Q-1; Mon, 04 Jul 2022 23:11:44 -0400
X-MC-Unique: 7amx55qCPYCgNG1Z7HwI6Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 10-20020ac2484a000000b0047f9f9c81daso3488784lfy.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 20:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qQCCvyEDOrmKMdgwu+myg3JTmuJjhTgWFLZCYX16vSI=;
 b=ihRFcwx+jsw0WZv+EZaj+bHevXDG9ux5/IS9AkB7OpfOFmvCGWpAlurXq8uD2sgUfU
 xWAIwKn6nAw+UFFEEk1Lk1AOGdcbi7xEZMpZb6TIlEVDVMGXnI8qQESklkrcFSlTtc9r
 dHViaFjPYbxHrWJoNhHfhQPWcnrItvcBeKPreTeCp3d3kA/QgHAHOF76IT0UWqTBiMMB
 tuXdkRK5FS7VO7/BFPWNH934uD4tAPuv4Ba3xPIUOqgxg+h1QQozGFYlMB0lhif39+Aa
 x+Pto+nfHbi33SMZaTUOhbyhAWJjnVSOVbTSIBicKiAUCPUrmRFL4aV53+aGK41GJ5/K
 ccZg==
X-Gm-Message-State: AJIora9CArAWmbxFYoWKmgh+n1bnX8bvIbGEpItOMxuRIFZvDVz+o+TL
 uZMUoQ+ZVapRdPpa9hltoFOl6hUkjZAYiVOOJ9LGfgj43hfrOpEg2kU0/YfO+ceRp4yt8J1ETeq
 jGmibuJXfgMLslWx/Se5g1hZsrA7RUy9wSflQ6SkAvMlniGQ7xorxIDEe9g==
X-Received: by 2002:ac2:53bb:0:b0:483:c716:c44 with SMTP id
 j27-20020ac253bb000000b00483c7160c44mr237738lfh.575.1656990702590; 
 Mon, 04 Jul 2022 20:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLOw7+4T4lQRXfmQ6YTcpg3v6l9JZnsnJq7gm4OzuYQgoh2U+mfUUTt6rhzVXRQOXHLa+mgXAw55t/y+8cXfY=
X-Received: by 2002:ac2:53bb:0:b0:483:c716:c44 with SMTP id
 j27-20020ac253bb000000b00483c7160c44mr237731lfh.575.1656990702409; Mon, 04
 Jul 2022 20:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220630153221.83371-1-sgarzare@redhat.com>
 <20220630153221.83371-3-sgarzare@redhat.com>
In-Reply-To: <20220630153221.83371-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Jul 2022 11:11:30 +0800
Message-ID: <CACGkMEtEDpX6QdBtqwx=eu-KpWEGRUZY9zuCJk1U+4Ht1TY4ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vdpa_sim_blk: limit the number of request handled
 per batch
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVGh1LCBKdW4gMzAsIDIwMjIgYXQgMTE6MzIgUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IExpbWl0IHRoZSBudW1iZXIgb2YgcmVxdWVzdHMg
KDQgcGVyIHF1ZXVlIGFzIGZvciB2ZHBhX3NpbV9uZXQpIGhhbmRsZWQKPiBpbiBhIGJhdGNoIHRv
IHByZXZlbnQgdGhlIHdvcmtlciBmcm9tIHVzaW5nIHRoZSBDUFUgZm9yIHRvbyBsb25nLgo+Cj4g
U3VnZ2VzdGVkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+CgpBY2tl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCj4gLS0tCj4gdjI6Cj4gLSBy
ZXN0b3JlZCBwcmV2aW91cyBiZWhhdmlvdXIsIGV4aXRpbmcgdGhlIGxvb3AgaW1tZWRpYXRlbHkg
aWYgdGhlCj4gICByZXF1ZXN0IGlzIG1hbGZvcm1lZCBbSmFzb25dCj4gLS0tCj4gIGRyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDEwICsrKysrKysrKysKPiAgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW1fYmxrLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxr
LmMKPiBpbmRleCBhODNhNWM3NmY2MjAuLmIyZDc1ZWZlYzYzYSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW1fYmxrLmMKPiBAQCAtMTk3LDYgKzE5Nyw3IEBAIHN0YXRpYyBib29sIHZk
cGFzaW1fYmxrX2hhbmRsZV9yZXEoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sCj4gIHN0YXRpYyB2
b2lkIHZkcGFzaW1fYmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICB7Cj4gICAg
ICAgICBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qg
dmRwYXNpbSwgd29yayk7Cj4gKyAgICAgICBib29sIHJlc2NoZWR1bGUgPSBmYWxzZTsKPiAgICAg
ICAgIGludCBpOwo+Cj4gICAgICAgICBzcGluX2xvY2soJnZkcGFzaW0tPmxvY2spOwo+IEBAIC0y
MDYsNiArMjA3LDcgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmspCj4KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBWRFBBU0lNX0JMS19WUV9O
VU07IGkrKykgewo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZx
ID0gJnZkcGFzaW0tPnZxc1tpXTsKPiArICAgICAgICAgICAgICAgaW50IHJlcXMgPSAwOwo+Cj4g
ICAgICAgICAgICAgICAgIGlmICghdnEtPnJlYWR5KQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOwo+IEBAIC0yMTgsMTAgKzIyMCwxOCBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX2Js
a193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAodnJpbmdoX25lZWRfbm90aWZ5X2lvdGxiKCZ2cS0+dnJpbmcpID4gMCkKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZyaW5naF9ub3RpZnkoJnZxLT52cmluZyk7Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgbG9jYWxfYmhfZW5hYmxlKCk7Cj4gKwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmICgrK3JlcXMgPiA0KSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXNjaGVkdWxlID0gdHJ1ZTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAg
fQo+ICAgICAgICAgfQo+ICBvdXQ6Cj4gICAgICAgICBzcGluX3VubG9jaygmdmRwYXNpbS0+bG9j
ayk7Cj4gKwo+ICsgICAgICAgaWYgKHJlc2NoZWR1bGUpCj4gKyAgICAgICAgICAgICAgIHNjaGVk
dWxlX3dvcmsoJnZkcGFzaW0tPndvcmspOwo+ICB9Cj4KPiAgc3RhdGljIHZvaWQgdmRwYXNpbV9i
bGtfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdm9pZCAqY29uZmlnKQo+IC0t
Cj4gMi4zNi4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
