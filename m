Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449EEC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3CA384299;
	Wed,  9 Mar 2022 09:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnjONGMopAOT; Wed,  9 Mar 2022 09:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4286484295;
	Wed,  9 Mar 2022 09:02:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04B43C001D;
	Wed,  9 Mar 2022 09:02:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BBF3C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3674084297
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GuOzEhZyMkH4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:02:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B4BE84295
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646816551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5aObMD6Ok3RFIxMTKg8qnF6qbjrqHlGEfR26y0Xh7So=;
 b=hUepXG8ZPBG6A/PFxWhKoHq5UqLHTlQLyLuluVE7GP6ddqI03nl31knlP1z8s6P2IpTTpr
 J1JHoOPrDR9mOKVlvBbFNxbheHRqtZEBtINxE7am9qQkF2kXqlw7gzl6Mwi6Ndz+yY1AlC
 FHmniMCJ/ozsA5JyldnsLq0/Frntyn8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-jlvNHBxlNdqTvjaEYk_UMA-1; Wed, 09 Mar 2022 04:02:28 -0500
X-MC-Unique: jlvNHBxlNdqTvjaEYk_UMA-1
Received: by mail-wr1-f69.google.com with SMTP id
 o9-20020adfca09000000b001ea79f7edf8so524442wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 01:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5aObMD6Ok3RFIxMTKg8qnF6qbjrqHlGEfR26y0Xh7So=;
 b=kP+7ivAj2UV+99rtHW2dWIbMXTgdu1n6AWL6OvXKPilegpD821u+FbS39PaHV06jM4
 Qn2IyKJFsnn/GLHTOnKKrJLPJQUtN29rJzJuaRunYcWJn2qPPCjMBU7jslin/rxNX1Oy
 Ht2PQHSJE5Zr7WCY55l8D9DTcblIPSMKO1iuHAt/Js2D1cfkv7HW+V3kjMo17756WGs8
 uiddZcV+z3awmzmdlTidLytCLHunfMKSKddcLfAfzQe/F47Zb0AyJA82mfKtJ0GwJBAE
 hNIbQZTPVv2Qyc+xiJTIrhi2yqNajnN78MTZYl2dbHHU8Q3jPM2jNZA0m6Cc66UtiRaA
 Bxew==
X-Gm-Message-State: AOAM533ndcelhuvxZG2pDdWxpRyNo/N7P4FzcBnb4Q65kFIRqwzRlS6p
 QsYcZf9DnAfroTabPZqYoT8sh2oTl4njJPMiiLOoGZYz5PdK6IrcoZS75PN1vhGA0Q0LMbWW76b
 Y3l+olauEoi6hDk5Uvp45Ct91Pt4QU1TpiYx7xfAs0w==
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id
 w3-20020a05600018c300b001e582d3e4e2mr14993278wrq.575.1646816547191; 
 Wed, 09 Mar 2022 01:02:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/K3pXZ+ppWTfZ6/r7oUGokhYCJ/UF0RyQUca34snHdSOK5obfoBIbDyvpSzzrgemP9xZiVA==
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id
 w3-20020a05600018c300b001e582d3e4e2mr14993243wrq.575.1646816546861; 
 Wed, 09 Mar 2022 01:02:26 -0800 (PST)
Received: from redhat.com ([2.55.46.250]) by smtp.gmail.com with ESMTPSA id
 u10-20020adfa18a000000b001f04c24afe7sm1094077wru.41.2022.03.09.01.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 01:02:26 -0800 (PST)
