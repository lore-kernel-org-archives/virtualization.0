Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D5ACDB47E
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 06:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 798F9847A7;
	Fri, 20 Oct 2023 06:52:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 798F9847A7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAs/FRd1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4eXXnMsZyEV; Fri, 20 Oct 2023 06:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B3407847A1;
	Fri, 20 Oct 2023 06:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3407847A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F2A6C0071;
	Fri, 20 Oct 2023 06:52:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1B3C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D70D84C351
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D70D84C351
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAs/FRd1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cFc1wI1Zx1wf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1A094BE7B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:52:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1A094BE7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697784755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EIj3bf1mGidhArRikuspkUzwv3+tYWXHezkRsnPZu4=;
 b=HAs/FRd13cxmS1u3hfT9iJoZHJizojR0V+OafL48AiyN3gSFlr9+cg62m3UbVih3U1pZEF
 ceDN34HbHn/9Siar3jOjGG0YW3l39tGuUF20rAkofK7OC72kAehEhEHpUCaHlXHNcBWYXl
 QyPBHz49S7PT14nvdAjO2WCLyxdF5gg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-UnLRgXS4NlS3DRdpPmdD4w-1; Fri, 20 Oct 2023 02:52:31 -0400
X-MC-Unique: UnLRgXS4NlS3DRdpPmdD4w-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507c8a8e5d1so470515e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 23:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697784750; x=1698389550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EIj3bf1mGidhArRikuspkUzwv3+tYWXHezkRsnPZu4=;
 b=E3VOJAMq0SqSpiOs0rvkMnJwCEtiePSiZfYvY4gHK4Ry6Yvzz+qFWnogYZzoTpscgz
 gQSEtTmp17A5X1/GQJn52CBx6sRbq1hR61DCPSO3DJqLye3rgrF6QMJmsOMIi0yjZHJc
 q2qCan6oxsyVGfME99mdLC8sZ7QiMJvQJI4yb92Wi761GhhkgIRabztkInlExEosFtTu
 sThbflcPAOqjMbKpjFlS8F8eVoWQWrgEG1MKFeqid33TmjGrYabUuagu7OePn8GTi2BB
 VjaLNkDCvB4TtQk70CPOaO6pF4BGTt4wTKMwkPeXo88wh+8iFB3zmqHBF6Z+3bkM93ek
 XzuA==
X-Gm-Message-State: AOJu0YwLYWljeiRzx+KDHn55iTm+5OhaiLhxi5w3b+ClIWw0Yg98ReD+
 BoaAdwU1fWtmqCOCuHI8N4ZYJySV7YEwrh/omqUdylBF1aH1R01bzSCSwpdgGt96Y/+RMuUjONh
 G9VtzVVAqkrTAEdfAUFvvjFWhJg5y1yRd2HKACT+tVpA8saYs1RoewmRbew==
X-Received: by 2002:ac2:5ec3:0:b0:507:9625:5fd3 with SMTP id
 d3-20020ac25ec3000000b0050796255fd3mr583000lfq.32.1697784750328; 
 Thu, 19 Oct 2023 23:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnRuo5sqDr6/4TZIIbTk2wPU8ZXdj12hqoUmgYAL5U7xWnIZLrHn0v6rW79DCzNMacRgQXtQXbupSnIn3yQJ8=
X-Received: by 2002:ac2:5ec3:0:b0:507:9625:5fd3 with SMTP id
 d3-20020ac25ec3000000b0050796255fd3mr582985lfq.32.1697784749976; Thu, 19 Oct
 2023 23:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:52:18 +0800
