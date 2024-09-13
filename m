Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25D188A21
	for <virtualization@lists.linux.dev>; Fri, 13 Sep 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219302; cv=none; b=HRheBjAi44r/LRLN8LLZYJWOXUawEd3C3P24re1e3hvACPOyO5wNKxgBia3YZWejQEdpkAN2JA5oqSameug9u1vShqZ6yyHBWyIHxVx2C1bj1R4PxWi/hr8xRJVAij8uSd0DZy0e0pi9e+o9rdieGMuDnQQMkIbKyG/mzYdQw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219302; c=relaxed/simple;
	bh=tWkzn9AUKlrK6QQAZu0vK6poffG651sKve/AMWzydJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3jVeugsaH2ibuG4STtRhErFKgxtZkS5nbYvKLJijPqA7mqNEURbw6qnpCbAiDFOAcr/9DCrAzM/FnBpBvl1x+N6BGhJFIMVjUVu0kLrntbzFU7vwraRi8NfjYp4XUhHH0SIFuG0EoR0/6MxLUB/QxL7jYot8I8h+Irk+96F4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=NP63nPsE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="NP63nPsE"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so554329566b.1
        for <virtualization@lists.linux.dev>; Fri, 13 Sep 2024 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1726219299; x=1726824099; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tWkzn9AUKlrK6QQAZu0vK6poffG651sKve/AMWzydJw=;
        b=NP63nPsEwMIavSVKFG/yUrqnTQtq5wW1QcwZ5O6cuNplU8zAZGqtUkvCaT2yh1lSnQ
         eQvm74KktJUoXzKf8j7h6KCalcAl0K1d/ZrYsBJgN4H9QhVJCWeC8STSX+my4UgMgGiw
         A2uPTe6i2QtfnI9pq27Png84ahOfQRZO+8mY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726219299; x=1726824099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWkzn9AUKlrK6QQAZu0vK6poffG651sKve/AMWzydJw=;
        b=KqjNtG/c2c2C1dq/mbhJS423ui/KdxhoPWUfcrOZFG6bE7vOmePJSFyRE24unTh/OM
         4jMkYUUOMU4HF1Uv28xAA22R4vVuIiGIeLdsHGUwn0oDemUqfES+IvZjjFG6U8RyrcTu
         PJX6R2BsyioPvcShEEI6SXFhtXNTuOR1mCuGLKDtr9Re8RCM8VtUz+PrnHmGcpNaEfuM
         ErU3m+sbn+LTfhjfRZDOSJTfrpPomJIlWjeZVMlskVgZ7YVt2X0//ck1ZzRd8p4o9TpG
         4D2ki0CAYJ21BHCEdMnxjWwvwcUO7IjvVZYPJCluSk0OLIERT3I8Hu+zGn0XbrQSMbuA
         2PsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5HyZURS3VSgzB4CtkYulHpr3QxGyBjAlfd/SOrvNJf3FDejir8BVMbzmCuh0XWevMRV0XvHkmaraP1rDnw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq+ldMYajoElIqXKrjZOg80rWTpsBXtbmrdXdspL0twUMbJNia
	h0E41I9/1Ydld9Zfi7OgpX6WdKWcrL9vYTmlBh+jAeUFMKRY/+LHgMKslt2A/YakaVUWt509irc
	6HUXETxwOfv8HqgqbMPDnuqA+lRCmWHgsKTZc
X-Google-Smtp-Source: AGHT+IGpKeGirDMUAJQQV4kBllWSmHSmIGPbPjkPo0xIKBiMBuJy60TOCZjyAs5p+mHlIfoVoySt0tSAuLi6f9z2Dfw=
X-Received: by 2002:a17:907:6ea0:b0:a8d:4cec:fcec with SMTP id
 a640c23a62f3a-a8ffae0016cmr1256940466b.26.1726219298512; Fri, 13 Sep 2024
 02:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
 <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
 <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info> <1726216954.7439098-1-xuanzhuo@linux.alibaba.com>
 <565a9204-362d-458d-8b8e-11c5aada7b98@leemhuis.info>
