Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825CCC4320E
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 16:37:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325C760F11
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 16:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 325C760F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9D31402BF;
	Mon, 26 Jul 2021 16:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mc2uaUMUtTlR; Mon, 26 Jul 2021 16:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 469EB402A9;
	Mon, 26 Jul 2021 16:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB307C0010;
	Mon, 26 Jul 2021 16:37:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0241EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 16:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E411A60708
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 16:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWGwyjq9oemm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 16:37:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6203605F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 16:37:25 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 v8-20020a0568301bc8b02904d5b4e5ca3aso9694892ota.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7eA3rP3aWeS+yKeUdalJiZZ3+MRB3dmDKKblxGisnlw=;
 b=GssCdZ2Cb0jSmDpxOFe0MlOWTQWWl7WaUOyiC9YvkNMAhFbA8+vipsdUyaxdGtobKA
 +K9PgtULjSODzEx2u8I7sTNIvS6qGDyD6JeL8jCcNYF4pPFMF2j+eYlYVuNHpoN0g9Tw
 6OSO2ji0ZrOa5xj53nkTXCINZ0qaiy0AbwS+u7bMZbm7OphnOiJnlAbJwjQJmchyljUT
 FNjz8XPoNOOpFvzVdgiGHSl71pTT7twCKMhLE196N7WdLWtAjIZX1mQhORzy32E0X7F5
 CiGsC89e2rREx538wrVgl2sL/kPUhgzQDJ+FCKmlrMAiIz+fMdQvlPwbjTyNNrMqw3M2
 qbeg==
X-Gm-Message-State: AOAM533/ssPGIH7RRJlqymRdV15mYffqR9FY1RBQwHWRsbR/yrm/WzPj
 0onFmQFxDqW4iFVYGLSBHRESkisdAfzhVtp7y/c=
X-Google-Smtp-Source: ABdhPJx5k6Wln1bzY8Oi4eCitpGpORwmKPZ8bqs2YffzycATwB2RqMeEuPCjlxvSObMYzzHxoeWLw1jLujkzVW/AGvY=
X-Received: by 2002:a9d:2968:: with SMTP id d95mr12468577otb.321.1627317444886; 
 Mon, 26 Jul 2021 09:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210713161906.457857-1-stefanha@redhat.com>
 <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
 <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
 <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
 <YP7SEkDEIBOch9U8@stefanha-x1.localdomain>
 <CAJZ5v0h+RrRP-3MtV8dgxmba0rDfqoOw54DsFh0yx3YGUAVRqw@mail.gmail.com>
 <YP7cTjrfipfsJe9O@stefanha-x1.localdomain>
In-Reply-To: <YP7cTjrfipfsJe9O@stefanha-x1.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Jul 2021 18:37:13 +0200
Message-ID: <CAJZ5v0i4+2xda4Z6=JwRQf4ZzM2_agiyCwhMDRzAC-yz39fGzg@mail.gmail.com>
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Linux PM <linux-pm@vger.kernel.org>,
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

