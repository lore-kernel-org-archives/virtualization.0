Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B6DC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 10:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F2E0F408B4;
	Tue,  8 Nov 2022 10:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2E0F408B4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SQfTRdmP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tSvHWrGbdwQ; Tue,  8 Nov 2022 10:18:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48CA140191;
	Tue,  8 Nov 2022 10:18:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48CA140191
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9CBC0032;
	Tue,  8 Nov 2022 10:18:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8181C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F60E4029B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F60E4029B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bgl8vtmWILlR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3621940191
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3621940191
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667902679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cF+8y1hQLR1XQYB6z4AKH7Ufuu5GHf8+qc+tJznnmzM=;
 b=SQfTRdmPY9tJS5F+yAdPqhCiJxhH9s8lAJpPAi6vMqNflUj8Lk6kt4EqGQphkKqPVwGOSm
 jkIRfUnb7B3lZ/nb/600S5oyIKO0a7BDkdqE4zUHUspvChProwoEk9qQ0F8T5ycohQ/Rus
 hBd+6PLMyzP7AG2I/+N1JBjLwyNwP+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-Gp2742yeMwODnpttwtl9xw-1; Tue, 08 Nov 2022 05:17:50 -0500
X-MC-Unique: Gp2742yeMwODnpttwtl9xw-1
Received: by mail-wm1-f69.google.com with SMTP id
 v125-20020a1cac83000000b003cfa148576dso3808616wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 02:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cF+8y1hQLR1XQYB6z4AKH7Ufuu5GHf8+qc+tJznnmzM=;
 b=hS5coq/4hJuLqbKxa2qZSAfDwbKTWhpioBu1T0aO4Xmh3ib7O1cKntG+lifE/HpwWF
 pVKEM2WhZiOhLuJrKrmNVHx9YkxKoTA2uUmwwpReMsS/vQ3w1JIjyl/O3wKSm1E3Kmny
 ObHJICGR6yD8LPBg0Z+/m3TigD66HZRg/YwoNZRLkqVG8b/M4Q3zD7eRfhL5R3Hwaoep
 n7wf4eDMOw/WP3+oQVyE2uwaII2tJw9FcJwXK6aZGlfKDp4sBCKzBpyc0uiBpxrfhY7A
 XkDdnS2Xg3+uqWuldNcgqLCqHhmMZ4KgAm2P0s3jcjrtXq0QlZNHFXG98n+ezCeymYVk
 xFyA==
X-Gm-Message-State: ACrzQf22fEJUGtb55qHeX5pzXcDjJx3vccwDvvpvpMRAzSbOpeglDO7y
 wTZdrfarVouQMAFOToXooFINYlaOVkaou+q3xVHj8rPjincR0miNTmB+aAR2sBXy+2EfWl9qgED
 DZ5ZYxJq+EQ4f3bkXnAxseuZ2MlXN1SGU3tcf5+aJSw==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id
 c7-20020a05600c0a4700b003a658484bdemr45840881wmq.189.1667902669069; 
 Tue, 08 Nov 2022 02:17:49 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6qjMk7Q2aU+OW7rdNY0NXXzOdM9Qok9tzwuYqCSRhR1WPENKApNbIQikvl2g7GYLIb6cuaWw==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id
 c7-20020a05600c0a4700b003a658484bdemr45840863wmq.189.1667902668850; 
 Tue, 08 Nov 2022 02:17:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a7bc381000000b003c6b874a0dfsm12609043wmj.14.2022.11.08.02.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Nov 2022 02:17:48 -0800 (PST)
Message-ID: <7105abc8-85d1-63a4-7f77-a2b3e0177b6f@redhat.com>
Date: Tue, 8 Nov 2022 11:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
 <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
 <20221108041820-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20221108041820-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eric.auger.pro@gmail.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgTWljaGFlbCwgSmFzb24sCgpPbiAxMS84LzIyIDEwOjMxLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gT24gVHVlLCBOb3YgMDgsIDIwMjIgYXQgMDU6MTM6NTBQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPj4gT24gVHVlLCBOb3YgOCwgMjAyMiBhdCA0OjU2IFBNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4gT24gVHVlLCBOb3YgMDgsIDIwMjIg
