Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73358C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 07:57:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA9323131
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 07:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA9323131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7F4268484F;
	Wed, 20 Jan 2021 07:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P-OjZUZY3z6o; Wed, 20 Jan 2021 07:57:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 746CB84491;
	Wed, 20 Jan 2021 07:57:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CAF7C088B;
	Wed, 20 Jan 2021 07:57:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF34BC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A3274868B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7CQK20I+XKWC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 465D286847
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611129432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er7iaXjTuPXAuVg2JyI2Go7WG0KWUxlUDhb5X07oLSI=;
 b=ZAk6OyrGa9vuIcuPxmNhXlT1fJZT2PsWtsi8znqvozG1Q0MQud96ebqK4PqbZUP/Bt0jCL
 PzCKwcOydc5mfNwsTG0xTh8HWCy1HQZCvDEZmB1VOki8tioMK0ik64BPz0ag8aM5opEvXa
 OsL3KcwiQuU8gjVGWtg3Tu01XRssF1s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-Eog9547aMhe2j3-ph856aw-1; Wed, 20 Jan 2021 02:57:10 -0500
X-MC-Unique: Eog9547aMhe2j3-ph856aw-1
Received: by mail-wr1-f70.google.com with SMTP id u29so11078938wru.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 23:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=er7iaXjTuPXAuVg2JyI2Go7WG0KWUxlUDhb5X07oLSI=;
 b=lFpKdJjzP49JT54kkqDYyxtOWyKB5PeB7Yya6vdEloLomuJonVQ8pUXGhdLN9KUNFj
 Nc/zfyEuldfHRnh5qRDvypbIjk9dP8dIMLU6NUCDWE7aI5p4D+FdoIP35PWFLr24SJ/O
 FRL3wBhCA3DxX2nW/HNQCPwrVNuBbzpLFnbGGAG5mn8Vu6VbWyHRmSAzn3a2HfZ9SsBx
 rXt6QyhJF5Lk84mW66OgXya0Utzpr6Y9GkYniUer+RXUF3g5y9wU01jaMzdwZiMC00oo
 SlQCWB1e02Pwjyi+s/T7Bd9BUaa8DSHXbAtqrfrBTgBVpbS7YMYi2PAx7MfsDf9KxRdt
 X7Kw==
X-Gm-Message-State: AOAM531NcycG83z2nRPWcETAP3Lu8h4yOz3SnA3e+oZFbOSBMmuJdOH2
 bcqpCLVDHec0gymcvPVojv/+Pw4okMrJvRCj3BXnm2EQ8t4ejlwihtcYaOkUNvEiPV6mc1umSDK
 T4AAvVdDtYQ0ZjBmwmKN0rR7/cYsVtOmEx3UA88rPsg==
X-Received: by 2002:a05:6000:23c:: with SMTP id
 l28mr7999287wrz.193.1611129429003; 
 Tue, 19 Jan 2021 23:57:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUiC5Y9Vg5pC0MU0ECnGIqKfkGRRvWpS4NGc3EA1VxrPUjICeThsn7tnPF+wylrJ5i3NLdeQ==
X-Received: by 2002:a05:6000:23c:: with SMTP id
 l28mr7999283wrz.193.1611129428857; 
 Tue, 19 Jan 2021 23:57:08 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id s24sm2328921wmh.22.2021.01.19.23.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 23:57:08 -0800 (PST)
Date: Wed, 20 Jan 2021 02:57:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] vdpa/mlx5: Fix memory key MTT population
Message-ID: <20210120025651-mutt-send-email-mst@kernel.org>
References: <20210107071845.GA224876@mtl-vdi-166.wap.labs.mlnx>
 <07d336a3-7fc2-5e4a-667a-495b5bb755da@redhat.com>
 <20210120053619.GA126435@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210120053619.GA126435@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lulu@redhat.com,
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