Date: Wed, 9 Mar 2022 04:02:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v7 00/26] virtio pci support VIRTIO_F_RING_RESET
Message-ID: <20220309035751-mutt-send-email-mst@kernel.org>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <2c823fed-8024-39e7-f6f5-176fb518fc1a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2c823fed-8024-39e7-f6f5-176fb518fc1a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 platform-driver-x86@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBNYXIgMDksIDIwMjIgYXQgMTI6NDU6NTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi8zLzgg5LiL5Y2IODozNCwgWHVhbiBaaHVvIOWGmemBkzoKPiA+IFRo
ZSB2aXJ0aW8gc3BlYyBhbHJlYWR5IHN1cHBvcnRzIHRoZSB2aXJ0aW8gcXVldWUgcmVzZXQgZnVu
Y3Rpb24uIFRoaXMgcGF0Y2ggc2V0Cj4gPiBpcyB0byBhZGQgdGhpcyBmdW5jdGlvbiB0byB0aGUg
a2VybmVsLiBUaGUgcmVsZXZhbnQgdmlydGlvIHNwZWMgaW5mb3JtYXRpb24gaXMKPiA+IGhlcmU6
Cj4gPiAKPiA+ICAgICAgaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlYy9p
c3N1ZXMvMTI0Cj4gPiAKPiA+IEFsc28gcmVnYXJkaW5nIE1NSU8gc3VwcG9ydCBmb3IgcXVldWUg
cmVzZXQsIEkgcGxhbiB0byBzdXBwb3J0IGl0IGFmdGVyIHRoaXMKPiA+IHBhdGNoIGlzIHBhc3Nl
ZC4KPiA+IAo+ID4gUGVyZm9ybWluZyByZXNldCBvbiBhIHF1ZXVlIGlzIGRpdmlkZWQgaW50byBm
b3VyIHN0ZXBzOgo+ID4gICAgICAgMS4gdmlydGlvX3Jlc2V0X3ZxKCkgICAgICAgICAgICAgIC0g
bm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQgdGhlIHF1ZXVlCj4gPiAgICAgICAyLiB2aXJ0cXVl
dWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xlIHRoZSBidWZmZXIgc3VibWl0dGVkCj4g
PiAgICAgICAzLiB2aXJ0cXVldWVfcmVzZXRfdnJpbmcoKSAgICAgICAgLSByZXNldCB0aGUgdnJp
bmcgKG1heSByZS1hbGxvYykKPiA+ICAgICAgIDQuIHZpcnRpb19lbmFibGVfcmVzZXRxKCkgICAg
ICAgICAtIG1tYXAgdnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBxdWV1ZQo+ID4gCj4g
PiBUaGUgZmlyc3QgcGFydCAxLTE3IG9mIHRoaXMgcGF0Y2ggc2V0IGltcGxlbWVudHMgdmlydGlv
IHBjaSdzIHN1cHBvcnQgYW5kIEFQSQo+ID4gZm9yIHF1ZXVlIHJlc2V0LiBUaGUgbGF0dGVyIHBh
cnQgaXMgdG8gbWFrZSB2aXJ0aW8tbmV0IHN1cHBvcnQgc2V0X3JpbmdwYXJhbS4gRG8KPiA+IHRo
ZXNlIHRoaW5ncyBmb3IgdGhpcyBmZWF0dXJlOgo+ID4gCj4gPiAgICAgICAgMS4gdmlydGlvLW5l
dCBzdXBwb3J0IHJ4LHR4IHJlc2V0Cj4gPiAgICAgICAgMi4gZmluZF92cXMoKSBzdXBwb3J0IHRv
IHNwZWNpYWwgdGhlIG1heCBzaXplIG9mIGVhY2ggdnEKPiA+ICAgICAgICAzLiB2aXJ0aW8tbmV0
IHN1cHBvcnQgc2V0X3JpbmdwYXJhbQo+ID4gCj4gPiAjMSAtIzMgOiAgICAgICBwcmVwYXJlCj4g
PiAjNCAtIzEyOiAgICAgICB2aXJ0aW8gcmluZyBzdXBwb3J0IHJlc2V0IHZyaW5nIG9mIHRoZSB2
cQo+ID4gIzEzLSMxNDogICAgICAgYWRkIGhlbHBlcgo+ID4gIzE1LSMxNzogICAgICAgdmlydGlv
IHBjaSBzdXBwb3J0IHJlc2V0IHF1ZXVlIGFuZCByZS1lbmFibGUKPiA+ICMxOC0jMjE6ICAgICAg
IGZpbmRfdnFzKCkgc3VwcG9ydCBzaXplcyB0byBzcGVjaWFsIHRoZSBtYXggc2l6ZSBvZiBlYWNo
IHZxCj4gPiAjMjMtIzI0OiAgICAgICB2aXJ0aW8tbmV0IHN1cHBvcnQgcngsIHR4IHJlc2V0Cj4g
PiAjMjIsICMyNSwgIzI2OiB2aXJ0aW8tbmV0IHN1cHBvcnQgc2V0IHJpbmdwYXJhbQo+ID4gCj4g
PiBUZXN0IGVudmlyb25tZW50Ogo+ID4gICAgICBIb3N0OiA0LjE5LjkxCj4gPiAgICAgIFFlbXU6
IFFFTVUgZW11bGF0b3IgdmVyc2lvbiA2LjIuNTAgKHdpdGggdnEgcmVzZXQgc3VwcG9ydCkKPiA+
ICAgICAgVGVzdCBDbWQ6ICBldGh0b29sIC1HIGV0aDEgcnggJDEgdHggJDI7IGV0aHRvb2wgLWcg
ZXRoMQo+ID4gCj4gPiAgICAgIFRoZSBkZWZhdWx0IGlzIHNwbGl0IG1vZGUsIG1vZGlmeSBRZW11
IHZpcnRpby1uZXQgdG8gYWRkIFBBQ0tFRCBmZWF0dXJlIHRvIHRlc3QKPiA+ICAgICAgcGFja2Vk
IG1vZGUuCj4gPiAKPiA+IAo+ID4gUGxlYXNlIHJldmlldy4gVGhhbmtzLgo+ID4gCj4gPiB2NzoK
PiA+ICAgIDEuIGZpeCAjNiBzdWJqZWN0IHR5cG8KPiA+ICAgIDIuIGZpeCAjNiByaW5nX3NpemVf
aW5fYnl0ZXMgaXMgdW5pbml0aWFsaXplZAo+ID4gICAgMy4gY2hlY2sgYnk6IG1ha2UgVz0xMgo+
ID4gCj4gPiB2NjoKPiA+ICAgIDEuIHZpcnRpb19wY2k6IHVzZSBzeW5jaHJvbml6ZV9pcnEoaXJx
KSB0byBzeW5jIHRoZSBpcnEgY2FsbGJhY2tzCj4gPiAgICAyLiBJbnRyb2R1Y2UgdmlydHF1ZXVl
X3Jlc2V0X3ZyaW5nKCkgdG8gaW1wbGVtZW50IHRoZSByZXNldCBvZiB2cmluZyBkdXJpbmcKPiA+
ICAgICAgIHRoZSByZXNldCBwcm9jZXNzLiBNYXkgdXNlIHRoZSBvbGQgdnJpbmcgaWYgbnVtIG9m
IHRoZSB2cSBub3QgY2hhbmdlLgo+ID4gICAgMy4gZmluZF92cXMoKSBzdXBwb3J0IHNpemVzIHRv
IHNwZWNpYWwgdGhlIG1heCBzaXplIG9mIGVhY2ggdnEKPiA+IAo+ID4gdjU6Cj4gPiAgICAxLiBh
ZGQgdmlydGlvLW5ldCBzdXBwb3J0IHNldF9yaW5ncGFyYW0KPiA+IAo+ID4gdjQ6Cj4gPiAgICAx
LiBqdXN0IHRoZSBjb2RlIG9mIHZpcnRpbywgd2l0aG91dCB2aXJ0aW8tbmV0Cj4gPiAgICAyLiBQ
ZXJmb3JtaW5nIHJlc2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIHRoZXNlIHN0ZXBzOgo+
ID4gICAgICAxLiByZXNldF92cTogcmVzZXQgb25lIHZxCj4gPiAgICAgIDIuIHJlY3ljbGUgdGhl
IGJ1ZmZlciBmcm9tIHZxIGJ5IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZigpCj4gPiAgICAg
IDMuIHJlbGVhc2UgdGhlIHJpbmcgb2YgdGhlIHZxIGJ5IHZyaW5nX3JlbGVhc2VfdmlydHF1ZXVl
KCkKPiA+ICAgICAgNC4gZW5hYmxlX3Jlc2V0X3ZxOiByZS1lbmFibGUgdGhlIHJlc2V0IHF1ZXVl
Cj4gPiAgICAzLiBTaW1wbGlmeSB0aGUgcGFyYW1ldGVycyBvZiBlbmFibGVfcmVzZXRfdnEoKQo+
ID4gICAgNC4gYWRkIGNvbnRhaW5lciBzdHJ1Y3R1cmVzIGZvciB2aXJ0aW9fcGNpX2NvbW1vbl9j
ZmcKPiA+IAo+ID4gdjM6Cj4gPiAgICAxLiBrZWVwIHZxLCBpcnEgdW5yZWxlYXNlZAo+IAo+IAo+
IFRoZSBzZXJpZXMgYmVjYW1lIGtpbmQgb2YgaHVnZS4KPiAKPiBJJ2Qgc3VnZ2VzdCB0byBzcGxp
dCBpdCBpbnRvIHR3byBzZXJpZXMuCj4gCj4gMSkgcmVmYWN0b3Jpbmcgb2YgdGhlIHZpcnRpb19y
aW5nIHRvIHByZXBhcmUgZm9yIHRoZSByZXNpemUKPiAyKSB0aGUgcmVzZXQgc3VwcG9ydCArIHZp
cnRpby1uZXQgc3VwcG9ydAo+IAo+IFRoYW5rcwoKCkFuZCBqdXN0IHRvIGNsYXJpZnksIEkgdGhp
bmsgeW91IG1lYW4gYWxsIHRoZSAiZXh0cmFjdCBsb2dpYyIKdGhpbmdzIG5lZWQgdG8gYWxzbyBn
byBpbnRvIHRoZSByZWZhY3RvcmluZyBwYXJ0LCByaWdodD8KSnVzdCBtYWtpbmcgMyBmaXJzdCBw
YXRjaGVzIGEgc2VyaWVzIGJ5IHRoZW1zZWx2ZXMgd29uJ3QgaGVscCAuLi4KSSdtIGtpbmQgb2Yg
YW1iaXZhbGVudCBvbiB0aGUgc3BsaXR1cCAtIGJvdGggcGFydHMKbmVlZCB3b3JrIGZvciBub3cs
IHNvIEkgd29uZGVyIGhvdyBkb2VzIGl0IGhlbHAuCkJ1dCBpZiB5b3UgY2FyZSBhYm91dCBpdCwg
SSBkb24ndCBtaW5kLgoKPiA+IAo+ID4gKioqIEJMVVJCIEhFUkUgKioqCgoKWW91IGRvbid0IHdh
bnQgdGhpcyBpbiB5b3VyIGNvdmVyIGxldHRlcnMgYnR3LgoKPiA+IFh1YW4gWmh1byAoMjYpOgo+
ID4gICAgdmlydGlvX3BjaTogc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBhZGQgcXVldWVf
bm90aWZ5X2RhdGEKPiA+ICAgIHZpcnRpbzogcXVldWVfcmVzZXQ6IGFkZCBWSVJUSU9fRl9SSU5H
X1JFU0VUCj4gPiAgICB2aXJ0aW86IGFkZCBoZWxwZXIgdmlydHF1ZXVlX2dldF92cmluZ19tYXhf
c2l6ZSgpCj4gPiAgICB2aXJ0aW9fcmluZzogc3BsaXQ6IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIGNy
ZWF0aW5nIHZyaW5nCj4gPiAgICB2aXJ0aW9fcmluZzogc3BsaXQ6IGV4dHJhY3QgdGhlIGxvZ2lj
IG9mIGluaXQgdnEgYW5kIGF0dGFjaCB2cmluZwo+ID4gICAgdmlydGlvX3Jpbmc6IHBhY2tlZDog
ZXh0cmFjdCB0aGUgbG9naWMgb2YgY3JlYXRpbmcgdnJpbmcKPiA+ICAgIHZpcnRpb19yaW5nOiBw
YWNrZWQ6IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIGluaXQgdnEgYW5kIGF0dGFjaCB2cmluZwo+ID4g
ICAgdmlydGlvX3Jpbmc6IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIGZyZWVpbmcgdnJpbmcKPiA+ICAg
IHZpcnRpb19yaW5nOiBzcGxpdDogaW1wbGVtZW50IHZpcnRxdWV1ZV9yZXNldF92cmluZ19zcGxp
dCgpCj4gPiAgICB2aXJ0aW9fcmluZzogcGFja2VkOiBpbXBsZW1lbnQgdmlydHF1ZXVlX3Jlc2V0
X3ZyaW5nX3BhY2tlZCgpCj4gPiAgICB2aXJ0aW9fcmluZzogaW50cm9kdWNlIHZpcnRxdWV1ZV9y
ZXNldF92cmluZygpCj4gPiAgICB2aXJ0aW9fcmluZzogdXBkYXRlIHRoZSBkb2N1bWVudCBvZiB0
aGUgdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmCj4gPiAgICAgIGZvciBxdWV1ZSByZXNldAo+
ID4gICAgdmlydGlvOiBxdWV1ZV9yZXNldDogc3RydWN0IHZpcnRpb19jb25maWdfb3BzIGFkZCBj
YWxsYmFja3MgZm9yCj4gPiAgICAgIHF1ZXVlX3Jlc2V0Cj4gPiAgICB2aXJ0aW86IGFkZCBoZWxw
ZXIgZm9yIHF1ZXVlIHJlc2V0Cj4gPiAgICB2aXJ0aW9fcGNpOiBxdWV1ZV9yZXNldDogdXBkYXRl
IHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgYW5kCj4gPiAgICAgIG9wdGlvbiBmdW5jdGlv
bnMKPiA+ICAgIHZpcnRpb19wY2k6IHF1ZXVlX3Jlc2V0OiBleHRyYWN0IHRoZSBsb2dpYyBvZiBh
Y3RpdmUgdnEgZm9yIG1vZGVybiBwY2kKPiA+ICAgIHZpcnRpb19wY2k6IHF1ZXVlX3Jlc2V0OiBz
dXBwb3J0IFZJUlRJT19GX1JJTkdfUkVTRVQKPiA+ICAgIHZpcnRpbzogZmluZF92cXMoKSBhZGQg
YXJnIHNpemVzCj4gPiAgICB2aXJ0aW9fcGNpOiBzdXBwb3J0IHRoZSBhcmcgc2l6ZXMgb2YgZmlu
ZF92cXMoKQo+ID4gICAgdmlydGlvX21taW86IHN1cHBvcnQgdGhlIGFyZyBzaXplcyBvZiBmaW5k
X3ZxcygpCj4gPiAgICB2aXJ0aW86IGFkZCBoZWxwZXIgdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXpl
KCkKPiA+ICAgIHZpcnRpb19uZXQ6IGdldCByaW5ncGFyYW0gYnkgdmlydHF1ZXVlX2dldF92cmlu
Z19tYXhfc2l6ZSgpCj4gPiAgICB2aXJ0aW9fbmV0OiBzcGxpdCBmcmVlX3VudXNlZF9idWZzKCkK
PiA+ICAgIHZpcnRpb19uZXQ6IHN1cHBvcnQgcngvdHggcXVldWUgcmVzZXQKPiA+ICAgIHZpcnRp
b19uZXQ6IHNldCB0aGUgZGVmYXVsdCBtYXggcmluZyBzaXplIGJ5IGZpbmRfdnFzKCkKPiA+ICAg
IHZpcnRpb19uZXQ6IHN1cHBvcnQgc2V0X3JpbmdwYXJhbQo+ID4gCj4gPiAgIGFyY2gvdW0vZHJp
dmVycy92aXJ0aW9fdW1sLmMgICAgICAgICAgICAgfCAgIDIgKy0KPiA+ICAgZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jICAgICAgICAgICAgICAgICB8IDI1NyArKysrKysrKy0tCj4gPiAgIGRyaXZl
cnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtdG1maWZvLmMgfCAgIDMgKy0KPiA+ICAgZHJpdmVy
cy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMgICB8ICAgMiArLQo+ID4gICBkcml2ZXJz
L3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYyAgICAgICAgIHwgICAyICstCj4gPiAgIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19tbWlvLmMgICAgICAgICAgICAgfCAgMTIgKy0KPiA+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyAgICAgICB8ICAyOCArLQo+ID4gICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oICAgICAgIHwgICAzICstCj4gPiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgICAgICAgfCAgIDggKy0KPiA+ICAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyAgICAgICB8IDE0NiArKysrKy0KPiA+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgICB8ICAzNiArKwo+ID4gICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jICAgICAgICAgICAgIHwgNTg0ICsrKysrKysrKysrKysrKysrLS0t
LS0tCj4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgICAgICAgICAgICAgfCAgIDIg
Ky0KPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICAgICAgICAgICAgICB8ICAxMiAr
Cj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oICAgICAgICAgICAgfCAgNzQgKyst
Cj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaCAgICAgICAgfCAgIDIgKwo+
ID4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oICAgICAgIHwgICA3ICstCj4g
PiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggICAgICAgICAgfCAgMTQgKwo+ID4g
ICAxOCBmaWxlcyBjaGFuZ2VkLCA5NzkgaW5zZXJ0aW9ucygrKSwgMjE1IGRlbGV0aW9ucygtKQo+
ID4gCj4gPiAtLQo+ID4gMi4zMS4wCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
