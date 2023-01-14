Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7C9C3DA78
	for <virtualization@archiver.kernel.org>; Sat, 14 Jan 2023 00:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19ED140AA8;
	Sat, 14 Jan 2023 00:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19ED140AA8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iR4kmvdy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id isOwsIFINzWM; Sat, 14 Jan 2023 00:37:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8B885400C8;
	Sat, 14 Jan 2023 00:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B885400C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59C86C0033;
	Sat, 14 Jan 2023 00:37:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD11C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2250182218
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2250182218
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=iR4kmvdy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0L7_dhGt7Wh
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:37:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7D82821BB
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7D82821BB
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:37:02 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 v13-20020a17090a6b0d00b00219c3be9830so25986435pjj.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 16:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgNFr3/ezXsDZIl7tdWNOPg0j+scXc5AL7Uadx41h+Q=;
 b=iR4kmvdyV/ZaYkmhVtyE8qa0q/p5nRWq/hgVWcQpjvji7VH6/t2YutICbE2prPh5FC
 ICaZaIaWB1bo6YQVuNSxzsNvOtfNLtp+FeMl/z0F4ehzFRt0kwRIToNY5Pkfzh1H8CfP
 MJwmpoXi+k3wtd7M7DkZtOOSqF5J7ogQi34AP4133pXDTPGOgeDaYw+DJKrDSJWq4ctg
 TBSX+SYDbKLIRW1XOd2UbixEmc/UJ4bulrMyCDk9rVY/iMVce4UhGKm77YX5WBhqxr4J
 +hx1krMM9tpwGDusAfTSK09hjL8LzV3GymAyAhMT3wZ3kDdPnIQM9+QQTIyegkrcUhTk
 C/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgNFr3/ezXsDZIl7tdWNOPg0j+scXc5AL7Uadx41h+Q=;
 b=koA+9Nz2BUdOeRKEZEmejnerNast2BjNJ/tehchEGDp42WUrGtY2fqQmblQvp1OZ/7
 n0JTRi/ObxBRBAKTj6grML8hqMAZO0QsxUrpM8vGRGesY72KT/Wsk0x8Dp+61g/7ZBwb
 hnqDBUOK26ugTKABEl8GeRmlKZ0goNZGud4yU4nAkataPKHqW6Y2ZDHbhYI+W1Ophm8F
 KnhVvFMviC8QPebBMz7RnctczLCIizPm+ZEJ2+alIcffJMPRHZX+QoacR0X4px01u6bi
 7zXmGTFeCs2Rq42pI7KkV+84DQ2wg1GFZ+fJTDmOE+V7pTyE6zlhCvlBbZK87BSXyEWT
 zz5A==
X-Gm-Message-State: AFqh2krgGkN8O3725r7ipUiotaex7RT9pQuzCbv69CPebmcOHK53SQO1
 gsMrooLiHdY+HTEwdjkCmtn4fbQ8UgpmAtxKnzY=
X-Google-Smtp-Source: AMrXdXutvktGPcR2EtUN7Ke7oh6I4rh95m6/IYTXGMnuxiqZ+nTUUC5M24rxo7waz2w83QJEg7IO8yclt232CZoJ0l8=
X-Received: by 2002:a17:90a:7f8d:b0:229:118f:c84c with SMTP id
 m13-20020a17090a7f8d00b00229118fc84cmr529502pjl.211.1673656622102; Fri, 13
 Jan 2023 16:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20230113223619.162405-1-parav@nvidia.com>
 <20230113223619.162405-2-parav@nvidia.com>
 <92b98f45dcd65facac78133c6250d9d96ea1a25f.camel@gmail.com>
 <PH0PR12MB5481C03EDED7C2D67395FCA4DCC29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAKgT0UenRh4gdcOOg3t7+JXXyu06daXE8U8a38oxUQWQ3UnQVg@mail.gmail.com>