T24gV2VkLCBKYW4gMjAsIDIwMjEgYXQgMDc6MzY6MTlBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIEZyaSwgSmFuIDA4LCAyMDIxIGF0IDA0OjM4OjU1UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gCj4gSGkgTWljaGFlbCwKPiB0aGlzIHBhdGNoIGlzIGEgZml4LiBBcmUgeW91IGdv
aW5nIHRvIG1lcmdlIGl0PwoKeWVzIC0gaW4gdGhlIG5leHQgcHVsbCByZXF1ZXN0LgoKPiA+IAo+
ID4gT24gMjAyMS8xLzcg5LiL5Y2IMzoxOCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiBtYXBfZGly
ZWN0X21yKCkgYXNzdW1lZCB0aGF0IHRoZSBudW1iZXIgb2Ygc2NhdHRlci9nYXRoZXIgZW50cmll
cwo+ID4gPiByZXR1cm5lZCBieSBkbWFfbWFwX3NnX2F0dHJzKCkgd2FzIGVxdWFsIHRvIHRoZSBu
dW1iZXIgb2Ygc2VnbWVudHMgaW4KPiA+ID4gdGhlIHNnbCBsaXN0LiBUaGlzIGxlZCB0byB3cm9u
ZyBwb3B1bGF0aW9uIG9mIHRoZSBta2V5IG9iamVjdC4gRml4IHRoaXMKPiA+ID4gYnkgcHJvcGVy
bHkgcmVmZXJyaW5nIHRvIHRoZSByZXR1cm5lZCB2YWx1ZS4KPiA+ID4gCj4gPiA+IFRoZSBoYXJk
d2FyZSBleHBlY3RzIGVhY2ggTVRUIGVudHJ5IHRvIGNvbnRhaW4gdGhlIERNQSBhZGRyZXNzIG9m
IGEKPiA+ID4gY29udGlndW91cyBibG9jayBvZiBtZW1vcnkgb2Ygc2l6ZSAoMSA8PCBtci0+bG9n
X3NpemUpIGJ5dGVzLgo+ID4gPiBkbWFfbWFwX3NnX2F0dHJzKCkgY2FuIGNvYWxlc2NlIHNldmVy
YWwgc2cgZW50cmllcyBpbnRvIGEgc2luZ2xlCj4gPiA+IHNjYXR0ZXIvZ2F0aGVyIGVudHJ5IG9m
IGNvbnRpZ3VvdXMgRE1BIHJhbmdlIHNvIHdlIG5lZWQgdG8gc2NhbiB0aGUgbGlzdAo+ID4gPiBh
bmQgcmVmZXIgdG8gdGhlIHNpemUgb2YgZWFjaCBzL2cgZW50cnkuCj4gPiA+IAo+ID4gPiBJbiBh
ZGRpdGlvbiwgZ2V0IHJpZCBvZiBmaWxsX3NnKCkgd2hpY2ggZWZmZWN0IGlzIG92ZXJ3cml0dGVu
IGJ5Cj4gPiA+IHBvcHVsYXRlX210dHMoKS4KPiA+ID4gCj4gPiA+IEZpeGVzOiA5NGFiYmNjZGYy
OTEgKCJ2ZHBhL21seDU6IEFkZCBzaGFyZWQgbWVtb3J5IHJlZ2lzdHJhdGlvbiBjb2RlIikKPiA+
ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gPiA+IC0tLQo+
ID4gPiBWMC0+VjE6Cj4gPiA+IDEuIEZpeCB0eXBvcwo+ID4gPiAyLiBJbXByb3ZlIGNoYW5nZWxv
Zwo+ID4gCj4gPiAKPiA+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
Pgo+ID4gCj4gPiAKPiA+ID4gCj4gPiA+ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaCB8ICAxICsKPiA+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAgIHwg
MjggKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbWx4NV92ZHBhLmgKPiA+ID4gaW5kZXggNWM5MmE1NzZlZGFlLi4wOGY3NDJmZDI0MDkg
MTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiA+
ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+ID4gPiBAQCAtMTUs
NiArMTUsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tciB7Cj4gPiA+ICAgCXN0cnVjdCBz
Z190YWJsZSBzZ19oZWFkOwo+ID4gPiAgIAlpbnQgbG9nX3NpemU7Cj4gPiA+ICAgCWludCBuc2c7
Cj4gPiA+ICsJaW50IG5lbnQ7Cj4gPiA+ICAgCXN0cnVjdCBsaXN0X2hlYWQgbGlzdDsKPiA+ID4g
ICAJdTY0IG9mZnNldDsKPiA+ID4gICB9Owo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4gPiA+IGluZGV4
IDRiNjE5NTY2NmM1OC4uZDMwMGY3OTllZmNkIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL21yLmMKPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5j
Cj4gPiA+IEBAIC0yNSwxNyArMjUsNiBAQCBzdGF0aWMgaW50IGdldF9vY3RvX2xlbih1NjQgbGVu
LCBpbnQgcGFnZV9zaGlmdCkKPiA+ID4gICAJcmV0dXJuIChucGFnZXMgKyAxKSAvIDI7Cj4gPiA+
ICAgfQo+ID4gPiAtc3RhdGljIHZvaWQgZmlsbF9zZyhzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9t
ciAqbXIsIHZvaWQgKmluKQo+ID4gPiAtewo+ID4gPiAtCXN0cnVjdCBzY2F0dGVybGlzdCAqc2c7
Cj4gPiA+IC0JX19iZTY0ICpwYXM7Cj4gPiA+IC0JaW50IGk7Cj4gPiA+IC0KPiA+ID4gLQlwYXMg
PSBNTFg1X0FERFJfT0YoY3JlYXRlX21rZXlfaW4sIGluLCBrbG1fcGFzX210dCk7Cj4gPiA+IC0J
Zm9yX2VhY2hfc2cobXItPnNnX2hlYWQuc2dsLCBzZywgbXItPm5zZywgaSkKPiA+ID4gLQkJKCpw
YXMpID0gY3B1X3RvX2JlNjQoc2dfZG1hX2FkZHJlc3Moc2cpKTsKPiA+ID4gLX0KPiA+ID4gLQo+
ID4gPiAgIHN0YXRpYyB2b2lkIG1seDVfc2V0X2FjY2Vzc19tb2RlKHZvaWQgKm1rYywgaW50IG1v
ZGUpCj4gPiA+ICAgewo+ID4gPiAgIAlNTFg1X1NFVChta2MsIG1rYywgYWNjZXNzX21vZGVfMV8w
LCBtb2RlICYgMHgzKTsKPiA+ID4gQEAgLTQ1LDEwICszNCwxOCBAQCBzdGF0aWMgdm9pZCBtbHg1
X3NldF9hY2Nlc3NfbW9kZSh2b2lkICpta2MsIGludCBtb2RlKQo+ID4gPiAgIHN0YXRpYyB2b2lk
IHBvcHVsYXRlX210dHMoc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKm1yLCBfX2JlNjQgKm10
dCkKPiA+ID4gICB7Cj4gPiA+ICAgCXN0cnVjdCBzY2F0dGVybGlzdCAqc2c7Cj4gPiA+ICsJaW50
IG5zZyA9IG1yLT5uc2c7Cj4gPiA+ICsJdTY0IGRtYV9hZGRyOwo+ID4gPiArCXU2NCBkbWFfbGVu
Owo+ID4gPiArCWludCBqID0gMDsKPiA+ID4gICAJaW50IGk7Cj4gPiA+IC0JZm9yX2VhY2hfc2co
bXItPnNnX2hlYWQuc2dsLCBzZywgbXItPm5zZywgaSkKPiA+ID4gLQkJbXR0W2ldID0gY3B1X3Rv
X2JlNjQoc2dfZG1hX2FkZHJlc3Moc2cpKTsKPiA+ID4gKwlmb3JfZWFjaF9zZyhtci0+c2dfaGVh
ZC5zZ2wsIHNnLCBtci0+bmVudCwgaSkgewo+ID4gPiArCQlmb3IgKGRtYV9hZGRyID0gc2dfZG1h
X2FkZHJlc3Moc2cpLCBkbWFfbGVuID0gc2dfZG1hX2xlbihzZyk7Cj4gPiA+ICsJCSAgICAgbnNn
ICYmIGRtYV9sZW47Cj4gPiA+ICsJCSAgICAgbnNnLS0sIGRtYV9hZGRyICs9IEJJVChtci0+bG9n
X3NpemUpLCBkbWFfbGVuIC09IEJJVChtci0+bG9nX3NpemUpKQo+ID4gPiArCQkJbXR0W2orK10g
PSBjcHVfdG9fYmU2NChkbWFfYWRkcik7Cj4gPiA+ICsJfQo+ID4gPiAgIH0KPiA+ID4gICBzdGF0
aWMgaW50IGNyZWF0ZV9kaXJlY3RfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1
Y3QgbWx4NV92ZHBhX2RpcmVjdF9tciAqbXIpCj4gPiA+IEBAIC02NCw3ICs2MSw2IEBAIHN0YXRp
YyBpbnQgY3JlYXRlX2RpcmVjdF9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVj
dCBtbHg1X3ZkcGFfZGlyZWN0Cj4gPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsKPiA+ID4gICAJTUxY
NV9TRVQoY3JlYXRlX21rZXlfaW4sIGluLCB1aWQsIG12ZGV2LT5yZXMudWlkKTsKPiA+ID4gLQlm
aWxsX3NnKG1yLCBpbik7Cj4gPiA+ICAgCW1rYyA9IE1MWDVfQUREUl9PRihjcmVhdGVfbWtleV9p
biwgaW4sIG1lbW9yeV9rZXlfbWtleV9lbnRyeSk7Cj4gPiA+ICAgCU1MWDVfU0VUKG1rYywgbWtj
LCBsdywgISEobXItPnBlcm0gJiBWSE9TVF9NQVBfV08pKTsKPiA+ID4gICAJTUxYNV9TRVQobWtj
LCBta2MsIGxyLCAhIShtci0+cGVybSAmIFZIT1NUX01BUF9STykpOwo+ID4gPiBAQCAtMjc2LDgg
KzI3Miw4IEBAIHN0YXRpYyBpbnQgbWFwX2RpcmVjdF9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yCj4gPiA+ICAgZG9uZToKPiA+ID4gICAJ
bXItPmxvZ19zaXplID0gbG9nX2VudGl0eV9zaXplOwo+ID4gPiAgIAltci0+bnNnID0gbnNnOwo+
ID4gPiAtCWVyciA9IGRtYV9tYXBfc2dfYXR0cnMoZG1hLCBtci0+c2dfaGVhZC5zZ2wsIG1yLT5u
c2csIERNQV9CSURJUkVDVElPTkFMLCAwKTsKPiA+ID4gLQlpZiAoIWVycikKPiA+ID4gKwltci0+
bmVudCA9IGRtYV9tYXBfc2dfYXR0cnMoZG1hLCBtci0+c2dfaGVhZC5zZ2wsIG1yLT5uc2csIERN
QV9CSURJUkVDVElPTkFMLCAwKTsKPiA+ID4gKwlpZiAoIW1yLT5uZW50KQo+ID4gPiAgIAkJZ290
byBlcnJfbWFwOwo+ID4gPiAgIAllcnIgPSBjcmVhdGVfZGlyZWN0X21yKG12ZGV2LCBtcik7Cj4g
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
