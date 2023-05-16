Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD16C77B7F
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 17:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D1636114B;
	Tue, 16 May 2023 17:07:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D1636114B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QHItLCNtNnE3; Tue, 16 May 2023 17:07:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8819261119;
	Tue, 16 May 2023 17:07:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8819261119
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D133C0037;
	Tue, 16 May 2023 17:07:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE12BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7FBF40514
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:07:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7FBF40514
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ob72TYRg5KH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:07:42 +0000 (UTC)
X-Greylist: delayed 01:10:43 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDD8D400E5
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDD8D400E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 17:07:41 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:50950)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pyx2l-0025sd-8t; Tue, 16 May 2023 09:56:55 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:40674
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pyx2j-006GOt-S4; Tue, 16 May 2023 09:56:54 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
Date: Tue, 16 May 2023 10:56:45 -0500
In-Reply-To: <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
 (Linus Torvalds's message of "Mon, 15 May 2023 15:54:49 -0700")
Message-ID: <87cz30s20y.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1pyx2j-006GOt-S4; ; ;
 mid=<87cz30s20y.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX1/VfBwRPfud8jr0vc2IuGNU4bzbZFMEkfc=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Oleg Nesterov <oleg@redhat.com>, Thorsten Leemhuis <linux@leemhuis.info>,
 hch@infradead.org, stefanha@redhat.com, nicolas.dichtel@6wind.com,
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

TGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cml0ZXM6Cgo+
IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDM6MjPigK9QTSBNaWtlIENocmlzdGllCj4gPG1pY2hh
ZWwuY2hyaXN0aWVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+Cj4+IFRoZSB2aG9zdCBsYXllciByZWFs
bHkgZG9lc24ndCB3YW50IGFueSBzaWduYWxzIGFuZCB3YW50cyB0byB3b3JrIGxpa2Uga3RocmVh
ZHMKPj4gZm9yIHRoYXQgY2FzZS4gVG8gbWFrZSBpdCByZWFsbHkgc2ltcGxlIGNhbiB3ZSBkbyBz
b21ldGhpbmcgbGlrZSB0aGlzIHdoZXJlIGl0Cj4+IHNlcGFyYXRlcyB1c2VyIGFuZCBpbyB3b3Jr
ZXIgYmVoYXZpb3Igd2hlcmUgdGhlIG1ham9yIGRpZmYgaXMgaG93IHRoZXkgaGFuZGxlCj4+IHNp
Z25hbHMgYW5kIGV4aXQuIEkgYWxzbyBpbmNsdWRlZCBhIGZpeCBmb3IgdGhlIGZyZWV6ZSBjYXNl
Ogo+Cj4gSSBkb24ndCBsb3ZlIHRoZSBTSUdLSUxMIHNwZWNpYWwgY2FzZSwgYnV0IEkgYWxzbyBk
b24ndCBmaW5kIHRoaXMKPiBkZWVwbHkgb2ZmZW5zaXZlLiBTbyBpZiB0aGlzIGlzIHdoYXQgaXQg
dGFrZXMsIEknbSBvayB3aXRoIGl0Lgo+Cj4gSSB3b25kZXIgaWYgd2UgY291bGQgbWFrZSB0aGF0
IHNwZWNpYWwgY2FzZSBzaW1wbHkgY2hlY2sgZm9yICJpcwo+IFNJR0tJTEwgYmxvY2tlZCIgaW5z
dGVhZD8gTm8gbm9ybWFsIGNhc2Ugd2lsbCBjYXVzZSB0aGF0LCBhbmQgaXQgbWVhbnMKPiB0aGF0
IGEgUEZfVVNFUl9XT1JLRVIgdGhyZWFkIGNvdWxkIGRlY2lkZSBwZXItdGhyZWFkIHdoYXQgaXQg
d2FudHMgdG8KPiBkbyB3cnQgU0lHS0lMTC4KCkEga2VybmVsIHRocmVhZCBjYW4gYmxvY2sgU0lH
S0lMTCBhbmQgdGhhdCBpcyBzdXBwb3J0ZWQuCgpGb3IgYSB0aHJlYWQgdGhhdCBpcyBwYXJ0IG9m
IGEgcHJvY2VzcyB5b3UgY2FuJ3QgYmxvY2sgU0lHS0lMTCB3aGVuIHRoZQp0YXNrIGlzIHBhcnQg
b2YgYSB1c2VyIG1vZGUgcHJvY2Vzcy4KClRoZXJlIGlzIHRoaXMgYml0IGluIGNvbXBsZXRlX3Np
Z25hbCB3aGVuIFNJR0tJTEwgaXMgZGVsaXZlcmVkIHRvIGFueQp0aHJlYWQgaW4gdGhlIHByb2Nl
c3MuCgoKCQkJLyoKCQkJICogU3RhcnQgYSBncm91cCBleGl0IGFuZCB3YWtlIGV2ZXJ5Ym9keSB1
cC4KCQkJICogVGhpcyB3YXkgd2UgZG9uJ3QgaGF2ZSBvdGhlciB0aHJlYWRzCgkJCSAqIHJ1bm5p
bmcgYW5kIGRvaW5nIHRoaW5ncyBhZnRlciBhIHNsb3dlcgoJCQkgKiB0aHJlYWQgaGFzIHRoZSBm
YXRhbCBzaWduYWwgcGVuZGluZy4KCQkJICovCgkJCXNpZ25hbC0+ZmxhZ3MgPSBTSUdOQUxfR1JP
VVBfRVhJVDsKCQkJc2lnbmFsLT5ncm91cF9leGl0X2NvZGUgPSBzaWc7CgkJCXNpZ25hbC0+Z3Jv
dXBfc3RvcF9jb3VudCA9IDA7CgkJCXQgPSBwOwoJCQlkbyB7CgkJCQl0YXNrX2NsZWFyX2pvYmN0
bF9wZW5kaW5nKHQsIEpPQkNUTF9QRU5ESU5HX01BU0spOwoJCQkJc2lnYWRkc2V0KCZ0LT5wZW5k
aW5nLnNpZ25hbCwgU0lHS0lMTCk7CgkJCQlzaWduYWxfd2FrZV91cCh0LCAxKTsKCQkJfSB3aGls
ZV9lYWNoX3RocmVhZChwLCB0KTsKCkZvciBjbGFyaXR5IHRoYXQgc2lnYWRkc2V0KCZ0LT5wZW5k
aW5nLnNpZ25hbCwgU0lHS0lMTCk7ICBSZWFsbHkgaXNuJ3QKc2V0dGluZyBTSUdLSUxMIHBlbmRp
bmcsIGl0IGlzIHBhcnQgb2YgdGhlIHNob3J0IGNpcmN1aXQgZGVsaXZlcnkgbG9naWMsCmFuZCB0
aGF0IHNpZ2FkZHNldChTSUdLSUxMKSBpcyBqdXN0IHNldHRpbmcgYSBmbGFnIHRvIHRlbGwgdGhl
IHByb2Nlc3MKaXQgbmVlZHMgdG8gZGllLgoKClRoZSBpbXBvcnRhbnQgcGFydCBvZiB0aGF0IGNv
ZGUgaXMgdGhhdCBTSUdOQUxfR1JPVVBfRVhJVCBnZXRzIHNldC4KVGhhdCBpbmRpY2F0ZXMgdGhl
IGVudGlyZSBwcm9jZXNzIGlzIGJlaW5nIHRvcm4gZG93bi4KCldoZXJlIHRoaXMgYmVjb21lcyBp
bXBvcnRhbnQgaXMgZXhpdF9ub3RpZnkgYW5kIHJlbGVhc2VfdGFzayB3b3JrCnRvZ2V0aGVyIHRv
IGVuc3VyZSB0aGF0IHRoZSBmaXJzdCB0aHJlYWQgaW4gdGhlIHByb2Nlc3MgKGEgdXNlciBzcGFj
ZQp0aHJlYWQgdGhhdCBjYW4gbm90IGJsb2NrIFNJR0tJTEwpIHdpbGwgbm90IHNlbmQgU0lHQ0hM
RCB0byBpdCdzIHBhcmVudApwcm9jZXNzIHVudGlsIGV2ZXJ5IHRocmVhZCBpbiB0aGUgcHJvY2Vz
cyBoYXMgZXhpdGVkLgoKVGhlIGRlbGF5X2dyb3VwX2xlYWRlciBsb2dpYyBpbiB3YWl0X2NvbnNp
ZGVyX3Rhc2sgcGFydCBvZiB3YWl0KDIpIGhhcwp0aGUgc2FtZSBsb2dpYy4KCkhhdmluZyBiZWVu
IHRocm91Z2ggdGhpcyB3aXRoIGlvX3VyaW5nIHRoZSB0aHJlYWRzIHJlYWxseSBuZWVkIHRvIGNh
bGwKZ2V0X3NpZ25hbCB0byBoYW5kbGUgdGhhdCBjYXNlLgoKClRoaXMgaXMgcHJldHR5IG11Y2gg
d2h5IEkgc2FpZCBhdCB0aGUgb3V0c2V0IHlvdSB0aGV5IG5lZWRlZCB0byBkZWNpZGVkCmlmIHRo
ZXkgd2VyZSBnb2luZyB0byBpbXBsZW1lbnQgYSB0aHJlYWQgb3IgaWYgdGhleSB3ZXJlIGdvaW5n
IHRvIGJlIGEKcHJvY2Vzcy4gIENoYW5naW5nIHRoZSBkZWNpc2lvbiB0byBiZSBhIHRocmVhZCBm
cm9tIGEgcHJvY2VzcyBpcyBmaW5lCmJ1dCBpbiB0aGF0IGNhc2UgdGhlIHZob3N0IGxvZ2ljIG5l
ZWRzIHRvIGFjdCBsaWtlIGEgcHJvY2VzcywganVzdApsaWtlIGlvX3VyaW5nIGRvZXMuCgoKPiBD
aHJpc3RpYW4/IEFuZCBJIGd1ZXNzIHdlIHNob3VsZCBDYzogT2xlZyB0b28sIHNpbmNlIHRoZSBz
aWduYWwgcGFydHMKPiBhcmUgYW4gYXJlYSBoZSdzIGZhbWlsaWFyIHdpdGggYW5kIGhhcyB3b3Jr
ZWQgb24uLiBFcmljIEJpZWRlcm1hbiBoYXMKPiBhbHJlYWR5IGJlZW4gb24gdGhlIGxpc3QgYW5k
IGhhcyBhbHNvIGJlZW4gaW52b2x2ZWQKCj4KPiBPbGVnOiBzZWUKPgo+ICAgaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8xMjJiNTk3ZS1hNWZhLWRhZjctMjdiYi02ZjA0ZmE5OGQ0OTZAb3Jh
Y2xlLmNvbS8KPgo+IGZvciB0aGUgY29udGV4dCBoZXJlLgoKRXJpYwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
