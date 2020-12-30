Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF07C433E0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 08:38:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66749216C4
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 08:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66749216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2294E8717B;
	Wed, 30 Dec 2020 08:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5cC7xojt+9LM; Wed, 30 Dec 2020 08:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E27858716A;
	Wed, 30 Dec 2020 08:38:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF955C088B;
	Wed, 30 Dec 2020 08:38:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69710C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5AE9887176
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4Aryie8g7B2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:38:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3E7998716A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609317515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXGRrEKfp1XBbzT9rwci0lnhPFNMUzMfAOk3WaXRwXc=;
 b=XcYUoEIFbk11IlGxCnyZoKVmXAcBp4NGU21FDIJq7f9y3HmcgDZ1ush9Ptut6eBRLDoV0g
 rpORLHZhJsFG5JNZ9qhe4drNVEu1NNXgB70AJOirToyz+leDqKzGAEWMUhp07JjUDN4wMU
 EKqyoqB7PCKVRY1v3SvdKLGdA9jThaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-jAD8VXo4PrC8U1bHMtDoXQ-1; Wed, 30 Dec 2020 03:38:30 -0500
X-MC-Unique: jAD8VXo4PrC8U1bHMtDoXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD14C425E0;
 Wed, 30 Dec 2020 08:38:29 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC291A262;
 Wed, 30 Dec 2020 08:38:22 +0000 (UTC)
Subject: Re: [PATCH rfc 2/3] virtio-net: support receive timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20201228122253-mutt-send-email-mst@kernel.org>
 <CA+FuTScguDWkvk=Lc+GzP=UCK2wjRFNJ_GEn_bniHpCDWdkfjg@mail.gmail.com>
 <20201228162903-mutt-send-email-mst@kernel.org>
 <CA+FuTSffjFZGGwpMkpnTBbHHwnJN7if=0cVf0Des7Db5UFe0bw@mail.gmail.com>
 <1881606476.40780520.1609233449300.JavaMail.zimbra@redhat.com>
 <CA+FuTScycxSHqxvZZRjK9+tpXVV2iTv8vqeFc5U_m2CGDR3jog@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da66cc7b-826c-cb55-8825-b6d3687a1e3c@redhat.com>
