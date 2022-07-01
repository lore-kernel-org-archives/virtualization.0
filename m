Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4655C43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 08:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D680845BC;
	Fri,  1 Jul 2022 08:55:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D680845BC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiQ/niCX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E5LM7p74gOag; Fri,  1 Jul 2022 08:55:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A792A842AB;
	Fri,  1 Jul 2022 08:55:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A792A842AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70EE6C0032;
	Fri,  1 Jul 2022 08:55:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90940C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DBF340B14
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DBF340B14
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiQ/niCX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6WC2YhOEfSLw
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:55:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7527940182
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7527940182
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656665722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkjeVHLiRKnGx+SDkOMpqWolwraAwFwTa3XTNY2+eNo=;
 b=BiQ/niCXleD3uwPY3G3/np0TOzvcBKs/6U+ORi5JCLm4ojnjbdjqdA5hVJo07MMgH7JZTV
 PQ3wCKBxdHEZHlB3JavXIalOGsXa2zusxR71uAQ2rciP2PqOfw2nA0Ad5cZoxMIY8/Upoi
 nN58IUusREzSIf5IjihKykW1pIe1zLk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-wbukpn5_OOCvY7zArqufSw-1; Fri, 01 Jul 2022 04:55:21 -0400
X-MC-Unique: wbukpn5_OOCvY7zArqufSw-1
Received: by mail-pj1-f69.google.com with SMTP id
 e17-20020a17090ac21100b001ef367cb6a6so1071350pjt.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lkjeVHLiRKnGx+SDkOMpqWolwraAwFwTa3XTNY2+eNo=;
 b=ncCsrUp1efKs1nYkGRO0HdCc4r7GRYrSwmNCwmO3cFI8l9jqCIJ/OmxHX+pwksWi17
 elHgB0m5ByKnqk7Hdj5/ydK58W6blo8WXCXU1saYFTZYfvoEu3KeaE4Q/0j2LQdSwDAm
 NoxNBBXPCMQzriUDKzHjKalLVXQFROfhVL5aGw8e+BZtEvMyztZWo4Gw2mhwpoM0WF24
 rXh6usyO6TP3xHl4HCBg1RhoazO5JzGl4RSVww2JdO4v4BbiGxZQBwqydz7emBkMvEil
 YUynsO6ytK3va92BH7Rr2sXY+q2PJTi4sKklm80lBdYkFPmmgbKwTg5/0Euoi3hzwusK
 ULzQ==
X-Gm-Message-State: AJIora+WgdipyvmUKsNNWIVHDG7Wkri6l5lbRiErhRSJ8KuecIsnp+dR
 szHTxESMOgWWbyIj4SDzPA6RybAXI+xZWPl/F6tfcNOOOGxaFiXen22vtVxg/eqn9Aq0OcGOwtZ
 zfn1qeMjBNYWGk8cFdceOKe6yCNi/GPkZpY9G3yuOwQ==
X-Received: by 2002:a17:903:2443:b0:16a:2b65:7edd with SMTP id
 l3-20020a170903244300b0016a2b657eddmr18561919pls.20.1656665720020; 
 Fri, 01 Jul 2022 01:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sLP/MnYa3Xp+qYQJlIuiumTLO6KyhDeS6ZBk4hW4qZwr9I7787jFOGOD5WGdVtJecP+R32Tg==
X-Received: by 2002:a17:903:2443:b0:16a:2b65:7edd with SMTP id
 l3-20020a170903244300b0016a2b657eddmr18561866pls.20.1656665719734; 
 Fri, 01 Jul 2022 01:55:19 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902654400b001663e1881ecsm14988996pln.306.2022.07.01.01.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 01:55:19 -0700 (PDT)
Message-ID: <c4d24e5c-1a3e-e577-462e-c9ebde90d659@redhat.com>
Date: Fri, 1 Jul 2022 16:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 09/40] virtio_ring: split: extract the logic of alloc
 state and extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-10-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGNyZWF0aW5nIGRlc2Nfc3RhdGUsIGRlc2NfZXh0cmEsIGFuZCBzdWJzZXF1ZW50Cj4g
