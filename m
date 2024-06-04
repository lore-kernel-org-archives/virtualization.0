Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83A13A24E
	for <virtualization@lists.linux.dev>; Tue,  4 Jun 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492735; cv=none; b=SLuvmellNP8hBpQgo8Z+Hb0HJGj0bFXa937ydD/SNev0hB4IkrMMUh9WP82ndbOPFcZCuowgeExIox18hfagleIyAsJkn6gYvmb2j2mVUfkY22xIK9m5fu4XavpF4Gm/7TCSI1eLyNYD5BzTPBN2dQxbTe/ddZWtO2Br/3m8Pb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492735; c=relaxed/simple;
	bh=y24sg8KoLjv+41EDnW9OXIgfRUxZm78ZBUxCXzBqUnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmlK4/Aatbl0q1w8r7qjYUEqzdyTN0+xT2EWgBoaMI1ejy41UyPJAGlmZuC6SlerrCi18a41xoZCwOQf33UAIIV8iC7O9Iv3t73fIomrPxD2N1U1OaFrQPCWf/Yqtt4coxjeR4BqYJJG+iuer4z7P7JQfR6sjVFjXemDJOwcHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gMTPzPG4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gMTPzPG4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a3d21299aso4407524a12.2
        for <virtualization@lists.linux.dev>; Tue, 04 Jun 2024 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717492732; x=1718097532; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fEpYJu85v46NTnKJ3KqBksM1WhwBh1dyX2mzBw78w34=;
        b=gMTPzPG4n2tGGgkRToxE+/XIT2aPXrBo8XOp/fHb1clQlK+ki61nVha94fyH4aqhRB
         tXgZ8Eczfftion6LDa+R0QY18j+3vXe+D6nbP6smxAwJurnj32eT6QWKaim2bubipzQo
         xynuOz/jF7mtqjucOr6aX3AG26Fp4itbvh3gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492732; x=1718097532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEpYJu85v46NTnKJ3KqBksM1WhwBh1dyX2mzBw78w34=;
        b=bA+i8VbKvu84xLQTGA0SFFlxqOml1SdP50dwCeXxRpBsv2awWE+o7HcGQiVRMp7Jgp
         GmFI0TwYjwIMTECwuxZb3rmZIvdAqu4CAiuOLFUgSF6pLdPl4xK/SN2+A2TLF0WIxgDN
         4DcZAdajWBm8jFG5GdrTYUSwMYUhswHH+Yhl18OKzT9ICyEc15IY47/m/CmTYjLvYowh
         Od8+UkQcKR8Lgb5em6LwKpdYIQhJP+flL1jgMsP2FAoSJdqwC2xRzwUH+emnlDGVjNNT
         U6rT4gDpaKMURhHX5CSUTvSIUg03mMYjaXhwVp3PLPLlRP3pZEBi0hl05TlgcLgrqXjF
         GWUA==
X-Forwarded-Encrypted: i=1; AJvYcCVRd4FBG/SXpTFq+O9zia0T9eJw332cSZDovdTve5nGQxClKPjXpQy08jBTTQv32svzQv1VaYK5Pb+lBrpitIbmQfjY7HVF6kVdkRCQnh8=
X-Gm-Message-State: AOJu0Yw9EH4qVjL9ckvCSQL6v8DohPu9GB0xuAxN1Vu13PPFCVOzrSJR
	Px3jdKvOR5zqXVnyApOvA+jUGkem8kZQauy/0q5Zn5Lngm8tnnrpsHU5wajCBKVrSb9eFQN/79p
	ZZRNHt7JteevHfqzL+xH1Oi0Sl99sNizbyaJSGA==
X-Google-Smtp-Source: AGHT+IFo8j4sOBfT1n8cPC7tGx+7OLobCxi5ayAMEMDGNgh+nAaoLHPDPn7rp6lrSqaGLRRjQ0GDgHh2x0xSeqMgKdo=
X-Received: by 2002:a17:906:b20a:b0:a68:a52b:7554 with SMTP id
 a640c23a62f3a-a68a52b7810mr533041766b.66.1717492732344; Tue, 04 Jun 2024
 02:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com> <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
 <20240603152801.GA1688749@fedora.redhat.com> <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
 <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
 <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com> <464c42bc3711332c5f50a562d99eb8353ef24acb.camel@nvidia.com>
In-Reply-To: <464c42bc3711332c5f50a562d99eb8353ef24acb.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 11:18:40 +0200
Message-ID: <CAJfpegu3kwv9y1+Yz=Ad_eJt7-fNJbxgJ8m2_B=Su+Lg6EskGQ@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: Idan Zach <izach@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 11:08, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> Option 2 is detectable if fuse_init_out.minor < CANON_ARCH_MINOR, not
> sure yet what we could do with that knowledge (maybe useful in error
> logging?).

Using the version for feature detection breaks if a feature is
backported.  So this method has been deprecated and not used on new
features.

Thanks,
Miklos
