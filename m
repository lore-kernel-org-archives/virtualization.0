Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BD8C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 17:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA60C402EB;
	Mon, 10 Oct 2022 17:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA60C402EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SRz6DDgl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJgLNGmOWyct; Mon, 10 Oct 2022 17:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0DF2B400A6;
	Mon, 10 Oct 2022 17:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DF2B400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEB5BC0032;
	Mon, 10 Oct 2022 17:11:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD55C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB38F40865
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB38F40865
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SRz6DDgl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7DBaEDQdE9v
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B837940860
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B837940860
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665421905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihtPTRwtIx7/JivDxGqfc0yBndE/NMthdx5dSqwVLUk=;
 b=SRz6DDglenJtb5MCaMCeP5E69jcoQ9bMOpxeY3yuzPflGBxT1sCjaW9oN82eJSFtrosBRf
 vRGCBPUYExfZ59HqBYkgRdNKopYQ8G3xxuiV5HI0EpzQMyWHD/ZnFiIk2QlnJ8CSBluHUA
 /KKapp2T5bbKY83SE9JK/oQ6bgf6WCE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-ieEijXEHOM6-Y7Ej7GWSYQ-1; Mon, 10 Oct 2022 13:11:44 -0400
X-MC-Unique: ieEijXEHOM6-Y7Ej7GWSYQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 h129-20020a1c2187000000b003bf635eac31so4232832wmh.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 10:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ihtPTRwtIx7/JivDxGqfc0yBndE/NMthdx5dSqwVLUk=;
 b=4stqqB7Ltd11uYLFazce3gRkmgrhef5vp0MXhbMSCVV7rrTeDvmx2tlQw9Q1NWUa/W
 QKFdcNfApbH1PoltKYQCckBeWD+xxl67L5q4wvTfDJVF/mxwSsW8KMVpoo8UrlxOXn52
 ZzA400gW/duyFJUd6yQhLUl8GyyjG/0J2blMFtn5Mng6NADQWZOJii+irUBOiifI8VpE
 5KdxwSaNtfrkwUlM7m09H5CFXCa2NUtmq+yr0BEYPbUhRslQ0vQmxlG4x65yFe3QeXLV
 gopU2dPXtPLZAQ8uwUYjbJtXM99KsocQiAQGNtPNcj0DWsj7qbCGE4YGEJ2DIJhZVuto
 XdTQ==
X-Gm-Message-State: ACrzQf0pGrdPl0fOvm+XDTQI+k2nsB81TsOGE1uyz6FtkIww0EGzX2AZ
 rlLbOez2DsQyjEed8npgdb8eeyJVWrHIpN2fk3ZdtzfA7COqjtxo3v1SrCOwTjTxGrKT/GHcFy7
 tT5+/QwaIXM9tO6Jr9M+1DzTNbLmiKwa+5Ru5CnMQTw==
X-Received: by 2002:a05:600c:2255:b0:3c4:6c57:3d19 with SMTP id
 a21-20020a05600c225500b003c46c573d19mr9236225wmm.92.1665421903385; 
 Mon, 10 Oct 2022 10:11:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Pt1iCxXK/D/7OXuLbmKUR4GbwjfQKEwoqRrCp9NsMmehZvd3bh1vqeEQ9Oqps/BNVAHHBkw==
X-Received: by 2002:a05:600c:2255:b0:3c4:6c57:3d19 with SMTP id
 a21-20020a05600c225500b003c46c573d19mr9236197wmm.92.1665421903113; 
 Mon, 10 Oct 2022 10:11:43 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c511300b003b95ed78275sm11264457wms.20.2022.10.10.10.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 10:11:42 -0700 (PDT)
Date: Mon, 10 Oct 2022 13:11:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
Message-ID: <20221009160520-mutt-send-email-mst@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
 <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
 <20220907034407-mutt-send-email-mst@kernel.org>
 <d32101bb-783f-dbd1-545a-be291c27cb63@redhat.com>
 <20220908011858-mutt-send-email-mst@kernel.org>
 <c8cd9a2e-3480-6ca5-96fa-4b5bd2c1174a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c8cd9a2e-3480-6ca5-96fa-4b5bd2c1174a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

