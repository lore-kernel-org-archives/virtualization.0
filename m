Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA351EE7A5
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818553; cv=none; b=mqplUPOriB1qhO0W0XNsURNViOPiIdtm48NBYxM+Brvz4vlj5Jp1rkWk4xyBMCnNzZ7xvu1T3YwG/wSawJwQHKybZXbLz9tXhjjREj9kXiVgoUpAAMtTZzt7bEXZRGSNb5bGcjv1CY66nDuYhFysJq4LrvY8/qwOgvreSHJEyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818553; c=relaxed/simple;
	bh=6PSD8Ihb5wqTIoMhe00VHOCE57HyMwiB7MEagGbuhZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4H15aH2eSqsxpa6mPzFHvPF/2b+riaOCXKELqUnLvAe5xjVCjPLL7i2jVnrvV/UkH7kBHgbQtk3STE0aOKpR+pOfTa7NchGC4GUg6AAWNuzmyJmAI6nKLYmsw/ishyxnza8jj3hETR35oZU5z5bOfr8I8TOIABMwVGX0h50W0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/ksHQGY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/ksHQGY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D21A83886
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 22:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEAb-IYPphpQ for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Mar 2025 22:29:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 269BD8387D
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 269BD8387D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b/ksHQGY
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 269BD8387D
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 22:29:11 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-22355618fd9so6597815ad.3
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741818550; x=1742423350; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Zt5RBTdS4tu9y1ZkvHvMS6PvikbgYBd+xanSqGhaSs=;
        b=b/ksHQGYT56GKvPrGGSKKE9uOknzp1uSgeVSxiRpLawGqWOEN7dfEC2dPz+BIkwtyJ
         AgQ1cEAa1VDAmkNred+36kxmJjt8rc0bQtTRMfeXeYxVbaeej6KkFMu91kdDGf19+b/Q
         YJqTtfd5hXvoYXP3d7RSjMR+GgAmBpBA4wv3zObk6P1CqKXH5pv66eutv2BgnNMU1l9S
         Ng41sf1//ZpJ0Hq+wo8Xmb29ovVvrlj+Aj6I7alTHGQto/LlCzH0adpCSwZdnyB7Nay1
         qPGUhXm7Zn+cWbrcSOs+UA6Ft3MnmOGXd+22c6rM2ZImfjpf/jNuKDsjf7dSkUKf2QP+
         Aj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741818550; x=1742423350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zt5RBTdS4tu9y1ZkvHvMS6PvikbgYBd+xanSqGhaSs=;
        b=YgRAOyxF/iVivDe1sAZlQ4hhW5C7JNazdWkGND8AZ5LvYzACYJPT381KSve6lPx5Wk
         8pO+HIlcmdtDEI6RpxPfNIWFfP7CMFS3BkD+g608VLBNYUxPWJL3xHSzEe3w8PTiKVVE
         su3ekj03KGjHZf9kR7gjo7F5RnJl8NNCJ/LXstaNgwiMPrMd0DbsdvvHQTrYsbvUAQFO
         x/QB5poB/wY6Wfttkf2a9iHfStYTm8DdNmlnuoNePcZ+GA/Crljjv3b6cQKC2ZmZMCoe
         XdxVw3J2MRRhGOu1M9fJAe8n8nSBRknczOrVJ9YIvT++H3jMElFPd7hTeFy2b4EaTD4p
         REZw==
X-Forwarded-Encrypted: i=1; AJvYcCXD6JJgIWelKaguR4ZBuPYvrNNNQ4DarBDcOk/0G9fgDzyLh1B0QP65ucCYorCiKgsLlqdaht+5Me52EUvb3Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxzKN7VuKBA6WtQB/qIDKwORjSBdzyHSrR+XglngbQQQP3TgbHv
	NKWXEYvKAzs2+2zKGozMamCwuM+5tfsyEUBtA970bgqhEFgOM6+3
