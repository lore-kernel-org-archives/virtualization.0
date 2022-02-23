Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EDFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 947A060EFE;
	Wed, 23 Feb 2022 02:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NqhDOTjCqwX0; Wed, 23 Feb 2022 02:26:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F3BD860D87;
	Wed, 23 Feb 2022 02:26:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A857AC001A;
	Wed, 23 Feb 2022 02:26:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 032D8C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF0D5813F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cKETesBF6XjY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:26:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1BCD813F5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645583211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFBrVW2j7bgxrq7IKE3e6mJZ/d5bXY7U1H0yzf0NnOQ=;
 b=aSQ4Q+LBmkzserjABtze5Gg0kggrABSUmaVpcZPb08xlviyK4g1xisrmLSXGTuoN65xlDL
 DDHRLJdVdhFFcpxMn24RQRVRuPVd63N1+4XSTGw0YOYgxkR8qZ6QtHnv5jnXETWsW8e6uV
 RbELa4htEZqqLQYGCrumH++Zx1wknSY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-Ro83JwOYPKWsLx-uuqWgxA-1; Tue, 22 Feb 2022 21:26:50 -0500
X-MC-Unique: Ro83JwOYPKWsLx-uuqWgxA-1
Received: by mail-lj1-f199.google.com with SMTP id
 k33-20020a05651c062100b002460b0e948dso6726723lje.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HFBrVW2j7bgxrq7IKE3e6mJZ/d5bXY7U1H0yzf0NnOQ=;
 b=0OaUmZzzfkFzY3NlcnvwZaC/zfdly0HvMvsWjNRgsuKT56g3EBS8rwh/zBXl+cFjvl
 Dc15dhhhJBe9r9WJ/dCRcJ2c+8bx2m7OaF63btWvdn9b94H7SY+RNZegVzVyCyBrMh93
 oikv0J9/feIGvk6ePHoHRyzzqU2IrVXfnaZRrcpw6N3uHxY3L8f7DR59AOjlvUvDZcmX
 541H48FQmpYX7y7yUXC5ZRJHWb7mHmWg5NgJd71fpQdNIiwYEBhPHwdWMBOpznVPp+FU
 vdeUagw02vK0x9HxEeqGvesGPEv3CESlCy5nGaRy/WNVRlymRsnbXvU5v1iVYNbXPGXf
 npXg==
X-Gm-Message-State: AOAM5319t6sx+P0XOTMYl5IFy1ZYP8GzXGahJ2oK3Xxg4vSKr6SsUgEU
 zNaXTl5r7fMJa/lfjJQSMFACk9jjhAc2Ps51HtPsWSLu8Tah48DUMQ+kymNddaOgr6Wt7Y5LQlw
 CGuE4SGuFL5ACnOFytboFro/ysNSyUK7PIjV6YXIIJ5JE2FUAllJhX5l79w==
X-Received: by 2002:a2e:a885:0:b0:23a:30ac:5798 with SMTP id
 m5-20020a2ea885000000b0023a30ac5798mr20108264ljq.73.1645583208755; 
 Tue, 22 Feb 2022 18:26:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVBxswc3ZfjIgVcgr8VKwp0TmNSNXUykFxP8Cgjg2kuAqrwJwqJnKROea8cFBvfGMGsd/z+UlAWuBFyLqSIkA=
X-Received: by 2002:a2e:a885:0:b0:23a:30ac:5798 with SMTP id
 m5-20020a2ea885000000b0023a30ac5798mr20108242ljq.73.1645583208512; Tue, 22
 Feb 2022 18:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-19-eperezma@redhat.com>
 <62e877ca-51d7-da85-13c9-d469a85f33c9@redhat.com>
 <CAJaqyWfF01k3LntM7RLEmFcej=EY2d4+2MARKXPptQ2J7VnB9A@mail.gmail.com>
 <7c52e50a-4c8e-7865-1c3d-8b156986c13a@redhat.com>
 <CAJaqyWedqtzRW=ur7upchneSc-oOkvkr3FUph_BfphV3zTmnkw@mail.gmail.com>
 <7e72def5-a1e9-ad92-2c83-fda72ffd7b60@redhat.com>
 <CAJaqyWcHhMpjJ4kde1ejV5c_vP7_8PvfXpi5u9rdWuaORFt_zg@mail.gmail.com>
 <24717b73-7aca-dd75-22d4-2b8d9e6bd737@redhat.com>
 <CAJaqyWePWg+eeQjjcMh24k0K+yUQUF2x0yXH32tPPWEw_wYP0Q@mail.gmail.com>
