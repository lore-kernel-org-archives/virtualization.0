Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691538FA6
	for <virtualization@lists.linux.dev>; Sat,  2 Aug 2025 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.248.84.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754120086; cv=none; b=QxDZK11flcA58p0bKMnsqCHsuvyoBmTWMpbsXRuT9/jp+/YKFbH4k46bWpmb4hrBEYU4E5SFyEgxJrrM8XCWKwEgOOuHFVAfsjgUcnT5yiFOtZTvE4XisZLasbvLsSAz/Npuo4SYrH7V4CWZfYe8ubmHJAXFbop1vN91AxsDkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754120086; c=relaxed/simple;
	bh=7jHPoS3M6R5uINh6Ww6zI1lKrjTVqtrHqIRNAiSBrIc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=eSNIbKmm5RbuTyyly3fzkibCPXpTwm2EGiOcIyM0e74RVUGyjI3Q6vYZSWSltc7pxl4LMDIXlrYuiEcjkVZp1alq4GmOpJtsk1cq21Xgo1sljRaqR7tYF4ZhAa9lnQd3Daz3uiOrt9WH00ZtecLW5cFJE4+2bMLva+59bUSs27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; arc=none smtp.client-ip=212.248.84.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 53C1913CF05;
	Sat, 02 Aug 2025 10:26:18 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
	by tsrv.corpit.ru (Postfix) with ESMTP id 1E68D255024;
	Sat,  2 Aug 2025 10:26:34 +0300 (MSK)
Content-Type: multipart/mixed; boundary="------------ialuacMZDRp7TnXh9wmWFbxQ"
Message-ID: <7b657acb-7186-42bf-9be5-8c1253c6316c@tls.msk.ru>
Date: Sat, 2 Aug 2025 10:26:33 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio-net: Fix VLAN filter table reset timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
 jasowang@redhat.com, virtualization@lists.linux.dev, qemu-stable@nongnu.org,
 Lei Yang <leiyang@redhat.com>
References: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>

This is a multi-part message in MIME format.
--------------ialuacMZDRp7TnXh9wmWFbxQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.07.2025 09:22, Akihiko Odaki wrote:
...
> @@ -3942,6 +3943,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>       n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
>   
>       n->vlans = g_malloc0(MAX_VLAN >> 3);
> +    memset(n->vlans, 0xff, MAX_VLAN >> 3);

A nitpick: we don't need to init this memory with 0 before
initing it with 0xff.

But looking at this, why can't we embed n->vlans directly into
this structure, something like the attached patch?

This, and maybe a few other fields like it?

Thanks,

/mjt
--------------ialuacMZDRp7TnXh9wmWFbxQ
Content-Type: text/x-patch; charset=UTF-8;
 name="virtio-net-vlans-inside-struct.patch"
Content-Disposition: attachment;
 filename="virtio-net-vlans-inside-struct.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2h3L25ldC92aXJ0aW8tbmV0LmMgYi9ody9uZXQvdmlydGlvLW5ldC5j
CmluZGV4IDZiNWI1ZGFjZTMuLjFhNzliMDZjZmYgMTAwNjQ0Ci0tLSBhL2h3L25ldC92aXJ0
aW8tbmV0LmMKKysrIGIvaHcvbmV0L3ZpcnRpby1uZXQuYwpAQCAtOTMxLDcgKzkzMSw3IEBA
IHN0YXRpYyB2b2lkIHZpcnRpb19uZXRfc2V0X2ZlYXR1cmVzKFZpcnRJT0RldmljZSAqdmRl
diwgdWludDY0X3QgZmVhdHVyZXMpCiAKICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZk
ZXYtPmd1ZXN0X2ZlYXR1cmVzIF4gZmVhdHVyZXMsIFZJUlRJT19ORVRfRl9DVFJMX1ZMQU4p
KSB7CiAgICAgICAgIGJvb2wgdmxhbiA9IHZpcnRpb19oYXNfZmVhdHVyZShmZWF0dXJlcywg
VklSVElPX05FVF9GX0NUUkxfVkxBTik7Ci0gICAgICAgIG1lbXNldChuLT52bGFucywgdmxh
biA/IDAgOiAweGZmLCBNQVhfVkxBTiA+PiAzKTsKKyAgICAgICAgbWVtc2V0KG4tPnZsYW5z
LCB2bGFuID8gMCA6IDB4ZmYsIHNpemVvZihuLT52bGFucykpOwogICAgIH0KIAogICAgIGlm
ICh2aXJ0aW9faGFzX2ZlYXR1cmUoZmVhdHVyZXMsIFZJUlRJT19ORVRfRl9TVEFOREJZKSkg
ewpAQCAtMzk0Miw4ICszOTQyLDcgQEAgc3RhdGljIHZvaWQgdmlydGlvX25ldF9kZXZpY2Vf
cmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAKICAgICBuLT5tYWNf
dGFibGUubWFjcyA9IGdfbWFsbG9jMChNQUNfVEFCTEVfRU5UUklFUyAqIEVUSF9BTEVOKTsK
IAotICAgIG4tPnZsYW5zID0gZ19tYWxsb2MwKE1BWF9WTEFOID4+IDMpOwotICAgIG1lbXNl
dChuLT52bGFucywgMHhmZiwgTUFYX1ZMQU4gPj4gMyk7CisgICAgbWVtc2V0KG4tPnZsYW5z
LCAweGZmLCBzaXplb2Yobi0+dmxhbnMpKTsKIAogICAgIG5jID0gcWVtdV9nZXRfcXVldWUo
bi0+bmljKTsKICAgICBuYy0+cnhmaWx0ZXJfbm90aWZ5X2VuYWJsZWQgPSAxOwpAQCAtMzk5
Miw3ICszOTkxLDYgQEAgc3RhdGljIHZvaWQgdmlydGlvX25ldF9kZXZpY2VfdW5yZWFsaXpl
KERldmljZVN0YXRlICpkZXYpCiAgICAgbi0+bmV0Y2xpZW50X3R5cGUgPSBOVUxMOwogCiAg
ICAgZ19mcmVlKG4tPm1hY190YWJsZS5tYWNzKTsKLSAgICBnX2ZyZWUobi0+dmxhbnMpOwog
CiAgICAgaWYgKG4tPmZhaWxvdmVyKSB7CiAgICAgICAgIHFvYmplY3RfdW5yZWYobi0+cHJp
bWFyeV9vcHRzKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1uZXQu
aCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1uZXQuaAppbmRleCA3M2ZkZWZjMGRjLi40
YTBjYzM0YWU2IDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tbmV0LmgK
KysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW5ldC5oCkBAIC0yMDIsNyArMjAyLDcg
QEAgc3RydWN0IFZpcnRJT05ldCB7CiAgICAgICAgIHVpbnQ4X3QgdW5pX292ZXJmbG93Owog
ICAgICAgICB1aW50OF90ICptYWNzOwogICAgIH0gbWFjX3RhYmxlOwotICAgIHVpbnQzMl90
ICp2bGFuczsKKyAgICB1aW50MzJfdCB2bGFuc1tNQVhfVkxBTl07CiAgICAgdmlydGlvX25l
dF9jb25mIG5ldF9jb25mOwogICAgIE5JQ0NvbmYgbmljX2NvbmY7CiAgICAgRGV2aWNlU3Rh
dGUgKnFkZXY7Cg==

--------------ialuacMZDRp7TnXh9wmWFbxQ--
