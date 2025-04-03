Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370942E3386
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690421; cv=none; b=ErIVwNT9YG7Ej70pHiHHuPTVi4nTGep9S3NNbbiTZKxXNuAa9AC8B2BlXa89irhYY1a3v+kHH9vsOzMtGn0EHE0NlqTnFGoePa32zxtUtfeFLAw7eLu/e/aWW0AazU7AvTAAPd/xU2vaOG9ktz0LUvPWp205lWl1pNw3zwDEEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690421; c=relaxed/simple;
	bh=3H/q3VCbKUvTmxT5KHpB3sPOrrtaG+j/5ZoBSAeRGAk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oHnYuP+234Mh0sDlt5Jx8/sKZW1/qyLhaeP7cB0fBRuhl/Sv6fS+6h2xyRISwqA1Z4l5emNcUiHzeNmRsrqKUtmksyh3vre1mn1jtJnp8WgqNpQN6Hvn8QKsubg6I0/XgqEEjXf++UaOESEWU3992vWk+nZcmM98uk8NjmQKllE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqZJzhhE; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqZJzhhE"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBF7A40CDD
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 14:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DELdNWKoVzRj for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Apr 2025 14:26:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CA7EB406ED
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA7EB406ED
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CqZJzhhE
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA7EB406ED
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 14:26:58 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7c08f9d0ef3so48369685a.2
        for <virtualization@lists.linux-foundation.org>; Thu, 03 Apr 2025 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743690417; x=1744295217; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CZAmNn5KUIQDDBuM8wsmsl+fKPlZ/xNdDm5B7P8SPg=;
        b=CqZJzhhEHi9uVgDQ8gJ5ujr/fVJN9oZZGytDaa9ubK4szEzAWMO6DMQRB9AGrJnle4
         5s9Jqrv0qZAV9uLQDGqnM+RqFmTGHm5JNF4L95+FiXOdVcHtOaaRKAGHd1jwbLTbFfrs
         uI2iMDeTZfc2poGPSjf4WH7xavxqsPLbJXTdZVDkwhqPUi4BO2GwxcftSXbNuqzsB2y7
         w0D3J0xIu0PaQZpnm2CqlKd4uLyJR/wvcWE3mmc+px1qRHtr3Or14mSZdjbTURHqwcVZ
         RUSIYifL0ws8sk2j7hI4HEv5Ejx7DA2YzxQYGztiSuYGG5YRFVcMSbd3u/3Q1qQ8xGpw
         q5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690417; x=1744295217;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1CZAmNn5KUIQDDBuM8wsmsl+fKPlZ/xNdDm5B7P8SPg=;
        b=qEv0H2gTQUJToYD87ZGi8bH8fytyg2MdifQWw1E4vY7G+2LTAGceZiRiVBIDlrbqyI
         Phc4HgxyS/+X/wNNcXCFNWXFiDe5MrP743AK5IBb8ussHCbFAZxEw0SNpgZsAvCY5zHT
         Alo7bFy/UzEMBwJaL91QXntVCOjh44zCubN8j8lZG0Uy5kPpRbhtdoauQuoZeCJeOQfy
         U0cFn09JY/mZ0wZCoHxTOtVPHC/J8RamO3eG6EIa5Mp3HP2qYtbbSPhrLKMhh9vrzICc
         qEIZtPGhdUjeAicBY4TuU9wSrcdqjlLWdeABc9eO36sZltZzNilxRpL1JNZYBpI1RRG+
         fDuA==
X-Gm-Message-State: AOJu0YzdqtBTL76ps0yh22GZbDxn5UW+shKLtMa90AY+nwoIdcOPNSG6
	kwCF1F4rT4lLhrbRmwgJ3cGmMfSaELkNvNMDTiDSN9jYF8LI/5y/
X-Gm-Gg: ASbGnct6nEMz36ML3yyDHFNnTEbw6w2uHU0lncjgZQbrPKcABqrm/+fKudUtZb37FCe
	dR7RnjuUFf8hjXX9/cc9SBqDsfSCUnAoPLg6yl7FWNuTuKWJ48mo5EzPAaEhHbXe4W9o+CbH2Nr
	AILT3PNKRejcOLiF6IYq4mASL02RGCbbs7WQZn3GmQm+qIY4mbJmidQO0vVhiAiJXYCz2HRGd8+
	2hTbLeML9+THWkTJX0kNWkZlSDKzBv4P7B101DtITyb11NQrohzBeD5BhW/i0VakSyNijzySROU
	9beK2GK7CHPIZVXUpBlzlzrXnf4pjdy5BjMOJ5CeulRGznwghH+LHBX4pp/EdAGsVp+LxYGF3ZQ
	OM9B8zWL98ufRmSn6E3hkEw==