Message-ID: <CACGkMEsoA_y6FV0PzoLfO-UFhJrYRe96cDpX_hHgSo7PAwshrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 12/19] virtio_net: xsk: tx: support wakeup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4geHNrIHdha2V1cCBpcyB1c2VkIHRvIHRyaWdnZXIg
dGhlIGxvZ2ljIGZvciB4c2sgeG1pdCBieSB4c2sgZnJhbWV3b3JrIG9yCj4gdXNlci4KPgo+IFZp
cnRpby1OZXQgZG9lcyBub3Qgc3VwcG9ydCB0byBhY3RpdmVseSBnZW5lcmF0ZSBhbiBpbnRlcnJ1
cHRpb24sIHNvIGl0Cj4gdHJpZXMgdG8gdHJpZ2dlciB0eCBOQVBJIG9uIHRoZSB0eCBpbnRlcnJ1
cHQgY3B1Lgo+Cj4gQ29uc2lkZXIgdGhlIGVmZmVjdCBvZiBjYWNoZS4gV2hlbiBpbnRlcnJ1cHQg
dHJpZ2dlcnMsIGl0IGlzCj4gZ2VuZXJhbGx5IGZpeGVkIG9uIGEgQ1BVLiBJdCBpcyBiZXR0ZXIg
dG8gc3RhcnQgVFggTmFwaSBvbiB0aGUgc2FtZQo+IENQVS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0
L3ZpcnRpby9tYWluLmMgICAgICAgfCAgMyArKwo+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydGlv
X25ldC5oIHwgIDggKysrKysKPiAgZHJpdmVycy9uZXQvdmlydGlvL3hzay5jICAgICAgICB8IDU3
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICBkcml2ZXJzL25ldC92aXJ0aW8v
eHNrLmggICAgICAgIHwgIDEgKwo+ICA0IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jIGIvZHJpdmVycy9uZXQv
dmlydGlvL21haW4uYwo+IGluZGV4IGEwODQyOWJlZjYxZi4uMWEyMjIyMjEzNTJlIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby9tYWluLmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW8vbWFpbi5jCj4gQEAgLTIwNjYsNiArMjA2Niw4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xs
X3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7Cj4gICAgICAgICB9Cj4KPiArICAgICAgIHNxLT54c2subGFzdF9jcHUgPSBz
bXBfcHJvY2Vzc29yX2lkKCk7Cj4gKwo+ICAgICAgICAgdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1
ZSh2aS0+ZGV2LCBpbmRleCk7Cj4gICAgICAgICBfX25ldGlmX3R4X2xvY2sodHhxLCByYXdfc21w
X3Byb2Nlc3Nvcl9pZCgpKTsKPiAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7
Cj4gQEAgLTM3NzAsNiArMzc3Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9v
cHMgdmlydG5ldF9uZXRkZXYgPSB7Cj4gICAgICAgICAubmRvX3ZsYW5fcnhfa2lsbF92aWQgPSB2
aXJ0bmV0X3ZsYW5fcnhfa2lsbF92aWQsCj4gICAgICAgICAubmRvX2JwZiAgICAgICAgICAgICAg
ICA9IHZpcnRuZXRfeGRwLAo+ICAgICAgICAgLm5kb194ZHBfeG1pdCAgICAgICAgICAgPSB2aXJ0
bmV0X3hkcF94bWl0LAo+ICsgICAgICAgLm5kb194c2tfd2FrZXVwICAgICAgICAgPSB2aXJ0bmV0
X3hza193YWtldXAsCj4gICAgICAgICAubmRvX2ZlYXR1cmVzX2NoZWNrICAgICA9IHBhc3N0aHJ1
X2ZlYXR1cmVzX2NoZWNrLAo+ICAgICAgICAgLm5kb19nZXRfcGh5c19wb3J0X25hbWUgPSB2aXJ0
bmV0X2dldF9waHlzX3BvcnRfbmFtZSwKPiAgICAgICAgIC5uZG9fc2V0X2ZlYXR1cmVzICAgICAg
ID0gdmlydG5ldF9zZXRfZmVhdHVyZXMsCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRp
by92aXJ0aW9fbmV0LmggYi9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oCj4gaW5kZXgg
M2JiYjFmNWJhYWQ1Li43YzcyYThiYjE4MTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvL3ZpcnRpb19uZXQuaAo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmgK
PiBAQCAtMTAxLDYgKzEwMSwxNCBAQCBzdHJ1Y3QgdmlydG5ldF9zcSB7Cj4gICAgICAgICAgICAg
ICAgIHN0cnVjdCB4c2tfYnVmZl9wb29sIF9fcmN1ICpwb29sOwo+Cj4gICAgICAgICAgICAgICAg
IGRtYV9hZGRyX3QgaGRyX2RtYV9hZGRyZXNzOwo+ICsKPiArICAgICAgICAgICAgICAgdTMyIGxh
c3RfY3B1Owo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgX19jYWxsX3NpbmdsZV9kYXRhIGNzZDsK
PiArCj4gKyAgICAgICAgICAgICAgIC8qIFRoZSBsb2NrIHRvIHByZXZlbnQgdGhlIHJlcGVhdCBv
ZiBjYWxsaW5nCj4gKyAgICAgICAgICAgICAgICAqIHNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZV9h
c3luYygpLgo+ICsgICAgICAgICAgICAgICAgKi8KPiArICAgICAgICAgICAgICAgc3BpbmxvY2tf
dCBpcGlfbG9jazsKPiAgICAgICAgIH0geHNrOwo+ICB9Owo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3ZpcnRpby94c2suYyBiL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suYwo+IGluZGV4IDBl
Nzc1YTlkMjcwZi4uOTczZTc4MzI2MGMzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRp
by94c2suYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suYwo+IEBAIC0xMTUsNiArMTE1
LDYwIEBAIGJvb2wgdmlydG5ldF94c2tfeG1pdChzdHJ1Y3QgdmlydG5ldF9zcSAqc3EsIHN0cnVj
dCB4c2tfYnVmZl9wb29sICpwb29sLAo+ICAgICAgICAgcmV0dXJuIHNlbnQgPT0gYnVkZ2V0Owo+
ICB9Cj4KPiArc3RhdGljIHZvaWQgdmlydG5ldF9yZW1vdGVfbmFwaV9zY2hlZHVsZSh2b2lkICpp
bmZvKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdmlydG5ldF9zcSAqc3EgPSBpbmZvOwo+ICsKPiAr
ICAgICAgIHZpcnRuZXRfdnFfbmFwaV9zY2hlZHVsZSgmc3EtPm5hcGksIHNxLT52cSk7Cj4gK30K
PiArCj4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcmVtb3RlX3JhaXNlX25hcGkoc3RydWN0IHZpcnRu
ZXRfc3EgKnNxKQo+ICt7Cj4gKyAgICAgICB1MzIgbGFzdF9jcHUsIGN1cl9jcHU7Cj4gKwo+ICsg
ICAgICAgbGFzdF9jcHUgPSBzcS0+eHNrLmxhc3RfY3B1Owo+ICsgICAgICAgY3VyX2NwdSA9IGdl
dF9jcHUoKTsKPiArCj4gKyAgICAgICAvKiBPbiByZW1vdGUgY3B1LCBzb2Z0aXJxIHdpbGwgcnVu
IGF1dG9tYXRpY2FsbHkgd2hlbiBpcGkgaXJxIGV4aXQuIE9uCj4gKyAgICAgICAgKiBsb2NhbCBj
cHUsIHNtcF9jYWxsX3h4eCB3aWxsIG5vdCB0cmlnZ2VyIGlwaSBpbnRlcnJ1cHQsIHRoZW4gc29m
dGlycQo+ICsgICAgICAgICogY2Fubm90IGJlIHRyaWdnZXJlZCBhdXRvbWF0aWNhbGx5LiBTbyBD
YWxsIGxvY2FsX2JoX2VuYWJsZSBhZnRlciB0bwo+ICsgICAgICAgICogdHJpZ2dlciBzb2Z0SVJR
IHByb2Nlc3NpbmcuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChsYXN0X2NwdSA9PSBjdXJf
Y3B1KSB7Cj4gKyAgICAgICAgICAgICAgIGxvY2FsX2JoX2Rpc2FibGUoKTsKPiArICAgICAgICAg
ICAgICAgdmlydG5ldF92cV9uYXBpX3NjaGVkdWxlKCZzcS0+bmFwaSwgc3EtPnZxKTsKPiArICAg
ICAgICAgICAgICAgbG9jYWxfYmhfZW5hYmxlKCk7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICsgICAg
ICAgICAgICAgICBpZiAoc3Bpbl90cnlsb2NrKCZzcS0+eHNrLmlwaV9sb2NrKSkgewo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZV9hc3luYyhsYXN0X2Nw
dSwgJnNxLT54c2suY3NkKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9jaygm
c3EtPnhzay5pcGlfbG9jayk7Cj4gKyAgICAgICAgICAgICAgIH0KPiArICAgICAgIH0KCklzIHRo
ZXJlIGFueSBudW1iZXIgdG8gc2hvdyB3aGV0aGVyIGl0J3Mgd29ydGggaXQgZm9yIGFuIElQSSBo
ZXJlPyBGb3IKZXhhbXBsZSwgR1ZFIGRvZXNuJ3QgZG8gdGhpcy4KClRoYW5rcwoKCj4gKwo+ICsg
ICAgICAgcHV0X2NwdSgpOwo+ICt9Cj4gKwo+ICtpbnQgdmlydG5ldF94c2tfd2FrZXVwKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsIHUzMiBxaWQsIHUzMiBmbGFnKQo+ICt7Cj4gKyAgICAgICBzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gKyAgICAgICBzdHJ1Y3Qg
dmlydG5ldF9zcSAqc3E7Cj4gKwo+ICsgICAgICAgaWYgKCFuZXRpZl9ydW5uaW5nKGRldikpCj4g
KyAgICAgICAgICAgICAgIHJldHVybiAtRU5FVERPV047Cj4gKwo+ICsgICAgICAgaWYgKHFpZCA+
PSB2aS0+Y3Vycl9xdWV1ZV9wYWlycykKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
Cj4gKwo+ICsgICAgICAgc3EgPSAmdmktPnNxW3FpZF07Cj4gKwo+ICsgICAgICAgaWYgKG5hcGlf
aWZfc2NoZWR1bGVkX21hcmtfbWlzc2VkKCZzcS0+bmFwaSkpCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAwOwo+ICsKPiArICAgICAgIHZpcnRuZXRfcmVtb3RlX3JhaXNlX25hcGkoc3EpOwo+ICsK
PiArICAgICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IHZpcnRuZXRfcnFfYmlu
ZF94c2tfcG9vbChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRuZXRfcnEgKnJx
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB4c2tfYnVmZl9w
b29sICpwb29sKQo+ICB7Cj4gQEAgLTI0MCw2ICsyOTQsOSBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
eHNrX3Bvb2xfZW5hYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4KPiAgICAgICAgIHNxLT54
c2suaGRyX2RtYV9hZGRyZXNzID0gaGRyX2RtYTsKPgo+ICsgICAgICAgSU5JVF9DU0QoJnNxLT54
c2suY3NkLCB2aXJ0bmV0X3JlbW90ZV9uYXBpX3NjaGVkdWxlLCBzcSk7Cj4gKyAgICAgICBzcGlu
X2xvY2tfaW5pdCgmc3EtPnhzay5pcGlfbG9jayk7Cj4gKwo+ICAgICAgICAgcmV0dXJuIDA7Cj4K
PiAgZXJyX3NxOgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmggYi9kcml2
ZXJzL25ldC92aXJ0aW8veHNrLmgKPiBpbmRleCA3M2NhOGNkNTMwOGIuLjFiZDE5ZGNkYTY0OSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmgKPiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW8veHNrLmgKPiBAQCAtMTcsNCArMTcsNSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKnZp
cnRuZXRfeHNrX3RvX3B0cih1MzIgbGVuKQo+ICBpbnQgdmlydG5ldF94c2tfcG9vbF9zZXR1cChz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgbmV0ZGV2X2JwZiAqeGRwKTsKPiAgYm9vbCB2
aXJ0bmV0X3hza194bWl0KHN0cnVjdCB2aXJ0bmV0X3NxICpzcSwgc3RydWN0IHhza19idWZmX3Bv
b2wgKnBvb2wsCj4gICAgICAgICAgICAgICAgICAgICAgIGludCBidWRnZXQpOwo+ICtpbnQgdmly
dG5ldF94c2tfd2FrZXVwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHUzMiBxaWQsIHUzMiBmbGFn
KTsKPiAgI2VuZGlmCj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
