Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72217995E
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489921; cv=none; b=oG/k70BWHlau3E6GRKXCY6B8jq3pGoSZcCx8Uoj98G3iAIx8A1GmoQuEjqQDWH+f5gU8QU7lXFrtdAG2PvqeDKE2Q3Bf2ThnHnOMy7e7v/LBfz6lczDQOk8AzdI3CkNM7DgQE4DUfPdXNaDvIl1LDiUte3rVuc+VaB6PFWvV380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489921; c=relaxed/simple;
	bh=k8iw9+kciIECw/ctmne1alKhyO7yDWLOtGLrwdrz43s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHD49u0f8YtVfPARaJBcg2FJt1w9JG638oX2N+41BYBIC0bZPB7Lrz99/CA8taj7+ssBxr8Ep1dXszZZ6iVGAblQfyLiXYdJCrugugm1tghh/8JmDMgZlYdsNOLMXxHmD6tYXd/niMt0AJtOw47dasml0Rwvr++LR9e5wXynma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQOk15k2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQOk15k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736489917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISxfKzVoXDOr34Y5KsabwaYvJOoTxc4gV0y3MMcBA0A=;
	b=GQOk15k2V8gcHO2AnLz230RkKVKYjd8dNG1kBN3uqnuUkSVBnLW0CepRICY81BMJbL+wpA
	48hRnqgmqJugaW1/k1stliI6EHceyWoLwFNVHCDY8rzATD6grCMRQ+mCZZ6YVVvrWs3xw2
	zs3MsmXMa0Fc8smBxtihosTlDNgc9w8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-SlU31jIzMo-Ap87MNMii2A-1; Fri, 10 Jan 2025 01:18:35 -0500
X-MC-Unique: SlU31jIzMo-Ap87MNMii2A-1
X-Mimecast-MFC-AGG-ID: SlU31jIzMo-Ap87MNMii2A
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso1456221a12.0
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 22:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736489914; x=1737094714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISxfKzVoXDOr34Y5KsabwaYvJOoTxc4gV0y3MMcBA0A=;
        b=Wg5TnDctVFywC6EhKZczDnVcf+fFso8f34DgMb7zmuHD1hPY5S8Z1M0BEY1fMZZBwd
         wOz+BSILYI9KPIFZBdEOzq/bMYXM+6nmH4FcVBKs7x1ZJRPCE4GoaCRqMwNmqlKh2aQQ
         iT236J+tDJywyC6mpmaG4BWwtxM1g+a92rK96+FP0eCJ7WYsonBdvd3bAYv7q3pE4ey8
         roJb3TFqpHrh4C3xGrKFfUFBQk+7mC6EJ+f4m2n3b+w9YUCaC4QmS3xqYl1puQaNoKcq
         w4cKzAL3RYFXXvLGiSAj+kBhOcoHCoUykxfL6VC30/9OhuUX6Ko2GjlICuJiypraM+zg
         TgGw==
X-Forwarded-Encrypted: i=1; AJvYcCXYHvY4VHva5xzekpGUPHrXGxpike2e2mPwhg9+fMCTiKApz1DLoI9KqS7oXpgv+/ypTZ4RV7IhsdQRPnl3Ew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+5kvOZHkXoyv4U9KqpgHdYLQCV51j4ECHeX2hrTDCMNf11xCe
	fqt4+ecUpg7CIhC5xXO1iJYbGCmFI6536n0WKMnyfhSr5T6KMj1CQySWn+qg1P6NdyvZ6lL3pYE
	3s9xjS9GOLL2HZMASElinr28RolEGOrayHbZ9J5nf09VSs3nxb/0U9MH2F+xdOh7yh2tBBpET5y
	PF9DfDn8hkFdQHQMlWFCaksCJsvZl/x0mAFwDeszQ=
X-Gm-Gg: ASbGncsD6zoBLKN0O3xIuOScC+AZiELSI09jQN6iBrWy3MYZy3ROrQ99KrycHvO7u//
	Z524zuCnAqIrBfiRG2roV/8gjqMb3CcAhGiwidv8=
X-Received: by 2002:a05:6402:3888:b0:5d1:2377:5ae2 with SMTP id 4fb4d7f45d1cf-5d972dfb857mr8721761a12.7.1736489914359;
        Thu, 09 Jan 2025 22:18:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiAdihQyFMz0O5tj3Ue3EozuwVp0j8wLiDgLZq4DzNClh5miAT01uxp0Lj3n+X60xlkcwlDVJx2hp/x1jcaIw=
