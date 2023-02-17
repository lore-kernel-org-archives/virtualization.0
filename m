Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7327DC05027
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 05:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E214C40477;
	Fri, 17 Feb 2023 05:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E214C40477
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5/NiHk1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0ZyRw5sT8KN; Fri, 17 Feb 2023 05:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 479C9402EB;
	Fri, 17 Feb 2023 05:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 479C9402EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0EE7C0032;
	Fri, 17 Feb 2023 05:58:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F074C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 495A781FFA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 495A781FFA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5/NiHk1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B1YZUqaxbwe5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:58:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6504381FF9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6504381FF9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676613515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AP6C42/R8qAU0hxuIDM9Qu5qLKgmQO/4/XMSMYshv0=;
 b=S5/NiHk1z4OHIjq2ZxDvxuqEfTO2n3eVSPPZi3drWBNt5fYaTxfg8Vdkegy3/a8r3QHsKH
 SqHGYYcMZy/jaT46wTWAyrn2JbGSSinSgz6d9XMOKyFaM3hP+WUu51iEjgFPXk6u850ih9
 gjYXb/yG9FjYXxHTv3+FJiEF19xTxGY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-dtQglB5tOm-RfgxdIvah2Q-1; Fri, 17 Feb 2023 00:58:33 -0500
X-MC-Unique: dtQglB5tOm-RfgxdIvah2Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 q14-20020a056808200e00b0037ab5869804so1440981oiw.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 21:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AP6C42/R8qAU0hxuIDM9Qu5qLKgmQO/4/XMSMYshv0=;
 b=wa0KseDxFCWWW5ul3WD7v9H5GJlKi7wNDlqL7M6v/ppT9zAtmi+EdWrF5P3ErDyof1
 CRyGEYis8E37rht5QSn2sy12HiqSBzzszRvvWuHfmyLpUjhWU/jQaE/+YvGuwuQBVKwM
 zMyPbKalNfAmwB6ovcp8gWV5GkTcFvYAMMXu9D3Zeds202DUHCC7HwOt7NwhJkO9IWUQ
 Utq+XXpHQLSI5Bqi1nVttZFKgNguu4zned6hPjMFzRZ3CU9urxqEnOVV4X/6zh9rowzk
 eim5SzvGrHI2mr6emOmmvgXyGlv0A72kqjcLDAJmFe+ad/ek3flGmK9ruTDl4R49sm9q
 +V5g==
X-Gm-Message-State: AO0yUKWrFXIfZz1lMFZdkG/70+V1qKR0P2OruN72AeJMxITEOdy+2xHJ
 5XQ5/QTNom6Kz3ZNfzXs3R/PkDxS0dtG/OPcmOO46Wz25tY0ogXczxpQhJrk5PGWAtcQ23CZ+dF
 tt69B4zAAPZ9KAn5GAq6j+o750Jwcf0opqFXlhOJNA5lLXvN+GA/ugZdoZg==
X-Received: by 2002:a05:6871:84ca:b0:16a:2c1a:e416 with SMTP id
 sw10-20020a05687184ca00b0016a2c1ae416mr306280oab.35.1676613512984; 
 Thu, 16 Feb 2023 21:58:32 -0800 (PST)
X-Google-Smtp-Source: AK7set/DTnvWghD6LBzagHT2oVxIZ6Em4f+Zu8NAzl7w3xSe64tyl3U9v4dN2LtkQFyqeyCmiGccmvpI6xdxSkvo8c8=
X-Received: by 2002:a05:6871:84ca:b0:16a:2c1a:e416 with SMTP id
 sw10-20020a05687184ca00b0016a2c1ae416mr306274oab.35.1676613512767; Thu, 16
 Feb 2023 21:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20230131145310.2069-1-longpeng2@huawei.com>
 <db99245c-606a-2f24-52fe-836a6972437f@redhat.com>
 <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
 <CACGkMEt0Rgkcmt9k4dWsp-qqtPvrM40mtgmSERc0A7Ve1wzKHw@mail.gmail.com>
 <ad0ab6b8-1e1e-f686-eb5c-78cc63869c54@huawei.com>
 <CACGkMEsOWmVGA1RYTNZybmzkz53g5cYEkJeMK_9uuQu-ezZcqg@mail.gmail.com>
 <af95c38d-fdca-aef0-55ae-bbb0baee6029@huawei.com>
