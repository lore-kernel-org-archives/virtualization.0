Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB5BC32774
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 00:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 392D6840FE;
	Fri, 19 Aug 2022 00:42:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 392D6840FE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWkaEi+x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0yQwlqUgMIx1; Fri, 19 Aug 2022 00:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD536840DE;
	Fri, 19 Aug 2022 00:42:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD536840DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85D5BC0032;
	Fri, 19 Aug 2022 00:42:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3C7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66A89840FE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:42:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66A89840FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FHOTeuKWhmNO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:42:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 925AC84141
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 925AC84141
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660869766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+mwOXxAkoNOjKTh4pynirHUBFBiL6gHoAL0lptq2/s=;
 b=iWkaEi+xJrK09jcMTswrRVdKx19ipgjMXlR3FuRBj5/XMsarKrSFiLqcO7cIDDbQIIvNxq
 r1ovwgaGc8AY+P7XR/mP6eT/HKM6iZWe738RzbqD2YU5gBDAZHP3w8LHsxi/aFSS42AAnQ
 ziH8BcNjolW7dtyQhXHoCauLduL1Gts=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-NdegwtBJOQWkojXtMDxkOA-1; Thu, 18 Aug 2022 20:42:45 -0400
X-MC-Unique: NdegwtBJOQWkojXtMDxkOA-1
Received: by mail-lf1-f69.google.com with SMTP id
 e19-20020a05651236d300b0048d16bfadecso968270lfs.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 17:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=F+mwOXxAkoNOjKTh4pynirHUBFBiL6gHoAL0lptq2/s=;
 b=tjl6FcacSQpCo605Q0lgQ7JfhQG+1C68dFI4Alg23EQd2TWPOkdjLIAZnJF/z0mRJM
 50gWmAUYkgUWh1hdezyIydEZb6FMoF0D0ril1vQ1oVQ9KuVzUye4LaDENQyGKewHIMiQ
 Zq1zGM/Ohh859a0KWjTHX6ZhAIOK9bu7le0buSv8ACn5w8DQwmuvTeMY6oXU6FEb/Gdu
 q501MBDvFBN3l70HhT4naUAdv7ir7j3IuL0cwfUzC2nVLuvk5yrj7ECnZIGHuubU5s/I
 NC7/t7n+6m8V6q1n1u788fEUvuD+reTyKR/3U66nBSEXi0nl6lsd+IwNVjiIDJjUA/y4
 I//w==
X-Gm-Message-State: ACgBeo2qnHbH06dpC/zCNp6t4rGjWWwJ2V7buG+0hczrhviLVL2mDAOC
 0jYH8lK+a4WjJ9ZdX3bVOUmC+VlowoZFpEu2sv0hDMzlTZI0BEk2nzr5Ur/K8OY8p79xT0h3fig
 7SqLZtxuxRCWPK9lAAUIfdYYvZ9/gKmsr07Hfu6H9PzvST7t95nvg6I5Vuw==
X-Received: by 2002:a2e:a5c3:0:b0:261:ac2d:2820 with SMTP id
 n3-20020a2ea5c3000000b00261ac2d2820mr1566629ljp.243.1660869763761; 
 Thu, 18 Aug 2022 17:42:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DovrTZ8skbUJhveovXiAocl2YhXuq8pzuh+lrxGHEPrz2c5hrrGAnX9Fj0f/C41UKEX10jssdqlgV7yfRDzY=
X-Received: by 2002:a2e:a5c3:0:b0:261:ac2d:2820 with SMTP id
 n3-20020a2ea5c3000000b00261ac2d2820mr1566611ljp.243.1660869763375; Thu, 18
 Aug 2022 17:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
 <20220817045406-mutt-send-email-mst@kernel.org>
 <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
 <20220817053821-mutt-send-email-mst@kernel.org>
 <449c2fb2-3920-7bf9-8c5c-a68456dfea76@intel.com>
 <20220817063450-mutt-send-email-mst@kernel.org>
 <54aa5a5c-69e2-d372-3e0c-b87f595d213c@redhat.com>
 <f0b6ea5c-1783-96d2-2d9f-e5cf726b0fc0@oracle.com>
In-Reply-To: <f0b6ea5c-1783-96d2-2d9f-e5cf726b0fc0@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Aug 2022 08:42:32 +0800
Message-ID: <CACGkMEumKfktMUJOTUYL_JYkFbw8qH331gGARPB2bTH=7wKWPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
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

