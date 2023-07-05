Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E4EC001B0
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 07:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 466C381991;
	Wed,  5 Jul 2023 07:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 466C381991
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f43qxRKQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nKvqK6s_Z5jJ; Wed,  5 Jul 2023 07:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A25B2818D4;
	Wed,  5 Jul 2023 07:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A25B2818D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75EE5C0071;
	Wed,  5 Jul 2023 07:32:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D87EFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EE9660F67
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:32:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EE9660F67
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f43qxRKQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id azhGicY7sXHk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:32:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE86B60EFC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE86B60EFC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688542338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpXcof6e+BEvTuo7jhma98S398OVQl9+DVwfc6QCMT4=;
 b=f43qxRKQ89Yeo1RFDJEZqUFlAXN4r5HChT8td+Lgv6mslcB7f3V+B52VPJV8v694geAXR0
 v/khaL/0jyisJa7Av6jkLZ3eyqLLAoqjYyq1bNYlkNaEtOrbPCODtbUW4vIhxJWp34QCqA
 apC+vDkQI3dC7QowGVEIEUE3EbdJo3Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-tiYJBNj5M9y-Fv6Kdzw1Zg-1; Wed, 05 Jul 2023 03:32:17 -0400
X-MC-Unique: tiYJBNj5M9y-Fv6Kdzw1Zg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6cf671d94so45105271fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 00:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688542335; x=1691134335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpXcof6e+BEvTuo7jhma98S398OVQl9+DVwfc6QCMT4=;
 b=CI2nVmKMnWwVfstme1qf+Un0OI/8CyUJhS47JaVdKTu2vGi8+t79d3/9bhIUAGJvk7
 INVs4M7Dhjrl66fOqaGMu0hanmV+IN54vtAN2jp/GKeixVal+++SiPFJq06tbgBQkr1h
 /oWV7sPo9hqm4q3GujlRzGmKAXOQu5+BnOU5DM0AsQ55cS/hCLh5FitTf6VVSy0a2TOQ
 c2WH2oBzruyQImD0lWOzKnz17dsr2R1IMZssHuKt/8Rj1MJLYKQyy+GPufJDnOkf2N+V
 MrLQoXB5S/sneag7BQdsaXBf3/L8QPO+JDCBGrZxtzvyCg5BbhJlfOqfehA5qQi0thS7
 3ByA==
X-Gm-Message-State: ABy/qLaA/V+Hwo/0FOZjPiMBiR19/45QBjebg4yoPgy4oxWgTk2hZF2u
 i2yY0vejYL0Fc0d6YRklEHlNGtJXSHzyBu+4EhQhHt4Q5IfxxcG3QIWkjcLnmQIL++5QICVceOC
 oamoTRPxJdnvGMG3bAB1Nr36827bXV0Etmv7W42cIrdh/5aQyLez0OBe7gw==
X-Received: by 2002:a2e:8892:0:b0:2b1:b4e9:4c3 with SMTP id
 k18-20020a2e8892000000b002b1b4e904c3mr10723495lji.2.1688542335750; 
 Wed, 05 Jul 2023 00:32:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGFPQCI0pR0rWAmR/5AnhlrGyPnyA739M1MIRYMOx+r3LB2JLgEwWudYvjCiBhK4EUn+0ZzigXYDg36Dp8q61A=
X-Received: by 2002:a2e:8892:0:b0:2b1:b4e9:4c3 with SMTP id
 k18-20020a2e8892000000b002b1b4e904c3mr10723481lji.2.1688542335448; Wed, 05
 Jul 2023 00:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
 <20230704061356-mutt-send-email-mst@kernel.org>
 <CACGkMEtAfiODhHEMFDKkaVFVs1yjfUFsjfy_=p8Jtd6BXAE1xQ@mail.gmail.com>
 <20230705012917-mutt-send-email-mst@kernel.org>
 <CACGkMEtBjTmChSQX_E_n6yvTi9rxH5UrXgfAU5qZsFAF-RZQWw@mail.gmail.com>
 <20230705021447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230705021447-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 15:32:04 +0800