In-Reply-To: <af95c38d-fdca-aef0-55ae-bbb0baee6029@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Feb 2023 13:58:21 +0800
Message-ID: <CACGkMEt8TL=fc6tUfb7BTXTSsLZa=K39znJcFqpNhy7Oaw5s6A@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: cleanup memory maps when closing vdpa fds
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBGZWIgMTUsIDIwMjMgYXQgMToxNiBQTSBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5m
cmFzdHJ1Y3R1cmUKU2VydmljZSBQcm9kdWN0IERlcHQuKSA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+
IHdyb3RlOgo+Cj4KPgo+IOWcqCAyMDIzLzIvMTUgMTA6NTYsIEphc29uIFdhbmcg5YaZ6YGTOgo+
ID4gT24gV2VkLCBGZWIgMTUsIDIwMjMgYXQgMTA6NDkgQU0gTG9uZ3BlbmcgKE1pa2UsIENsb3Vk
IEluZnJhc3RydWN0dXJlCj4gPiBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pIDxsb25ncGVuZzJAaHVh
d2VpLmNvbT4gd3JvdGU6Cj4gPj4KPiA+Pgo+ID4+Cj4gPj4g5ZyoIDIwMjMvMi8xNSAxMDowMCwg
SmFzb24gV2FuZyDlhpnpgZM6Cj4gPj4+IE9uIFR1ZSwgRmViIDE0LCAyMDIzIGF0IDI6MjggUE0g
TG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlCj4gPj4+IFNlcnZpY2UgUHJvZHVj
dCBEZXB0LikgPGxvbmdwZW5nMkBodWF3ZWkuY29tPiB3cm90ZToKPiA+Pj4+Cj4gPj4+Pgo+ID4+
Pj4KPiA+Pj4+IOWcqCAyMDIzLzIvMTQgMTQ6MTYsIEphc29uIFdhbmcg5YaZ6YGTOgo+ID4+Pj4+
Cj4gPj4+Pj4g5ZyoIDIwMjMvMS8zMSAyMjo1MywgTG9uZ3BlbmcoTWlrZSkg5YaZ6YGTOgo+ID4+
Pj4+PiBGcm9tOiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gPj4+Pj4+Cj4gPj4+
Pj4+IFdlIG11c3QgY2xlYW51cCBhbGwgbWVtb3J5IG1hcHMgd2hlbiBjbG9zaW5nIHRoZSB2ZHBh
IGZkcywgb3RoZXJ3aXNlCj4gPj4+Pj4+IHNvbWUgY3JpdGljYWwgcmVzb3VyY2VzIChlLmcuIG1l
bW9yeSwgaW9tbXUgbWFwKSB3aWxsIGxlYWtlZCBpZiB0aGUKPiA+Pj4+Pj4gdXNlcnNwYWNlIGV4
aXRzIHVuZXhwZWN0ZWRseSAoZS5nLiBraWxsIC05KS4KPiA+Pj4+Pgo+ID4+Pj4+Cj4gPj4+Pj4g
U291bmRzIGxpa2UgYSBidWcgb2YgdGhlIGtlcm5lbCwgc2hvdWxkIHdlIGZpeCB0aGVyZT8KPiA+
Pj4+Pgo+ID4+Pj4KPiA+Pj4+IEZvciBleGFtcGxlLCB0aGUgaW9tbXUgbWFwIGlzIHNldHVwIHdo
ZW4gUUVNVSBjYWxscyBWSE9TVF9JT1RMQl9VUERBVEUKPiA+Pj4+IGlvY3RsIGFuZCBpdCdsbCBi
ZSBmcmVlZCBpZiBRRU1VIGNhbGxzIFZIT1NUX0lPVExCX0lOVkFMSURBVEUgaW9jdGwuCj4gPj4+
Pgo+ID4+Pj4gU28gbWF5YmUgd2UgcmVsZWFzZSB0aGVzZSByZXNvdXJjZXMgaW4gdmRwYSBmcmFt
ZXdvcmsgaW4ga2VybmVsIGlzIGEKPiA+Pj4+IHN1aXRhYmxlIGNob2ljZT8KPiA+Pj4KPiA+Pj4g
SSB0aGluayBJIG5lZWQgdW5kZXJzdGFuZCB3aGF0IGRvZXMgInJlc291cmNlcyIgbWVhbiBoZXJl
Ogo+ID4+Pgo+ID4+PiBGb3IgaW9tbXUgbWFwcGluZywgaXQgc2hvdWxkIGJlIGZyZWVkIGJ5IHZo
b3N0X3ZkcGFfZnJlZV9kb21haW4oKSBpbgo+ID4+PiB2aG9zdF92ZHBhX3JlbGVhc2UoKT8KPiA+
Pj4KPiA+Pgo+ID4+IFBsZWFzZSBjb25zaWRlciB0aGUgZm9sbG93aW5nIGxpZmVjeWNsZSBvZiB0
aGUgdmRwYSBkZXZpY2U6Cj4gPj4KPiA+PiAxLiB2aG9zdF92ZHBhX29wZW4KPiA+PiAgICAgICB2
aG9zdF92ZHBhX2FsbG9jX2RvbWFpbgo+ID4+Cj4gPj4gMi4gdmhvc3RfdmRwYV9wYV9tYXAKPiA+
PiAgICAgICBwaW5fdXNlcl9wYWdlcwo+ID4+ICAgICAgIHZob3N0X3ZkcGFfbWFwCj4gPj4gICAg
ICAgICBpb21tdV9tYXAKPiA+Pgo+ID4+IDMuIGtpbGwgUUVNVQo+ID4+Cj4gPj4gNC4gdmhvc3Rf
dmRwYV9yZWxlYXNlCj4gPj4gICAgICAgdmhvc3RfdmRwYV9mcmVlX2RvbWFpbgo+ID4+Cj4gPj4g
SW4gdGhpcyBjYXNlLCB3ZSBoYXZlIG5vIG9wcG9ydHVuaXR5IHRvIGludm9rZSB1bnBpbl91c2Vy
X3BhZ2VzIG9yCj4gPj4gaW9tbXVfdW5tYXAgdG8gZnJlZSB0aGUgbWVtb3J5Lgo+ID4KPiA+IFdl
IGRvOgo+ID4KPiA+IHZob3N0X3ZkcGFfY2xlYW51cCgpCj4gPiAgICAgIHZob3N0X3ZkcGFfcmVt
b3ZlX2FzKCkKPiA+ICAgICAgICAgIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAoKQo+ID4gICAgICAg
ICAgICAgIHZob3N0X3ZkcGFfcGFfdW5tYXAoKQo+ID4gICAgICAgICAgICAgICAgICB1bnBpbl91
c2VyX3BhZ2VzKCkKPiA+ICAgICAgICAgICAgICAgICAgdmhvc3RfdmRwYV9nZW5lcmFsX3VubWFw
KCkKPiA+ICAgICAgICAgICAgICAgICAgICAgIGlvbW11X3VubWFwKCkKPiA+ID8KPiA+Cj4gT2gs
IG15IGNvZGViYXNlIGlzIGxpbnV4LTYuMi1yYzIgYW5kIHRoZSBjb21taXQgYzA3MGMxOTEyYTgg
KHZob3N0LXZkcGE6Cj4gZml4IGFuIGlvdGxiIG1lbW9yeSBsZWFrKSBhbHJlYWR5IGZpeGVkIHRo
aXMgYnVnIGluIGxpbnV4LTYuMi1yYzMuCj4KPiA+IEJ0dywgaXQgbG9va3MgbGlrZSB3ZSBzaG91
bGQgY2FsbCB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKCkgKmFmdGVyKgo+ID4gdmhvc3RfdmRwYV9j
bGVhbnVwKCkgb3RoZXJ3aXNlIGl0J3MgYSBVQUY/Cj4gPgo+IEkgdGhpbmsgc28sIHRoZSB2LT5k
b21haW4gaXMgc2V0IHRvIE5VTEwgaW4gdmhvc3RfdmRwYV9mcmVlX2RvbWFpbigpLCBpdAo+IHNl
ZW1zIHdvdWxkIHRyaWdnZXIgbnVsbC1wb2ludGVyIGFjY2VzcyBpbiBteSBjYXNlLgoKUGF0Y2gg
YXJlIHdlbGNvbWVkLgoKVGhhbmtzCgo+Cj4gPiBUaGFua3MKPiA+Cj4gPj4KPiA+Pj4gc3RhdGlj
IGludCB2aG9zdF92ZHBhX3JlbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUg
KmZpbGVwKQo+ID4+PiB7Cj4gPj4+ICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGZp
bGVwLT5wcml2YXRlX2RhdGE7Cj4gPj4+ICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkID0g
JnYtPnZkZXY7Cj4gPj4+Cj4gPj4+ICAgICAgICAgICBtdXRleF9sb2NrKCZkLT5tdXRleCk7Cj4g
Pj4+ICAgICAgICAgICBmaWxlcC0+cHJpdmF0ZV9kYXRhID0gTlVMTDsKPiA+Pj4gICAgICAgICAg
IHZob3N0X3ZkcGFfY2xlYW5faXJxKHYpOwo+ID4+PiAgICAgICAgICAgdmhvc3RfdmRwYV9yZXNl
dCh2KTsKPiA+Pj4gICAgICAgICAgIHZob3N0X2Rldl9zdG9wKCZ2LT52ZGV2KTsKPiA+Pj4gICAg
ICAgICAgIHZob3N0X3ZkcGFfZnJlZV9kb21haW4odik7Cj4gPj4+ICAgICAgICAgICB2aG9zdF92
ZHBhX2NvbmZpZ19wdXQodik7Cj4gPj4+ICAgICAgICAgICB2aG9zdF92ZHBhX2NsZWFudXAodik7
Cj4gPj4+ICAgICAgICAgICBtdXRleF91bmxvY2soJmQtPm11dGV4KTsKPiA+Pj4KPiA+Pj4gICAg
ICAgICAgIGF0b21pY19kZWMoJnYtPm9wZW5lZCk7Cj4gPj4+ICAgICAgICAgICBjb21wbGV0ZSgm
di0+Y29tcGxldGlvbik7Cj4gPj4+Cj4gPj4+ICAgICAgICAgICByZXR1cm4gMDsKPiA+Pj4gfQo+
ID4+Pgo+ID4+Pj4KPiA+Pj4+IEJ5IHRoZSB3YXksIEphc29uLCBjYW4geW91IHJlcHJvZHVjZSB0
aGUgcHJvYmxlbSBpbiB5b3VyIG1hY2hpbmU/Cj4gPj4+Pgo+ID4+Pgo+ID4+PiBIYXZlbid0IGdv
dCB0aW1lIGluIGRvaW5nIHRoaXMgYnV0IGl0IHNob3VsZCBiZSB0aGUgcmVzcG9uc2liaWxpdHkg
b2YKPiA+Pj4gdGhlIGF1dGhvciB0byB2YWxpZGF0ZSB0aGlzIGFueWhvdy4KPiA+Pj4KPiA+Pj4g
VGhhbmtzCj4gPj4+Cj4gPj4+Pj4gVGhhbmtzCj4gPj4+Pj4KPiA+Pj4+Pgo+ID4+Pj4+Pgo+ID4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gPj4+
Pj4+IC0tLQo+ID4+Pj4+PiAgICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAxMyArKysrKysrKysr
KysrCj4gPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+ID4+Pj4+
Pgo+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+ID4+Pj4+PiBpbmRleCBhNTI3ZWVlYWM2MzcuLjM3NDc3Y2ZmYTVhYSAxMDA2
NDQKPiA+Pj4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+Pj4+Pj4gKysrIGIvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiA+Pj4+Pj4gQEAgLTgyMyw2ICs4MjMsMTggQEAgc3RhdGljIHZv
aWQgdmhvc3RfdmRwYV91bm1hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiA+Pj4+Pj4gICAgICAg
ICAgICAgdmhvc3RfdmRwYV9yZW1vdmVfYXModiwgYXNpZCk7Cj4gPj4+Pj4+ICAgICB9Cj4gPj4+
Pj4+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX2NsZWFuX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAq
dikKPiA+Pj4+Pj4gK3sKPiA+Pj4+Pj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAqYXM7Cj4g
Pj4+Pj4+ICsgICAgdTMyIGFzaWQ7Cj4gPj4+Pj4+ICsKPiA+Pj4+Pj4gKyAgICBmb3IgKGFzaWQg
PSAwOyBhc2lkIDwgdi0+dmRwYS0+bmFzOyBhc2lkKyspIHsKPiA+Pj4+Pj4gKyAgICAgICAgYXMg
PSBhc2lkX3RvX2FzKHYsIGFzaWQpOwo+ID4+Pj4+PiArICAgICAgICBpZiAoYXMpCj4gPj4+Pj4+
ICsgICAgICAgICAgICB2aG9zdF92ZHBhX3VubWFwKHYsICZhcy0+aW90bGIsIDBVTEwsIDBVTEwg
LSAxKTsKPiA+Pj4+Pj4gKyAgICB9Cj4gPj4+Pj4+ICt9Cj4gPj4+Pj4+ICsKPiA+Pj4+Pj4gICAg
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV92YV9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSwgdTY0IHVhZGRyLCB1
MzIgcGVybSkKPiA+Pj4+Pj4gQEAgLTEyNDcsNiArMTI1OSw3IEBAIHN0YXRpYyBpbnQgdmhvc3Rf
dmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9kZQo+ID4+Pj4+PiAqaW5vZGUsIHN0cnVjdCBmaWxlICpm
aWxlcCkKPiA+Pj4+Pj4gICAgICAgICB2aG9zdF92ZHBhX2NsZWFuX2lycSh2KTsKPiA+Pj4+Pj4g
ICAgICAgICB2aG9zdF92ZHBhX3Jlc2V0KHYpOwo+ID4+Pj4+PiAgICAgICAgIHZob3N0X2Rldl9z
dG9wKCZ2LT52ZGV2KTsKPiA+Pj4+Pj4gKyAgICB2aG9zdF92ZHBhX2NsZWFuX21hcCh2KTsKPiA+
Pj4+Pj4gICAgICAgICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKHYpOwo+ID4+Pj4+PiAgICAgICAg
IHZob3N0X3ZkcGFfY29uZmlnX3B1dCh2KTsKPiA+Pj4+Pj4gICAgICAgICB2aG9zdF92ZHBhX2Ns
ZWFudXAodik7Cj4gPj4+Pj4KPiA+Pj4+PiAuCj4gPj4+Pgo+ID4+Pgo+ID4+PiAuCj4gPj4KPiA+
Cj4gPiAuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