T24gTW9uLCBKdWwgMjYsIDIwMjEgYXQgNjowNCBQTSBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdWwgMjYsIDIwMjEgYXQgMDU6NDc6MTlQ
TSArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6Cj4gPiBPbiBNb24sIEp1bCAyNiwgMjAy
MSBhdCA1OjE3IFBNIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+Cj4gPiA+IE9uIFRodSwgSnVsIDIyLCAyMDIxIGF0IDA1OjA0OjU3UE0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiDlnKggMjAyMS83LzIxIOS4i+WNiDU6NDEs
IFN0ZWZhbiBIYWpub2N6aSDlhpnpgZM6Cj4gPiA+ID4gPiBPbiBXZWQsIEp1bCAyMSwgMjAyMSBh
dCAxMToyOTo1NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiDlnKggMjAy
MS83LzE0IOS4iuWNiDEyOjE5LCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+ID4gPiA+ID4gPiA+
IFRoZXNlIHBhdGNoZXMgYXJlIG5vdCBwb2xpc2hlZCB5ZXQgYnV0IEkgd291bGQgbGlrZSByZXF1
ZXN0IGZlZWRiYWNrIG9uIHRoaXMKPiA+ID4gPiA+ID4gPiBhcHByb2FjaCBhbmQgc2hhcmUgcGVy
Zm9ybWFuY2UgcmVzdWx0cyB3aXRoIHlvdS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IElk
bGUgQ1BVcyB0ZW50YXRpdmVseSBlbnRlciBhIGJ1c3kgd2FpdCBsb29wIGJlZm9yZSBoYWx0aW5n
IHdoZW4gdGhlIGNwdWlkbGUKPiA+ID4gPiA+ID4gPiBoYWx0cG9sbCBkcml2ZXIgaXMgZW5hYmxl
ZCBpbnNpZGUgYSB2aXJ0dWFsIG1hY2hpbmUuIFRoaXMgcmVkdWNlcyB3YWtldXAKPiA+ID4gPiA+
ID4gPiBsYXRlbmN5IGZvciBldmVudHMgdGhhdCBvY2N1ciBzb29uIGFmdGVyIHRoZSB2Q1BVIGJl
Y29tZXMgaWRsZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVz
IGV4dGVuZHMgdGhlIGNwdWlkbGUgYnVzeSB3YWl0IGxvb3Agd2l0aCB0aGUgbmV3IHBvbGxfc291
cmNlCj4gPiA+ID4gPiA+ID4gQVBJIHNvIGRyaXZlcnMgY2FuIHBhcnRpY2lwYXRlIGluIHBvbGxp
bmcuIFN1Y2ggcG9sbGluZy1hd2FyZSBkcml2ZXJzIGRpc2FibGUKPiA+ID4gPiA+ID4gPiB0aGVp
ciBkZXZpY2UncyBpcnEgZHVyaW5nIHRoZSBidXN5IHdhaXQgbG9vcCB0byBhdm9pZCB0aGUgY29z
dCBvZiBpbnRlcnJ1cHRzLgo+ID4gPiA+ID4gPiA+IFRoaXMgcmVkdWNlcyBsYXRlbmN5IGZ1cnRo
ZXIgdGhhbiByZWd1bGFyIGNwdWlkbGUgaGFsdHBvbGwsIHdoaWNoIHN0aWxsIHJlbGllcwo+ID4g
PiA+ID4gPiA+IG9uIGlycXMuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBWaXJ0aW8gZHJp
dmVycyBhcmUgbW9kaWZpZWQgdG8gdXNlIHRoZSBwb2xsX3NvdXJjZSBBUEkgc28gYWxsIHZpcnRp
byBkZXZpY2UKPiA+ID4gPiA+ID4gPiB0eXBlcyBnZXQgdGhpcyBmZWF0dXJlLiBUaGUgZm9sbG93
aW5nIHZpcnRpby1ibGsgZmlvIGJlbmNobWFyayByZXN1bHRzIHNob3cgdGhlCj4gPiA+ID4gPiA+
ID4gaW1wcm92ZW1lbnQ6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICBJT1BTIChudW1qb2JzPTQsIGlvZGVwdGg9MSwgNCB2aXJ0cXVldWVzKQo+ID4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgYmVmb3JlICAgcG9sbF9zb3VyY2UgICAgICBpb19wb2xsCj4gPiA+
ID4gPiA+ID4gNGsgcmFuZHJlYWQgICAgMTY3MTAyICAxODYwNDkgKCsxMSUpICAxODY2NTQgKCsx
MSUpCj4gPiA+ID4gPiA+ID4gNGsgcmFuZHdyaXRlICAgMTYyMjA0ICAxODEyMTQgKCsxMSUpICAx
ODE4NTAgKCsxMiUpCj4gPiA+ID4gPiA+ID4gNGsgcmFuZHJ3ICAgICAgMTU5NTIwICAxNzcwNzEg
KCsxMSUpICAxNzc5MjggKCsxMSUpCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGUgY29t
cGFyaXNvbiBhZ2FpbnN0IGlvX3BvbGwgc2hvd3MgdGhhdCBjcHVpZGxlIHBvbGxfc291cmNlIGFj
aGlldmVzCj4gPiA+ID4gPiA+ID4gZXF1aXZhbGVudCBwZXJmb3JtYW5jZSB0byB0aGUgYmxvY2sg
bGF5ZXIncyBpb19wb2xsIGZlYXR1cmUgKHdoaWNoIEkKPiA+ID4gPiA+ID4gPiBpbXBsZW1lbnRl
ZCBpbiBhIHNlcGFyYXRlIHBhdGNoIHNlcmllcyBbMV0pLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gVGhlIGFkdmFudGFnZSBvZiBwb2xsX3NvdXJjZSBpcyB0aGF0IGFwcGxpY2F0aW9ucyBk
byBub3QgbmVlZCB0byBleHBsaWNpdGx5IHNldAo+ID4gPiA+ID4gPiA+IHRoZSBSV0ZfSElQUkkg
SS9PIHJlcXVlc3QgZmxhZy4gVGhlIHBvbGxfc291cmNlIGFwcHJvYWNoIGlzIGF0dHJhY3RpdmUg
YmVjYXVzZQo+ID4gPiA+ID4gPiA+IGZldyBhcHBsaWNhdGlvbnMgYWN0dWFsbHkgdXNlIFJXRl9I
SVBSSSBhbmQgaXQgdGFrZXMgYWR2YW50YWdlIG9mIENQVSBjeWNsZXMgd2UKPiA+ID4gPiA+ID4g
PiB3b3VsZCBoYXZlIHNwZW50IGluIGNwdWlkbGUgaGFsdHBvbGwgYW55d2F5Lgo+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gVGhlIGN1cnJlbnQgc2VyaWVzIGRvZXMgbm90IGltcHJvdmUgdmly
dGlvLW5ldC4gSSBoYXZlbid0IGludmVzdGlnYXRlZCBkZWVwbHksCj4gPiA+ID4gPiA+ID4gYnV0
IGl0IGlzIHBvc3NpYmxlIHRoYXQgTkFQSSBhbmQgcG9sbF9zb3VyY2UgZG8gbm90IGNvbWJpbmUu
IFNlZSB0aGUgZmluYWwKPiA+ID4gPiA+ID4gPiBwYXRjaCBmb3IgYSBzdGFydGluZyBwb2ludCBv
biBtYWtpbmcgdGhlIHR3byB3b3JrIHRvZ2V0aGVyLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gSSBoYXZlIG5vdCB0cmllZCB0aGlzIG9uIGJhcmUgbWV0YWwgYnV0IGl0IG1pZ2h0IGhlbHAg
dGhlcmUgdG9vLiBUaGUgY29zdCBvZgo+ID4gPiA+ID4gPiA+IGRpc2FibGluZyBhIGRldmljZSdz
IGlycSBtdXN0IGJlIGxlc3MgdGhhbiB0aGUgc2F2aW5ncyBmcm9tIGF2b2lkaW5nIGlycQo+ID4g
PiA+ID4gPiA+IGhhbmRsaW5nIGZvciB0aGlzIG9wdGltaXphdGlvbiB0byBtYWtlIHNlbnNlLgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWJsb2NrLzIwMjEwNTIwMTQxMzA1LjM1NTk2MS0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEhpIFN0ZWZhbjoKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
U29tZSBxdWVzdGlvbnM6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IDEpIFdoYXQncyB0aGUgYWR2
YW50YWdlcyBvZiBpbnRyb2R1Y2luZyBwb2xsaW5nIGF0IHZpcnRpbyBsZXZlbCBpbnN0ZWFkIG9m
Cj4gPiA+ID4gPiA+IGRvaW5nIGl0IGF0IGVhY2ggc3Vic3lzdGVtcz8gUG9sbGluZyBpbiB2aXJ0
aW8gbGV2ZWwgbWF5IG9ubHkgd29yayB3ZWxsIGlmCj4gPiA+ID4gPiA+IGFsbCAob3IgbW9zdCkg
b2YgdGhlIGRldmljZXMgYXJlIHZpcnRpbwo+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIEkgdW5kZXJz
dGFuZCB0aGUgcXVlc3Rpb24uIGNwdWlkbGUgaGFsdHBvbGwgYmVuZWZpdHMgYWxsCj4gPiA+ID4g
PiBkZXZpY2VzIHRvZGF5LCBleGNlcHQgaXQgaW5jdXJzIGludGVycnVwdCBsYXRlbmN5LiBUaGUg
cG9sbF9zb3VyY2UgQVBJCj4gPiA+ID4gPiBlbGltaW5hdGVzIHRoZSBpbnRlcnJ1cHQgbGF0ZW5j
eSBmb3IgZHJpdmVycyB0aGF0IGNhbiBkaXNhYmxlIGRldmljZQo+ID4gPiA+ID4gaW50ZXJydXB0
cyBjaGVhcGx5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBwb2xsX3NvdXJj
ZSB0byBjb3JlIHZpcnRpbyBjb2RlIHNvIHRoYXQgYWxsIHZpcnRpbwo+ID4gPiA+ID4gZHJpdmVy
cyBnZXQgdGhpcyBmZWF0dXJlIGZvciBmcmVlLiBObyBkcml2ZXItc3BlY2lmaWMgY2hhbmdlcyBh
cmUKPiA+ID4gPiA+IG5lZWRlZC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJZiB5b3UgbWVhbiBuZXR3
b3JraW5nLCBibG9jayBsYXllciwgZXRjIGJ5ICJzdWJzeXN0ZW1zIiB0aGVuIHRoZXJlJ3MKPiA+
ID4gPiA+IG5vdGhpbmcgdGhvc2Ugc3Vic3lzdGVtcyBjYW4gZG8gdG8gaGVscC4gV2hldGhlciBw
b2xsX3NvdXJjZSBjYW4gYmUgdXNlZAo+ID4gPiA+ID4gZGVwZW5kcyBvbiB0aGUgc3BlY2lmaWMg
ZHJpdmVyLCBub3QgdGhlIHN1YnN5c3RlbS4gSWYgeW91IGNvbnNpZGVyCj4gPiA+ID4gPiBkcml2
ZXJzL3ZpcnRpby8gYSBzdWJzeXN0ZW0sIHRoZW4gdGhhdCdzIGV4YWN0bHkgd2hhdCB0aGUgcGF0
Y2ggc2VyaWVzCj4gPiA+ID4gPiBpcyBkb2luZy4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gSSBt
ZWFudCwgaWYgd2UgY2hvb3NlIHRvIHVzZSBpZGxlIHBvbGwsIHdlIGhhdmUgc29tZSBzZXZlcmFs
IGNob2ljZXM6Cj4gPiA+ID4KPiA+ID4gPiAxKSBidXMgbGV2ZWwgKGUuZyB0aGUgdmlydGlvKQo+
ID4gPiA+IDIpIHN1YnN5c3RlbSBsZXZlbCAoZS5nIHRoZSBuZXR3b3JraW5nIGFuZCBibG9jaykK
PiA+ID4gPgo+ID4gPiA+IEknbSBub3Qgc3VyZSB3aGljaCBvbmUgaXMgYmV0dGVyLgo+ID4gPgo+
ID4gPiBUaGlzIEFQSSBpcyBpbnRlbmRlZCB0byBiZSBkcml2ZXItIG9yIGJ1cy1sZXZlbC4gSSBk
b24ndCB0aGluawo+ID4gPiBzdWJzeXN0ZW1zIGNhbiBkbyB2ZXJ5IG11Y2ggc2luY2UgdGhleSBk
b24ndCBrbm93IHRoZSBoYXJkd2FyZQo+ID4gPiBjYXBhYmlsaXRpZXMgKGNoZWFwIGludGVycnVw
dCBkaXNhYmxpbmcpIGFuZCBpbiBtb3N0IGNhc2VzIHRoZXJlJ3Mgbm8KPiA+ID4gYWR2YW50YWdl
IG9mIHBsdW1iaW5nIGl0IHRocm91Z2ggc3Vic3lzdGVtcyB3aGVuIGRyaXZlcnMgY2FuIGNhbGwg
dGhlCj4gPiA+IEFQSSBkaXJlY3RseS4KPiA+ID4KPiA+ID4gPiA+ID4gMikgV2hhdCdzIHRoZSBh
ZHZhbnRhZ2VzIG9mIHVzaW5nIGNwdWlkbGUgaW5zdGVhZCBvZiB1c2luZyBhIHRocmVhZCAoYW5k
Cj4gPiA+ID4gPiA+IGxldmVyYWdlIHRoZSBzY2hlZHVsZXIpPwo+ID4gPiA+ID4gSW4gb3JkZXIg
dG8gY29tYmluZSB3aXRoIHRoZSBleGlzdGluZyBjcHVpZGxlIGluZnJhc3RydWN0dXJlLiBObyBu
ZXcKPiA+ID4gPiA+IHBvbGxpbmcgbG9vcCBpcyBpbnRyb2R1Y2VkIGFuZCBubyBhZGRpdGlvbmFs
IENQVSBjeWNsZXMgYXJlIHNwZW50IG9uCj4gPiA+ID4gPiBwb2xsaW5nLgo+ID4gPiA+ID4KPiA+
ID4gPiA+IElmIGNwdWlkbGUgaXRzZWxmIGlzIGNvbnZlcnRlZCB0byB0aHJlYWRzIHRoZW4gcG9s
bF9zb3VyY2Ugd291bGQKPiA+ID4gPiA+IGF1dG9tYXRpY2FsbHkgb3BlcmF0ZSBpbiBhIHRocmVh
ZCB0b28sIGJ1dCB0aGlzIHBhdGNoIHNlcmllcyBkb2Vzbid0Cj4gPiA+ID4gPiBjaGFuZ2UgaG93
IHRoZSBjb3JlIGNwdWlkbGUgY29kZSB3b3Jrcy4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gU28g
bmV0d29ya2luZyBzdWJzeXN0ZW0gY2FuIHVzZSBOQVBJIGJ1c3kgcG9sbGluZyBpbiB0aGUgcHJv
Y2VzcyBjb250ZXh0Cj4gPiA+ID4gd2hpY2ggbWVhbnMgaXQgY2FuIGJlIGxldmVyYWdlZCBieSB0
aGUgc2NoZWR1bGVyLgo+ID4gPiA+Cj4gPiA+ID4gSSdtIG5vdCBzdXJlIGl0J3MgYSBnb29kIGlk
ZWEgdG8gcG9sbCBkcml2ZXJzIGZvciBhIHNwZWNpZmljIGJ1cyBpbiB0aGUKPiA+ID4gPiBnZW5l
cmFsIGNwdSBpZGxlIGxheWVyLgo+ID4gPgo+ID4gPiBXaHk/IE1heWJlIGJlY2F1c2UgdGhlIGNw
dWlkbGUgZXhlY3V0aW9uIGVudmlyb25tZW50IGlzIGEgbGl0dGxlIHNwZWNpYWw/Cj4gPgo+ID4g
V2VsbCwgdGhpcyB3b3VsZCBiZSBwcm9uZSB0byBhYnVzZS4KPiA+Cj4gPiBUaGUgdGltZSBzcGVu
dCBpbiB0aGF0IGRyaXZlciBjYWxsYmFjayBjb3VudHMgYXMgQ1BVIGlkbGUgdGltZSB3aGlsZQo+
ID4gaXQgcmVhbGx5IGlzIHRoZSBkcml2ZXIgcnVubmluZyBhbmQgdGhlcmUgaXMgbm90IGxpbWl0
IG9uIGhvdyBtdWNoCj4gPiB0aW1lIHRoZSBjYWxsYmFjayBjYW4gdGFrZSwgd2hpbGUgZG9pbmcg
Y29zdGx5IHRoaW5ncyBpbiB0aGUgaWRsZSBsb29wCj4gPiBpcyBnZW5lcmFsbHkgYXZvaWRlZCwg
YmVjYXVzZSBvbiB3YWtldXAgdGhlIENQVSBuZWVkcyB0byBiZSBhdmFpbGFibGUKPiA+IHRvIHRo
ZSB0YXNrIG5lZWRpbmcgaXQgYXMgc29vbiBhcyBwb3NzaWJsZS4gIElPVywgdGhlIGNhbGxiYWNr
Cj4gPiBwb3RlbnRpYWxseSBhZGQgdW5ib3VuZGVkIGxhdGVuY3kgdG8gdGhlIENQVSB3YWtldXAg
cGF0aC4KPgo+IEhvdyBpcyB0aGlzIGRpZmZlcmVudCBmcm9tIGRyaXZlciBpbnRlcnJ1cHQgaGFu
ZGxlcnMgcnVubmluZyBkdXJpbmcKPiBjcHVpZGxlPwoKVGhlIHRpbWUgc3BlbnQgb24gaGFuZGxp
bmcgaW50ZXJydXB0cyBkb2VzIG5vdCBjb3VudCBhcyBDUFUgaWRsZSB0aW1lLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