X-Received: by 2002:a05:6402:3888:b0:5d1:2377:5ae2 with SMTP id
 4fb4d7f45d1cf-5d972dfb857mr8721718a12.7.1736489914008; Thu, 09 Jan 2025
 22:18:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241227191211.12485-1-chia-yu.chang@nokia-bell-labs.com>
 <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
 <CACGkMEu990O+2Sedj+ASv0P5TnZR9THiOdHmx=L0hOxQRXPcsg@mail.gmail.com>
 <PAXPR07MB79849952690901A50688EFEDA3092@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20250108072548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108072548-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 10 Jan 2025 14:17:57 +0800
X-Gm-Features: AbW1kvb8ubWeXgB-U6M0XsqnjiyDPikXOh18Gs0pZOWli8Sl1qeTWevc3-CPVnA
Message-ID: <CAPpAL=xcWrbDMnqd5X6QfSMi1Mz-VOm0k-07kR5wsB8d0LU_pA@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in virtio_net_hdr
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Jason Wang <jasowang@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dsahern@gmail.com" <dsahern@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "joel.granados@kernel.org" <joel.granados@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"horms@kernel.org" <horms@kernel.org>, "pablo@netfilter.org" <pablo@netfilter.org>, 
	"kadlec@netfilter.org" <kadlec@netfilter.org>, 
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"coreteam@netfilter.org" <coreteam@netfilter.org>, "shenjian15@huawei.com" <shenjian15@huawei.com>, 
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>, "shaojijie@huawei.com" <shaojijie@huawei.com>, 
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oRXQHIXeIrwWysicXWGMuramgBJvXKK4hJ3C9gk__6s_1736489914
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches v6 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jan 8, 2025 at 8:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Dec 30, 2024 at 09:50:59AM +0000, Chia-Yu Chang (Nokia) wrote:
> > >From: Jason Wang <jasowang@redhat.com>
> > >Sent: Monday, December 30, 2024 8:52 AM
> > >To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > >Cc: netdev@vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; ed=
umazet@google.com; dsahern@kernel.org; pabeni@redhat.com; joel.granados@ker=
nel.org; kuba@kernel.org; andrew+netdev@lunn.ch; horms@kernel.org; pablo@ne=
tfilter.org; kadlec@netfilter.org; netfilter-devel@vger.kernel.org; coretea=
m@netfilter.org; shenjian15@huawei.com; salil.mehta@huawei.com; shaojijie@h=
uawei.com; saeedm@nvidia.com; tariqt@nvidia.com; mst@redhat.com; xuanzhuo@l=
inux.alibaba.com; eperezma@redhat.com; virtualization@lists.linux.dev; ij@k=
ernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper=
@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.=
com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jas=
on_Livingood@comcast.com; vidhi_goel@apple.com
> > >Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag i=
n virtio_net_hdr
> > >
> > >[You don't often get email from jasowang@redhat.com. Learn why this is=
 important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > >CAUTION: This is an external email. Please be very careful when clicki=
ng links or opening attachments. See the URL nok.it/ext for additional info=
rmation.
> > >
> > >
> > >
> > >On Sat, Dec 28, 2024 at 3:13=E2=80=AFAM <chia-yu.chang@nokia-bell-labs=
.com> wrote:
> > >>
> > >> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >>
> > >> Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the A=
CE
> > >> field to count new packets with CE mark; however, it will be corrupt=
ed
> > >> by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied =
by
> > >> seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be
> > >> changed within a super-skb.
> > >>
> > >> To apply the aforementieond new AccECN GSO for virtio, new featue bi=
ts
> > >> for host and guest are added for feature negotiation between driver
> > >> and device. And the translation of Accurate ECN GSO flag between
> > >> virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added t=
o
> > >> avoid CWR flag corruption due to RFC3168 ECN TSO.
> > >>
> > >> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >> ---
> > >>  drivers/net/virtio_net.c        | 14 +++++++++++---
> > >>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
> > >>  include/linux/virtio_net.h      | 16 ++++++++++------
> > >>  include/uapi/linux/virtio_net.h |  5 +++++
> > >>  4 files changed, 32 insertions(+), 9 deletions(-)
> > >
> > >Is there a link to the spec patch? It needs to be accepted first.
> > >
> > >Thanks
> >
> > Hi Jason,
> >
> > Thanks for the feedback, I found the virtio-spec in github: https://git=
hub.com/oasis-tcs/virtio-spec but not able to find the procedure to propose=
.
> > Could you help to share the procedure to propose spec patch? Thanks.
>
>
> You post it on virtio-comment for discussion. Github issues are then used
> for voting and to track acceptance.
> https://github.com/oasis-tcs/virtio-spec/blob/master/README.md#use-of-git=
hub-issues
>
>
> > --
> > Chia-Yu
>
>

