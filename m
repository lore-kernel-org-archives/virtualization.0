Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC866CCA480
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 459C361016;
	Fri,  1 Jul 2022 09:34:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 459C361016
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frQjgV8e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JHGw_AnUDa7I; Fri,  1 Jul 2022 09:34:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF86561011;
	Fri,  1 Jul 2022 09:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF86561011
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81A2EC0035;
	Fri,  1 Jul 2022 09:34:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D02FDC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9424D40193
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:34:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9424D40193
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=frQjgV8e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kjXqAGtpclvw
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:34:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DB1240088
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DB1240088
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656668066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRbVMG9pe9kLTW8fXLQQcAgh1G0fF5UqNIzjXT/Ehks=;
 b=frQjgV8eDQIyeBUP7eS5JJ11PoKKd/sdDRGarXN0U8VLdqFiQS6G7fxAwuZsIyCOLesowF
 goJ9kjryM/ws2dCqbMHUP/ksV/KnIfR0FUrDZmLG0EJbQXIiEaMRUesHP42ktUVb+AKxsI
 ZQVIE1BetqJNqMiq/uVuHlw+4b/E0rk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-m6RLhZVKPmuWtj3GVsB5Mg-1; Fri, 01 Jul 2022 05:34:25 -0400
X-MC-Unique: m6RLhZVKPmuWtj3GVsB5Mg-1
Received: by mail-pl1-f198.google.com with SMTP id
 s9-20020a170902ea0900b0016a4515b2e4so1187689plg.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=TRbVMG9pe9kLTW8fXLQQcAgh1G0fF5UqNIzjXT/Ehks=;
 b=X7ewKLSLUysjWfUTcn22e2GHc3rretNcvXllQpk9VBYLhZ7SZWQeC+zLTrNA25cxwl
 fJi3Pcc9qAtevYfc6MQ0S/1YnsxomFTaebvb9f482g5RHYRcUra0v8lfQ82z4LEgjrwD
 fhiOy1deoLkOqD0fkjbw2EFT82ABtQRfrYpPDm2NQjIIDpcYySUxpEvECRTMqNiezfDU
 FlRSzA/w6bfcYNE9nfWud5nUCjVVa7G0SW2Qs4ZUo/Ho2sn3K2/3GmZbzVuzLgmXvzto
 So9DnLZi+tDucjpuSxtttcDyeNmmSTKaYdy0IxBJ9Zmf7UH8J/PySN2qa/qznKncEQCS
 Jtmg==
X-Gm-Message-State: AJIora/YGwSP8EYGT7nhVAcHjG/lJLF2NF9zN4O0hkzjYg1rI1t/85OQ
 6BG89Z3dMpIQgkEZqZUPvAbBVW+XD8FVlUYz3iQoJwyirLkWw+TbskvTq6RLthO26qjjcAN5qeE
 71OmuuBMow1jfjz70dduY8QHdoD9GGToj06L4SRHysQ==
X-Received: by 2002:a63:be41:0:b0:40c:b4a8:dee9 with SMTP id
 g1-20020a63be41000000b0040cb4a8dee9mr11432168pgo.107.1656668064250; 
 Fri, 01 Jul 2022 02:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sE5v7ksf3buwxxjLGMpBCFIkErXWPc59l6I+VsrcgW6eytue9aR08XqOAivwqVk5DzrN+qQw==
X-Received: by 2002:a63:be41:0:b0:40c:b4a8:dee9 with SMTP id
 g1-20020a63be41000000b0040cb4a8dee9mr11432146pgo.107.1656668063999; 
 Fri, 01 Jul 2022 02:34:23 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a636301000000b004085adf1372sm14860507pgb.77.2022.07.01.02.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:34:23 -0700 (PDT)
Message-ID: <10281add-4d72-efe6-e94d-1f19ced9cb27@redhat.com>
Date: Fri, 1 Jul 2022 17:34:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 24/40] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-25-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-25-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gQWRkIHF1ZXVlX25vdGlm
eV9kYXRhIGluIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcsIHdoaWNoIGNvbWVzIGZyb20K
PiBoZXJlIGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzg5
Cj4KPiBTaW5jZSBJIHdhbnQgdG8gYWRkIHF1ZXVlX3Jlc2V0IGFmdGVyIHF1ZXVlX25vdGlmeV9k
YXRhLCBJIHN1Ym1pdHRlZAo+IHRoaXMgcGF0Y2ggZmlyc3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IEFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9f
cGNpX21vZGVybi5oIHwgMiArKwo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCAg
IHwgMSArCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaCBiL2luY2x1ZGUvbGludXgvdmly
dGlvX3BjaV9tb2Rlcm4uaAo+IGluZGV4IGM0ZjdmZmJhY2I0ZS4uOWYzMWRkZTQ2ZjU3IDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+ICsrKyBiL2luY2x1
ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IEBAIC0yOSw2ICsyOSw4IEBAIHN0cnVjdCB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ICAgCV9fbGUzMiBxdWV1ZV9hdmFpbF9oaTsJCS8qIHJl
YWQtd3JpdGUgKi8KPiAgIAlfX2xlMzIgcXVldWVfdXNlZF9sbzsJCS8qIHJlYWQtd3JpdGUgKi8K
PiAgIAlfX2xlMzIgcXVldWVfdXNlZF9oaTsJCS8qIHJlYWQtd3JpdGUgKi8KPiArCV9fbGUxNiBx
dWV1ZV9ub3RpZnlfZGF0YTsJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTE2IHBhZGRpbmc7Cj4g
ICB9OwoKCkFzIHByZXZpb3VzIHBhdGNoLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHNpbXBsZSBl
bWJlZCB0aGUgdUFQSSAKc3RydWN0dXJlIGhlcmUuCgpUaGFua3MKCgo+ICAgCj4gICBzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlIHsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiBpbmRl
eCAyNDdlYzQyYWYyYzguLjc0OGIzZWI2MmQyZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvdmlydGlvX3BjaS5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2ku
aAo+IEBAIC0xNzYsNiArMTc2LDcgQEAgc3RydWN0IHZpcnRpb19wY2lfY2ZnX2NhcCB7Cj4gICAj
ZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfQVZBSUxISQk0NAo+ICAgI2RlZmluZSBWSVJUSU9f
UENJX0NPTU1PTl9RX1VTRURMTwk0OAo+ICAgI2RlZmluZSBWSVJUSU9fUENJX0NPTU1PTl9RX1VT
RURISQk1Mgo+ICsjZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfTkRBVEEJNTYKPiAgIAo+ICAg
I2VuZGlmIC8qIFZJUlRJT19QQ0lfTk9fTU9ERVJOICovCj4gICAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
