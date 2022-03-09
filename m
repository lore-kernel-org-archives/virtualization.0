Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7327EC4167B
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F578429C;
	Wed,  9 Mar 2022 09:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ob1W1j95m-pY; Wed,  9 Mar 2022 09:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD54F82835;
	Wed,  9 Mar 2022 09:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE68BC001D;
	Wed,  9 Mar 2022 09:04:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBE0C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1B0A60F74
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09alDgre1KDv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50FB060F72
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646816673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eOwlkZcGQDXJozobV2VKRCePhnXpJDnIKdIuSxdQwY=;
 b=DJdxwQi1J2c9dRDmsnS39cdJafN5qr1aTjSlsSzwM9BND+eT2OsXjN2cBwKgKPP1KcQDKy
 v0rGS3k/FrlcWHZJLUeYcSsLytuTwf0gOlT6iYQY3mL6e0qFB4a5HDCAJcLcRIZC8HC+NW
 XryrYE2yEEZ4nnB3ArGQpPCmImkDnjQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-qrjzgPxkNgmdu1TtNmg69w-1; Wed, 09 Mar 2022 04:04:29 -0500
X-MC-Unique: qrjzgPxkNgmdu1TtNmg69w-1
Received: by mail-pg1-f199.google.com with SMTP id
 p21-20020a631e55000000b00372d919267cso982028pgm.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 01:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8eOwlkZcGQDXJozobV2VKRCePhnXpJDnIKdIuSxdQwY=;
 b=GRRw6haGcVZSfPOYlO/OJ8bkO5BJ81FH+ZQ0htSXNIfXgnvYRiqebvt35Kdttccfd4
 81aS+Kr3fJ+nwIwEjuxUfkKNAukeok9TJNfrRFdeBYfZH7NU8djlz0AZdZliVUK0EIAA
 7G+/zUZuZYR5q2A7C9+JoAOdWjs0nd/RnlyB6pq+csAYB+IWqG1oATIBCeawm9vTzPH2
 jE5nRbA0RcF/D/J6p4trVJYrUAiKSXj4HWTr7ON1lfvEJXptmfz2F6oTQtENQXXTJm3Y
 86V5Muk1za7Smk7Lv4UODUAb0uJwc7LwmPU1EvA5RIH67w1nkp3bT2wHAmyOpo2h4n8M
 KfVw==
X-Gm-Message-State: AOAM5320SIKhfY600iqp2DoTUPKjOZStUpyPW06EBoxJd8AtjBNRz0o/
 3qIiJON2HsCgaIVzz8JQqpP77RLw2w3YFj6KAhjQ8p149hsYLlua0K4YVvZ/uKzVLi8ZaDt/nHT
 qM1vVrAk+TocDLJ0Og4SZlYWZFaUu1kZxjAxv7U1HRg==
X-Received: by 2002:a62:1881:0:b0:4e0:1b4c:36f8 with SMTP id
 123-20020a621881000000b004e01b4c36f8mr22643987pfy.26.1646816668219; 
 Wed, 09 Mar 2022 01:04:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUnje7NyiCBB5gGNjdXAqLUtIZXfE6NBoxWfMgYiTY4JFlOMy5UMt3jQvXKvTlc37/MUAVcA==
X-Received: by 2002:a62:1881:0:b0:4e0:1b4c:36f8 with SMTP id
 123-20020a621881000000b004e01b4c36f8mr22643942pfy.26.1646816667945; 
 Wed, 09 Mar 2022 01:04:27 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a639919000000b00364f999aed5sm1614910pge.20.2022.03.09.01.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 01:04:27 -0800 (PST)
Message-ID: <f1fb522d-74ce-a642-7768-deaad76aeddc@redhat.com>
Date: Wed, 9 Mar 2022 17:04:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 21/26] virtio: add helper virtio_find_vqs_ctx_size()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-22-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-22-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEludHJvZHVjZSBo
ZWxwZXIgdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXplKCkgdG8gY2FsbCBmaW5kX3ZxcyBhbmQgc3Bl
Y2lmeQo+IHRoZSBtYXhpbXVtIHNpemUgb2YgZWFjaCB2cSByaW5nLgo+Cj4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGluY2x1
ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIHwgMTIgKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmly
dGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCA1MTU3
NTI0ZDgwMzYuLjkyMWQ4NjEwZGIwYyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRp
b19jb25maWcuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTIz
Myw2ICsyMzMsMTggQEAgaW50IHZpcnRpb19maW5kX3Zxc19jdHgoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYsIHVuc2lnbmVkIG52cXMsCj4gICAJCQkJICAgICAgZGVzYywgTlVMTCk7Cj4gICB9
Cj4gICAKPiArc3RhdGljIGlubGluZQo+ICtpbnQgdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXplKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1MzIgbnZxcywKPiArCQkJCSBzdHJ1Y3QgdmlydHF1
ZXVlICp2cXNbXSwKPiArCQkJCSB2cV9jYWxsYmFja190ICpjYWxsYmFja3NbXSwKPiArCQkJCSBj
b25zdCBjaGFyICogY29uc3QgbmFtZXNbXSwKPiArCQkJCSBjb25zdCBib29sICpjdHgsIHN0cnVj
dCBpcnFfYWZmaW5pdHkgKmRlc2MsCj4gKwkJCQkgdTMyIHNpemVzW10pCj4gK3sKPiArCXJldHVy
biB2ZGV2LT5jb25maWctPmZpbmRfdnFzKHZkZXYsIG52cXMsIHZxcywgY2FsbGJhY2tzLCBuYW1l
cywgY3R4LAo+ICsJCQkJICAgICAgZGVzYywgc2l6ZXMpOwo+ICt9CgoKRG8gd2UgbmVlZCB0byBj
b252ZXJ0IGFsbCB0aGUgb3BlbiBjb2RlZCBkaXJlY3QgY2FsbCB0byBmaW5kX3ZxcygpIG90aGVy
IAp0aGFuIG5ldD8KClRoYW5rcwoKCj4gKwo+ICAgLyoqCj4gICAgKiB2aXJ0aW9fcmVzZXRfdnEg
LSByZXNldCBhIHF1ZXVlIGluZGl2aWR1YWxseQo+ICAgICogQHZxOiB0aGUgdmlydHF1ZXVlCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
