Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3131F941E
	for <virtualization@lists.linux.dev>; Wed,  8 Jan 2025 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339281; cv=none; b=HEgqF5s3OG6Ce56/noOn/zI7pSUI3gshLbUlWpX8i9TYVUqb9VXtILcS6zSE0FHA5Adndj+A8q2iJu7b4p84rKUnGw8RHgchuWnc4eIuqHrCff3StRppXkPGsFmA52nWVndjuYnmHuO8akgr4qOx8PXqSzRfRP0kPi75cjF5VZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339281; c=relaxed/simple;
	bh=XnLemeL4IHrhEImF6ctGxz/BFHYds4mn0cQmO+AnjTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KyFYY8uNh62I96vCSF8qQEdHNWFxdB4j11rvN6nqp38sizSHGO0w98SkDiqfnNryCgjKM5knXWg54JzqB2DMXNK5jhlG2AxHS25pygsxruhB7gQLJv/o4p78g0beVu5+pah3JVAe4zGirwqOaX+y31zH1+4l8uP2Q9/ZUGZXfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce9IVfKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce9IVfKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736339278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CE+ieq2Nnj1SjMfQGTDo5V1UJ6zv6x6ViYgzrgENqg0=;
	b=ce9IVfKVd5H1Kwg8tAcHw32LGV9+iuiuuSLRw4o+5dvmwSyNOVAh4/crD41iV9bHLR2Asy
	b/KQ2p1CgJ7c73aj6HOK04GiYabnGfRyg8uWK0COj7QSS/VF4LTWh2mc55mMcL54ApCnMR
	qHZo3AwGCRG4Dbipfv6nnfvo5P1insA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JnRq3yS1MUSW35VLBeSeZA-1; Wed, 08 Jan 2025 07:27:55 -0500
X-MC-Unique: JnRq3yS1MUSW35VLBeSeZA-1
X-Mimecast-MFC-AGG-ID: JnRq3yS1MUSW35VLBeSeZA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436723db6c4so96393475e9.3
        for <virtualization@lists.linux.dev>; Wed, 08 Jan 2025 04:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339274; x=1736944074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE+ieq2Nnj1SjMfQGTDo5V1UJ6zv6x6ViYgzrgENqg0=;
        b=Crd6MJgOfJRBwLckRkGrw1tv7/m1sqPLD4PoUcBF0s8g0qK5hyaD2Hv/IJI2ID/cwQ
         uZYcrYWqhh3fELIM9BAdXH7CCVehvkORZJEbfixLlJ4D6Q9j+jKVcWdbpTsbS2xTYMXC
         AcU0ELTcwCOxkE6Uh5v2geYhPeePfIA2Y7NF7l6/vd68vDYRFSskns5uGvOJA724d7gM
         8WAm14XdtBki6n7rMKXvkCq1XSr1771kMFMnwjUE49CbDPuz/1cpq+hkFi3E1eckG6gR
         WwMzK3woCp8Jpig6sdAa5Uuqi5l07CqGc/5FULa4SqR6RCBnYQ8/0nnsNcfh4Cty751N
         HGCA==
X-Forwarded-Encrypted: i=1; AJvYcCW5s1Fag39AAONwSHxP/DNCAIlTVZBLz8Lq5kORjzEHHgGNQTYExBfTiVtTnKA0+OBKzOj91q5GX9B4odi8Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4B2LHwZ2bJhE2Hk2mWNvni/zazY3Nu+PJTF9m/lXQ3H1q736n
	GN5tp5wCcmbKxyRPGZGWQhnv+77ncuMoaeMlJ13kYV47M37+wZ5omukendxHoxBs3cbRI+48/Wm
	RgYxVArHIR7fA9l6MBEMlghLshtVpPSQqHyG+IBbttg5cvkVgDKO6ZknRPD3M7Bjw
X-Gm-Gg: ASbGncuXoJujOdJPXnbrludYL05E6VEYoF8u0x7VGqjfM5KZ1zN9BVe54aYU1z0K08V
	QQV7nl6zbfiGl5d4pfY7eopfJyHHV8vmgUhhYDKbawt68uGx41o8goS7g+XJorvSO2lXOgYkkOU
	sze14cNV1010R7ugzTSNBCCciCN+yfGsB89cScn/3LVTOKsadKnIo+OOYSGmwZH2SkYNO1GcFJf
	vyF/o9vJ5v2g/rwsM1tDOUZruVRqfzBySxvhUVFayeCSfH5yqQ=