cGF0Y2hlcyB3aWxsIGNhbGwgaXQgaW5kZXBlbmRlbnRseS4KPgo+IFNpbmNlIG9ubHkgdGhlIHN0
cnVjdHVyZSB2cmluZyBpcyBwYXNzZWQgaW50byBfX3ZyaW5nX25ld192aXJ0cXVldWUoKSwKPiB3
aGVuIGNyZWF0aW5nIHRoZSBmdW5jdGlvbiB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgp
LCB3ZSBwcmVmZXIgdG8KPiB1c2UgdnJpbmdfdmlydHF1ZXVlX3NwbGl0IGFzIGEgcGFyYW1ldGVy
LCBhbmQgaXQgd2lsbCBiZSBtb3JlIGNvbnZlbmllbnQKPiB0byBwYXNzIHZyaW5nX3ZpcnRxdWV1
ZV9zcGxpdCB0byBzb21lIHN1YnNlcXVlbnQgZnVuY3Rpb25zLgo+Cj4gU28gYSBuZXcgdnJpbmdf
dmlydHF1ZXVlX3NwbGl0IHZhcmlhYmxlIGlzIGFkZGVkIGluCj4gX192cmluZ19uZXdfdmlydHF1
ZXVlKCkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDU4ICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQwIGlu
c2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXgg
YTljZWI5YzE2YzU0Li5jZWRkMzQwZDZkYjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAt
MjA0LDYgKzIwNCw3IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAgI2VuZGlmCj4gICB9
Owo+ICAgCj4gK3N0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVz
Y19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKTsKPiAgIAo+ICAgLyoKPiAgICAqIEhlbHBlcnMuCj4g
QEAgLTkzOSw2ICs5NDAsMzIgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2Vk
X2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gICAJcmV0dXJuIE5VTEw7Cj4gICB9
Cj4gICAKPiArc3RhdGljIGludCB2cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdChzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlX3NwbGl0ICp2cmluZykKPiArewo+ICsJc3RydWN0IHZyaW5nX2Rlc2Nf
c3RhdGVfc3BsaXQgKnN0YXRlOwo+ICsJc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhOwo+
ICsJdTMyIG51bSA9IHZyaW5nLT52cmluZy5udW07Cj4gKwo+ICsJc3RhdGUgPSBrbWFsbG9jX2Fy
cmF5KG51bSwgc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSwgR0ZQX0tFUk5F
TCk7Cj4gKwlpZiAoIXN0YXRlKQo+ICsJCWdvdG8gZXJyX3N0YXRlOwo+ICsKPiArCWV4dHJhID0g
dnJpbmdfYWxsb2NfZGVzY19leHRyYShudW0pOwo+ICsJaWYgKCFleHRyYSkKPiArCQlnb3RvIGVy
cl9leHRyYTsKPiArCj4gKwltZW1zZXQoc3RhdGUsIDAsIG51bSAqIHNpemVvZihzdHJ1Y3QgdnJp
bmdfZGVzY19zdGF0ZV9zcGxpdCkpOwo+ICsKPiArCXZyaW5nLT5kZXNjX3N0YXRlID0gc3RhdGU7
Cj4gKwl2cmluZy0+ZGVzY19leHRyYSA9IGV4dHJhOwo+ICsJcmV0dXJuIDA7Cj4gKwo+ICtlcnJf
ZXh0cmE6Cj4gKwlrZnJlZShzdGF0ZSk7Cj4gK2Vycl9zdGF0ZToKPiArCXJldHVybiAtRU5PTUVN
Owo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgdnJpbmdfZnJlZV9zcGxpdChzdHJ1Y3QgdnJpbmdf
dmlydHF1ZXVlX3NwbGl0ICp2cmluZywKPiAgIAkJCSAgICAgc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYpCj4gICB7Cj4gQEAgLTIyMjQsNyArMjI1MSw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHZy
aW5nX2ludGVycnVwdCk7Cj4gICAKPiAgIC8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5n
ICovCj4gICBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQg
aW50IGluZGV4LAo+IC0JCQkJCXN0cnVjdCB2cmluZyB2cmluZywKPiArCQkJCQlzdHJ1Y3QgdnJp
bmcgX3ZyaW5nLAo+ICAgCQkJCQlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAgIAkJCQkJ
Ym9vbCB3ZWFrX2JhcnJpZXJzLAo+ICAgCQkJCQlib29sIGNvbnRleHQsCj4gQEAgLTIyMzIsNyAr
MjI1OSw5IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25l
ZCBpbnQgaW5kZXgsCj4gICAJCQkJCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAq
KSwKPiAgIAkJCQkJY29uc3QgY2hhciAqbmFtZSkKPiAgIHsKPiArCXN0cnVjdCB2cmluZ192aXJ0
cXVldWVfc3BsaXQgdnJpbmcgPSB7fTsKCgpOaXQ6IHRvIHJlZHVjZSB0aGUgY2hhbmdlLXNldCwg
bGV0J3MgdXNlIHZyaW5nX3NwbGl0IGhlcmU/CgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoK
PiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cTsKPiArCWludCBlcnI7Cj4gICAKPiAgIAlp
ZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkKPiAgIAkJ
cmV0dXJuIE5VTEw7Cj4gQEAgLTIyNjEsNyArMjI5MCw3IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9f
dnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gICAJdnEtPnNwbGl0LnF1
ZXVlX2RtYV9hZGRyID0gMDsKPiAgIAl2cS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IDA7
Cj4gICAKPiAtCXZxLT5zcGxpdC52cmluZyA9IHZyaW5nOwo+ICsJdnEtPnNwbGl0LnZyaW5nID0g
X3ZyaW5nOwo+ICAgCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgPSAwOwo+ICAgCXZxLT5z
cGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiAgIAo+IEBAIC0yMjczLDMwICsyMzAyLDIzIEBA
IHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5k
ZXgsCj4gICAJCQkJCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cpOwo+ICAgCX0KPiAgIAo+
IC0JdnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSBrbWFsbG9jX2FycmF5KHZyaW5nLm51bSwKPiAtCQkJ
c2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSwgR0ZQX0tFUk5FTCk7Cj4gLQlp
ZiAoIXZxLT5zcGxpdC5kZXNjX3N0YXRlKQo+IC0JCWdvdG8gZXJyX3N0YXRlOwo+ICsJdnJpbmcu
dnJpbmcgPSBfdnJpbmc7Cj4gICAKPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmdfYWxs
b2NfZGVzY19leHRyYSh2cmluZy5udW0pOwo+IC0JaWYgKCF2cS0+c3BsaXQuZGVzY19leHRyYSkK
PiAtCQlnb3RvIGVycl9leHRyYTsKPiArCWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3Nw
bGl0KCZ2cmluZyk7Cj4gKwlpZiAoZXJyKSB7Cj4gKwkJa2ZyZWUodnEpOwo+ICsJCXJldHVybiBO
VUxMOwo+ICsJfQo+ICAgCj4gLQltZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAsIHZyaW5n
Lm51bSAqCj4gLQkJCXNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCkpOwo+ICsJ
dnEtPnNwbGl0LmRlc2Nfc3RhdGUgPSB2cmluZy5kZXNjX3N0YXRlOwo+ICsJdnEtPnNwbGl0LmRl
c2NfZXh0cmEgPSB2cmluZy5kZXNjX2V4dHJhOwo+ICAgCj4gLQl2aXJ0cXVldWVfaW5pdCh2cSwg
dnEtPnNwbGl0LnZyaW5nLm51bSk7Cj4gKwl2aXJ0cXVldWVfaW5pdCh2cSwgdnJpbmcudnJpbmcu
bnVtKTsKPiAgIAo+ICAgCXNwaW5fbG9jaygmdmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gICAJbGlz
dF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2LT52cXMpOwo+ICAgCXNwaW5fdW5sb2NrKCZ2
ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiAgIAlyZXR1cm4gJnZxLT52cTsKPiAtCj4gLWVycl9leHRy
YToKPiAtCWtmcmVlKHZxLT5zcGxpdC5kZXNjX3N0YXRlKTsKPiAtZXJyX3N0YXRlOgo+IC0Ja2Zy
ZWUodnEpOwo+IC0JcmV0dXJuIE5VTEw7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTChfX3Zy
aW5nX25ld192aXJ0cXVldWUpOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