T24gU3VuLCBPY3QgMDksIDIwMjIgYXQgMDE6NTg6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi85LzggMTM6MTksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4g
PiBPbiBUaHUsIFNlcCAwOCwgMjAyMiBhdCAxMDoyMTo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiDlnKggMjAyMi85LzcgMTU6NDYsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6
Cj4gPiA+ID4gT24gV2VkLCBTZXAgMDcsIDIwMjIgYXQgMDk6MDc6MjBBTSArMDIwMCwgUGFvbG8g
QWJlbmkgd3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQsIDIwMjItMDktMDcgYXQgMTA6MDkgKzA4MDAs
IEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIFR1ZSwgU2VwIDYsIDIwMjIgYXQgNjo1
NiBQTSBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+
IE9uIE1vbiwgMjAyMi0wOS0wNSBhdCAxNTo0OSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+IE9uIE1vbiwgU2VwIDUsIDIwMjIgYXQgMzoxNSBQTSBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBT
ZXAgMDUsIDIwMjIgYXQgMTI6NTM6NDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4g
PiA+ID4gPiA+ID4gPiBBZGRpbmcgY29uZF9yZXNjaGVkKCkgdG8gdGhlIGNvbW1hbmQgd2FpdGlu
ZyBsb29wIGZvciBhIGJldHRlcgo+ID4gPiA+ID4gPiA+ID4gPiA+IGNvLW9wZXJhdGlvbiB3aXRo
IHRoZSBzY2hlZHVsZXIuIFRoaXMgYWxsb3dzIHRvIGdpdmUgQ1BVIGEgYnJlYXRoIHRvCj4gPiA+
ID4gPiA+ID4gPiA+ID4gcnVuIG90aGVyIHRhc2sod29ya3F1ZXVlKSBpbnN0ZWFkIG9mIGJ1c3kg
bG9vcGluZyB3aGVuIHByZWVtcHRpb24gaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiBub3QgYWxsb3dl
ZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGF0J3MgbW9yZSBp
bXBvcnRhbnQuIFRoaXMgaXMgYSBtdXN0IGZvciBzb21lIHZEUEEgcGFyZW50IHRvIHdvcmsKPiA+
ID4gPiA+ID4gPiA+ID4gPiBzaW5jZSBjb250cm9sIHZpcnRxdWV1ZSBpcyBlbXVsYXRlZCB2aWEg
YSB3b3JrcXVldWUgZm9yIHRob3NlIHBhcmVudHMuCj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+
ID4gPiA+ID4gPiA+ID4gRml4ZXM6IGJkYTMyNGZkMDM3YSAoInZkcGFzaW06IGNvbnRyb2wgdmly
dHF1ZXVlIHN1cHBvcnQiKQo+ID4gPiA+ID4gPiA+ID4gPiBUaGF0J3MgYSB3ZWlyZCBjb21taXQg
dG8gZml4LiBzbyBpdCBmaXhlcyB0aGUgc2ltdWxhdG9yPwo+ID4gPiA+ID4gPiA+ID4gWWVzLCBz
aW5jZSB0aGUgc2ltdWxhdG9yIGlzIHVzaW5nIGEgd29ya3F1ZXVlIHRvIGhhbmRsZSBjb250cm9s
IHZpcnR1ZXVlLgo+ID4gPiA+ID4gPiA+IFVobW0uLi4gdG91Y2hpbmcgYSBkcml2ZXIgZm9yIGEg
c2ltdWxhdG9yJ3Mgc2FrZSBsb29rcyBhIGxpdHRsZSB3ZWlyZC4KPiA+ID4gPiA+ID4gU2ltdWxh
dG9yIGlzIG5vdCB0aGUgb25seSBvbmUgdGhhdCBpcyB1c2luZyBhIHdvcmtxdWV1ZSAoYnV0IHNo
b3VsZCBiZQo+ID4gPiA+ID4gPiB0aGUgZmlyc3QpLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
SSBjYW4gc2VlICB0aGF0IHRoZSBtbHg1IHZEUEEgZHJpdmVyIGlzIHVzaW5nIGEgd29ya3F1ZXVl
IGFzIHdlbGwgKHNlZQo+ID4gPiA+ID4gPiBtbHg1X3ZkcGFfa2lja192cSgpKS4KPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+IEFuZCBpbiB0aGUgY2FzZSBvZiBWRFVTRSwgaXQgbmVlZHMgdG8gd2Fp
dCBmb3IgdGhlIHJlc3BvbnNlIGZyb20gdGhlCj4gPiA+ID4gPiA+IHVzZXJzcGFjZSwgdGhpcyBt
ZWFucyBjb25kX3Jlc2NoZWQoKSBpcyBwcm9iYWJseSBhIG11c3QgZm9yIHRoZSBjYXNlCj4gPiA+
ID4gPiA+IGxpa2UgVVAuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IEFkZGl0aW9uYWxseSwg
aWYgdGhlIGJ1ZyBpcyB2ZHBhc2ltLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHRyeSB0bwo+ID4g
PiA+ID4gPiA+IHNvbHZlIGl0IHRoZXJlLCBpZiBwb3NzaWJsZS4KPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiBMb29raW5nIGF0IHZkcGFzaW1fbmV0X3dvcmsoKSBhbmQgdmRwYXNpbV9ibGtf
d29yaygpIGl0IGxvb2tzIGxpa2UKPiA+ID4gPiA+ID4gPiBuZWl0aGVyIG5lZWRzIGEgcHJvY2Vz
cyBjb250ZXh0LCBzbyBwZXJoYXBzIHlvdSBjb3VsZCByZXdvcmsgaXQgdG8gcnVuCj4gPiA+ID4g
PiA+ID4gdGhlIHdvcmtfZm4oKSBkaXJlY3RseSBmcm9tIHZkcGFzaW1fa2lja192cSgpLCBhdCBs
ZWFzdCBmb3IgdGhlIGNvbnRyb2wKPiA+ID4gPiA+ID4gPiB2aXJ0cXVldWU/Cj4gPiA+ID4gPiA+
IEl0J3MgcG9zc2libGUgKGJ1dCByZXF1aXJlIHNvbWUgcmV3b3JrIG9uIHRoZSBzaW11bGF0b3Ig
Y29yZSkuIEJ1dAo+ID4gPiA+ID4gPiBjb25zaWRlcmluZyB3ZSBoYXZlIG90aGVyIHNpbWlsYXIg
dXNlIGNhc2VzLCBpdCBsb29rcyBiZXR0ZXIgdG8gc29sdmUKPiA+ID4gPiA+ID4gaXQgaW4gdGhl
IHZpcnRpby1uZXQgZHJpdmVyLgo+ID4gPiA+ID4gSSBzZWUuCj4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gQWRkaXRpb25hbGx5LCB0aGlzIG1heSBoYXZlIGJldHRlciBiZWhhdmlvdXIgd2hlbiB1c2lu
ZyBmb3IgdGhlIGJ1Z2d5Cj4gPiA+ID4gPiA+IGhhcmR3YXJlIChlLmcgdGhlIGNvbnRyb2wgdmly
dHF1ZXVlIHRha2VzIHRvbyBsb25nIHRvIHJlc3BvbmQpLiBXZSBtYXkKPiA+ID4gPiA+ID4gY29u
c2lkZXIgc3dpdGNoaW5nIHRvIHVzZSBpbnRlcnJ1cHQvc2xlZXAgaW4gdGhlIGZ1dHVyZSAoYnV0
IG5vdAo+ID4gPiA+ID4gPiBzdWl0YWJsZSBmb3IgLW5ldCkuCj4gPiA+ID4gPiBBZ3JlZWQuIFBv
c3NpYmx5IGEgdGltZW91dCBjb3VsZCBiZSB1c2VmdWwsIHRvby4KPiA+ID4gPiA+IAo+ID4gPiA+
ID4gQ2hlZXJzLAo+ID4gPiA+ID4gCj4gPiA+ID4gPiBQYW9sbwo+ID4gPiA+IEhtbSB0aW1lb3V0
cyBhcmUga2luZCBvZiBhcmJpdHJhcnkuCj4gPiA+ID4gcmVndWxhciBkcml2ZXJzIGJhc2ljYWxs
eSBkZXJpdmUgdGhlbSBmcm9tIGhhcmR3YXJlCj4gPiA+ID4gYmVoYXZpb3VyIGJ1dCB3aXRoIGEg
Z2VuZXJpYyBkcml2ZXIgbGlrZSB2aXJ0aW8gaXQncyBoYXJkZXIuCj4gPiA+ID4gSSBndWVzcyB3
ZSBjb3VsZCBhZGQgdGltZW91dCBhcyBhIGNvbmZpZyBmaWVsZCwgaGF2ZQo+ID4gPiA+IGRldmlj
ZSBtYWtlIGEgcHJvbWlzZSB0byB0aGUgZHJpdmVyLgo+ID4gPiA+IAo+ID4gPiA+IE1ha2luZyB0
aGUgd2FpdCBpbnRlcnJ1cHRpYmxlIHNlZW1zIG1vcmUgcmVhc29uYWJsZS4KPiA+ID4gCj4gPiA+
IFllcywgYnV0IEkgdGhpbmsgd2Ugc3RpbGwgbmVlZCB0aGlzIHBhdGNoIGZvciAtbmV0IGFuZCAt
c3RhYmxlLgo+ID4gPiAKPiA+ID4gVGhhbmtzCj4gPiBJIHdhcyByZWZlcnJpbmcgdG8gUGFvbG8n
cyBpZGVhIG9mIGhhdmluZyBhIHRpbWVvdXQuCj4gCj4gCj4gT2ssIEkgdGhpbmsgd2UncmUgZmlu
ZSB3aXRoIHRoaXMgcGF0Y2guIEFueSBjaGFuY2UgdG8gbWVyZ2UgdGhpcyBvciBkbyBJCj4gbmVl
ZCB0byByZXNlbmQ/Cj4gCj4gVGhhbmtzCgpMYXN0IHF1ZXN0aW9uOiBkbyB3ZSB3YW50IGNwdV9y
ZWxheCBoZXJlIG5vdz8gT3IgaXMgY29uZF9yZXNjaGVkCnN1ZmZpY2llbnQ/Cgo+IAo+ID4gCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