X-Gm-Gg: ASbGncuKwa7C4GLuRnLW0W1jakOUw6v5AALdjUTM2V79BtQ+ukzl+raewHtbRHCHY60
	oqWozhD5/PDO6Hwxcww6RU3WUCxJ5E6W0QL+m/8YwdiHxaXPJB7Nq2hgpI+zS+YkdZUL/kscm3u
	6HK9V6tPN3i3IsH41gsAom+6/OjlsX4siKXQAzkON0MgjV+dlyLp8hnx/4mGe7z2XL1ULxV2hYP
	ePoU8B+c+abpu5C3mf9ksw90XDc9PoIL3OSkK4meXjarfPWuG3QPA3IRoppCCrUrBugB7EjU3hu
	mkMzmM9EXroAe2DlzPLYRF2lu6RwDfltips0Zr33FGp1HUlByrYQRe146B506xXsUEgMwJ5izdF
	c
X-Google-Smtp-Source: AGHT+IG5eB7LsgG76qzryME3xovo7CXpCBzbsMGvNvGwS4V4Ch2lCvncSSjVtCrUYYynhYS0YR2b6g==
X-Received: by 2002:a05:6a20:160c:b0:1f5:7007:9eb1 with SMTP id adf61e73a8af0-1f58cbc4a43mr14791625637.34.1741818550325;
        Wed, 12 Mar 2025 15:29:10 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7c87csm46437a12.57.2025.03.12.15.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 15:29:09 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:29:07 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <Z9IKs15jhjaaj5px@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
 <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>
 <Z89ILjEUU12CuVwk@devvm6277.cco0.facebook.com>
 <CACGkMEskp720d+UKm_aPUtGZC5NzH+mp_YKoY2NQV6_YBbRz9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEskp720d+UKm_aPUtGZC5NzH+mp_YKoY2NQV6_YBbRz9g@mail.gmail.com>

On Tue, Mar 11, 2025 at 08:59:44AM +0800, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 4:14 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 01:46:54PM +0800, Jason Wang wrote:
> > > On Wed, Mar 5, 2025 at 8:39 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > > >
> > > > On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> > > > > On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> > > >
> > > > WRT netdev, do we foresee big gains beyond just leveraging the netdev's
> > > > namespace?
> > >
> > > It's a leverage of the network subsystem (netdevice, steering, uAPI,
> > > tracing, probably a lot of others), not only its namespace. It can
> > > avoid duplicating existing mechanisms in a vsock specific way. If we
> > > manage to do that, namespace support will be a "byproduct".
> > >
> > [...]
> > >
> > > Yes, it can. I think we need to evaluate both approaches (that's why I
> > > raise the approach of reusing netdevice). We can hear from others.
> > >
> >
> > I agree it is worth evaluating. If netdev is being considered, then it
> > is probably also worth considering your suggestion from a few years back
> > to add these capabilities by building vsock on top of virtio-net [1].
> >
> > [1] https://lore.kernel.org/all/2747ac1f-390e-99f9-b24e-f179af79a9da@redhat.com/
> 
> Yes. I think having a dedicated netdev might be simpler than reusing
> the virito-net.
> 
> >
> > Considering that the current vsock protocol will only ever be able to
> > enjoy a restricted feature set of these other net subsystems due to its
> > lack of tolerance for packet loss (e.g., no multiqueue steering, no
> > packet scheduling), I wonder if it would be best to a) wait until a user
> > requires these capabilities, and b) at that point extend vsock to tolerate
> > packet loss (add a seqnum)?
> 
> Maybe, a question back to this proposal. What's the plan for the
> userspace? For example, do we expect to extend iproute2 and other and
> how (e.g having a new vsock dedicated tool)?
> 

If we were going to add a seqnum and start bringing in other systems, we
would probably want to add support into iproute2. For example, when I
played with qdisc, using ip seemed like the best from the user side.
The iproute2 changes weren't bad at all[1]. We'd probably need the
device to carry a new feature bit too.

That said, all of this still creates the problem of adding new
system-level ways to disrupt AF_VSOCK users. I think we could offer this
in a way that is orthogonal to prior vsock, possibly AF_VSOCK2, a
sockopt, or ioctl to opt-in to using net features... so that we aren't
violating commitment to existing users that vsock should work regardless
of network configuration? letting the user that holds the fd of the
socket make the choice might be the best way to safeguard the contract?

[1]:	https://github.com/beshleman/iproute2/commit/55fd8a6c133335cda4ede6f8928eb3cea54534b8

Best,
Bobby
