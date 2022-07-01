Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DB3C43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC9A940B7A;
	Fri,  1 Jul 2022 09:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC9A940B7A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MReX2+Xl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ffni8KAoUHjB; Fri,  1 Jul 2022 09:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37F1240B78;
	Fri,  1 Jul 2022 09:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37F1240B78
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 115A5C0035;
	Fri,  1 Jul 2022 09:33:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A4EBC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10EA8831F5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10EA8831F5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MReX2+Xl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pbPRRNjA6cmp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:33:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3975682C3E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3975682C3E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656667996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5mtGmTe8EOGM3d6UvtPR8foUzN0Vd8FdOhETeQJNPM=;
 b=MReX2+Xlzcs8C5oKn9ZuHZ6QFf6aPTcoSbiUuAHB8mwcZz/w36GrqfX45skiZ36HZgDcGz
 N87XzzZA48s1qzGmzrzpRqCGVlmu0CnN953nQFQ3aiiPPHEUxAUINKC6BoC/R26gElrO+3
 9D9KFV6Tx7vAs/NYHnKFlGc/1ouGzXQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-5cpK5-8gP3-zR6JSVBL0WQ-1; Fri, 01 Jul 2022 05:33:12 -0400
X-MC-Unique: 5cpK5-8gP3-zR6JSVBL0WQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 g67-20020a636b46000000b0040e64eee874so1061162pgc.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=f5mtGmTe8EOGM3d6UvtPR8foUzN0Vd8FdOhETeQJNPM=;
 b=4p/xjP8WIa5z0M+/lEFlqTbUk8tjlThETciJ+Wncf2I2Hl0pCDHRj0mL2dJqsnjNDi
 s234Hm9/lDRwpy5kK1nzDQzfHBskoHcdYCJyOO9nXfoWX2T8Qw0taMJTLGqP7nm7bRDI
 4JqlymyBi0KkccdcxxJ4ryz/ZEHSaJ8M7jY8e7QeRugr7ZPG4Et0qJWlY6X3IfdCoJMH
 BAk2j9HzImjtCXFnldVgxwASth1v3xwFCSfxPGmRcGGP+OFxgayJwc6BNWB3jxj4/XN3
 LDO5w0MkBP32GXz+puPreCTFBd5aVeu7FlR3AnzLMqSIhqmyht52rdbb52aMJ0nRCNtp
 BMPA==
X-Gm-Message-State: AJIora/UrS6MkMM7ELpfRhzoxoBcoWC9sGC7hARUSlwV8hKxUbCniVsh
 RhLxi9dNmttPKLj+ctFQ57ZV8yWxjsEhz6Sx5f1UEF4DdnuQQ89L4T+tJvISXen8JsecYBli+vJ
 GOpJC3b0R20TMgY+uPPmXhgtghEL9+IEHNtP5r6wu+g==
X-Received: by 2002:a17:90b:4a0c:b0:1ec:d90c:601d with SMTP id
 kk12-20020a17090b4a0c00b001ecd90c601dmr15636535pjb.154.1656667991692; 
 Fri, 01 Jul 2022 02:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVe2pzm2DqVb3UijAovoeTNBz5xv7L4VqCc/Ur/3iGdxZa8PDpPNxiGPMy4N7soHRJKb82Vw==
X-Received: by 2002:a17:90b:4a0c:b0:1ec:d90c:601d with SMTP id
 kk12-20020a17090b4a0c00b001ecd90c601dmr15636485pjb.154.1656667991387; 
 Fri, 01 Jul 2022 02:33:11 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a170902714400b0015e8d4eb28fsm15068862plm.217.2022.07.01.02.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:33:10 -0700 (PDT)
Message-ID: <f35fdd60-8f69-6004-dd00-62e5fe8a8856@redhat.com>
Date: Fri, 1 Jul 2022 17:33:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 23/40] virtio_pci: move struct virtio_pci_common_cfg
 to virtio_pci_modern.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-24-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-24-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW4gb3JkZXIgdG8gZmFj
