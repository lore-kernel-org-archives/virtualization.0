Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73DAC43217
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 17:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68727405F2;
	Tue, 30 Nov 2021 17:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FWfAbAqWLCDx; Tue, 30 Nov 2021 17:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C2E4405F3;
	Tue, 30 Nov 2021 17:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFE7BC001C;
	Tue, 30 Nov 2021 17:56:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E7BCC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E21B405F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id awL8jVSwflbX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:56:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E02C7405F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:56:30 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 35-20020a9d08a6000000b00579cd5e605eso31447039otf.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=sP3a2w9TIAvowtRsPrZvQyg1T33o3v6kWhUG+u0tLlE=;
 b=b4upmZcT1t7xQzyUYE8KQU475W7lJjkGOOYfS1joYDLLcIERbWMU/rYjx7209HwrNK
 algIH55puJuHwwc10ZxvR1AEIiK4O2PxuSQVc8xC3OZkhiAusKoWmtGw0R/JSagg5hqj
 KOOgnN/EGXChaY7ZmP60oildRx3fhZZhcDhel4GtuG1xIv6nTDwuRXVJkksQZWh1IagO
 omft/vl1YWdZRzgivXLMgLiuDzpHzGrF4WSVr4AH6Usp1IBVbxoh9j+cH1ov3fP5ziir
 rRlrtvtaHkZ2YdiEPHMCzm8vwp+Gotsvw/4NMmw20OEne3Yob3RGtquWPRUGJqLVs4fO
 gfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sP3a2w9TIAvowtRsPrZvQyg1T33o3v6kWhUG+u0tLlE=;
 b=BdzUH0+sWdW8x+S3FxAvxVlcPJbmk0zc7rI/ARMFmEUavzHsjfg6yz++66rr3KOYvC
 jl2ed2NmTgfFFKXfUmhqC4zDRimeWW40wlwFU+xNAnWrWneC/vLc/0tXsmEIwmx+Wh3r
 gj377QsPGzrQqV1iG3dyUDv/ySxtXLESck5ucMqf0oCBOxz7ObbiYmUK/LwAUqCHqwYI
 TLNXer2rG26A06iI50cwpC2CgZVDHaFipL/w4O9FiQ7t8fkK5K2yUawfNpBCvMq+s7Wk
 mEOK2RBFBooWMr2QLviWPzxarCnOzlkNQB5Go1+/oclmFPYeVxh512Yr++BIo4dY/yli
 r7xA==
X-Gm-Message-State: AOAM533Uw/lZdp5AYA/gPHMqPknQgqxiuz+SpkxQdvutAPDaZ6T+25in
 QQISgG3HTB/HBB7T+IQSIPc=
X-Google-Smtp-Source: ABdhPJzy2Yq4AwU02waQ4hZbuxHokWD5+Xy6wCmmsKNJziTS72PXddbDdSp6ndvI+xhGOJyxmVEkkA==
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr733642otn.128.1638294989887; 
 Tue, 30 Nov 2021 09:56:29 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id r5sm3859326oiw.20.2021.11.30.09.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Nov 2021 09:56:29 -0800 (PST)
Message-ID: <d9be528c-af35-6c10-c458-9e2f7759bbb3@gmail.com>
Date: Tue, 30 Nov 2021 10:56:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v2 net-next 00/26] net: introduce and use generic XDP stats
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211130155612.594688-1-alexandr.lobakin@intel.com> <871r2x8vor.fsf@toke.dk>
 <20211130090716.4a557036@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211130090716.4a557036@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Andrei Vagin <avagin@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Noam Dagan <ndagan@amazon.com>,
 Cong Wang <cong.wang@bytedance.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Yonghong Song <yhs@fb.com>,
 Shay Agroskin <shayagr@amazon.com>, Marcin Wojtas <mw@semihalf.com>,
 Leon Romanovsky <leon@kernel.org>, David Arinzon <darinzon@amazon.com>,
 David Ahern <dsahern@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
 netdev@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
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

T24gMTEvMzAvMjEgMTA6MDcgQU0sIEpha3ViIEtpY2luc2tpIHdyb3RlOgo+IE9uIFR1ZSwgMzAg
Tm92IDIwMjEgMTc6MTc6MjQgKzAxMDAgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIHdyb3RlOgo+
Pj4gMS4gQ2hhbm5lbHMgdnMgcXVldWVzIHZzIGdsb2JhbC4KPj4+Cj4+PiBKYWt1Yjogbm8gcGVy
LWNoYW5uZWwuCj4+PiBEYXZpZCAoQWhlcm4pOiBpdCdzIHdvcnRoIGl0IHRvIHNlcGFyYXRlIGFz
IFJ4L1R4Lgo+Pj4gVG9rZSBpcyBmaW5lIHdpdGggZ2xvYmFscyBhdCB0aGUgZW5kIEkgdGhpbms/
ICAKPj4KPj4gV2VsbCwgSSBkb24ndCBsaWtlIHRocm93aW5nIGRhdGEgYXdheSwgc28gaW4gdGhh
dCBzZW5zZSBJIGRvIGxpa2UKPj4gcGVyLXF1ZXVlIHN0YXRzLCBidXQgaXQncyBub3QgYSB2ZXJ5
IHN0cm9uZyBwcmVmZXJlbmNlIChpLmUuLCBJIGNhbiBsaXZlCj4+IHdpdGggZWl0aGVyKS4uLgo+
IAo+IFdlIGRvbid0IGV2ZW4gaGF2ZSBhIGNsZWFyIGRlZmluaXRpb24gb2YgYSBxdWV1ZSBpbiBM
aW51eC4KPiAKClRoZSBzdW1tYXJ5IGFib3ZlIHNheXMgIkpha3ViOiBubyBwZXItY2hhbm5lbCIs
IGFuZCB0aGVuIHlvdSBoYXZlIHRoaXMKY29tbWVudCBhYm91dCBhIGNsZWFyIGRlZmluaXRpb24g
b2YgYSBxdWV1ZS4gV2hhdCBpcyB5b3VyIHByZWZlcmVuY2UKaGVyZSwgSmFrdWI/IEkgdGhpbmsg
SSBoYXZlIGdvdHRlbiBsb3N0IGluIGFsbCBvZiB0aGUgY29tZW50cy4KCk15IHJlcXVlc3Qgd2Fz
IGp1c3QgdG8gbm90IGx1bXAgUnggYW5kIFR4IHRvZ2V0aGVyIHVuZGVyIGEgJ2NoYW5uZWwnCmRl
ZmluaXRpb24gYXMgYSBuZXcgQVBJLiBQcm9wb3NhbHMgbGlrZSB6Y3RhcCBhbmQgJ3F1ZXVlcyBh
cyBhIGZpcnN0CmNsYXNzIGNpdGl6ZW4nIGFyZSBleGFtcGxlcyBvZiBpbnRlbnRpb25zIC8gZGVz
aXJlcyB0byBtb3ZlIHRvd2FyZHMgUngKYW5kIFR4IHF1ZXVlcyBiZXlvbmQgd2hhdCBleGlzdHMg
dG9kYXkuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
