Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EEDC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 03:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 166A9829B1;
	Tue, 26 Apr 2022 03:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPxT2j3bjxRY; Tue, 26 Apr 2022 03:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B592B81490;
	Tue, 26 Apr 2022 03:46:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD9DC0032;
	Tue, 26 Apr 2022 03:46:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA90C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C85441295
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MgtSgfIlDL0Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:46:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D619541724
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650944783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+5kKdPw3WI+dqWqeF0INPrgyOUCKqxJJn7dgIpXh9w=;
 b=PB2y2CZxPaz11IECiPAg+xhPlGLJ+I4ACX0AdNk96idndSzzcihi9uojskCfWxq85WMwu5
 5vX7yzfFhYs7Bcq6nNgHsPLs5CV3n0iV7LBzL7UwdQCAVjwZ0G/KaZ1DLLPrLpMJMlobc+
 tUbjVINrGhfV/OH9nMsPIbatF63BnMk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-13K51mzsP5e5zfoA7t-amA-1; Mon, 25 Apr 2022 23:46:15 -0400
X-MC-Unique: 13K51mzsP5e5zfoA7t-amA-1
Received: by mail-pg1-f198.google.com with SMTP id
 d127-20020a633685000000b003ab20e589a8so3480175pga.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 20:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=V+5kKdPw3WI+dqWqeF0INPrgyOUCKqxJJn7dgIpXh9w=;
 b=aQnVgScMHCzhXO5zKIfmK41eR1HLQp/Ibu3Jb/hbCJbCNEyYrF243XIRdBtZWIrEu5
 fkOhHkUvku6Dt/p9JHVqtKDm0+JOhZqyNa90W6nFBWqJnO1JVRJExbY9cJmhws9nA1Cj
 tvpUAP9tNLppYAA6ZfePbIUBzfhTKgpVouZi1MexgihDJAdhQ7Z46AOXJc2in8WmE5q7
 uDLKoF9iXtpd+DQwcWhjPyoYP8hOOEp5D2TtA3jyNHkX8wBXM1b6B0gFZXUXQ63Mf/ac
 IYsmZzIOY7vOfK2PFJ34KGuAHFUaizghjucaMkTx96/14WSnOj1NKeMefOHFb1VIw5tC
 HQzg==
X-Gm-Message-State: AOAM5314/Yzuv5/kwDB/yc4fUDIfbnRRwYbJJkmJsM/DWOaZsqiCL/5c
 UToJmHCvq9xsPpJgp0wAHMEjgfwlGgpMG6HeS6gihhfdkx3jT4YmU6myq+1YrFAtyOegf0LENlI
 iExhJZkWjBbGTKeu9JtX1jyqGD3+ap0RO/pUzK7SB/A==
X-Received: by 2002:a63:e116:0:b0:3ab:812a:d5b8 with SMTP id
 z22-20020a63e116000000b003ab812ad5b8mr2439107pgh.457.1650944774042; 
 Mon, 25 Apr 2022 20:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG6Ams0Mtboz1vlInLrgOti6uyQkKvjIJxFLHKyvNtz76RtrzgASTFxQVGo+4X8PgoYjWslg==
X-Received: by 2002:a63:e116:0:b0:3ab:812a:d5b8 with SMTP id
 z22-20020a63e116000000b003ab812ad5b8mr2439093pgh.457.1650944773852; 
 Mon, 25 Apr 2022 20:46:13 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a62f80e000000b0050d2671b11bsm8826357pfh.53.2022.04.25.20.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 20:46:13 -0700 (PDT)
Message-ID: <7f459ca6-0564-7206-adb2-6abc01c95a6d@redhat.com>
Date: Tue, 26 Apr 2022 11:46:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org> <87a6c98rwf.fsf@redhat.com>
 <20220426045050.4697c833.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220426045050.4697c833.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: paulmck@kernel.org, lulu@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 peterz@infradead.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 tglx@linutronix.de
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

CuWcqCAyMDIyLzQvMjYgMTA6NTAsIEhhbGlsIFBhc2ljIOWGmemBkzoKPj4+PiArc3RhdGljIHZv
aWQgdmlydGlvX2Njd19zeW5jaHJvbml6ZV9jYnMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYp
Cj4+Pj4gK3sKPj4+PiArCXN0cnVjdCB2aXJ0aW9fY2N3X2RldmljZSAqdmNkZXYgPSB0b192Y19k
ZXZpY2UodmRldik7Cj4+Pj4gKwlzdHJ1Y3QgYWlycV9pbmZvICppbmZvID0gdmNkZXYtPmFpcnFf
aW5mbzsKPj4+PiArCj4+Pj4gKwkvKgo+Pj4+ICsJICogU3luY2hyb25pemUgd2l0aCB0aGUgdnJp
bmdfaW50ZXJydXB0KCkgY2FsbGVkIGJ5Cj4+Pj4gKwkgKiB2aXJ0aW9fY2N3X2ludF9oYW5kbGVy
KCkuCj4+Pj4gKwkgKi8KPj4+PiArCXNwaW5fbG9jaygmdmNkZXYtPmlycV9sb2NrKTsKPj4+PiAr
CXNwaW5fdW5sb2NrKCZ2Y2Rldi0+aXJxX2xvY2spOwo+Pj4+ICsKPj4+PiArCWlmIChpbmZvKSB7
Cj4+Pj4gKwkJLyoKPj4+PiArCQkgKiBTeW5jaHJvbml6ZSB3aXRoIHRoZSB2cmluZ19pbnRlcnJ1
cHQoKSB3aXRoIGFpcnEgaW5kaWNhdG9yCj4+Pj4gKwkJICovCj4+Pj4gKwkJd3JpdGVfbG9jaygm
aW5mby0+bG9jayk7Cj4+Pj4gKwkJd3JpdGVfdW5sb2NrKCZpbmZvLT5sb2NrKTsKPj4+PiArCX0K
Pj4gSSB0aGluayB3ZSBjYW4gbWFrZSB0aGlzIGFuIGVpdGhlci9vciBvcGVyYXRpb24gKGRldmlj
ZXMgd2lsbCBlaXRoZXIgdXNlCj4+IGNsYXNzaWMgaW50ZXJydXB0cyBvciBhZGFwdGVyIGludGVy
cnVwdHMpPwo+IFJpZ2h0LCBmb3IgdmlydHF1ZXVlIG5vdGlmaWNhdGlvbnMuIEkgc2Vjb25kIENv
bm5pZSdzIG1vdGlvbiEKCgpXaWxsIGRvIHRoaXMuCgpUaGFua3MKCgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