In-Reply-To: <565a9204-362d-458d-8b8e-11c5aada7b98@leemhuis.info>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Fri, 13 Sep 2024 11:21:11 +0200
Message-ID: <CAK8fFZ6W2ZfwTa4nYz8ORTgb0mOTysg89LEEz7cHGtdqwpsvmA@mail.gmail.com>
Subject: Re: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and
 packed virtqueues
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000001859320621fcc0a1"

--0000000000001859320621fcc0a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So far:

1/ I was able to "do a reproducer" and hit the "random memory
corruption" issue with vanila 6.10.10 in our setup in ~28m of uptime
see attached 6.10.10-1.gdc.el9.x86_64.log.
2/ I reverted these commits
"virtio_net: rx remove premapped failover code":
defd28aa5acb0fd7c15adc6bc40a8ac277d04dea
"virtio_net: big mode skip the unmap check":
a377ae542d8d0a20a3173da3bbba72e045bea7a9
"virtio_ring: enable premapped mode whatever use_dma_api":
f9dac92ba9081062a6477ee015bd3b8c5914efc4
in our next build and so far the environment is stable and not
crashing under same conditions like the previous crash.


p=C3=A1 13. 9. 2024 v 10:51 odes=C3=ADlatel Linux regression tracking (Thor=
sten
Leemhuis) <regressions@leemhuis.info> napsal:
>
> On 13.09.24 10:42, Xuan Zhuo wrote:
> > On Fri, 13 Sep 2024 10:26:57 +0200, "Linux regression tracking (Thorste=
n Leemhuis)" <regressions@leemhuis.info> wrote:
> >> [CCing a few people that know more about this stuff than I do]
> >>
> >> On 13.09.24 09:50, Jaroslav Pulchart wrote:
> >>>
> >>> actually I'm getting random memory corruption related crashes after
> >>> updating to 6.10.y. My expectation is that it relates to this issue:
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=3D219154
> >>> It looks like it is almost 1 month ago
> >>
> >> A lot of developer ignore bugzilla.
> >>
> >>> already from the last comment
> >>> there, However the patches fixing the regression are not reverted fro=
m
> >>> the 6.10.y tree which surprises me.
> >>>
> >>> I will try to revert them from our builds and see if it helps to avoi=
d
> >>> random daily happening crashes.
> >>
> >> Not my area of expertise, but to me it sounds like the problem will be
> >> resolved my "Revert "virtio_net: rx enable premapped mode by default""=
:
> >> https://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alib=
aba.com/
> >
> > YES. That is merged into net.
>
> Well, yes, but TWIMC to avoid confusion, it's already one step further,
> as mentioned:
>
> >> That set just landed in mainline.
>
> See
> https://git.kernel.org/torvalds/c/48aa361c5db0b380c2b75c24984c0d3e7c1e8c0=
9
> or
> https://git.kernel.org/torvalds/c/111fc9f517cb293c4213673733b980123c3b020=
9
>
> Ciao, Thorsten



--=20
Jaroslav Pulchart
Sr. Principal SW Engineer
GoodData

--0000000000001859320621fcc0a1
Content-Type: text/x-log; charset="US-ASCII"; name="6.10.10-1.gdc.el9.x86_64.log"
Content-Disposition: attachment; filename="6.10.10-1.gdc.el9.x86_64.log"
Content-Transfer-Encoding: base64
Content-ID: <f_m10idre50>
X-Attachment-Id: f_m10idre50

