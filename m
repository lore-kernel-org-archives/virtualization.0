Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A279EA
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920828; cv=none; b=jbw/93meegPpR49U4Lh/L3sibHvZmPJaWhcEhba+IEIGlgpH435MIBzdoxd7MoIW4lg9ddVuSJnEmoO+mQm8BBFeU7eI0Dbmq+dclu2n8/AvoQKE1Ijop3i1TxmUuhsXcaSc4zHEf1CvujG2BeDykku5TEeEhSG6EkvbpQjxYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920828; c=relaxed/simple;
	bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpQ5ed58g9/+Yw0TMSovujkticraDY6iOKFKxQApAVHumqLOCLjingxHocrO6tr9WgAvJ64rwvpPZCNeuFvvy6apKUwRHWLGQtdbSSSuL8acND4zACZptKNllCLTBzNjzeMcsygMrOJcMzJ+u4qFJ9jI3/Iz0lGTM9NxAhsw2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjmCxlJw; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjmCxlJw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D049841137
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 03:20:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLyHexVWL3w7 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jun 2025 03:20:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0677D40D9E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0677D40D9E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UjmCxlJw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0677D40D9E
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748920824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
	b=UjmCxlJwISGCRLXLgRI/NCGknD4F16wVjnfwHZ7lDWT+TUodS1HXRCByDt9cXhgGMcemJe
	bDeRZgQm3u8TJVt4+m2l7Kk8Y3XmeU94IrLl4rzgg0hCKYxs7/6+xCYDDGzd85VstroApp
	DQg3vJwRFVnq5sM29yuDcw2+hfgpHuw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-_w5VuJ5nP02b0B2xDC7GMA-1; Mon, 02 Jun 2025 23:20:20 -0400
X-MC-Unique: _w5VuJ5nP02b0B2xDC7GMA-1
X-Mimecast-MFC-AGG-ID: _w5VuJ5nP02b0B2xDC7GMA_1748920819
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311e7337f26so3933811a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 02 Jun 2025 20:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920819; x=1749525619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuUuFxKyZLAGBzKOOo1OIiQNWaS91RBjDVMCFq+b1Ug=;
        b=bygSY3VVHNALyYEQFtWbi1prXmVhICtLk+841LfjqYtAtxxiCaws92ejahLFq8o6aj
         rUFaxFh5ikyErntOMJMEvxZgtGO37Q9sIWoDZip2Mj2vBdh5MFtmq9hXBuFa8uIN+o6t
         GsvaYvyw8HVCeGsCZk41qgEtQWSdbxq1zudviQBR8iFMkupD5iLmY69K2vYVROpbmj+n
         +GOc6aEJh83cIt12gXo82PcgvOpJmfG3NX1fTlDvEU+T8+/EFdB5JpWc/sBvSyfyTvR0
         t93oBi/6F3FFjbvlYZaCN+1AiWzGrDJzsigUYaMZRk08jMCjCFoob4iYVgKvqS6dWCGG
         Po1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxyoeGNSEZ0RA/WlbKubqNvA2d/qL2LaOz+8WG1N5Z/3eQ5jE6JfxQZhujhm7Hgn2CCJ2iR0JxpGmOIwcFOA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzHjgu+ZpJTig0mSPgnawBQ/LfZV4LMNi3+Lm2NSwqIGVC3RCeV
	ymeLmQwA2LUv7K9zWQ37V0QM5iREAcmDVCW9+IHzMYJFne0XJZgCbVB2XHQZF65pkBQzRMEm6yj
	j65ioR1hRSO/FuMndp3a+hc6BkSauIrN1/8wtJjbxuiA86ha57WpHigRHO7Ojk5nat31WYNeUFw
	9c7kaXOYjY6n5hdZ6kqtqVhuJnwygsUsorNUC4GfAyhp6Lwoya7VeGs2r2Og==
X-Gm-Gg: ASbGncutqaGzev3teiGxz/nxkyFGr+42GNkGYD+HwdEuAmSMy6iW36VwXX3A/Ydm9dn
	H1pb0FMdDoh93SfRvEnLuWB6Ux2vUUdro63M7EO2m5DvxBQWdtqbk5PN5ppc++qolcqWS8Q==
X-Received: by 2002:a17:90b:2e45:b0:311:ea13:2e6a with SMTP id 98e67ed59e1d1-3124150cd29mr24182687a91.13.1748920819265;
        Mon, 02 Jun 2025 20:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMKoDoVhANJXhkEH8PMyc1LxUezj6sEzlWUU8w4Uyd+7t0SdHYB02l6iAUnHMY64ChUWPuoGBpUpLK5iNRSqc=
X-Received: by 2002:a17:90b:2e45:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-3124150cd29mr24182639a91.13.1748920818809; Mon, 02 Jun 2025
 20:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-2-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-2-95d8b348de91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 11:20:06 +0800
X-Gm-Features: AX0GCFvi3ezIBQa7yKxnmidSOgr8eNk-oM266seJU5yCRwglxX_y22dfD-57w2A
Message-ID: <CACGkMEuwb+EcT=W5OwbZ=HOf=d56cZFKF5aYPx0iCLOZ630qNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 02/10] net: flow_dissector: Export flow_keys_dissector_symmetric
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hoM6LveiL0UTy0z4kNu0a6XRvbbxjrgpKF7-7RvUnhQ_1748920819
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> flow_keys_dissector_symmetric is useful to derive a symmetric hash
> and to know its source such as IPv4, IPv6, TCP, and UDP.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