T24gRnJpLCBBdWcgMTksIDIwMjIgYXQgNzoyMCBBTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9y
YWNsZS5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDgvMTcvMjAyMiA5OjE1IFBNLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIyLzgvMTcgMTg6MzcsIE1pY2hhZWwgUy4gVHNpcmtpbiDl
hpnpgZM6Cj4gPj4gT24gV2VkLCBBdWcgMTcsIDIwMjIgYXQgMDU6NDM6MjJQTSArMDgwMCwgWmh1
LCBMaW5nc2hhbiB3cm90ZToKPiA+Pj4KPiA+Pj4gT24gOC8xNy8yMDIyIDU6MzkgUE0sIE1pY2hh
ZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+Pj4+IE9uIFdlZCwgQXVnIDE3LCAyMDIyIGF0IDA1OjEz
OjU5UE0gKzA4MDAsIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4gPj4+Pj4gT24gOC8xNy8yMDIyIDQ6
NTUgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+Pj4+Pj4gT24gV2VkLCBBdWcgMTcs
IDIwMjIgYXQgMTA6MTQ6MjZBTSArMDgwMCwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPiA+Pj4+Pj4+
IFllcyBpdCBpcyBhIGxpdHRsZSBtZXNzeSwgYW5kIHdlIGNhbiBub3QgY2hlY2sgX0ZfVkVSU0lP
Tl8xCj4gPj4+Pj4+PiBiZWNhdXNlIG9mCj4gPj4+Pj4+PiB0cmFuc2l0aW9uYWwgZGV2aWNlcywg
c28gbWF5YmUgdGhpcyBpcyB0aGUgYmVzdCB3ZSBjYW4gZG8gZm9yIG5vdwo+ID4+Pj4+PiBJIHRo
aW5rIHZob3N0IGdlbmVyYWxseSBuZWVkcyBhbiBBUEkgdG8gZGVjbGFyZSBjb25maWcgc3BhY2UK
PiA+Pj4+Pj4gZW5kaWFuLW5lc3MKPiA+Pj4+Pj4gdG8ga2VybmVsLiB2ZHBhIGNhbiByZXVzZSB0
aGF0IHRvbyB0aGVuLgo+ID4+Pj4+IFllcywgSSByZW1lbWJlciB5b3UgaGF2ZSBtZW50aW9uZWQg
c29tZSBJT0NUTCB0byBzZXQgdGhlIGVuZGlhbi1uZXNzLAo+ID4+Pj4+IGZvciB2RFBBLCBJIHRo
aW5rIG9ubHkgdGhlIHZlbmRvciBkcml2ZXIga25vd3MgdGhlIGVuZGlhbiwKPiA+Pj4+PiBzbyB3
ZSBtYXkgbmVlZCBhIG5ldyBmdW5jdGlvbiB2ZHBhX29wcy0+Z2V0X2VuZGlhbigpLgo+ID4+Pj4+
IEluIHRoZSBsYXN0IHRocmVhZCwgd2Ugc2F5IG1heWJlIGl0J3MgYmV0dGVyIHRvIGFkZCBhIGNv
bW1lbnQgZm9yCj4gPj4+Pj4gbm93Lgo+ID4+Pj4+IEJ1dCBpZiB5b3UgdGhpbmsgd2Ugc2hvdWxk
IGFkZCBhIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCksIEkgY2FuIHdvcmsKPiA+Pj4+PiBvbiBpdCBm
b3Igc3VyZSEKPiA+Pj4+Pgo+ID4+Pj4+IFRoYW5rcwo+ID4+Pj4+IFpodSBMaW5nc2hhbgo+ID4+
Pj4gSSB0aGluayBRRU1VIGhhcyB0byBzZXQgZW5kaWFuLW5lc3MuIE5vIG9uZSBlbHNlIGtub3dz
Lgo+ID4+PiBZZXMsIGZvciBTVyBiYXNlZCB2aG9zdCBpdCBpcyB0cnVlLiBCdXQgZm9yIEhXIHZE
UEEsIG9ubHkKPiA+Pj4gdGhlIGRldmljZSAmIGRyaXZlciBrbm93cyB0aGUgZW5kaWFuLCBJIHRo
aW5rIHdlIGNhbiBub3QKPiA+Pj4gInNldCIgYSBoYXJkd2FyZSdzIGVuZGlhbi4KPiA+PiBRRU1V
IGtub3dzIHRoZSBndWVzdCBlbmRpYW4tbmVzcyBhbmQgaXQga25vd3MgdGhhdAo+ID4+IGRldmlj
ZSBpcyBhY2Nlc3NlZCB0aHJvdWdoIHRoZSBsZWdhY3kgaW50ZXJmYWNlLgo+ID4+IEl0IGNhbiBh
Y2NvcmRpbmdseSBzZW5kIGVuZGlhbi1uZXNzIHRvIHRoZSBrZXJuZWwgYW5kCj4gPj4ga2VybmVs
IGNhbiBwcm9wYWdhdGUgaXQgdG8gdGhlIGRyaXZlci4KPiA+Cj4gPgo+ID4gSSB3b25kZXIgaWYg
d2UgY2FuIHNpbXBseSBmb3JjZSBMRSBhbmQgdGhlbiBRZW11IGNhbiBkbyB0aGUgZW5kaWFuCj4g
PiBjb252ZXJzaW9uPwo+IGNvbnZlcnQgZnJvbSBMRSBmb3IgY29uZmlnIHNwYWNlIGZpZWxkcyBv
bmx5LCBvciBRRU1VIGhhcyB0byBmb3JjZWZ1bGx5Cj4gbWVkaWF0ZSBhbmQgY292ZXJ0IGVuZGlh
bm5lc3MgZm9yIGFsbCBkZXZpY2UgbWVtb3J5IGFjY2VzcyBpbmNsdWRpbmcKPiBldmVuIHRoZSBk
YXRhcGF0aCAoZmllbGRzIGluIGRlc2NyaXB0b3IgYW5kIGF2YWlsL3VzZWQgcmluZ3MpPwoKRm9y
bWVyLiBBY3R1YWxseSwgSSB3YW50IHRvIGZvcmNlIG1vZGVybiBkZXZpY2VzIGZvciB2RFBBIHdo
ZW4KZGV2ZWxvcGluZyB0aGUgdkRQQSBmcmFtZXdvcmsuIEJ1dCB0aGVuIHdlIHNlZSByZXF1aXJl
bWVudHMgZm9yCnRyYW5zaXRpb25hbCBvciBldmVuIGxlZ2FjeSAoZS5nIHRoZSBBbGkgRU5JIHBh
cmVudCkuIFNvIGl0CmNvbXBsaWNhdGVzIHRoaW5ncyBhIGxvdC4KCkkgdGhpbmsgc2V2ZXJhbCBp
ZGVhcyBoYXMgYmVlbiBwcm9wb3NlZDoKCjEpIFlvdXIgcHJvcG9zYWwgb2YgaGF2aW5nIGEgdkRQ
QSBzcGVjaWZpYyB3YXkgZm9yCm1vZGVybi90cmFuc2l0aW9uYWwvbGVnYWN5IGF3YXJlbmVzcy4g
VGhpcyBzZWVtcyB2ZXJ5IGNsZWFuIHNpbmNlIGVhY2gKdHJhbnNwb3J0IHNob3VsZCBoYXZlIHRo
ZSBhYmlsaXR5IHRvIGRvIHRoYXQgYnV0IGl0IHN0aWxsIHJlcXVpcmVzCnNvbWUga2luZCBvZiBt
ZWRpYXRpb24gZm9yIHRoZSBjYXNlIGUuZyBydW5uaW5nIEJFIGxlZ2FjeSBndWVzdCBvbiBMRQpo
b3N0LgoKMikgTWljaGFlbCBzdWdnZXN0cyB1c2luZyBWSE9TVF9TRVRfVlJJTkdfRU5ESUFOIHdo
ZXJlIGl0IG1lYW5zIHdlCm5lZWQgYSBuZXcgY29uZmlnIG9wcyBmb3IgdkRQQSBidXMsIGJ1dCBp
dCBkb2Vzbid0IHNvbHZlIHRoZSBpc3N1ZSBmb3IKY29uZmlnIHNwYWNlIChhdCBsZWFzdCBmcm9t
IGl0cyBuYW1lKS4gV2UgcHJvYmFibHkgbmVlZCBhIG5ldyBpb2N0bApmb3IgYm90aCB2cmluZyBh
bmQgY29uZmlnIHNwYWNlLgoKb3IKCjMpIHJldmlzaXQgdGhlIGlkZWEgb2YgZm9yY2luZyBtb2Rl
cm4gb25seSBkZXZpY2Ugd2hpY2ggbWF5IHNpbXBsaWZ5CnRoaW5ncyBhIGxvdAoKd2hpY2ggd2F5
IHNob3VsZCB3ZSBnbz8KCj4gSSBob3BlCj4gaXQncyBub3QgdGhlIGxhdHRlciwgb3RoZXJ3aXNl
IGl0IGxvc2VzIHRoZSBwb2ludCB0byB1c2UgdkRQQSBmb3IKPiBkYXRhcGF0aCBhY2NlbGVyYXRp
b24uCj4KPiBFdmVuIGlmIGl0cyB0aGUgZm9ybWVyLCBpdCdzIGEgbGl0dGxlIHdlaXJkIGZvciB2
ZW5kb3IgZGV2aWNlIHRvCj4gaW1wbGVtZW50IGEgTEUgY29uZmlnIHNwYWNlIHdpdGggQkUgcmlu
ZyBsYXlvdXQsIGFsdGhvdWdoIHN0aWxsIHBvc3NpYmxlLi4uCgpSaWdodC4KClRoYW5rcwoKPgo+
IC1TaXdlaQo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4gPj4KPiA+Pj4gU28gaWYgeW91IHRoaW5r
IHdlIHNob3VsZCBhZGQgYSB2ZHBhX29wcy0+Z2V0X2VuZGlhbigpLAo+ID4+PiBJIHdpbGwgZHJv
cCB0aGVzZSBjb21tZW50cyBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mCj4gPj4+IHNlcmllcywgYW5k
IHdvcmsgb24gYSBuZXcgcGF0Y2ggZm9yIGdldF9lbmRpYW4oKS4KPiA+Pj4KPiA+Pj4gVGhhbmtz
LAo+ID4+PiBaaHUgTGluZ3NoYW4KPiA+PiBHdWVzdHMgZG9uJ3QgZ2V0IGVuZGlhbi1uZXNzIGZy
b20gZGV2aWNlcyBzbyB0aGlzIHNlZW1zIHBvaW50bGVzcy4KPiA+Pgo+ID4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