YXQgMTE6MDk6MzZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+PiBPbiBUdWUsIE5vdiA4
LCAyMDIyIGF0IDc6MDYgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Pj4+IE9uIE1vbiwgTm92IDA3LCAyMDIyIGF0IDEwOjEwOjA2UE0gKzAxMDAsIEVyaWMg
QXVnZXIgd3JvdGU6Cj4+Pj4+PiBIaSBNaWNoYWVsLAo+Pj4+Pj4gT24gMTEvNy8yMiAyMTo0Miwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4+IE9uIE1vbiwgTm92IDA3LCAyMDIyIGF0
IDA5OjM0OjMxUE0gKzAxMDAsIEVyaWMgQXVnZXIgd3JvdGU6Cj4+Pj4+Pj4+IFdoZW4gdGhlIHZo
b3N0IGlvdGxiIGlzIHVzZWQgYWxvbmcgd2l0aCBhIGd1ZXN0IHZpcnR1YWwgaW9tbXUKPj4+Pj4+
Pj4gYW5kIHRoZSBndWVzdCBnZXRzIHJlYm9vdGVkLCBzb21lIE1JU1MgbWVzc2FnZXMgbWF5IGhh
dmUgYmVlbgo+Pj4+Pj4+PiByZWNvcmRlZCBqdXN0IGJlZm9yZSB0aGUgcmVib290IGFuZCBzcHVy
aW91c2x5IGV4ZWN1dGVkIGJ5Cj4+Pj4+Pj4+IHRoZSB2aXJ0dWFsIGlvbW11IGFmdGVyIHRoZSBy
ZWJvb3QuIERlc3BpdGUgdGhlIGRldmljZSBpb3RsYiBnZXRzCj4+Pj4+Pj4+IHJlLWluaXRpYWxp
emVkLCB0aGUgbWVzc2FnZXMgYXJlIG5vdCBjbGVhcmVkLiBGaXggdGhhdCBieSBjYWxsaW5nCj4+
Pj4+Pj4+IHZob3N0X2NsZWFyX21zZygpIGF0IHRoZSBlbmQgb2Ygdmhvc3RfaW5pdF9kZXZpY2Vf
aW90bGIoKS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPgo+Pj4+Pj4+PiAtLS0KPj4+Pj4+Pj4gIGRyaXZlcnMvdmhvc3Qv
dmhvc3QuYyB8IDEgKwo+Pj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+
Pj4+Pj4+Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2
ZXJzL3Zob3N0L3Zob3N0LmMKPj4+Pj4+Pj4gaW5kZXggNDAwOTc4MjZjZmYwLi40MjJhMWZkZWUw
Y2EgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+Pj4+Pj4+PiAr
KysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4+Pj4+Pj4gQEAgLTE3NTEsNiArMTc1MSw3IEBA
IGludCB2aG9zdF9pbml0X2RldmljZV9pb3RsYihzdHJ1Y3Qgdmhvc3RfZGV2ICpkLCBib29sIGVu
YWJsZWQpCj4+Pj4+Pj4+ICAgIH0KPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgdmhvc3RfaW90bGJfZnJl
ZShvaW90bGIpOwo+Pj4+Pj4+PiArICB2aG9zdF9jbGVhcl9tc2coZCk7Cj4+Pj4+Pj4+Cj4+Pj4+
Pj4+ICAgIHJldHVybiAwOwo+Pj4+Pj4+PiAgfQo+Pj4+Pj4+IEhtbS4gIENhbid0IG1lc3NhZ2Vz
IG1lYW53aGlsZSBnZXQgcHJvY2Vzc2VzIGFuZCBhZmZlY3QgdGhlCj4+Pj4+Pj4gbmV3IGlvdGxi
Pwo+Pj4+Pj4gSXNuJ3QgdGhlIG1zZyBwcm9jZXNzaW5nIHN0b3BwZWQgYXQgdGhlIG1vbWVudCB0
aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZAo+Pj4+Pj4gKFZIT1NUX1NFVF9GRUFUVVJFUyk/Cj4+Pj4+
Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4gRXJpYwo+Pj4+PiBJdCdzIHByZXR0eSBsYXRl
IGhlcmUgSSdtIG5vdCBzdXJlLiAgWW91IHRlbGwgbWUgd2hhdCBwcmV2ZW50cyBpdC4KPj4+PiBT
byB0aGUgcHJvcG9zZWQgY29kZSBhc3N1bWVzIHRoYXQgUWVtdSBkb2Vzbid0IHByb2Nlc3MgZGV2
aWNlIElPVExCCj4+Pj4gYmVmb3JlIFZIT1NUX1NFVF9GRUFFVFVSRVMuIENvbnNpZGVyIHRoZXJl
J3Mgbm8gcmVzZXQgaW4gdGhlIGdlbmVyYWwKPj4+PiB2aG9zdCB1QVBJLCAgSSB3b25kZXIgaWYg
aXQncyBiZXR0ZXIgdG8gbW92ZSB0aGUgY2xlYXIgdG8gZGV2aWNlIGNvZGUKPj4+PiBsaWtlIFZI
T1NUX05FVF9TRVRfQkFDS0VORC4gU28gd2UgY2FuIGNsZWFyIGl0IHBlciB2cT8KPj4+IEhtbSB0
aGlzIG1ha2VzIG5vIHNlbnNlIHRvIG1lLiBpb21tdSBzaXRzIGJldHdlZW4gYmFja2VuZAo+Pj4g
YW5kIGZyb250ZW5kLiBUeWluZyBvbmUgdG8gYW5vdGhlciBpcyBnb2luZyB0byBiYWNrZmlyZS4K
Pj4gSSB0aGluayB3ZSBuZWVkIHRvIGVtdWxhdGUgd2hhdCByZWFsIGRldmljZXMgYXJlIGRvaW5n
LiBEZXZpY2Ugc2hvdWxkCj4+IGNsZWFyIHRoZSBwYWdlIGZhdWx0IG1lc3NhZ2UgZHVyaW5nIHJl
c2V0LCBzbyB0aGUgZHJpdmVyIHdvbid0IHJlYWQKPj4gYW55dGhpbmcgYWZ0ZXIgcmVzZXQuIEJ1
dCB3ZSBkb24ndCBoYXZlIGEgcGVyIGRldmljZSBzdG9wIG9yIHJlc2V0Cj4+IG1lc3NhZ2UgZm9y
IHZob3N0LW5ldC4gVGhhdCdzIHdoeSB0aGUgVkhPU1RfTkVUX1NFVF9CQUNLRU5EIGNhbWUgaW50
bwo+PiBteSBtaW5kLgo+IFRoYXQncyBub3QgYSByZXNldCBtZXNzYWdlLiBVc2Vyc3BhY2UgY2Fu
IHN3aXRjaCBiYWNrZW5kcyBhdCB3aWxsLgo+IEkgZ3Vlc3Mgd2UgY291bGQgY2hlY2sgd2hlbiBi
YWNrZW5kIGlzIHNldCB0byAtMS4KPiBJdCdzIGEgaGFjayBidXQgbWlnaHQgd29yay4KPgo+Pj4g
SSdtIHRoaW5raW5nIG1vcmUgYWxvbmcgdGhlIGxpbmVzIG9mIGRvaW5nIGV2ZXJ5dGhpbmcKPj4+
IHVuZGVyIGlvdGxiX2xvY2suCj4+IEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgd2UgbmVlZCB0byBm
aW5kIGEgcHJvcGVyIHBsYWNlIHRvIGNsZWFyIHRoZQo+PiBtZXNzYWdlLiBTbyBJIGRvbid0IGdl
dCBob3cgaW90bGJfbG9jayBjYW4gaGVscDogdGhlIG1lc3NhZ2UgY291bGQgYmUKPj4gc3RpbGwg
cmVhZCBmcm9tIHVzZXIgc3BhY2UgYWZ0ZXIgdGhlIGJhY2tlbmQgaXMgc2V0IHRvIE5VTEwuCj4+
Cj4+IFRoYW5rcwo+IFdlbGwgSSB0aGluayB0aGUgcmVhbCBwcm9ibGVtIGlzIHRoaXMuCj4KPiB2
aG9zdF9uZXRfc2V0X2ZlYXR1cmVzIGRvZXM6Cj4KPiAgICAgICAgIGlmICgoZmVhdHVyZXMgJiAo
MVVMTCA8PCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkgewo+ICAgICAgICAgICAgICAgICBp
ZiAodmhvc3RfaW5pdF9kZXZpY2VfaW90bGIoJm4tPmRldiwgdHJ1ZSkpCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBvdXRfdW5sb2NrOwo+ICAgICAgICAgfQo+Cj4KPiBzbyB3ZSBnZXQg
YSBuZXcgaW90bGIgZWFjaCB0aW1lIGZlYXR1cmVzIGFyZSBzZXQuCj4KPiBCdXQgZmVhdHVyZXMg
Y2FuIGJlIGNoYW5nZXMgd2hpbGUgZGV2aWNlIGlzIHJ1bm5pbmcuCj4gRS5nLgo+IAlWSE9TVF9G
X0xPR19BTEwKPgo+Cj4gTGV0J3MganVzdCBzYXkgdGhpcyBoYWNrIG9mIHJldXNpbmcgZmVhdHVy
ZSBiaXRzIGZvciBiYWNrZW5kCj4gd2FzIG5vdCBteSBicmlnaHRlc3QgaWRlYSA6KAo+CgpJc24n
dCB2aG9zdF9pbml0X2RldmljZV9pb3RsYigpIHJhY3kgdGhlbiwgYXMgZC0+aW90bGIgaXMgZmly
c3QgdXBkYXRlZCB3aXRoIG5pb3RsYiBhbmQgbGF0ZXIgZC0+dnFzW2ldLT5pb3RsYiBpcyB1cGRh
dGVkIHdpdGggbmlvdGxiLiBXaGF0IGRvZXMgZ2FyYW50ZWUgdGhpcyBpcyBkb25lIGF0b21pY2Fs
bHk/CgpTaG91bGRuJ3Qgd2UgaG9sZCB0aGUgZGV2LT5tdXRleCB0byBtYWtlIGFsbCB0aGUgc2Vx
dWVuY2UgYXRvbWljIGFuZAppbmNsdWRlIHZob3N0X2NsZWFyX21zZygpP8KgIENhbid0IHRoZSB2
aG9zdF9jbGVhcl9tc2coKSB0YWtlIHRoZSBkZXYgbG9jaz8KClRoYW5rcwoKRXJpYwoKPgo+Cj4K
Pj4+Cj4+Pgo+Pj4+PiBCVFcgdmhvc3RfaW5pdF9kZXZpY2VfaW90bGIgZ2V0cyBlbmFibGVkIHBh
cmFtZXRlciBidXQgaWdub3Jlcwo+Pj4+PiBpdCwgd2UgcmVhbGx5IHNob3VsZCBkcm9wIHRoYXQu
Cj4+Pj4gWWVzLgo+Pj4+Cj4+Pj4+IEFsc28sIGl0IGxvb2tzIGxpa2UgaWYgZmVhdHVyZXMgYXJl
IHNldCB3aXRoIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQo+Pj4+PiBhbmQgdGhlbiBjbGVhcmVk
LCBpb3RsYiBpcyBub3QgcHJvcGVybHkgY2xlYXJlZCAtIGJ1Zz8KPj4+PiBOb3Qgc3VyZSwgb2xk
IElPVExCIG1heSBzdGlsbCB3b3JrLiBCdXQgZm9yIHNhZmV0eSwgd2UgbmVlZCB0byBkaXNhYmxl
Cj4+Pj4gZGV2aWNlIElPVExCIGluIHRoaXMgY2FzZS4KPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+
Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pj4gLS0KPj4+Pj4+Pj4gMi4zNy4zCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
