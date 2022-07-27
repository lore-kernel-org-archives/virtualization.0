Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E58C19F29
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 09:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0323C403B8;
	Wed, 27 Jul 2022 09:51:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0323C403B8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cO8uE1IY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b33OPYTvUynW; Wed, 27 Jul 2022 09:51:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 724C74017E;
	Wed, 27 Jul 2022 09:51:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 724C74017E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35F00C0035;
	Wed, 27 Jul 2022 09:51:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D396C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21CE560B50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:51:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21CE560B50
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cO8uE1IY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LnrUszJaqmiq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FFB560B0A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FFB560B0A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658915473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmcnU9bKKlvtZ450kEDTGR935/iCiWC+HuQGNyiPCw0=;
 b=cO8uE1IYvIehgAbGBkVb+ANDA/rgB1plb7HlwSamyJ9ZCXlIQCsItnXjxh5FFSJw3JdwFB
 vqzedV7ZdTJ/g3hXU7er8rMP6Sy+2czZEnU5VnnjaBI6zB39o9ZYUt2zOKAHT2e5L3yECf
 AWgkxXfZ7RHAd6FlGHR5ULLPLwCygJQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-2QIOmcyHNme52WENYKXJAw-1; Wed, 27 Jul 2022 05:51:12 -0400
X-MC-Unique: 2QIOmcyHNme52WENYKXJAw-1
Received: by mail-ej1-f70.google.com with SMTP id
 nc23-20020a1709071c1700b0072b94109144so4934503ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 02:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MmcnU9bKKlvtZ450kEDTGR935/iCiWC+HuQGNyiPCw0=;
 b=KbMYV6mYnNEc100N1foFX7UQ7HdRHFhqawANnVeYcbKrUoF6gRUDAMoi9i5OM6FQG9
 jfEXKDa6NLKSY0EwuRV5moWkIEZnUrIUkPBnoJic16/JZdwzlhXEgUyok+GJ+h1sxjnJ
 +t1Zh/W8mfNA26QqWl3LmKSwmKA5LoaT0nADJ5mf/Xd4SvDxkjp2VrjJaLwhoxr9mMfh
 Q1DHLwritFlRPFcs0t6VMqNthggO7QAN5zJj1id26K3MkaXFNdKY672a0XX1D/FLuHHv
 jalwT+qKKk40L318DuhM39sRP+0XEtxMvXMtspVHNw7QMVhmRlt1T4w9zqHQjjXd/l+p
 RlFA==
X-Gm-Message-State: AJIora9SOHWu4Minv+3Wg5fLUFUanQG1weh6ZNw4hqDoOFLMEMH+0mpk
 avAjXgIkrBceNo+Hz8ApRWYgTOeg1SPy30HrhTbOtX2I9X/iA3W8byR/bFePsb9coesC/BCeYaO
 IsKiv8hM2omQHZGKP28l+a9NLtUT7n/bCZ/NHn6Xkg3Jbqf2NCRZRACCbwQ==
X-Received: by 2002:a17:907:724c:b0:72e:e6fe:5ea4 with SMTP id
 ds12-20020a170907724c00b0072ee6fe5ea4mr17467461ejc.421.1658915471377; 
 Wed, 27 Jul 2022 02:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sNjQ/GrSbdNE6rF0h84DLE6uO7Ifs9fq1rTj001hSuJ5EvwewWjIs0wj69vzy25IAVNvHQApWd62YST1MulVk=
X-Received: by 2002:a17:907:724c:b0:72e:e6fe:5ea4 with SMTP id
 ds12-20020a170907724c00b0072ee6fe5ea4mr17467434ejc.421.1658915470909; Wed, 27
 Jul 2022 02:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <CACGkMEv62tuOP3ra0GBhjCH=syFWxP+GVfGL_i0Ce0iD4uMY=Q@mail.gmail.com>
 <20220727050222-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220727050222-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Jul 2022 17:50:59 +0800