WyAyMjI0Ljc0Mzc4MF0gT29wczogc3RhY2sgc2VnbWVudDogMDAwMCBbIzFdIFBSRUVNUFQgU01Q
IE5PUFRJClsgMjIyNC43NDQ2MDVdIENQVTogMSBQSUQ6IDUyIENvbW06IGtzd2FwZDAgVGFpbnRl
ZDogRyAgICAgICAgICAgIEUgICAgICA2LjEwLjEwLTEuZ2RjLmVsOS54ODZfNjQgIzEKWyAyMjI0
Ljc0NTM3NV0gSGFyZHdhcmUgbmFtZTogUkRPIE9wZW5TdGFjayBDb21wdXRlL1JIRUwsIEJJT1Mg
ZWRrMi0yMDI0MDUyNC0xLmVsOSAwNS8yNC8yMDI0ClsgMjIyNC43NDYwOTRdIFJJUDogMDAxMDpy
ZWZpbGxfb2JqX3N0b2NrKzB4NDAvMHgxNzAKWyAyMjI0Ljc0NjYyOV0gQ29kZTogNWMgZmEgNjUg
NDggOGIgMDUgYzggYzQgYmQgNzcgNGMgOGQgYjggNjAgMTIgMDMgMDAgNDkgOGIgNDcgMTAgNDgg
MzkgZjggNzQgNWQgNGMgODkgZmYgZTggNzggZWQgZmYgZmYgNDkgODkgYzYgZTggZjAgMzQgZDcg
ZmYgPDQ4PiA4YiA0NSAwMCBhOCAwMyAwZiA4NSBjYSAwMCAwMCAwMCA2NSA0OCBmZiAwMCBlOCBh
YiA3NCBkNyBmZiA0OQpbIDIyMjQuNzQ4MjQxXSBSU1A6IDAwMTg6ZmZmZmE1MDI0MDEwY2UxMCBF
RkxBR1M6IDAwMDEwMDAyClsgMjIyNC43NDg4MDNdIFJBWDogMDAwMDAwMDAwMDAwMDAwMiBSQlg6
IDAwMDAwMDAwMDAwMDAwYzggUkNYOiAwMDAwMmQ4MmQ0MDM4MjQwClsgMjIyNC43NDk0NDldIFJE
WDogZmZmZjk3N2IwMGFhOWEwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiBmZmZmOTc3YjAw
YWE5YTAwClsgMjIyNC43NTAwODJdIFJCUDogYTkxZWY3NjYyMDYxNGQ4NSBSMDg6IDAwMDAwMDAw
MDAwMDAwMDEgUjA5OiBmZmZmZmZmZjg4MWI5MDc3ClsgMjIyNC43NTA3MjBdIFIxMDogMDAwMDAw
MDAwMDA0MDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMjgyClsg
MjIyNC43NTEzNTldIFIxMzogZmZmZjk3N2IwMDIzNWMwMCBSMTQ6IGZmZmY5NzdiYWExNGUyODAg
UjE1OiBmZmZmOTc3ZjZiZDMxMjYwClsgMjIyNC43NTIxODNdIEZTOiAgMDAwMDAwMDAwMDAwMDAw
MCgwMDAwKSBHUzpmZmZmOTc3ZjZiZDAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAK
WyAyMjI0Ljc1Mjk1Ml0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4
MDA1MDAzMwpbIDIyMjQuNzUzNTkzXSBDUjI6IDAwMDA3ZjJkN2U1ZGMwMDAgQ1IzOiAwMDAwMDAw
MjIyMzQwMDA1IENSNDogMDAwMDAwMDAwMDc3MGVmMApbIDIyMjQuNzU0MjcxXSBQS1JVOiA1NTU1
NTU1NApbIDIyMjQuNzU0Njk3XSBDYWxsIFRyYWNlOgpbIDIyMjQuNzU1MTEyXSAgPElSUT4KWyAy
MjI0Ljc1NTUwOV0gID8gZGllKzB4MzMvMHg5MApbIDIyMjQuNzU1OTQ5XSAgPyBkb190cmFwKzB4
ZDkvMHgxMDAKWyAyMjI0Ljc1NjQxOF0gID8gZG9fZXJyb3JfdHJhcCsweDY1LzB4ODAKWyAyMjI0
Ljc1NjkwM10gID8gZXhjX3N0YWNrX3NlZ21lbnQrMHgzNS8weDUwClsgMjIyNC43NTc0MTddICA/
IGFzbV9leGNfc3RhY2tfc2VnbWVudCsweDIyLzB4MzAKWyAyMjI0Ljc1Nzk5OV0gID8gcmN1X2Rv
X2JhdGNoKzB4MWE3LzB4NTMwClsgMjIyNC43NTg1NDldICA/IHJlZmlsbF9vYmpfc3RvY2srMHg0
MC8weDE3MApbIDIyMjQuNzU5MTI1XSAgX19tZW1jZ19zbGFiX2ZyZWVfaG9vaysweGIwLzB4MTQw
ClsgMjIyNC43NTk3MjNdICBrbWVtX2NhY2hlX2ZyZWUrMHgzYjIvMHgzZTAKWyAyMjI0Ljc2MDI5
Ml0gID8gcmN1X2RvX2JhdGNoKzB4MWE3LzB4NTMwClsgMjIyNC43NjA4NDVdICByY3VfZG9fYmF0
Y2grMHgxYTcvMHg1MzAKWyAyMjI0Ljc2MTM5OV0gID8gcmN1X2RvX2JhdGNoKzB4MTNiLzB4NTMw
ClsgMjIyNC43NjE5NTBdICByY3VfY29yZSsweDI1Ni8weDQyMApbIDIyMjQuNzYyNDc1XSAgPyBr
dGltZV9nZXQrMHgzNC8weGMwClsgMjIyNC43NjMwMTBdICBoYW5kbGVfc29mdGlycXMrMHhkMy8w
eDJiMApbIDIyMjQuNzYzNTczXSAgX19pcnFfZXhpdF9yY3UrMHg5Yi8weGMwClsgMjIyNC43NjQx
MThdICBzeXN2ZWNfYXBpY190aW1lcl9pbnRlcnJ1cHQrMHg3MS8weDkwClsgMjIyNC43NjQ3Mzhd
ICA8L0lSUT4KWyAyMjI0Ljc2NTE1OV0gIDxUQVNLPgpbIDIyMjQuNzY1NTk0XSAgYXNtX3N5c3Zl
Y19hcGljX3RpbWVyX2ludGVycnVwdCsweDE2LzB4MjAKWyAyMjI0Ljc2NjE2M10gUklQOiAwMDEw
Om1lbV9jZ3JvdXBfZnJvbV9zbGFiX29iaisweDUxLzB4MTMwClsgMjIyNC43NjY3NTBdIENvZGU6
IDAxIGM4IDQ4IDhiIDM1IDU4IDlkIDI4IDAxIDQ4IGMxIGU4IDBjIDQ4IGMxIGUwIDA2IDQ4IDAx
IGYwIDQ4IDhiIDc4IDA4IDQ4IDg5IGMxIDQwIGY2IGM3IDAxIDBmIDg1IGNkIDAwIDAwIDAwIDY2
IDkwIDhiIDQxIDMwIDwyNT4gMDAgMTAgMDAgZjAgM2QgMDAgMDAgMDAgZjAgNzQgNDUgNDggOGIg
NTEgMzggZjYgYzIgMDEgNzUgMTUgNDgKWyAyMjI0Ljc2ODM1NV0gUlNQOiAwMDE4OmZmZmZhNTAy
NDAzY2ZhNzAgRUZMQUdTOiAwMDAwMDIwMgpbIDIyMjQuNzY4OTk0XSBSQVg6IDAwMDAwMDAwZmZm
ZmVmZmYgUkJYOiBmZmZmOTc3YjlmYmI3MDAwIFJDWDogZmZmZmM2OTIxNGMwYjUwMApbIDIyMjQu
NzY5NzQ3XSBSRFg6IGZmZmY5NzdmMzAyZDZhNDAgUlNJOiBmZmZmYzY5MjAwMDAwMDAwIFJESTog
ZmZmZmM2OTIxNGMwYjUwMQpbIDIyMjQuNzcwNTA0XSBSQlA6IGZmZmY5NzdmMzAyZDZhNDAgUjA4
OiBmZmZmOTc3ZjMwMGU1OGM4IFIwOTogZmZmZjk3N2YzMDBlNThjOApbIDIyMjQuNzcxMjQ2XSBS
MTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiBmZmZmYTUwMjQwM2NmOTAwIFIxMjogZmZmZjk3N2I5
ZmJiNzQ5OApbIDIyMjQuNzcxOTc0XSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiBmZmZmOTc3
YjlmYmI3MDcwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApbIDIyMjQuNzcyNjc4XSAgbGlzdF9scnVf
YWRkX29iaisweDZiLzB4YTAKWyAyMjI0Ljc3MzE1OF0gIGlwdXQrMHgxZjEvMHgyMTAKWyAyMjI0
Ljc3MzU5Nl0gIF9fZGVudHJ5X2tpbGwrMHg3MS8weDE3MApbIDIyMjQuNzc0MDU1XSAgc2hyaW5r
X2RlbnRyeV9saXN0KzB4NjcvMHhlMApbIDIyMjQuNzc0NTQyXSAgcHJ1bmVfZGNhY2hlX3NiKzB4
NTQvMHg4MApbIDIyMjQuNzc0OTk2XSAgc3VwZXJfY2FjaGVfc2NhbisweDEyMC8weDFjMApbIDIy
MjQuNzc1NDcwXSAgZG9fc2hyaW5rX3NsYWIrMHgxMzQvMHgzNTAKWyAyMjI0Ljc3NTkxNl0gIHNo
cmlua19zbGFiX21lbWNnKzB4MTk5LzB4MmMwClsgMjIyNC43NzYzODddICBzaHJpbmtfb25lKzB4
MTE4LzB4MWIwClsgMjIyNC43NzY4NDVdICBzaHJpbmtfbWFueSsweDEyNy8weDJhMApbIDIyMjQu
Nzc3MzE0XSAgc2hyaW5rX25vZGUrMHgzZDcvMHg0MzAKWyAyMjI0Ljc3Nzc2NV0gID8gcGlja19u
ZXh0X3Rhc2srMHg1YS8weGFlMApbIDIyMjQuNzc4MjUwXSAgYmFsYW5jZV9wZ2RhdCsweDI5Yy8w
eDczMApbIDIyMjQuNzc4NzA0XSAgPyBfX3RyeV90b19kZWxfdGltZXJfc3luYysweDYyLzB4YTAK
WyAyMjI0Ljc3OTIyN10gID8gX19wZnhfa3N3YXBkKzB4MTAvMHgxMApbIDIyMjQuNzc5Njc0XSAg
a3N3YXBkKzB4ZjcvMHgxODAKWyAyMjI0Ljc4MDA4Ml0gIGt0aHJlYWQrMHhjYy8weDEwMApbIDIy
MjQuNzgwNDgzXSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMApbIDIyMjQuNzgwODg3XSAgcmV0
X2Zyb21fZm9yaysweDJkLzB4NTAKWyAyMjI0Ljc4MTI5N10gID8gX19wZnhfa3RocmVhZCsweDEw
LzB4MTAKWyAyMjI0Ljc4MTcwM10gIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMApbIDIyMjQu
NzgyMTE4XSAgPC9UQVNLPgpbIDIyMjQuNzgyNDUxXSBNb2R1bGVzIGxpbmtlZCBpbjogdWRwX2Rp
YWcoRSkgdGNwX2RpYWcoRSkgaW5ldF9kaWFnKEUpIG5mX2Nvbm50cmFjayhFKSBuZl9kZWZyYWdf
aXB2NihFKSBuZl9kZWZyYWdfaXB2NChFKSBiaW5mbXRfbWlzYyhFKSB6cmFtKEUpIHRscyhFKSBp
c29mcyhFKSBpbnRlbF9yYXBsX21zcihFKSBpbnRlbF9yYXBsX2NvbW1vbihFKSBrdm1fYW1kKEUp
IGNjcChFKSBrdm0oRSkgdmlydGlvX2dwdShFKSB2aXJ0aW9fbmV0KEUpIGkyY19pODAxKEUpIGky
Y19zbWJ1cyhFKSBuZXRfZmFpbG92ZXIoRSkgZmFpbG92ZXIoRSkgZGltbGliKEUpIHZpcnRpb19k
bWFfYnVmKEUpIHZpcnRpb19iYWxsb29uKEUpIHZmYXQoRSkgZmF0KEUpIGZ1c2UoRSkgZXh0NChF
KSBtYmNhY2hlKEUpIGpiZDIoRSkgc3JfbW9kKEUpIGNkcm9tKEUpIHNnKEUpIGFoY2koRSkgbGli
YWhjaShFKSBsaWJhdGEoRSkgY3JjdDEwZGlmX3BjbG11bChFKSBjcmMzMl9wY2xtdWwoRSkgcG9s
eXZhbF9jbG11bG5pKEUpIHBvbHl2YWxfZ2VuZXJpYyhFKSBnaGFzaF9jbG11bG5pX2ludGVsKEUp
IHNoYTUxMl9zc3NlMyhFKSB2aXJ0aW9fYmxrKEUpIHNlcmlvX3JhdyhFKSBidHJmcyhFKSB4b3Io
RSkgenN0ZF9jb21wcmVzcyhFKSByYWlkNl9wcShFKSBsaWJjcmMzMmMoRSkgY3JjMzJjX2ludGVs
KEUpIGRtX21pcnJvcihFKSBkbV9yZWdpb25faGFzaChFKSBkbV9sb2coRSkgZG1fbW9kKEUpClsg
MjIyNC43ODI0ODddIFVubG9hZGVkIHRhaW50ZWQgbW9kdWxlczogYW1kX2F0bChFKToyIGVkYWNf
bWNlX2FtZChFKToxIHBhZGxvY2tfYWVzKEUpOjMKWyAyMjI0Ljc4NzY5OF0gLS0tWyBlbmQgdHJh
Y2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tClsgMjIyNC43ODgyODZdIFJJUDogMDAxMDpyZWZpbGxf
b2JqX3N0b2NrKzB4NDAvMHgxNzAKWyAyMjI0Ljc4ODg2MF0gQ29kZTogNWMgZmEgNjUgNDggOGIg
MDUgYzggYzQgYmQgNzcgNGMgOGQgYjggNjAgMTIgMDMgMDAgNDkgOGIgNDcgMTAgNDggMzkgZjgg
NzQgNWQgNGMgODkgZmYgZTggNzggZWQgZmYgZmYgNDkgODkgYzYgZTggZjAgMzQgZDcgZmYgPDQ4
PiA4YiA0NSAwMCBhOCAwMyAwZiA4NSBjYSAwMCAwMCAwMCA2NSA0OCBmZiAwMCBlOCBhYiA3NCBk
NyBmZiA0OQpbIDIyMjQuNzkwNjAwXSBSU1A6IDAwMTg6ZmZmZmE1MDI0MDEwY2UxMCBFRkxBR1M6
IDAwMDEwMDAyClsgMjIyNC43OTEyMzBdIFJBWDogMDAwMDAwMDAwMDAwMDAwMiBSQlg6IDAwMDAw
MDAwMDAwMDAwYzggUkNYOiAwMDAwMmQ4MmQ0MDM4MjQwClsgMjIyNC43OTE5MjRdIFJEWDogZmZm
Zjk3N2IwMGFhOWEwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiBmZmZmOTc3YjAwYWE5YTAw
ClsgMjIyNC43OTI2MTBdIFJCUDogYTkxZWY3NjYyMDYxNGQ4NSBSMDg6IDAwMDAwMDAwMDAwMDAw
MDEgUjA5OiBmZmZmZmZmZjg4MWI5MDc3ClsgMjIyNC43OTMzMDNdIFIxMDogMDAwMDAwMDAwMDA0
MDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMjgyClsgMjIyNC43
OTM5ODVdIFIxMzogZmZmZjk3N2IwMDIzNWMwMCBSMTQ6IGZmZmY5NzdiYWExNGUyODAgUjE1OiBm
ZmZmOTc3ZjZiZDMxMjYwClsgMjIyNC43OTQ2ODFdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAw
KSBHUzpmZmZmOTc3ZjZiZDAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAyMjI0
Ljc5NTQzOV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAz
MwpbIDIyMjQuNzk2MTE3XSBDUjI6IDAwMDA3ZjJkN2U1ZGMwMDAgQ1IzOiAwMDAwMDAwMjIyMzQw
MDA1IENSNDogMDAwMDAwMDAwMDc3MGVmMApbIDIyMjQuNzk2ODg3XSBQS1JVOiA1NTU1NTU1NApb
IDIyMjQuNzk3Mzg0XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9u
IGluIGludGVycnVwdApbIDIyMjQuNzk4MzA0XSBLZXJuZWwgT2Zmc2V0OiAweDcwMDAwMDAgZnJv
bSAweGZmZmZmZmZmODEwMDAwMDAgKHJlbG9jYXRpb24gcmFuZ2U6IDB4ZmZmZmZmZmY4MDAwMDAw
MC0weGZmZmZmZmZmYmZmZmZmZmYpClsgMjIyNC43OTkxOTBdIC0tLVsgZW5kIEtlcm5lbCBwYW5p
YyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gaW4gaW50ZXJydXB0IF0tLS0KCg==
--0000000000001859320621fcc0a1--
