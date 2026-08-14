Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379C337F337
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734911; cv=pass; b=Ml0VlFHWXUlaexU09fymZOBHAQlW7szRMpWUxY7fqiS/8uth4MB+Z22jkmIlpkzER19fZJV4N2qh129r9EtiIdQZhv0wPIlghqI9ufKPNAB6kjsXN9Qo0J6+X49nKyyWrELoC6hBTlqaIIqT0Da3bHb/9is2tb741eWdKWU5Aw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734911; c=relaxed/simple;
	bh=YARhzzSQQ1PYu0fWMrgI/uEX5C0qrr5INxA7sSEl8ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYv+Jcux24UEwxSR0RAlNPinATVO4wiUSSIDyOTt5SJk0ypnqIELcox2fp+f/uV56MQucVm5TaO3yY36wtscc/L0meXT2SmcQzyR6t/a1OWBr+A9sKczLAu974aJoynIpE2+QbPVdwnbMTE1IbL2vYaKZekHTLtvupOJW5TNQX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzzABvpq; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzzABvpq"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c7264d87dso2616335d50.1
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 12:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786734908; cv=none;
        d=google.com; s=arc-20260327;
        b=jveEt/symuB1P0VV75ccTJcY2whwdx/Wckzh9s1628whAWOtgVS/SnqgPajeDQLb07
         JrGkCLz/Uw3xur2VizZ5Uk6X5oleb7ZlkK3dGu2vMVBOA6b0vQdiQf2xlzikWDrZBy+C
         BPHmsS0G/XsbI9pqntCzdo3O8k9sh9g8HDfxEmLrjMUZHf++4Rs9icogAuQ1F0qdhH7y
         QdXtA1FUSaE00xjSo9281xzLlIiOWoMLkg1TyjgDrZ41F8QceNU55jpO7vUYucUVLHFI
         P3o2I9N3uRL16eGMzOHD+gjoBx7PfiZKEjEyC3KsCLy/nrObYWtfPDXYTw0pZlSG4lST
         hKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        fh=kyicYHbJSojaSJXq9TNzSot7+4OQiWvKk5ypEx7eU4M=;
        b=Xnutx5dMRu/5i5qx0nVG+ULHMTE86JYc3V7dKGyQa8xqaT1xl1LlfjvIsDl+MK3Pnq
         8N8OlkysbWO7bXY4NRKduK2et1ZXELeDukonYCccJ04N3iysOpbucKceT9MfdRkKg+vq
         3EgyqNm9pDB5pt2M+nbKQhkLZ38wAzHoKz6ZNOCdELsVMvmjEr62ZpXy9/ZWEOt/Akx4
         Ji6mOkD6O1AQs+UtJdU4XiEUlxcTMu+8yey2WAnSgnpApH5vg8OPzNe2MOaDukTkjsZV
         D7GNrhBAeKWVAQgq8VdI+wbNiV9GUXFE6tLzcODA5QCpbDxmMyzKrBzGwD58d0r8IuBw
         klgw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734908; x=1787339708; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        b=dzzABvpq9ZLuVJ8NeOb+63vU37b4yOHEi5XaWy2/CoTsqEtqPFmt5AAL4DQIPCGbRn
         9gzxPfXd7X/m0ftIIu2Dgyd6shnpyslEgYu7VtSaGi2lxDcfVqluY5hSo9KIM3z8chIk
         X8Ig4PSQ94dF10d5y5dVBIbM7PrLGkI2tI91p/1HrjCAiphy4iYAasiMpSRzWsbBttxs
         NQZhp0wT/GI47oz+e6lRRlwIuux70ryCjeoxOxqzaLstqDMCCkS3tfoJ4xrWdGiBtBll
         GZF3xUlppOXPUq/qQEfTySzaVT529Lw4vYxBDIypuiSbM82LTqHJItG6nDRIvkV4RpDW
         r3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734908; x=1787339708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        b=IMjUkW6XVZlmJDbdVR0CgWnIrTgM5Aw8Ejs0FWENf5LHjL2HlK5wpuBqbDmolH9IbG
         U4usTsuL7C7Ee2v8TmCsvqYx8xVh0sbIE8WMmw7MvlYRlKnskj9MQZhcy1dHAsBdgFU7
         QdmYqvCe9BoMDsXm5zA12GbAMH/M15MAzDuhOP0HSwJaiDmU7M3F46oZDGCzETR8JU/E
         nQSofUqzEadeodtoHBRifT0DD2ON6zyOFsRLbZrLRgGuQHWK6dVb+n8jmeccCHn/bn0h
         Ke/yMqS7Gzl9Pg+TQDRHaOMbbPFGodElPAxueTWstnCaQ5nYANyDr6H+UiV8q+JkFTel
         ynbw==
