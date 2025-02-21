Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603745948
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Feb 2025 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100517; cv=none; b=sTNvQ+fep8hB+yZ5dTQL5i17i3GKyJ3Mb2sjcN6uP092fmPI0gMF9QFOsS1S1MSPojQiHgu2ZabedrZhWTfrKGJ202gq8siOpMZYd54V61aSd9lFrQu/GFXjaGuJeqKH9AqIPygA57swoVnLyuqgEiplFcu3yEWtxJeUU1nrtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100517; c=relaxed/simple;
	bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7fSzFZGaUGVI2scjBW0Q2ONBzxjsJqimLInmbGcvqwhulwH4q1eb/JWBiCYkxVFLn9rYWj2SdfNifjnWu5mk1X4J7MHME0ebb+IW1OlT17ZB3ryrmFJY8JmyGYCjL8b2ILxQufkaxglUfUEfT/ckllygKNsvHivQeAYqpf+SBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0o4AW0S; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0o4AW0S"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8763E814B6
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Feb 2025 01:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLRILvnylNoj for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Feb 2025 01:15:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B288E814B1
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B288E814B1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O0o4AW0S
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B288E814B1
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Feb 2025 01:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
	b=O0o4AW0S4KF4+1E1qQeOtCSp2vnpW40WlgKXQMJhSXp3bg0QIKJXbPSOAq9abp8GrjmZuE
	kuWSpIZwxH3rHfGeuadNJ/MYs9oDmap3VGg0sC5SyiXxgGcyge6fGqoRar3vRx7WKswtci
	auH4iWwP1TuLpGulNsdYEKkNT+W4S4Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-Rp7qyRcEOA-Rtzzq08nsEw-1; Thu, 20 Feb 2025 20:15:09 -0500
X-MC-Unique: Rp7qyRcEOA-Rtzzq08nsEw-1
X-Mimecast-MFC-AGG-ID: Rp7qyRcEOA-Rtzzq08nsEw_1740100508
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2217a4bfcc7so34681925ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 20 Feb 2025 17:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100508; x=1740705308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
        b=YvVxJAut7TNMCYq4uuq83ox1ACYqzpsa1w0C+SYIBLp+eEZE7A1EBEJsJG/3CBF7cU
         5h/DAVuzx/K/yfyWkMWSSwqpAzxnVC5yannorA5RJXP85w86RsdHo5OsD7ZK1eSuJiTc
         5Z/05eDEBcOgCM25y19xMwjw1xTw3Kz+p/q2EVlrDx8F2ShuA7yjxX32U/Z0L1jcJKBK
         +9pxW5daU9Y6ckiKjfudIdBdzCX2CVFriN0f9UfCPsPyVk/TxcycKEA2s0e98fFH30VO
         ZGo0xgG3sHfScWmmFITrGQuvybxZ7FtiJCD2EDES1pMVrZEkeFkjVmwOUW5GYsA16m4o
         T36g==
X-Forwarded-Encrypted: i=1; AJvYcCWIhw4MhXtSP4GC1izZK4XGmr+9h9w54WTm0cTNjGmujO3r3Jy0xnM8oJu0zW7CIaH+MKkL+zEEm3oeAVI4xw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzR5OjqPqIgMdxL6HnNoTtnUGMmiikDcWEZTyJCKVapMMTDUrVz
	5m3GAQuoVdWTdVikakPsUOUfu9O6ruK7a7yIgJjgn1DtytrSTGAY+B0VtpcR19n++H75p+CSU0z
	YIN42lMqPaFJx1Q2WD4yhyDsfOuzJJGPhQIDk7hFYGN+g8bzsZU10d+YxFMe+zgDs/wV7cspN2q
	7EIneNg8NpOPmytgx1wtrDo8ca07sNIFcTpY/Uua0oXxPX5Oc6m0OdAA==
X-Gm-Gg: ASbGnctL2X7+FNQI0TMSuXJ6RAvozQ1D73c6S1A8r9bs4w38+OhZBmU4XLnzPqmhwLD
	BgLRqjL4tOFshPQsiJbIbSicNEN5l8YjUxKcuxpzR1CS3k9YnUegoG+BnLNI8B30=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id d9443c01a7336-221a0ec944cmr13551735ad.9.1740100508428;
        Thu, 20 Feb 2025 17:15:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNUoAtdLLCDrmQ4E0KhxP1/v8E8OjE3hwAErurd7Thltd/lsB3alr0YyGDAyw/Vnr52MolQRVxcb5jecipEJY=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-221a0ec944cmr13551285ad.9.1740100507900; Thu, 20 Feb 2025
 17:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
 <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com> <20250220034042-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220034042-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:14:56 +0800
X-Gm-Features: AWEUYZk12eKYMoRdAhOr_VqKFdK71rl0l2JCQtxsCVicbAIDmOs5Fp4sSGUmfl4
Message-ID: <CACGkMEtN1K7jRVmZwxah1vET=p5k_Nd0cpov=R0B8sP=bjC-sA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U0-5Y_kd_05cGg7VFJYRHl2JvvBm7khkHNjWUIIPbH8_1740100508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Feb 20, 2025 at 08:58:38AM +0100, Paolo Abeni wrote:
> > Hi,
> >
> > On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> > > tun simply advances iov_iter when it needs to pad virtio header,
> > > which leaves the garbage in the buffer as is. This will become
> > > especially problematic when tun starts to allow enabling the hash
> > > reporting feature; even if the feature is enabled, the packet may lac=
k a
> > > hash value and may contain a hole in the virtio header because the
> > > packet arrived before the feature gets enabled or does not contain th=
e
> > > header fields to be hashed. If the hole is not filled with zero, it i=
s
> > > impossible to tell if the packet lacks a hash value.
> >
> > Should virtio starting sending packets only after feature negotiation?
> > In other words, can the above happen without another bug somewhere else=
?
>
>
> Not if this is connected with a guest with the standard virtio driver, no=
.
> The issue is that tun has no concept of feature negotiation,
> and we don't know who uses the vnet header feature, or why.
>
> > I guess the following question is mostly for Jason and Michael: could b=
e
> > possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
> > to explicitly signal the hash fields presence? i.e. making the actual
> > virtio_net_hdr size 'dynamic'.
>
> But it is dynamic - that is why we have TUNSETVNETHDRSZ.

Yes, tun currently only recognizes a subset of the whole virtio-net header.

Thanks