X-Google-Smtp-Source: AGHT+IFlRHBw2ikpgIutCACR/qwVGVZnnXg5ZN0d8jVb1lzRGOGU/wMd718oZ4+RUAzNMauzG0xZww==
X-Received: by 2002:a05:6214:20c3:b0:6e8:955b:141e with SMTP id 6a1803df08f44-6eed6023f5bmr348001696d6.21.1743690417447;
        Thu, 03 Apr 2025 07:26:57 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f00f2e0sm8170696d6.36.2025.04.03.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:26:57 -0700 (PDT)
Date: Thu, 03 Apr 2025 10:26:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <67ee9ab0a1665_136b7c29412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250403100206-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
 <20250403100206-mutt-send-email-mst@kernel.org>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > Tsirkin:
> > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > > Hi,
> > > > =

> > > > I'm observing a significant performance regression in KVM guest V=
Ms
> > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> > > > =

> > > > When running on a host system equipped with a Broadcom NetXtreme-=
E
> > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the
> > > > guest drops to 100=E2=80=93200 KB/s. The same guest configuration=
 performs
> > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM is
> > > > moved to a host with Intel NICs.
> > > > =

> > > > Test environment:
> > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > - Guest: Linux with virtio-net interface
> > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level=
)
> > > > - CPU: AMD EPYC
> > > > - Storage: virtio-scsi
> > > > - VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
> > > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > > =

> > > > This issue is not present:
> > > > - On 6.8.0 =

> > > > - On hosts with Intel NICs (same VM config)
> > > > =

> > > > I have bisected the issue to the following upstream commit:
> > > > =

> > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning for=
 small
> > > > tx")
> > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > =

> > > Thanks a lot for the info!
> > > =

> > > =

> > > both the link and commit point at:
> > > =

> > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > =

> > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in virtio=
_net_hdr_to_skb()
> > > =C2=A0=C2=A0=C2=A0 =

> > > =

> > > is this what you mean?
> > > =

> > > I don't know which commit is "virtio-net: Suppress tx timeout warni=
ng
> > > for small tx"
> > > =

> > > =

> > > =

> > > > Reverting this commit restores normal network performance in
> > > > affected guest VMs.
> > > > =

> > > > I=E2=80=99m happy to provide more data or assist with testing a p=
otential
> > > > fix.
> > > > =

> > > > Thanks,
> > > > Markus Fohrer
> > > =

> > > =

> > > Thanks! First I think it's worth checking what is the setup, e.g.
> > > which offloads are enabled.
> > > Besides that, I'd start by seeing what's doing on. Assuming I'm rig=
ht
> > > about
> > > Eric's patch:
> > > =

> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.=
h
> > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct=

> > > sk_buff *skb,
> > > =C2=A0
> > > =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> > > =C2=A0			return -EINVAL;
> > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > +			return -EINVAL;
> > > =C2=A0
> > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > skb_transport_offset(skb));
> > > +		nh_min_len =3D skb_transport_offset(skb);
> > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > =C2=A0			return -EINVAL;
> > > =

> > > =

> > > sticking a printk before return -EINVAL to show the offset and
> > > nh_min_len
> > > would be a good 1st step. Thanks!
> > > =

> > =

> > =

> > Hi Eric,
> > =

> > thanks a lot for the quick response =E2=80=94 and yes, you're absolut=
ely right.
> > =

> > Apologies for the confusion: I mistakenly wrote the wrong commit
> > description in my initial mail.
> > =

> > The correct commit is indeed:
> > =

> > commit 49d14b54a527289d09a9480f214b8c586322310a
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Thu Sep 26 16:58:36 2024 +0000
> > =

> >     net: test for not too small csum_start in virtio_net_hdr_to_skb()=

> > =

> > This is the one I bisected and which causes the performance regressio=
n
> > in my environment.

This commit is introduced in v6.12.

You say 6.8 is good, but 6.8.1 is bad. This commit is not in 6.8.1.
Nor any virtio-net related change:

$ git log --oneline linux/v6.8..linux/v6.8.1 -- include/linux/virtio_net.=
h drivers/net/virtio_net.c | wc -l
0

Is it perhaps a 6.8.1 derived distro kernel?

That patch detects silly packets created by a fuzzer. It should not
affect sane traffic. Not saying your analysis is wrong. We just need
more data to understand the regression better.=