X-Received: by 2002:a05:600c:511f:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-436e26867f6mr21830975e9.5.1736339274322;
        Wed, 08 Jan 2025 04:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENxKhGDHesgYkFwNwBJXCiFFCpFk4h9OPIuCpP1RPQAdqKF9uWZeo5HUnJYIpAberSrBMGeQ==
X-Received: by 2002:a05:600c:511f:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-436e26867f6mr21830685e9.5.1736339273849;
        Wed, 08 Jan 2025 04:27:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89dfesm19211805e9.32.2025.01.08.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:27:53 -0800 (PST)
Date: Wed, 8 Jan 2025 07:27:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dsahern@gmail.com" <dsahern@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"horms@kernel.org" <horms@kernel.org>,
	"pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"shaojijie@huawei.com" <shaojijie@huawei.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Message-ID: <20250108072548-mutt-send-email-mst@kernel.org>
References: <20241227191211.12485-1-chia-yu.chang@nokia-bell-labs.com>
 <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
 <CACGkMEu990O+2Sedj+ASv0P5TnZR9THiOdHmx=L0hOxQRXPcsg@mail.gmail.com>
 <PAXPR07MB79849952690901A50688EFEDA3092@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <PAXPR07MB79849952690901A50688EFEDA3092@PAXPR07MB7984.eurprd07.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BHLzSt8UvtMabp6QdeajxJSsC7sezUz9ZH1R4gM2JO0_1736339274
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 30, 2024 at 09:50:59AM +0000, Chia-Yu Chang (Nokia) wrote:
> >From: Jason Wang <jasowang@redhat.com> 
> >Sent: Monday, December 30, 2024 8:52 AM
> >To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> >Cc: netdev@vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; edumazet@google.com; dsahern@kernel.org; pabeni@redhat.com; joel.granados@kernel.org; kuba@kernel.org; andrew+netdev@lunn.ch; horms@kernel.org; pablo@netfilter.org; kadlec@netfilter.org; netfilter-devel@vger.kernel.org; coreteam@netfilter.org; shenjian15@huawei.com; salil.mehta@huawei.com; shaojijie@huawei.com; saeedm@nvidia.com; tariqt@nvidia.com; mst@redhat.com; xuanzhuo@linux.alibaba.com; eperezma@redhat.com; virtualization@lists.linux.dev; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> >Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in virtio_net_hdr
> >
> >[You don't often get email from jasowang@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> >CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
> >
> >
> >
> >On Sat, Dec 28, 2024 at 3:13 AM <chia-yu.chang@nokia-bell-labs.com> wrote:
> >>
> >> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >>
> >> Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE 
> >> field to count new packets with CE mark; however, it will be corrupted 
> >> by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by 
> >> seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be 
> >> changed within a super-skb.
> >>
> >> To apply the aforementieond new AccECN GSO for virtio, new featue bits 
> >> for host and guest are added for feature negotiation between driver 
> >> and device. And the translation of Accurate ECN GSO flag between 
> >> virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to 
> >> avoid CWR flag corruption due to RFC3168 ECN TSO.
> >>
> >> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >> ---
> >>  drivers/net/virtio_net.c        | 14 +++++++++++---
> >>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
> >>  include/linux/virtio_net.h      | 16 ++++++++++------
> >>  include/uapi/linux/virtio_net.h |  5 +++++
> >>  4 files changed, 32 insertions(+), 9 deletions(-)
> >
> >Is there a link to the spec patch? It needs to be accepted first.
> >
> >Thanks
> 
> Hi Jason,
> 
> Thanks for the feedback, I found the virtio-spec in github: https://github.com/oasis-tcs/virtio-spec but not able to find the procedure to propose.
> Could you help to share the procedure to propose spec patch? Thanks.


You post it on virtio-comment for discussion. Github issues are then used
for voting and to track acceptance.
https://github.com/oasis-tcs/virtio-spec/blob/master/README.md#use-of-github-issues


> --
> Chia-Yu