Date: Wed, 30 Dec 2020 16:38:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+FuTScycxSHqxvZZRjK9+tpXVV2iTv8vqeFc5U_m2CGDR3jog@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2IMTA6MjAsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24g
VHVlLCBEZWMgMjksIDIwMjAgYXQgNDoyMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4KPj4gLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+Pj4gT24g
TW9uLCBEZWMgMjgsIDIwMjAgYXQgNzo1NSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiBPbiBNb24sIERlYyAyOCwgMjAyMCBhdCAwMjozMDozMVBNIC0w
NTAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+Pj4+PiBPbiBNb24sIERlYyAyOCwgMjAyMCBh
dCAxMjoyOSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pj4+PiB3cm90
ZToKPj4+Pj4+IE9uIE1vbiwgRGVjIDI4LCAyMDIwIGF0IDExOjIyOjMyQU0gLTA1MDAsIFdpbGxl
bSBkZSBCcnVpam4gd3JvdGU6Cj4+Pj4+Pj4gRnJvbTogV2lsbGVtIGRlIEJydWlqbiA8d2lsbGVt
YkBnb29nbGUuY29tPgo+Pj4+Pj4+Cj4+Pj4+Pj4gQWRkIG9wdGlvbmFsIFBUUCBoYXJkd2FyZSB0
aW1lc3RhbXAgb2ZmbG9hZCBmb3IgdmlydGlvLW5ldC4KPj4+Pj4+Pgo+Pj4+Pj4+IEFjY3VyYXRl
IFJUVCBtZWFzdXJlbWVudCByZXF1aXJlcyB0aW1lc3RhbXBzIGNsb3NlIHRvIHRoZSB3aXJlLgo+
Pj4+Pj4+IEludHJvZHVjZSB2aXJ0aW8gZmVhdHVyZSBWSVJUSU9fTkVUX0ZfUlhfVFNUQU1QLiBJ
ZiBuZWdvdGlhdGVkLCB0aGUKPj4+Pj4+PiB2aXJ0aW8tbmV0IGhlYWRlciBpcyBleHBhbmRlZCB3
aXRoIHJvb20gZm9yIGEgdGltZXN0YW1wLiBBIGhvc3QgbWF5Cj4+Pj4+Pj4gcGFzcyByZWNlaXZl
IHRpbWVzdGFtcHMgZm9yIGFsbCBvciBzb21lIHBhY2tldHMuIEEgdGltZXN0YW1wIGlzIHZhbGlk
Cj4+Pj4+Pj4gaWYgbm9uLXplcm8uCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUgdGltZXN0YW1wIHN0cmFk
ZGxlcyAodmlydHVhbCkgaGFyZHdhcmUgZG9tYWlucy4gTGlrZSBQVFAsIHVzZQo+Pj4+Pj4+IGlu
dGVybmF0aW9uYWwgYXRvbWljIHRpbWUgKENMT0NLX1RBSSkgYXMgZ2xvYmFsIGNsb2NrIGJhc2Uu
IEl0IGlzCj4+Pj4+Pj4gZ3Vlc3QgcmVzcG9uc2liaWxpdHkgdG8gc3luYyB3aXRoIGhvc3QsIGUu
Zy4sIHRocm91Z2gga3ZtLWNsb2NrLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogV2ls
bGVtIGRlIEJydWlqbiA8d2lsbGVtYkBnb29nbGUuY29tPgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4+Pj4+Pj4gYi9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX25ldC5oCj4+Pj4+Pj4gaW5kZXggZjY4ODFiNWI3N2VlLi4wZmZlMmVlZWJkNGEg
MTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaAo+Pj4+
Pj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgKPj4+Pj4+PiBAQCAtNTcs
NiArNTcsNyBAQAo+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqIFN0ZWVyaW5nICovCj4+Pj4+Pj4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9DVFJMX01BQ19B
RERSIDIzICAgICAgICAvKiBTZXQgTUFDIGFkZHJlc3MgKi8KPj4+Pj4+Pgo+Pj4+Pj4+ICsjZGVm
aW5lIFZJUlRJT19ORVRfRl9SWF9UU1RBTVAgICAgICAgICA1NSAgICAvKiBIb3N0IHNlbmRzIFRB
SQo+Pj4+Pj4+IHJlY2VpdmUgdGltZSAqLwo+Pj4+Pj4+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0Zf
VFhfSEFTSCAgIDU2ICAgIC8qIEd1ZXN0IHNlbmRzIGhhc2ggcmVwb3J0ICovCj4+Pj4+Pj4gICAj
ZGVmaW5lIFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCAgNTcgLyogU3VwcG9ydHMgaGFzaCByZXBv
cnQgKi8KPj4+Pj4+PiAgICNkZWZpbmUgVklSVElPX05FVF9GX1JTUyAgICAgICA2MCAgICAvKiBT
dXBwb3J0cyBSU1MgUlggc3RlZXJpbmcgKi8KPj4+Pj4+PiBAQCAtMTgyLDYgKzE4MywxNyBAQCBz
dHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCB7Cj4+Pj4+Pj4gICAgICAgIH07Cj4+Pj4+Pj4g
ICB9Owo+Pj4+Pj4+Cj4+Pj4+Pj4gK3N0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MTIgewo+Pj4+Pj4+
ICsgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MSBoZHI7Cj4+Pj4+Pj4gKyAgICAgc3RydWN0
IHsKPj4+Pj4+PiArICAgICAgICAgICAgIF9fbGUzMiB2YWx1ZTsKPj4+Pj4+PiArICAgICAgICAg
ICAgIF9fbGUxNiByZXBvcnQ7Cj4+Pj4+Pj4gKyAgICAgICAgICAgICBfX2xlMTYgZmxvd19zdGF0
ZTsKPj4+Pj4+PiArICAgICB9IGhhc2g7Cj4+Pj4+Pj4gKyAgICAgX192aXJ0aW8zMiByZXNlcnZl
ZDsKPj4+Pj4+PiArICAgICBfX3ZpcnRpbzY0IHRzdGFtcDsKPj4+Pj4+PiArfTsKPj4+Pj4+PiAr
Cj4+Pj4+Pj4gICAjaWZuZGVmIFZJUlRJT19ORVRfTk9fTEVHQUNZCj4+Pj4+Pj4gICAvKiBUaGlz
IGhlYWRlciBjb21lcyBmaXJzdCBpbiB0aGUgc2NhdHRlci1nYXRoZXIgbGlzdC4KPj4+Pj4+PiAg
ICAqIEZvciBsZWdhY3kgdmlydGlvLCBpZiBWSVJUSU9fRl9BTllfTEFZT1VUIGlzIG5vdCBuZWdv
dGlhdGVkLCBpdAo+Pj4+Pj4+ICAgIG11c3QKPj4+Pj4+Cj4+Pj4+PiBTbyBpdCBsb29rcyBsaWtl
IFZJUlRJT19ORVRfRl9SWF9UU1RBTVAgc2hvdWxkIGRlcGVuZCBvbiBib3RoCj4+Pj4+PiBWSVJU
SU9fTkVUX0ZfUlhfVFNUQU1QIGFuZCBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQgdGhlbj8KPj4+
Pj4gRG8geW91IG1lYW4gVklSVElPX05FVF9GX1RYX1RTVEFNUCBkZXBlbmRzIG9uIFZJUlRJT19O
RVRfRl9SWF9UU1RBTVA/Cj4+Pj4+Cj4+Pj4+IEkgdGhpbmsgaWYgZWl0aGVyIGlzIGVuYWJsZWQg
d2UgbmVlZCB0byBlbmFibGUgdGhlIGV4dGVuZGVkIGxheW91dC4KPj4+Pj4gUmVnYXJkbGVzcyBv
ZiB3aGV0aGVyIFRYX0hBU0ggb3IgSEFTSF9SRVBPUlQgYXJlIGVuYWJsZWQuIElmIHRoZXkgYXJl
Cj4+Pj4+IG5vdCwgdGhlbiB0aG9zZSBmaWVsZHMgYXJlIGlnbm9yZWQuCj4+Pj4gSSBtZWFuIGRv
IHdlIHdhc3RlIHRoZSA4IGJ5dGVzIGZvciBoYXNoIGlmIFRTVEFNUCBpcyBzZXQgYnV0IEhBU0gg
aXMgbm90Pwo+Pj4+IElmIFRTVEFNUCBkZXBlbmRzIG9uIEhBU0ggdGhlbiBwb2ludCBpcyBtb290
Lgo+Pj4gVHJ1ZSwgYnV0IHRoZSB0d28gZmVhdHVyZXMgcmVhbGx5IGFyZSBpbmRlcGVuZGVudC4K
Pj4+Cj4+PiBJIGRpZCBjb25zaWRlciB1c2luZyBjb25maWd1cmFibGUgbWV0YWRhdGEgbGF5b3V0
IGRlcGVuZGluZyBvbgo+Pj4gZmVhdHVyZXMgbmVnb3RpYXRlZC4gSWYgdGhlcmUgYXJlIHRvbnMg
b2Ygb3B0aW9uYWwgZXh0ZW5zaW9ucywgdGhhdAo+Pj4gbWFrZXMgc2Vuc2UuIEJ1dCBpdCBpcyBt
b3JlIGNvbXBsZXggYW5kIHBhcnNpbmcgZXJyb3IgcHJvbmUuIFdpdGggYQo+Pj4gaGFuZGZ1bCBv
ZiBvcHRpb25zIGVhY2ggb2YgYSBmZXcgYnl0ZXMsIHRoYXQgZGlkIG5vdCBzZWVtIHdvcnRoIHRo
ZQo+Pj4gY29zdCB0byBtZSBhdCB0aGlzIHBvaW50Lgo+PiBDb25zaWRlciBORlYgd29ya2xvYWRz
KDY0QikgcGFja2V0LiBNb3N0IGZpZWxkcyBvZiBjdXJyZW50IHZuZXQgaGVhZGVyCj4+IGlzIGV2
ZW4gYSBidXJkZXJuLgo+IFN1Y2ggd29ya2xvYWRzIHdpbGwgbm90IG5lZ290aWF0ZSB0aGVzZSBm
ZWF0dXJlcywgSSBpbWFnaW5lLgo+Cj4gSSB0aGluayB0aGlzIGNvdWxkIG9ubHkgYmVjb21lIGFu
IGlzc3VlIGlmIGEgc21hbGwgcGFja2V0IHdvcmtsb2FkCj4gd291bGQgd2FudCB0byBuZWdvdGlh
dGUgb25lIG9wdGlvbmFsIGZlYXR1cmUsIHdpdGhvdXQgdGhlIG90aGVycy4KCgpZZXMuCgoKPiBF
dmVuIHRoZW4sIHRoZSBhY3R1YWwgY29zdCBvZiBhIGZldyB1bnRvdWNoZWQgYnl0ZXMgaXMgbmVn
bGlnaWJsZSwgYXMKPiBsb25nIGFzIHRoZSBoZWFkZXJzIGRvbid0IHNwYW4gY2FjaGUtbGluZXMu
CgoKUmlnaHQuIEl0IGxvb2tzIHRvIG1lIHdpdGggaGFzaCByZXBvcnQgc3VwcG9ydCB0aGUgY3Vy
cmVudCBoZWFkZXIgaGFzIApleGNlZWRzIDMyIGJ5dGVzIHdoaWNoIGlzIHRoZSBjYWNoZWxpbmUg
c2l6ZSBmb3Igc29tZSBhcmNocy4gQW5kIGl0IGNhbiAKYmUgaW1hZ2luZWQgdGhhdCBhZnRlciB0
d28gb3IgbW9yZSBmZWF0dXJlcyBpdCBjb3VsZCBiZSBsYXJnZXIgdGhhbiA2NCAKYnl0ZXMuCgoK
PiAgIEkgZXhwZWN0IGl0IHRvIGJlIGNoZWFwZXIKPiB0aGFuIGhhdmluZyB0byBwYXJzZSBhIGR5
bmFtaWMgbGF5b3V0LgoKClRoZSBvbmx5IG92ZXJoZWFkIGlzIHByb2JhYmx5IGFuYWx5emluZyAi
dHlwZSIgd2hpY2ggc2hvdWxkIGJlIGNoZWFwIEkgCmd1ZXNzLgoKCj4KPj4gSXQgbWlnaHQgYmUg
dGhlIHRpbWUgdG8gaW50cm9kdWNlIGNvbmZpZ3VyYWJsZSBvcgo+PiBzZWxmLWRlc2NyaXB0aXZl
IHZuZXQgaGVhZGVyLgo+IEkgZGlkIGJyaWVmbHkgdG95IHdpdGggYSB0eXBlLXZhbCBlbmNvZGlu
Zy4gTm90IHR5cGUtdmFsLWxlbiwgYXMgYWxsCj4gb3B0aW9ucyBoYXZlIGZpeGVkIGxlbmd0aCAo
c28gZmFyKSwgc28gbGVuZ3RoIGNhbiBiZSBsZWZ0IGltcGxpY2l0Lgo+IEJ1dCBhcyBlYWNoIGZl
YXR1cmUgaXMgbmVnb3RpYXRlZCBiZWZvcmUgaGFuZCwgdGhlIHR5cGUgY2FuIGJlIGxlZnQKPiBp
bXBsaWNpdCB0b28uIExlYXZpbmcganVzdCB0aGUgZGF0YSBlbGVtZW50cyB0aWdodGx5IHBhY2tl
ZC4gQXMgbG9uZwo+IGFzIG9yZGVyIGlzIGRlZmluZWQuCgoKUmlnaHQsIHNvIGluIHRoaXMgY2Fz
ZSB0aGVyZSBzaG91bGQgYmUgZXZlbiBubyBvdmVyaGVhZC4KCgo+Cj4+PiBBbmQgaW1wb3J0YW50
bHksIHN1Y2ggYSBtb2RlIGNhbiBhbHdheXMgYmUgYWRkZWQgbGF0ZXIgYXMgYSBzZXBhcmF0ZQo+
Pj4gVklSVElPX05FVF9GX1BBQ0tFRF9IRUFERVIgb3B0aW9uLgo+PiBXaGF0IHdpbGwgZG8gZmVh
dHVyZSBwcm92aWRlPwo+IFRoZSB0aWdodGx5IHBhY2tlZCBkYXRhIGVsZW1lbnRzLiBTdHJpcCBv
dXQgdGhlIGVsZW1lbnRzIGZvciBub24KPiBuZWdvdGlhdGVkIGZlYXR1cmVzLiBTbyBpZiBlaXRo
ZXIgdHN0YW1wIG9wdGlvbiBpcyBuZWdvdGlhdGVkLCBidXQKPiBoYXNoIGlzIG5vdCwgZXhjbHVk
ZSB0aGUgNjRiIG9mIGhhc2ggZmllbGRzLiBOb3RlIHRoYXQgSSdtIG5vdAo+IGFjdHVhbGx5IGFy
Z3VpbmcgZm9yIHRoaXMgKGF0IHRoaXMgcG9pbnQpLgoKCkkgc2Vjb25kIGZvciB0aGlzLgoKVGhh
bmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