X-Forwarded-Encrypted: i=1; AHgh+RqOpHzQ9PyoTWx0hChB/+XUR0SVKqax4VRpi5KkVltN1+Qw3ZWZ4hulW2fk3myJk/x2unC7FylbyGrFAI5fbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5PJwnXIzXyLLAHFiBFr2wg3ofAjmaMvSGk8TT392fmsm9bW+Z
	BFYfqI6sh3f83bT1z1MxIB9yEpdk68qidpvogn/1kGVTBbR4dKUFzTTAPsFV7KjlPhkN5BloGIQ
	kK3ANd+sUMQFeTXAMKBqN7wKtHJda9cE=
X-Gm-Gg: AR+sD11YKJNckcwp5Vhik53iYjhwvnK5dD4qVD9mghh0X0ARugt/GNdWUeHlPC04N/1
	5S68rZoQC1pH4lloVUuybKoEvX7NRcA/NvFyU9mrAm2LoBYqmW0JsrPgtwNvVcnwlNiBJcFCCps
	tXm8luk9ntEri1NN39xX5zymRyBc+2GQJuDRfxeWqWH42Y+o9J4kfIn8Kj29HEit3C7Y5TFzUWY
	MKj0JbwZVi33H99k3FhyIWw1F0y6NFN23fOzwCZUvVBEq/gRJ1l5lPf0hQm7WATRKkROfUYwz+t
	3YCQo5onWLZWdxD4KMf8Ld3tkr7HKrDT90QPOD/0ECVED8/Xi/TmDNmhKL5txZqKhe8d+NN7bfq
	Wow==
X-Received: by 2002:a53:dd0a:0:b0:668:894a:f534 with SMTP id
 956f58d0204a3-66c54cc5fcfmr4473139d50.25.1786734907868; Fri, 14 Aug 2026
 12:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804213510.673084-1-chia-yu.chang@nokia-bell-labs.com>
 <20260804213510.673084-2-chia-yu.chang@nokia-bell-labs.com>
 <20260811173017.3d18dfdc@kernel.org> <PAXPR07MB79849A3F1724DBB2DA8EA20AA3DC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260812155430.6ec81eec@kernel.org> <PAXPR07MB7984E3E73868BF8966821C27A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CAF=yD-LQbndjPZiXcfA6fMp6msza_+YdzqqwyeUDVTdOCOHhDw@mail.gmail.com>
 <47BE8A8A-F80C-4C30-BC95-C85FEBFFB606@ericsson.com> <PAXPR07MB7984ED42ED0849D3A9AB8C19A3DA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <willemdebruijn.kernel.c248a28f9c86@gmail.com> <20260814120121.50e61d01@kernel.org>
In-Reply-To: <20260814120121.50e61d01@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 14 Aug 2026 15:14:30 -0400
X-Gm-Features: AUfX_mzfpoxQCDCly02kzT0GRl9rBucQ1xz8t4L_tqiifrYvAjnLnYkwChvD3sw
Message-ID: <CAF=yD-L1-Sxz9uyP_4WqtNRJHnwTVMhQba_KF-=Eiy=d9Jf-qA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>, 
	"shaojijie@huawei.com" <shaojijie@huawei.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	Ingemar Johansson S <ingemar.s.johansson@ericsson.com>, 
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>, 
	Parav Pandit <parav@nvidia.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 09:34:01 -0400 Willem de Bruijn wrote:
> > > Current SW GRO sets SKB_GSO_TCP_ACCECN when the flushed skb carries C=
WR in tcp_gro_complete():
> > > if (th->cwr)
> > >     shinfo->gso_type |=3D SKB_GSO_TCP_ACCECN;
> >
> > And I suppose it follows correct AccECN rules for coalescing.
> >
> > That is a performance regression from RFC 3168 ECN, as it allows for
> > less effective coalescing. I have no intuition how much it will
> > differ in practice.
> >
> > > For HW GRO of a legacy device that implementing RFC3168 semantics, se=
tting SKB_GSO_TCP_ECN seems reasonable.
> > > However, such a device would not be able to preserve ACCECN signaling=
 across the GRO/GSO.
> > > In that case, if preserving AccECN signaling is required, disabling H=
W GRO may indeed be necessary.
> >
> > Right.
>
> I'm still not following.. Maybe Willem can ELI5 what the problem is.
>
> _SW_ GRO follows only the AccECN rules.
> But if HW GRO follows RFC 3168 and we mark the aggregate as
> SKB_GSO_TCP_ECN - TSO will also abide, and segmented output
> will be identical to pre-GRO input.

+1

> Are we trying to ban RFC 3168 behavior in HW purely to match SW?

I think that's the intent here?

>
> > And there currently is no kernel API to disable only ECN
> > coalescing. NETIF_F_GRO_HW enables or disables HW-GRO entirely.
> > Or even to signal whether a HW-GRO implementation is AccECN
> > capable.
> >
> > Disabling HW-GRO can be a huge efficiency regression. I suspect
> > many users will prioritize the efficiency over preserving the AccECN
> > signal.
> >
> > That said, some devices may have other ways to configure such
> > finer details of their HW-GRO, even though not available through
> > Ethtool.