Message-ID: <CACGkMEtDFUGX17giwYdF58QJ1ccZJDJg1nFVDkSeB27sfZz28g@mail.gmail.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
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

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgNTowMyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0IDAyOjU0OjEzUE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAyOjAx
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBXZWQsIEp1bCAyNywgMjAyMiBhdCAwMzo0NzozNUFNICswMDAwLCBQYXJhdiBQYW5kaXQg
d3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiA+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpo
dUBpbnRlbC5jb20+Cj4gPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDEwOjUz
IFBNCj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gNy8yNy8yMDIyIDEwOjE3IEFNLCBQYXJhdiBQYW5k
aXQgd3JvdGU6Cj4gPiA+ID4gPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVA
aW50ZWwuY29tPgo+ID4gPiA+ID4gPj4gU2VudDogVHVlc2RheSwgSnVseSAyNiwgMjAyMiAxMDox
NSBQTQo+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4+IE9uIDcvMjYvMjAyMiAxMTo1NiBQTSwgUGFy
YXYgUGFuZGl0IHdyb3RlOgo+ID4gPiA+ID4gPj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPgo+ID4gPiA+ID4gPj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDEy
LCAyMDIyIDExOjQ2IFBNCj4gPiA+ID4gPiA+Pj4+PiBXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNo
IGludm9rZXMgbmV0bGluayBjb21tYW5kcywgZGV0ZWN0cyB0aGF0Cj4gPiA+ID4gPiA+PiBfTVEK
PiA+ID4gPiA+ID4+Pj4gaXMgbm90IHN1cHBvcnRlZCwgaGVuY2UgaXQgdGFrZXMgbWF4X3F1ZXVl
X3BhaXIgPSAxIGJ5IGl0c2VsZi4KPiA+ID4gPiA+ID4+Pj4gSSB0aGluayB0aGUga2VybmVsIG1v
ZHVsZSBoYXZlIGFsbCBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIGl0IGlzCj4gPiA+ID4gPiA+
Pj4+IHRoZSBvbmx5IG9uZSB3aGljaCBoYXZlIHByZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZp
Y2UsIHNvIGl0Cj4gPiA+ID4gPiA+Pj4+IHNob3VsZCBhbnN3ZXIgcHJlY2lzZWx5IHRoYW4gbGV0
IHRoZSB1c2VyIHNwYWNlIGd1ZXNzLiBUaGUga2VybmVsCj4gPiA+ID4gPiA+Pj4+IG1vZHVsZSBz
aG91bGQgYmUgcmVsaWFibGUgdGhhbiBzdGF5IHNpbGVudCwgbGVhdmUgdGhlIHF1ZXN0aW9uIHRv
Cj4gPiA+ID4gPiA+Pj4+IHRoZSB1c2VyIHNwYWNlCj4gPiA+ID4gPiA+PiB0b29sLgo+ID4gPiA+
ID4gPj4+IEtlcm5lbCBpcyByZWxpYWJsZS4gSXQgZG9lc27igJl0IGV4cG9zZSBhIGNvbmZpZyBz
cGFjZSBmaWVsZCBpZiB0aGUKPiA+ID4gPiA+ID4+PiBmaWVsZCBkb2VzbuKAmXQKPiA+ID4gPiA+
ID4+IGV4aXN0IHJlZ2FyZGxlc3Mgb2YgZmllbGQgc2hvdWxkIGhhdmUgZGVmYXVsdCBvciBubyBk
ZWZhdWx0Lgo+ID4gPiA+ID4gPj4gc28gd2hlbiB5b3Uga25vdyBpdCBpcyBvbmUgcXVldWUgcGFp
ciwgeW91IHNob3VsZCBhbnN3ZXIgb25lLCBub3QgdHJ5Cj4gPiA+ID4gPiA+PiB0byBndWVzcy4K
PiA+ID4gPiA+ID4+PiBVc2VyIHNwYWNlIHNob3VsZCBub3QgZ3Vlc3MgZWl0aGVyLiBVc2VyIHNw
YWNlIGdldHMgdG8gc2VlIGlmIF9NUQo+ID4gPiA+ID4gPj4gcHJlc2VudC9ub3QgcHJlc2VudC4g
SWYgX01RIHByZXNlbnQgdGhhbiBnZXQgcmVsaWFibGUgZGF0YSBmcm9tIGtlcm5lbC4KPiA+ID4g
PiA+ID4+PiBJZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUg
VlEgcGFpci4KPiA+ID4gPiA+ID4+IGl0IGlzIHN0aWxsIGEgZ3Vlc3MsIHJpZ2h0PyBBbmQgYWxs
IHVzZXIgc3BhY2UgdG9vbHMgaW1wbGVtZW50ZWQgdGhpcwo+ID4gPiA+ID4gPj4gZmVhdHVyZSBu
ZWVkIHRvIGd1ZXNzCj4gPiA+ID4gPiA+IE5vLiBpdCBpcyBub3QgYSBndWVzcy4KPiA+ID4gPiA+
ID4gSXQgaXMgZXhwbGljaXRseSBjaGVja2luZyB0aGUgX01RIGZlYXR1cmUgYW5kIGRlcml2aW5n
IHRoZSB2YWx1ZS4KPiA+ID4gPiA+ID4gVGhlIGNvZGUgeW91IHByb3Bvc2VkIHdpbGwgYmUgcHJl
c2VudCBpbiB0aGUgdXNlciBzcGFjZS4KPiA+ID4gPiA+ID4gSXQgd2lsbCBiZSB1bmlmb3JtIGZv
ciBfTVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRoYXQgYXJlIHByZXNlbnQgbm93IGFuZAo+ID4g
PiA+ID4gaW4gdGhlIGZ1dHVyZS4KPiA+ID4gPiA+IE1RIGFuZCBvdGhlciBmZWF0dXJlcyBsaWtl
IFJTUyBhcmUgZGlmZmVyZW50LiBJZiB0aGVyZSBpcyBubyBfUlNTX1hYLCB0aGVyZQo+ID4gPiA+
ID4gYXJlIG5vIGF0dHJpYnV0ZXMgbGlrZSBtYXhfcnNzX2tleV9zaXplLCBhbmQgdGhlcmUgaXMg
bm90IGEgZGVmYXVsdCB2YWx1ZS4KPiA+ID4gPiA+IEJ1dCBmb3IgTVEsIHdlIGtub3cgaXQgaGFz
IHRvIGJlIDEgd2lodG91dCBfTVEuCj4gPiA+ID4gIndlIiA9IHVzZXIgc3BhY2UuCj4gPiA+ID4g
VG8ga2VlcCB0aGUgY29uc2lzdGVuY3kgYW1vbmcgYWxsIHRoZSBjb25maWcgc3BhY2UgZmllbGRz
Lgo+ID4gPgo+ID4gPiBBY3R1YWxseSBJIGxvb2tlZCBhbmQgdGhlIGNvZGUgc29tZSBtb3JlIGFu
ZCBJJ20gcHV6emxlZDoKPiA+ID4KPiA+ID4KPiA+ID4gICAgICAgICBzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcgY29uZmlnID0ge307Cj4gPiA+ICAgICAgICAgdTY0IGZlYXR1cmVzOwo+ID4gPiAg
ICAgICAgIHUxNiB2YWxfdTE2Owo+ID4gPgo+ID4gPiAgICAgICAgIHZkcGFfZ2V0X2NvbmZpZ191
bmxvY2tlZCh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4gPiA+Cj4gPiA+ICAg
ICAgICAgaWYgKG5sYV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiwgc2l6
ZW9mKGNvbmZpZy5tYWMpLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgIGNvbmZpZy5tYWMpKQo+
ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPiA+ID4KPiA+ID4KPiA+ID4g
TWFjIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTUFDCj4gPiA+Cj4gPiA+Cj4g
PiA+ICAgICAgICAgdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5zdGF0dXMpOwo+ID4gPiAg
ICAgICAgIGlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX1NUQVRVUywgdmFs
X3UxNikpCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVNU0dTSVpFOwo+ID4gPgo+ID4g
Pgo+ID4gPiBzdGF0dXMgcmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9TVEFUVVMK
PiA+ID4KPiA+ID4gICAgICAgICB2YWxfdTE2ID0gbGUxNl90b19jcHUoY29uZmlnLm10dSk7Cj4g
PiA+ICAgICAgICAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01U
VSwgdmFsX3UxNikpCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVNU0dTSVpFOwo+ID4g
Pgo+ID4gPgo+ID4gPiBNVFUgcmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NVFUK
PiA+ID4KPiA+ID4KPiA+ID4gV2hhdCdzIGdvaW5nIG9uIGhlcmU/Cj4gPgo+ID4gUHJvYmFibHkg
dG9vIGxhdGUgdG8gZml4LCBidXQgdGhpcyBzaG91bGQgYmUgZmluZSBhcyBsb25nIGFzIGFsbAo+
ID4gcGFyZW50cyBzdXBwb3J0IFNUQVRVUy9NVFUvTUFDLgo+Cj4gV2h5IGlzIHRoaXMgdG9vIGxh
dGUgdG8gZml4LgoKSWYgd2UgbWFrZSB0aGlzIGNvbmRpdGlvbmFsIG9uIHRoZSBmZWF0dXJlcy4g
VGhpcyBtYXkgYnJlYWsgdGhlCnVzZXJzcGFjZSB0aGF0IGFsd2F5cyBleHBlY3RzIFZEUEFfQVRU
Ul9ERVZfTkVUX0NGR19NVFU/CgpUaGFua3MKCj4KPiA+IEkgd29uZGVyIGlmIHdlIGNhbiBhZGQg
YSBjaGVjayBpbiB0aGUgY29yZSBhbmQgZmFpbCB0aGUgZGV2aWNlCj4gPiByZWdpc3RyYXRpb24g
aW4gdGhpcyBjYXNlLgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4KPiA+ID4gLS0KPiA+
ID4gTVNUCj4gPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