In-Reply-To: <CAJaqyWePWg+eeQjjcMh24k0K+yUQUF2x0yXH32tPPWEw_wYP0Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 10:26:37 +0800
Message-ID: <CACGkMEsfKWw-sJWH0R+bV=UgdviQUTkY+FYQjNGx+OuBcQx4eA@mail.gmail.com>
Subject: Re: [PATCH 18/31] vhost: Shadow virtqueue buffers forwarding
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

T24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgNDo1NiBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCA4OjI2
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDl
nKggMjAyMi8yLzIxIOS4i+WNiDQ6MTUsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiA+
ID4gT24gTW9uLCBGZWIgMjEsIDIwMjIgYXQgODo0NCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4+Cj4gPiA+PiDlnKggMjAyMi8yLzE3IOS4i+WNiDg6NDgs
IEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiA+ID4+PiBPbiBUdWUsIEZlYiA4LCAyMDIy
IGF0IDk6MTYgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
Pj4+IOWcqCAyMDIyLzIvMSDkuIvljYg3OjI1LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6
Cj4gPiA+Pj4+PiBPbiBTdW4sIEphbiAzMCwgMjAyMiBhdCA3OjQ3IEFNIEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4+Pj4+IOWcqCAyMDIyLzEvMjIg5LiK5Y2I
NDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+ID4gPj4+Pj4+PiBAQCAtMjcyLDYgKzU5MCwy
OCBAQCB2b2lkIHZob3N0X3N2cV9zZXRfc3ZxX2tpY2tfZmQoVmhvc3RTaGFkb3dWaXJ0cXVldWUg
KnN2cSwgaW50IHN2cV9raWNrX2ZkKQo+ID4gPj4+Pj4+PiAgICAgIHZvaWQgdmhvc3Rfc3ZxX3N0
b3AoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSkKPiA+ID4+Pj4+Pj4gICAgICB7Cj4gPiA+Pj4+
Pj4+ICAgICAgICAgIGV2ZW50X25vdGlmaWVyX3NldF9oYW5kbGVyKCZzdnEtPnN2cV9raWNrLCBO
VUxMKTsKPiA+ID4+Pj4+Pj4gKyAgICBnX2F1dG9mcmVlIFZpcnRRdWV1ZUVsZW1lbnQgKm5leHRf
YXZhaWxfZWxlbSA9IE5VTEw7Cj4gPiA+Pj4+Pj4+ICsKPiA+ID4+Pj4+Pj4gKyAgICBpZiAoIXN2
cS0+dnEpIHsKPiA+ID4+Pj4+Pj4gKyAgICAgICAgcmV0dXJuOwo+ID4gPj4+Pj4+PiArICAgIH0K
PiA+ID4+Pj4+Pj4gKwo+ID4gPj4+Pj4+PiArICAgIC8qIFNlbmQgYWxsIHBlbmRpbmcgdXNlZCBk
ZXNjcmlwdG9ycyB0byBndWVzdCAqLwo+ID4gPj4+Pj4+PiArICAgIHZob3N0X3N2cV9mbHVzaChz
dnEsIGZhbHNlKTsKPiA+ID4+Pj4+PiBEbyB3ZSBuZWVkIHRvIHdhaXQgZm9yIGFsbCB0aGUgcGVu
ZGluZyBkZXNjcmlwdG9ycyB0byBiZSBjb21wbGV0ZWQgaGVyZT8KPiA+ID4+Pj4+Pgo+ID4gPj4+
Pj4gTm8sIHRoaXMgZnVuY3Rpb24gZG9lcyBub3Qgd2FpdCwgaXQgb25seSBjb21wbGV0ZXMgdGhl
IGZvcndhcmRpbmcgb2YKPiA+ID4+Pj4+IHRoZSAqdXNlZCogZGVzY3JpcHRvcnMuCj4gPiA+Pj4+
Pgo+ID4gPj4+Pj4gVGhlIGJlc3QgZXhhbXBsZSBpcyB0aGUgbmV0IHJ4IHF1ZXVlIGluIG15IG9w
aW5pb24uIFRoaXMgY2FsbCB3aWxsCj4gPiA+Pj4+PiBjaGVjayBTVlEncyB2cmluZyB1c2VkX2lk
eCBhbmQgd2lsbCBmb3J3YXJkIHRoZSBsYXN0IHVzZWQgZGVzY3JpcHRvcnMKPiA+ID4+Pj4+IGlm
IGFueSwgYnV0IGFsbCBhdmFpbGFibGUgZGVzY3JpcHRvcnMgd2lsbCByZW1haW4gYXMgYXZhaWxh
YmxlIGZvcgo+ID4gPj4+Pj4gcWVtdSdzIFZRIGNvZGUuCj4gPiA+Pj4+Pgo+ID4gPj4+Pj4gVG8g
c2tpcCBpdCB3b3VsZCBtaXNzIHRob3NlIGxhc3QgcnggZGVzY3JpcHRvcnMgaW4gbWlncmF0aW9u
Lgo+ID4gPj4+Pj4KPiA+ID4+Pj4+IFRoYW5rcyEKPiA+ID4+Pj4gU28gaXQncyBwcm9iYWJseSB0
byBub3QgdGhlIGJlc3QgcGxhY2UgdG8gYXNrLiBJdCdzIG1vcmUgYWJvdXQgdGhlCj4gPiA+Pj4+
IGluZmxpZ2h0IGRlc2NyaXB0b3JzIHNvIGl0IHNob3VsZCBiZSBUWCBpbnN0ZWFkIG9mIFJYLgo+
ID4gPj4+Pgo+ID4gPj4+PiBJIGNhbiBpbWFnaW5lIHRoZSBtaWdyYXRpb24gbGFzdCBwaGFzZSwg
d2Ugc2hvdWxkIHN0b3AgdGhlIHZob3N0LXZEUEEKPiA+ID4+Pj4gYmVmb3JlIGNhbGxpbmcgdmhv
c3Rfc3ZxX3N0b3AoKS4gVGhlbiB3ZSBzaG91bGQgYmUgZmluZSByZWdhcmRsZXNzIG9mCj4gPiA+
Pj4+IGluZmxpZ2h0IGRlc2NyaXB0b3JzLgo+ID4gPj4+Pgo+ID4gPj4+IEkgdGhpbmsgSSdtIHN0
aWxsIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUuCj4gPiA+Pj4KPiA+ID4+PiBUbyBiZSBvbiB0aGUg
c2FtZSBwYWdlLiBSZWdhcmRpbmcgdHggdGhpcyBjb3VsZCBjYXVzZSByZXBlYXRlZCB0eAo+ID4g
Pj4+IGZyYW1lcyAob25lIGF0IHNvdXJjZSBhbmQgb3RoZXIgYXQgZGVzdGluYXRpb24pLCBidXQg
bmV2ZXIgYSBtaXNzZWQKPiA+ID4+PiBidWZmZXIgbm90IHRyYW5zbWl0dGVkLiBUaGUgInN0b3Ag
YmVmb3JlIiBjb3VsZCBiZSBpbnRlcnByZXRlZCBhcyAiU1ZRCj4gPiA+Pj4gaXMgbm90IGZvcndh
cmRpbmcgYXZhaWxhYmxlIGJ1ZmZlcnMgYW55bW9yZSIuIFdvdWxkIHRoYXQgd29yaz8KPiA+ID4+
Cj4gPiA+PiBSaWdodCwgYnV0IHRoaXMgb25seSB3b3JrIGlmCj4gPiA+Pgo+ID4gPj4gMSkgYSBm
bHVzaCB0byBtYWtlIHN1cmUgVFggRE1BIGZvciBpbmZsaWdodCBkZXNjcmlwdG9ycyBhcmUgYWxs
IGNvbXBsZXRlZAo+ID4gPj4KPiA+ID4+IDIpIGp1c3QgbWFyayBhbGwgaW5mbGlnaHQgZGVzY3Jp
cHRvciB1c2VkCj4gPiA+Pgo+ID4gPiBJdCBjdXJyZW50bHkgdHJ1c3RzIG9uIHRoZSByZXZlcnNl
OiBCdWZmZXJzIG5vdCBtYXJrZWQgYXMgdXNlZCAoYnkgdGhlCj4gPiA+IGRldmljZSkgd2lsbCBi
ZSBhdmFpbGFibGUgaW4gdGhlIGRlc3RpbmF0aW9uLCBzbyBleHBlY3QKPiA+ID4gcmV0cmFuc21p
c3Npb25zLgo+ID4KPiA+Cj4gPiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgSSB0aGluayB3ZSBk
byBtaWdyYXRlIGxhc3RfYXZhaWxfaWR4LiBTbyB0aGVyZQo+ID4gd29uJ3QgYmUgYSByZS10cmFu
c21pc3Npb24sIHNpbmNlIHdlIGRlcGVuZCBvbiBxZW11IHZpcnRxdWV1ZSBjb2RlIHRvCj4gPiBk
ZWFsIHdpdGggdnJpbmcgYmFzZT8KPiA+Cj4KPiBPbiBzdG9wLCB2aG9zdF92aXJ0cXVldWVfc3Rv
cCBjYWxscyB2aG9zdF92ZHBhX2dldF92cmluZ19iYXNlLiBJbiBTVlEKPiBtb2RlLCBpdCByZXR1
cm5zIGxhc3RfdXNlZF9pZHguIEFmdGVyIHRoYXQsIHZob3N0LmMgY29kZSBzZXQgVmlydFF1ZXVl
Cj4gbGFzdF9hdmFpbF9pZHggPT0gbGFzdF91c2VkX2lkeCwgYW5kIGl0J3MgbWlncmF0ZWQgYWZ0
ZXIgdGhhdCBpZiBJJ20KPiBub3Qgd3JvbmcuCgpPaywgSSBtaXNzIHRoZXNlIGRldGFpbHMgaW4g
dGhlIHJldmlldy4gSSBzdWdnZXN0IG1lbnRpb25pbmcgdGhpcyBpbgp0aGUgY2hhbmdlIGxvZyBh
bmQgYWRkIGEgY29tbWVudCBpbiB2aG9zdF92ZHBhX2dldF92cmluZ19iYXNlKCkuCgo+Cj4gdmhv
c3Qga2VybmVsIG1pZ3JhdGVzIGxhc3RfYXZhaWxfaWR4LCBidXQgaXQgbWFrZXMgcnggYnVmZmVy
cwo+IGF2YWlsYWJsZSBvbi1kZW1hbmQsIHVubGlrZSBTVlEuIFNvIGl0IGRvZXMgbm90IG5lZWQg
dG8gdW53aW5kIGJ1ZmZlcnMKPiBvciBhbnl0aGluZyBsaWtlIHRoYXQuIEJlY2F1c2Ugb2YgaG93
IFNWUSB3b3JrcyB3aXRoIHRoZSByeCBxdWV1ZSwKPiB0aGlzIGlzIG5vdCBwb3NzaWJsZSwgc2lu
Y2UgdGhlIGRlc3RpbmF0aW9uIHdpbGwgZmluZCBubyBhdmFpbGFibGUKPiBidWZmZXJzIGZvciBy
eC4gQW5kIGZvciB0eCB5b3UgYWxyZWFkeSBoYXZlIGRlc2NyaWJlZCB0aGUgc2NlbmFyaW8uCj4K
PiBJbiBvdGhlciB3b3Jkcywgd2UgY2Fubm90IHNlZSBTVlEgYXMgYSB2aG9zdCBkZXZpY2UgaW4g
dGhhdCByZWdhcmQ6Cj4gU1ZRIGxvb2tzIGZvciB0b3RhbCBkcmFpbiAoYXMgIm1ha2UgYWxsIGd1
ZXN0J3MgYnVmZmVycyBhdmFpbGFibGUgZm9yCj4gdGhlIGRldmljZSBBU0FQIikgdnMgdGhlIHZo
b3N0IGRldmljZSB3aGljaCBjYW4gbGl2ZSB3aXRoIGEgbG90IG9mCj4gYXZhaWxhYmxlIG9uZXMg
YW5kIGl0IHdpbGwgdXNlIHRoZW0gb24gZGVtYW5kLiBTYW1lIHByb2JsZW0gYXMKPiBtYXNraW5n
LiBTbyB0aGUgZGlmZmVyZW5jZSBpbiBiZWhhdmlvciBpcyBqdXN0aWZpZWQgaW4gbXkgb3Bpbmlv
biwgYW5kCj4gaXQgY2FuIGJlIGltcHJvdmVkIGluIHRoZSBmdXR1cmUgd2l0aCB0aGUgdmRwYSBp
bi1mbGlnaHQgZGVzY3JpcHRvcnMuCj4KPiBJZiB3ZSByZXN0b3JlIHRoZSBzdGF0ZSB0aGF0IHdh
eSBpbiBhIHZpcnRpby1uZXQgZGV2aWNlLCBpdCB3aWxsIHNlZQo+IHRoZSBhdmFpbGFibGUgb25l
cyBhcyBleHBlY3RlZCwgbm90IGFzIGluLWZsaWdodC4KPgo+IEFub3RoZXIgcG9zc2liaWxpdHkg
aXMgdG8gdHJhbnNmb3JtIGFsbCBvZiB0aGVzZSBpbnRvIGluLWZsaWdodCBvbmVzLAo+IGJ1dCBJ
IGZlZWwgaXQgd291bGQgY3JlYXRlIHByb2JsZW1zLiBDYW4gd2UgbWlncmF0ZSBhbGwgcnggcXVl
dWVzIGFzCj4gaW4tZmxpZ2h0LCB3aXRoIDAgYnl0ZXMgd3JpdHRlbj8gSXMgaXQgd29ydGggaXQ/
CgpUbyBjbGFyaWZ5LCBmb3IgaW5mbGlnaHQgSSBtZWFudCBmcm9tIHRoZSBkZXZpY2UgcG9pbnQg
b2YgdmlldywgdGhhdAppcyBbbGFzdF91c2VkX2lkeCwgbGFzdF9hdmFpbF9pZHgpLgoKU28gZm9y
IFJYIGFuZCBTVlEsIGl0IHNob3VsZCBiZSBhcyBzaW1wbGUgYXMgc3RvcCBmb3J3YXJkaW5nIGJ1
ZmZlcnMKc2luY2UgbGFzdF91c2VkX2lkeCBzaG91bGQgYmUgdGhlIHNhbWUgYXMgbGFzdF9hdmFp
bF9pZHggaW4gdGhpcyBjYXNlLgooVGhvdWdoIHRlY2huaWNhbGx5IHRoZSByeCBidWZmZXIgbWln
aHQgYmUgbW9kaWZpZWQgYnkgdGhlIE5JQykuCgo+IEkgZGlkbid0IGludmVzdGlnYXRlCj4gdGhh
dCBwYXRoIHRvbyBtdWNoLCBidXQgSSB0aGluayB0aGUgdmlydGlvLW5ldCBlbXVsYXRlZCBkZXZp
Y2UgZG9lcwo+IG5vdCBzdXBwb3J0IHRoYXQgYXQgdGhlIG1vbWVudC4gSWYgSSdtIG5vdCB3cm9u
Zywgd2Ugc2hvdWxkIGNvcHkKPiBzb21ldGhpbmcgbGlrZSB0aGUgYm9keSBvZiB2aXJ0aW9fYmxr
X2xvYWRfZGV2aWNlIGlmIHdlIHdhbnQgdG8gZ28KPiB0aGF0IHJvdXRlLgo+Cj4gVGhlIGN1cnJl
bnQgYXBwcm9hY2ggbWlnaHQgYmUgdG9vIG5ldC1jZW50cmljLCBzbyBsZXQgbWUga25vdyBpZiB0
aGlzCj4gYmVoYXZpb3IgaXMgdW5leHBlY3RlZCBvciB3ZSBjYW4gZG8gYmV0dGVyIG90aGVyd2lz
ZS4KCkl0IHNob3VsZCBiZSBmaW5lIHRvIHN0YXJ0IGZyb20gYSBuZXR3b3JraW5nIGRldmljZS4g
V2UgY2FuIGFkZCBtb3JlCmluIHRoZSBmdXR1cmUgaWYgaXQgaXMgbmVlZGVkLgoKVGhhbmtzCgo+
Cj4gVGhhbmtzIQo+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+ID4gPgo+ID4gPiBUaGFua3MhCj4gPiA+
Cj4gPiA+PiBPdGhlcndpc2UgdGhlcmUgY291bGQgYmUgYnVmZmVycyB0aGF0IGlzIGluZmxpZ2h0
IGZvcmV2ZXIuCj4gPiA+Pgo+ID4gPj4gVGhhbmtzCj4gPiA+Pgo+ID4gPj4KPiA+ID4+PiBUaGFu
a3MhCj4gPiA+Pj4KPiA+ID4+Pj4gVGhhbmtzCj4gPiA+Pj4+Cj4gPiA+Pj4+Cj4gPiA+Pj4+Pj4g
VGhhbmtzCj4gPiA+Pj4+Pj4KPiA+ID4+Pj4+Pgo+ID4gPj4+Pj4+PiArCj4gPiA+Pj4+Pj4+ICsg
ICAgZm9yICh1bnNpZ25lZCBpID0gMDsgaSA8IHN2cS0+dnJpbmcubnVtOyArK2kpIHsKPiA+ID4+
Pj4+Pj4gKyAgICAgICAgZ19hdXRvZnJlZSBWaXJ0UXVldWVFbGVtZW50ICplbGVtID0gTlVMTDsK
PiA+ID4+Pj4+Pj4gKyAgICAgICAgZWxlbSA9IGdfc3RlYWxfcG9pbnRlcigmc3ZxLT5yaW5nX2lk
X21hcHNbaV0pOwo+ID4gPj4+Pj4+PiArICAgICAgICBpZiAoZWxlbSkgewo+ID4gPj4+Pj4+PiAr
ICAgICAgICAgICAgdmlydHF1ZXVlX2RldGFjaF9lbGVtZW50KHN2cS0+dnEsIGVsZW0sIGVsZW0t
Pmxlbik7Cj4gPiA+Pj4+Pj4+ICsgICAgICAgIH0KPiA+ID4+Pj4+Pj4gKyAgICB9Cj4gPiA+Pj4+
Pj4+ICsKPiA+ID4+Pj4+Pj4gKyAgICBuZXh0X2F2YWlsX2VsZW0gPSBnX3N0ZWFsX3BvaW50ZXIo
JnN2cS0+bmV4dF9ndWVzdF9hdmFpbF9lbGVtKTsKPiA+ID4+Pj4+Pj4gKyAgICBpZiAobmV4dF9h
dmFpbF9lbGVtKSB7Cj4gPiA+Pj4+Pj4+ICsgICAgICAgIHZpcnRxdWV1ZV9kZXRhY2hfZWxlbWVu
dChzdnEtPnZxLCBuZXh0X2F2YWlsX2VsZW0sCj4gPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBuZXh0X2F2YWlsX2VsZW0tPmxlbik7Cj4gPiA+Pj4+Pj4+ICsgICAg
fQo+ID4gPj4+Pj4+PiAgICAgIH0KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