In-Reply-To: <CAKgT0UenRh4gdcOOg3t7+JXXyu06daXE8U8a38oxUQWQ3UnQVg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 13 Jan 2023 16:36:50 -0800
Message-ID: <CAKgT0UdsazCNA+P7P_H5u36m9RELDPScBxwA6G=ZCjVH4ZEeDA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] virtio_net: Fix short frame length check
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gRnJpLCBKYW4gMTMsIDIwMjMgYXQgNDoyMyBQTSBBbGV4YW5kZXIgRHV5Y2sKPGFsZXhhbmRl
ci5kdXlja0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBKYW4gMTMsIDIwMjMgYXQgMzoz
NyBQTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiA+
IEZyb206IEFsZXhhbmRlciBIIER1eWNrIDxhbGV4YW5kZXIuZHV5Y2tAZ21haWwuY29tPgo+ID4g
PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTMsIDIwMjMgNjoyNCBQTQo+ID4gPgo+ID4gPiBPbiBT
YXQsIDIwMjMtMDEtMTQgYXQgMDA6MzYgKzAyMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4g
PiBBIHNtYWxsZXN0IEV0aGVybmV0IGZyYW1lIGRlZmluZWQgYnkgSUVFRSA4MDIuMyBpcyA2MCBi
eXRlcyB3aXRob3V0Cj4gPiA+ID4gYW55IHByZWVtYmxlIGFuZCBDUkMuCj4gPiA+ID4KPiA+ID4g
PiBDdXJyZW50IGNvZGUgb25seSBjaGVja3MgZm9yIG1pbmltYWwgMTQgYnl0ZXMgb2YgRXRoZXJu
ZXQgaGVhZGVyIGxlbmd0aC4KPiA+ID4gPiBDb3JyZWN0IGl0IHRvIGNvbnNpZGVyIHRoZSBtaW5p
bXVtIEV0aGVybmV0IGZyYW1lIGxlbmd0aC4KPiA+ID4gPgo+ID4gPiA+IEZpeGVzOiAyOTZmOTZm
Y2ZjMTYgKCJOZXQgZHJpdmVyIHVzaW5nIHZpcnRpbyIpCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
UGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyICstCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBpbmRleAo+
ID4gPiA+IDc3MjNiMmE0OWQ4ZS4uZDQ1ZTE0MGI2ODUyIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gPiA+IEBAIC0xMjQ4LDcgKzEyNDgsNyBAQCBzdGF0aWMgdm9pZCByZWNlaXZlX2J1
ZihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+ID4gc3RydWN0IHJlY2VpdmVfcXVldWUgKnJx
LAo+ID4gPiA+ICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwo+ID4gPiA+ICAgICBzdHJ1Y3Qgdmly
dGlvX25ldF9oZHJfbXJnX3J4YnVmICpoZHI7Cj4gPiA+ID4KPiA+ID4gPiAtICAgaWYgKHVubGlr
ZWx5KGxlbiA8IHZpLT5oZHJfbGVuICsgRVRIX0hMRU4pKSB7Cj4gPiA+ID4gKyAgIGlmICh1bmxp
a2VseShsZW4gPCB2aS0+aGRyX2xlbiArIEVUSF9aTEVOKSkgewo+ID4gPiA+ICAgICAgICAgICAg
IHByX2RlYnVnKCIlczogc2hvcnQgcGFja2V0ICVpXG4iLCBkZXYtPm5hbWUsIGxlbik7Cj4gPiA+
ID4gICAgICAgICAgICAgZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4gPiA+ID4gICAg
ICAgICAgICAgaWYgKHZpLT5tZXJnZWFibGVfcnhfYnVmcykgewo+ID4gPgo+ID4gPiBJJ20gbm90
IHN1cmUgSSBhZ3JlZSB3aXRoIHRoaXMgY2hhbmdlIGFzIHBhY2tldHMgYXJlIG9ubHkgNjBCIGlm
IHRoZXkgaGF2ZSBnb25lCj4gPiA+IGFjcm9zcyB0aGUgd2lyZSBhcyB0aGV5IGFyZSB1c3VhbGx5
IHBhZGRlZCBvdXQgb24gdGhlIHRyYW5zbWl0IHNpZGUuIFRoZXJlIG1heQo+ID4gPiBiZSBjYXNl
cyB3aGVyZSBzb2Z0d2FyZSByb3V0ZWQgcGFja2V0cyBtYXkgbm90IGJlIDYwQi4KPiA+ID4KPiA+
IERvIHlvdSBtZWFuIExpbnV4IGtlcm5lbCBzb2Z0d2FyZT8gQW55IGxpbmsgdG8gaXQgd291bGQg
YmUgaGVscGZ1bC4KPgo+IFRoZSBwcm9ibGVtIGlzIHRoZXJlIGFyZSBzZXZlcmFsIHNvZnR3YXJl
IHBhdGhzIGludm9sdmVkIGFuZCB0aGF0IGlzCj4gd2h5IEkgYW0gd2FudGluZyB0byBiZSBjYXV0
aW91cy4gQXMgSSByZWNhbGwgdGhpcyB3b3VsZCBpbXBhY3QgUWVtdQo+IGl0c2VsZiwgRFBESywg
dGhlIExpbnV4IEtlcm5lbCBhbmQgc2V2ZXJhbCBvdGhlcnMgaWYgSSBhbSBub3QKPiBtaXN0YWtl
bi4gVGhhdCBpcyB3aHkgSSBhbSB0ZW5kaW5nIHRvIGVyciBvbiB0aGUgc2lkZSBvZiBjYXV0aW9u
IGFzCj4gdGhpcyBpcyBhIHByZXR0eSBzaWduaWZpY2FudCBjaGFuZ2UuCj4KPiA+ID4gQXMgc3Vj
aCByYXRoZXIgdGhhbiBjaGFuZ2luZyBvdXQgRVRIX0hMRU4gZm9yIEVUSF9aTEVOIEkgd29uZGVy
IGlmIHdlCj4gPiA+IHNob3VsZCBsb29rIGF0IG1heWJlIG1ha2luZyB0aGlzIGEgIjw9IiBjb21w
YXJpc29uIGluc3RlYWQgc2luY2UgdGhhdCBpcyB0aGUKPiA+ID4gb25seSBjYXNlIEkgY2FuIHRo
aW5rIG9mIHdoZXJlIHRoZSBwYWNrZXQgd291bGQgZW5kIHVwIGJlaW5nIGVudGlyZWx5IGVtcHR5
Cj4gPiA+IGFmdGVyIGV0aF90eXBlX3RyYW5zIGlzIGNhbGxlZCBhbmQgd2Ugd291bGQgYmUgcGFz
c2luZyBhbiBza2Igd2l0aCBsZW5ndGggMC4KPiA+Cj4gPiBJIGxpa2VseSBkaWRu4oCZdCB1bmRl
cnN0YW5kIHlvdXIgY29tbWVudC4KPiA+IFRoaXMgZHJpdmVyIGNoZWNrIGlzIGJlZm9yZSBjcmVh
dGluZyB0aGUgc2tiIGZvciB0aGUgcmVjZWl2ZWQgcGFja2V0Lgo+ID4gU28sIHB1cnBvc2UgaXMg
dG8gbm90IGV2ZW4gcHJvY2VzcyB0aGUgcGFja2V0IGhlYWRlciBvciBwcmVwYXJlIHRoZSBza2Ig
aWYgaXQgbm90IGFuIEV0aGVybmV0IGZyYW1lLgo+ID4KPiA+IEl0IGlzIGludGVyZXN0aW5nIHRv
IGtub3cgd2hlbiB3ZSBnZXQgPCA2MEIgZnJhbWUuCj4KPiBJZiBJIHJlY2FsbCwgYSBVRFB2NCBm
cmFtZSBjYW4gZWFzaWx5IGRvIGl0IHNpbmNlIEV0aGVybmV0IGlzIDE0QiwgSVAKPiBoZWFkZXIg
aXMgMjAsIGFuZCBVRFAgaXMgb25seSA4IHNvIHRoYXQgb25seSBjb21lcyB0byA0MkIgaWYgSSBy
ZWNhbGwKPiBjb3JyZWN0bHkuIFNpbWlsYXJseSBJIHRoaW5rIGEgVENQdjQgRnJhbWUgY2FuIGJl
IGFzIHNtYWxsIGFzIDU0QiBpZgo+IHlvdSBkaXNhYmxlIGFsbCB0aGUgb3B0aW9uIGhlYWRlcnMu
Cj4KPiBBIHF1aWNrIGFuZCBkaXJ0eSB0ZXN0IHdvdWxkIGJlIHRvIHJ1biBzb21ldGhpbmcgbGlr
ZSBhIG5ldHBlcmYgVURQX1JSCj4gdGVzdC4gSSBrbm93IGluIHRoZSBjYXNlIG9mIHRoZSBuZXR3
b3JrIHN0YWNrIHdlIHNlZSB0aGUgdHJhbnNtaXRzCj4gdGhhdCBnbyBvdXQgYXJlIGxlc3MgdGhh
biA2MEIgdW50aWwgdGhleSBhcmUgcGFkZGVkIG9uIHhtaXQsIHVzdWFsbHkKPiBieSB0aGUgZGV2
aWNlLiBNeSBjb25jZXJuIGlzIHdhbnRpbmcgdG8gbWFrZSBzdXJlIGFsbCB0aG9zZSBwYXRocyBh
cmUKPiBjb3ZlcmVkIGJlZm9yZSB3ZSBhc3N1bWUgdGhhdCBhbGwgdGhlIHBhY2tldHMgd2lsbCBi
ZSBwYWRkZWQuCgpJIHdhcyBjdXJpb3VzIHNvIEkgZGVjaWRlZCB0byB0cnkgdmVyaWZ5aW5nIHRo
aW5ncyB3aXRoIGEgcWVtdSB3LyB1c2VyCm5ldHdvcmtpbmcgYW5kIHZpcnRpby1uZXQuIEZyb20g
d2hhdCBJIGNhbiB0ZWxsIGl0IGxvb2tzIGxpa2UgaXQgaXMKZGVmaW5pdGVseSBub3QgcGFkZGlu
ZyB0aGVtIG91dC4KCjE5OjM0OjM4LjMzMTM3NiBJUCAodG9zIDB4MCwgdHRsIDY0LCBpZCAzMTc5
OSwgb2Zmc2V0IDAsIGZsYWdzIFtERl0sCnByb3RvIFVEUCAoMTcpLCBsZW5ndGggMjkpCiAgICBs
b2NhbGhvc3QubG9jYWxkb21haW4uNTk1NzkgPiBfZ2F0ZXdheS41MjcwMTogW3VkcCBzdW0gb2td
IFVEUCwgbGVuZ3RoIDEKICAgICAgICAweDAwMDA6ICA1MjU1IDBhMDAgMDIwMiA1MjU0IDAwMTIg
MzQ1NiAwODAwIDQ1MDAKICAgICAgICAweDAwMTA6ICAwMDFkIDdjMzcgNDAwMCA0MDExIGE2ODgg
MGEwMCAwMjBmIDBhMDAKICAgICAgICAweDAwMjA6ICAwMjAyIGU4YmIgY2RkZCAwMDA5IGMzMzEg
NmUKMTk6MzQ6MzguMzMxNDMxIElQICh0b3MgMHgwLCB0dGwgNjQsIGlkIDQ1NDU5LCBvZmZzZXQg
MCwgZmxhZ3MgW25vbmVdLApwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDI5KQogICAgX2dhdGV3YXku
NTI3MDEgPiBsb2NhbGhvc3QubG9jYWxkb21haW4uNTk1Nzk6IFt1ZHAgc3VtIG9rXSBVRFAsIGxl
bmd0aCAxCiAgICAgICAgMHgwMDAwOiAgNTI1NCAwMDEyIDM0NTYgNTI1NSAwYTAwIDAyMDIgMDgw
MCA0NTAwCiAgICAgICAgMHgwMDEwOiAgMDAxZCBiMTkzIDAwMDAgNDAxMSBiMTJjIDBhMDAgMDIw
MiAwYTAwCiAgICAgICAgMHgwMDIwOiAgMDIwZiBjZGRkIGU4YmIgMDAwOSBjMzMxIDZlCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