Message-ID: <CACGkMEswyCWbXnLnm-i5ydp27kmQDvxF3gEfHhU_t0HJ7g+4Wg@mail.gmail.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, leiyang@redhat.com
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

T24gV2VkLCBKdWwgNSwgMjAyMyBhdCAyOjE24oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwMTo0Nzo0NFBN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gV2VkLCBKdWwgNSwgMjAyMyBhdCAxOjMx
4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IE9uIFdlZCwgSnVsIDA1LCAyMDIzIGF0IDAxOjExOjM3UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCA2OjE24oCvUE0gTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24g
TW9uLCBKdWwgMDMsIDIwMjMgYXQgMDU6MjY6MDJQTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90ZToK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gNy8zLzIwMjMgODo0NiBBTSwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAy
MDIzIGF0IDA0OjI1OjE0UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gT2ZmZXIgdGhpcyBiYWNrZW5kIGZlYXR1cmUgYXMgbWx4NSBpcyBjb21wYXRpYmxlIHdp
dGggaXQuIEl0IGFsbG93cyBpdAo+ID4gPiA+ID4gPiA+ID4gdG8gZG8gbGl2ZSBtaWdyYXRpb24g
d2l0aCBDVlEsIGR5bmFtaWNhbGx5IHN3aXRjaGluZyBiZXR3ZWVuIHBhc3N0aHJvdWdoCj4gPiA+
ID4gPiA+ID4gPiBhbmQgc2hhZG93IHZpcnRxdWV1ZS4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KPiA+ID4gPiA+ID4gPiBTYW1lIGNvbW1lbnQuCj4gPiA+ID4gPiA+IHRvIHdoaWNoPwo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiAtU2l3ZWkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBWSE9TVF9CQUNL
RU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBpcyB0b28gbmFycm93IGEgdXNlLWNhc2UgdG8g
Y29tbWl0IHRvIGl0Cj4gPiA+ID4gPiBhcyBhIGtlcm5lbC91c2Vyc3BhY2UgQUJJOiB3aGF0IGlm
IG9uZSB3YW50cyB0byBzdGFydCByaW5ncyBpbiBzb21lCj4gPiA+ID4gPiBvdGhlciBzcGVjaWZp
YyBvcmRlcj8KPiA+ID4gPgo+ID4gPiA+IEp1c3QgZW5hYmxlIGEgcXVldWUgYnkgd3JpdGluZyBl
LmcgMSB0byBxdWV1ZV9lbmFibGUgaW4gYSBzcGVjaWZpYyBvcmRlcj8KPiA+ID4KPiA+ID4KPiA+
ID4gQnV0IHRoZW4gYXQgZHJpdmVyIG9rIHRpbWUgd2UgZG9uJ3Qga25vdyBob3cgbWFueSBxdWV1
ZXMgYXJlIHRoZXJlLgo+ID4KPiA+IFRoZXJlIHNob3VsZCBiZSBhIGRldmljZSBzcGVjaWZpYyBp
bnRlcmZhY2UgZm9yIHRoaXMsIGZvciBleGFtcGxlLAo+ID4gbnVtX3F1ZXVlX3BhcmlzLiBTbyB0
aGUgZGV2aWNlIGtub3dzIGF0IG1vc3QgaG93IG1hbnkgcXVldWVzIHRoZXJlCj4gPiBhcmUuIE9y
IGFueXRoaW5nIEkgbWlzcz8KPgo+IFRoYXQncyBhIGRldmljZSBsaW1pdGF0aW9ucy4gRG9lcyBu
b3QgdGVsbCB0aGUgZGV2aWNlIGhvdyBtdWNoIGlzIHVzZWQuCgpJIHRoaW5rIEkgbWlzcyBzb21l
dGhpbmcsIGhvdyBraWNrIGRpZmZlcnMgZnJvbSBxdWV1ZV9lbmFibGUgaW4gdGhpcyB3YXk/Cgo+
Cj4gPiA+Cj4gPiA+ID4gPiBBcyB3YXMgZGlzY3Vzc2VkIG9uIGxpc3QsIGEgYmV0dGVyIHByb21p
c2UgaXMgbm90IHRvIGFjY2VzcyByaW5nCj4gPiA+ID4gPiB1bnRpbCB0aGUgMXN0IGtpY2suIHZk
cGEgY2FuIHRoZW4gZG8gYSBraWNrIHdoZW4gaXQgd2FudHMKPiA+ID4gPiA+IHRoZSBkZXZpY2Ug
dG8gc3RhcnQgYWNjZXNzaW5nIHJpbmdzLgo+ID4gPiA+Cj4gPiA+ID4gUmV0aGluayBhYm91dCB0
aGUgQUNDRVNTX0FGVEVSX0tJQ0ssIGl0IHNvdW5kcyBmdW5jdGlvbmFsIGVxdWl2YWxlbnQKPiA+
ID4gPiB0byBhbGxvdyBxdWV1ZV9lbmFibGUgYWZ0ZXIgRFJJVkVSX09LLCBidXQgaXQgc2VlbXMg
dG8gaGF2ZQo+ID4gPiA+IGRpc3RhbnZhZ2VzOgo+ID4gPiA+Cj4gPiA+ID4gQSBidXN5IHBvbGxp
bmcgc29mdHdhcmUgZGV2aWNlIG1heSBkaXNhYmxlIG5vdGlmaWNhdGlvbnMgYW5kIG5ldmVyCj4g
PiA+ID4gcmVzcG9uZCB0byByZWdpc3RlciB0byBhbnkga2ljayBub3RpZmllcnMuIEFDQ0VTU19B
RlRFUl9LSUNLIHdpbGwKPiA+ID4gPiBpbnRyb2R1Y2Ugb3ZlcmhlYWQgdG8gdGhvc2UgaW1wbGVt
ZW50YXRpb25zLgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+IEl0J3MganVzdCB0
aGUgMXN0IGtpY2ssIHRoZW4geW91IGNhbiBkaXNhYmxlLiBObz8KPiA+Cj4gPiBZZXMsIGJ1dDoK
PiA+Cj4gPiAxKSBhZGRpbmcgaG9va3MgZm9yIHF1ZXVlX2VuYWJsZQo+ID4gMikgYWRkaW5nIG5l
dyBjb2RlcyB0byByZWdpc3RlciBldmVudCBub3RpZmllciBhbmQgdG9nZ2xlIHRoZSBub3RpZmll
cgo+ID4KPiA+IDEpIHNlZW1zIG11Y2ggZWFzaWVyPyBPciBmb3IgbW9zdCBkZXZpY2VzLCBpdCBh
bHJlYWR5IGJlaGF2ZXMgbGlrZSB0aGlzLgo+ID4KPiA+IFRoYW5rcwo+Cj4gV2VsbCBsaWJ2aG9z
dHVzZXIgY2hlY2tzIGVuYWJsZWQgcXVldWVzIGF0IERSSVZFUl9PSywgZG9lcyBpdCBub3Q/CgpQ
cm9iYWJseSwgYnV0IEkgbWVhbnQ6CgoxKSBUaGlzIGJlaGF2aW91ciBoYXMgYmVlbiBzdXBwb3J0
ZWQgYnkgc29tZSBkZXZpY2UgKGUuZyBNTFgpCjIpIFRoaXMgaXMgdGhlIGN1cnJlbnQgYmVoYXZp
b3VyIG9mIFFlbXUgZm9yIHZob3N0LW5ldCBkZXZpY2VzOgoKc3RhdGljIHZvaWQgdmlydGlvX25l
dF9xdWV1ZV9lbmFibGUoVmlydElPRGV2aWNlICp2ZGV2LCB1aW50MzJfdCBxdWV1ZV9pbmRleCkK
ewogICAgVmlydElPTmV0ICpuID0gVklSVElPX05FVCh2ZGV2KTsKICAgIE5ldENsaWVudFN0YXRl
ICpuYzsKICAgIGludCByOwoKICAgIC4uLi4KCiAgICBpZiAoZ2V0X3Zob3N0X25ldChuYy0+cGVl
cikgJiYKICAgICAgICBuYy0+cGVlci0+aW5mby0+dHlwZSA9PSBORVRfQ0xJRU5UX0RSSVZFUl9U
QVApIHsKICAgICAgICByID0gdmhvc3RfbmV0X3ZpcnRxdWV1ZV9yZXN0YXJ0KHZkZXYsIG5jLCBx
dWV1ZV9pbmRleCk7CiAgICAgICAgaWYgKHIgPCAwKSB7CiAgICAgICAgICAgIGVycm9yX3JlcG9y
dCgidW5hYmxlIHRvIHJlc3RhcnQgdmhvc3QgbmV0IHZpcnRxdWV1ZTogJWQsICIKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJ3aGVuIHJlc2V0dGluZyB0aGUgcXVldWUiLCBxdWV1ZV9pbmRl
eCk7CiAgICAgICAgfQogICAgfQp9CgpUaGFua3MKCj4KPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMgfCA3ICsrKysrKysKPiA+ID4gPiA+ID4gPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4gPiA+IGluZGV4IDkxMzhlZjJm
YjJjOC4uNWYzMDlhMTZiOWRjIDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4gPiA+IEBAIC03LDYgKzcsNyBAQAo+
ID4gPiA+ID4gPiA+ID4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+Cj4gPiA+
ID4gPiA+ID4gPiAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19pZHMuaD4KPiA+ID4gPiA+
ID4gPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmRwYS5oPgo+ID4gPiA+ID4gPiA+ID4gKyNp
bmNsdWRlIDx1YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmg+Cj4gPiA+ID4gPiA+ID4gPiAgICNpbmNs
dWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gPiA+ID4gPiA+ID4gPiAgICNpbmNsdWRlIDxs
aW51eC9hdXhpbGlhcnlfYnVzLmg+Cj4gPiA+ID4gPiA+ID4gPiAgICNpbmNsdWRlIDxsaW51eC9t
bHg1L2NxLmg+Cj4gPiA+ID4gPiA+ID4gPiBAQCAtMjQ5OSw2ICsyNTAwLDExIEBAIHN0YXRpYyB2
b2lkIHVucmVnaXN0ZXJfbGlua19ub3RpZmllcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikK
PiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIGZsdXNoX3dvcmtxdWV1ZShuZGV2LT5t
dmRldi53cSk7Cj4gPiA+ID4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgdTY0
IG1seDVfdmRwYV9nZXRfYmFja2VuZF9mZWF0dXJlcyhjb25zdCBzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEpCj4gPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ID4gKyByZXR1cm4gQklUX1VM
TChWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyk7Cj4gPiA+ID4gPiA+ID4g
PiArfQo+ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gICBzdGF0aWMgaW50IG1seDVf
dmRwYV9zZXRfZHJpdmVyX2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZl
YXR1cmVzKQo+ID4gPiA+ID4gPiA+ID4gICB7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gPiA+ID4gPiA+ID4g
PiBAQCAtMzE0MCw2ICszMTQ2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19v
cHMgbWx4NV92ZHBhX29wcyA9IHsKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAuZ2V0X3ZxX2Fs
aWduID0gbWx4NV92ZHBhX2dldF92cV9hbGlnbiwKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAu
Z2V0X3ZxX2dyb3VwID0gbWx4NV92ZHBhX2dldF92cV9ncm91cCwKPiA+ID4gPiA+ID4gPiA+ICAg
ICAgICAgICAuZ2V0X2RldmljZV9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfZGV2aWNlX2ZlYXR1
cmVzLAo+ID4gPiA+ID4gPiA+ID4gKyAuZ2V0X2JhY2tlbmRfZmVhdHVyZXMgPSBtbHg1X3ZkcGFf
Z2V0X2JhY2tlbmRfZmVhdHVyZXMsCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgLnNldF9kcml2
ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfc2V0X2RyaXZlcl9mZWF0dXJlcywKPiA+ID4gPiA+ID4g
PiA+ICAgICAgICAgICAuZ2V0X2RyaXZlcl9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfZHJpdmVy
X2ZlYXR1cmVzLAo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgIC5zZXRfY29uZmlnX2NiID0gbWx4
NV92ZHBhX3NldF9jb25maWdfY2IsCj4gPiA+ID4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gPiA+ID4g
Mi4zOS4zCj4gPiA+ID4gPgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