aWxpdGF0ZSB0aGUgZXhwYW5zaW9uIG9mIHZpcnRpb19wY2lfY29tbW9uX2NmZyBpbiB0aGUKPiBm
dXR1cmUsIG1vdmUgaXQgZnJvbSB1YXBpIHRvIHZpcnRpb19wY2lfbW9kZXJuLmguIEluIHRoaXMg
d2F5LCB3ZSBjYW4KPiBmcmVlbHkgZXhwYW5kIHZpcnRpb19wY2lfY29tbW9uX2NmZyBpbiB0aGUg
ZnV0dXJlLgo+Cj4gT3RoZXIgcHJvamVjdHMgdXNpbmcgdmlydGlvX3BjaV9jb21tb25fY2ZnIGlu
IHVhcGkgbmVlZCB0byBtYWludGFpbiBhCj4gc2VwYXJhdGUgdmlydGlvX3BjaV9jb21tb25fY2Zn
IG9yIHVzZSB0aGUgb2Zmc2V0IG1hY3JvIGRlZmluZWQgaW4gdWFwaS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBpbmNs
dWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggfCAyNiArKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCAgIHwgMjYgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwg
MjYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNp
X21vZGVybi5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oCj4gaW5kZXggZWIy
YmQ5YjQwNzdkLi5jNGY3ZmZiYWNiNGUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0
aW9fcGNpX21vZGVybi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5o
Cj4gQEAgLTUsNiArNSwzMiBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+ICAgI2luY2x1
ZGUgPGxpbnV4L3ZpcnRpb19wY2kuaD4KPiAgIAo+ICsvKiBGaWVsZHMgaW4gVklSVElPX1BDSV9D
QVBfQ09NTU9OX0NGRzogKi8KPiArc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyB7Cj4gKwkv
KiBBYm91dCB0aGUgd2hvbGUgZGV2aWNlLiAqLwo+ICsJX19sZTMyIGRldmljZV9mZWF0dXJlX3Nl
bGVjdDsJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTMyIGRldmljZV9mZWF0dXJlOwkJLyogcmVh
ZC1vbmx5ICovCj4gKwlfX2xlMzIgZ3Vlc3RfZmVhdHVyZV9zZWxlY3Q7CS8qIHJlYWQtd3JpdGUg
Ki8KPiArCV9fbGUzMiBndWVzdF9mZWF0dXJlOwkJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTE2
IG1zaXhfY29uZmlnOwkJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTE2IG51bV9xdWV1ZXM7CQkv
KiByZWFkLW9ubHkgKi8KPiArCV9fdTggZGV2aWNlX3N0YXR1czsJCS8qIHJlYWQtd3JpdGUgKi8K
PiArCV9fdTggY29uZmlnX2dlbmVyYXRpb247CQkvKiByZWFkLW9ubHkgKi8KPiArCj4gKwkvKiBB
Ym91dCBhIHNwZWNpZmljIHZpcnRxdWV1ZS4gKi8KPiArCV9fbGUxNiBxdWV1ZV9zZWxlY3Q7CQkv
KiByZWFkLXdyaXRlICovCj4gKwlfX2xlMTYgcXVldWVfc2l6ZTsJCS8qIHJlYWQtd3JpdGUsIHBv
d2VyIG9mIDIuICovCj4gKwlfX2xlMTYgcXVldWVfbXNpeF92ZWN0b3I7CS8qIHJlYWQtd3JpdGUg
Ki8KPiArCV9fbGUxNiBxdWV1ZV9lbmFibGU7CQkvKiByZWFkLXdyaXRlICovCj4gKwlfX2xlMTYg
cXVldWVfbm90aWZ5X29mZjsJLyogcmVhZC1vbmx5ICovCj4gKwlfX2xlMzIgcXVldWVfZGVzY19s
bzsJCS8qIHJlYWQtd3JpdGUgKi8KPiArCV9fbGUzMiBxdWV1ZV9kZXNjX2hpOwkJLyogcmVhZC13
cml0ZSAqLwo+ICsJX19sZTMyIHF1ZXVlX2F2YWlsX2xvOwkJLyogcmVhZC13cml0ZSAqLwo+ICsJ
X19sZTMyIHF1ZXVlX2F2YWlsX2hpOwkJLyogcmVhZC13cml0ZSAqLwo+ICsJX19sZTMyIHF1ZXVl
X3VzZWRfbG87CQkvKiByZWFkLXdyaXRlICovCj4gKwlfX2xlMzIgcXVldWVfdXNlZF9oaTsJCS8q
IHJlYWQtd3JpdGUgKi8KPiArfTsKPiArCj4gICBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2
aWNlIHsKPiAgIAlzdHJ1Y3QgcGNpX2RldiAqcGNpX2RldjsKPiAgIAo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRp
b19wY2kuaAo+IGluZGV4IDNhODZmMzZkN2UzZC4uMjQ3ZWM0MmFmMmM4IDEwMDY0NAo+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX3BjaS5oCj4gQEAgLTE0MCwzMiArMTQwLDYgQEAgc3RydWN0IHZpcnRpb19wY2lf
bm90aWZ5X2NhcCB7Cj4gICAJX19sZTMyIG5vdGlmeV9vZmZfbXVsdGlwbGllcjsJLyogTXVsdGlw
bGllciBmb3IgcXVldWVfbm90aWZ5X29mZi4gKi8KPiAgIH07Cj4gICAKPiAtLyogRmllbGRzIGlu
IFZJUlRJT19QQ0lfQ0FQX0NPTU1PTl9DRkc6ICovCj4gLXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1v
bl9jZmcgewo+IC0JLyogQWJvdXQgdGhlIHdob2xlIGRldmljZS4gKi8KPiAtCV9fbGUzMiBkZXZp
Y2VfZmVhdHVyZV9zZWxlY3Q7CS8qIHJlYWQtd3JpdGUgKi8KPiAtCV9fbGUzMiBkZXZpY2VfZmVh
dHVyZTsJCS8qIHJlYWQtb25seSAqLwo+IC0JX19sZTMyIGd1ZXN0X2ZlYXR1cmVfc2VsZWN0Owkv
KiByZWFkLXdyaXRlICovCj4gLQlfX2xlMzIgZ3Vlc3RfZmVhdHVyZTsJCS8qIHJlYWQtd3JpdGUg
Ki8KPiAtCV9fbGUxNiBtc2l4X2NvbmZpZzsJCS8qIHJlYWQtd3JpdGUgKi8KPiAtCV9fbGUxNiBu
dW1fcXVldWVzOwkJLyogcmVhZC1vbmx5ICovCj4gLQlfX3U4IGRldmljZV9zdGF0dXM7CQkvKiBy
ZWFkLXdyaXRlICovCj4gLQlfX3U4IGNvbmZpZ19nZW5lcmF0aW9uOwkJLyogcmVhZC1vbmx5ICov
Cj4gLQo+IC0JLyogQWJvdXQgYSBzcGVjaWZpYyB2aXJ0cXVldWUuICovCj4gLQlfX2xlMTYgcXVl
dWVfc2VsZWN0OwkJLyogcmVhZC13cml0ZSAqLwo+IC0JX19sZTE2IHF1ZXVlX3NpemU7CQkvKiBy
ZWFkLXdyaXRlLCBwb3dlciBvZiAyLiAqLwo+IC0JX19sZTE2IHF1ZXVlX21zaXhfdmVjdG9yOwkv
KiByZWFkLXdyaXRlICovCj4gLQlfX2xlMTYgcXVldWVfZW5hYmxlOwkJLyogcmVhZC13cml0ZSAq
Lwo+IC0JX19sZTE2IHF1ZXVlX25vdGlmeV9vZmY7CS8qIHJlYWQtb25seSAqLwo+IC0JX19sZTMy
IHF1ZXVlX2Rlc2NfbG87CQkvKiByZWFkLXdyaXRlICovCj4gLQlfX2xlMzIgcXVldWVfZGVzY19o
aTsJCS8qIHJlYWQtd3JpdGUgKi8KPiAtCV9fbGUzMiBxdWV1ZV9hdmFpbF9sbzsJCS8qIHJlYWQt
d3JpdGUgKi8KPiAtCV9fbGUzMiBxdWV1ZV9hdmFpbF9oaTsJCS8qIHJlYWQtd3JpdGUgKi8KPiAt
CV9fbGUzMiBxdWV1ZV91c2VkX2xvOwkJLyogcmVhZC13cml0ZSAqLwo+IC0JX19sZTMyIHF1ZXVl
X3VzZWRfaGk7CQkvKiByZWFkLXdyaXRlICovCj4gLX07Cj4gLQoKCkkgdGhpbmsgaXQncyBiZXR0
ZXIgbm90IGRlbGV0ZSB0aG9zZSBmcm9tIHVBUEkuIFdlIGNhbiBlbWJlZCB0aGlzIHN0cnVjdCAK
aW4gdGhlIHByaXZhdGUgdmlyaXRvX3BjaV9tb2Rlbi5oIGFueWhvdy4KClRoYW5rcwoKCj4gICAv
KiBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBfUENJX0NGRzogKi8KPiAgIHN0cnVjdCB2aXJ0aW9f
cGNpX2NmZ19jYXAgewo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNpX2NhcCBjYXA7CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
