Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1477C8C7
	for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006303; cv=none; b=QZPQyiZaliCPbC49RbhpbFO6j8Iet7nsdJyF0SqRV/qz7ffwbc6frE9NbiMrt/1bNft/Hc+P29isz4SaV982kjZkDWHZg2jWzlyd9BFnVLC8UF8PcM/VVtaFWlTzewc2f1SzXK76oR2EHlgVSBMwrFvsALOiTEaT5Zaxd4ApOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006303; c=relaxed/simple;
	bh=jYA3ZdaSchCq0wZNMqgMfovOur83ZIG1iWn9IxkKTOc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAVbs6gQG4fGDbnJCqKat5ENdGJ66WRas073nrgKaQzEf1IWpBWQaVd/Ra8lCmoeE4DOYZFJpOJ18btMjip7Us1JxOpCEPpev/oFC/mYq5YLeih6cm0JrTnBipvveH402hnl0QoRWgslGIKFqQO+Gwa9VThbZY6UBGiCVJduPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gFux8NXI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gFux8NXI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e8814842so553501385a.0
        for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738006300; x=1738611100; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=crvuR4C0Wzq37Ox68vnGQkd0pKwwE3VZakrVpqMGG3w=;
        b=gFux8NXI336h/yNE3mr90gWOR+lci1eSSzE5BpkCm4o8y1jA70ENoYLqHBjU3I768e
         CJq2pR/dD0MJMSUP3XYTwABgJugRDyq9TG07R6NUpvc8OKnjckhz7j+A9elfbDnQHK3+
         WPVrh+iSLLnyIITGqImCM3MbPd5oDnWaU5Cjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006300; x=1738611100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crvuR4C0Wzq37Ox68vnGQkd0pKwwE3VZakrVpqMGG3w=;
        b=Yojpr0mf2QOLVcOVF4WKYMTask6qoid69ln4XN2PXO+YY0MLbWWhy9gqX1fRkJB/7T
         cZJo4+U7DmSfOotq436OSMb9XF9NFo5zx8m+oQiw1Gj/01UbL69iTQLEw34wlwdVTz2H
         R3sqKpysmjVNFkwmkDIBAeSNHO3qtHaRlNcA5pwTWTG6iyj2Q9FqorNlnNLnDaigc697
         xgffq6b1lsEEP0vxg/4htQTUJabejaDi3wjswkIaUC/6ZoirCLRwN5c1h9jjbbUvIEMX
         /7QOpaGQAb50OtP03KyjcF4Yp5xbqAcp3h1PkuDfzfabvBn2T2f6odQTtAS74rcoa8+n
         7Iig==
X-Forwarded-Encrypted: i=1; AJvYcCVHomPmp0hHwcaLsKeaBU26aAw0788VcTfH0170X0BPj1fUGZ8JLLYjGG7+tuVuSHb2A/v3EHfa6FP0dyvd8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS+PjdLvW+PmywKQEclzgDMLpthtNRK6OIpGQ5e6505WwM7eAt
	bp1/N+eZJOEyNYBWStE9i2QqUaLptjw9xT5KIkGSrRF/9niS5JJGx8pZPcuJbGg=
X-Gm-Gg: ASbGncuV5q+9HPEtFbr2TgfA3O529cDDD4d4WouRpSVWs8tIbz4s8g0o5oWMCW9wzAn
	XvPJ+Dq4+sX3u2yrTW27mkZYIwZaO0CxH9btSxZAfaYmw0rjfL06Rx0ySX3ouFSGNw/Pv/Y7Hho
	AXC9D5POhXPlFtE5OrWTGFBYiV7Ijsrz2eEPusaDIXrobT3pqKo4sBBB+U2P7j11wGJVUfdOQDj
	eN5HOI3GRk+N9DEgWb2VPSRArka0VlrUzuWKLZdy/mdEkv2+n9VOxa/EYPaCjMpK+QYEoW+/aq5
	2k2Fbs5qHoO+7CfSxRd6gfGtOJtiS7bGl3sUEmI+Jb/rzZ0/
X-Google-Smtp-Source: AGHT+IG1bN6WB8IKEPv4zC6FkCqrLYzIsDLpTGLJUuCnvXH9OMZ5TtZHoR7LW+wzA1TfDouWHICqTw==
X-Received: by 2002:a05:620a:2687:b0:7b7:106a:19b0 with SMTP id af79cd13be357-7be6320be8dmr6444146185a.12.1738006300651;
        Mon, 27 Jan 2025 11:31:40 -0800 (PST)
Received: from LQ3V64L9R2 (ip-185-104-139-70.ptr.icomera.net. [185.104.139.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8aaa9sm419402985a.34.2025.01.27.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:31:40 -0800 (PST)
Date: Mon, 27 Jan 2025 14:31:21 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5ffCVsbasJKnW6Q@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
 <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
 <Z5P10c-gbVmXZne2@LQ3V64L9R2>
 <CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
 <Z5fHxutzfsNMoLxS@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5fHxutzfsNMoLxS@LQ3V64L9R2>

On Mon, Jan 27, 2025 at 12:52:06PM -0500, Joe Damato wrote:
> On Sun, Jan 26, 2025 at 04:04:02PM +0800, Jason Wang wrote:
> > On Sat, Jan 25, 2025 at 4:19 AM Joe Damato <jdamato@fastly.com> wrote:
> > >
> > > On Fri, Jan 24, 2025 at 09:14:54AM +0800, Jason Wang wrote:
> > > > On Thu, Jan 23, 2025 at 10:47 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > >
> > > > > On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> > > > > > On Thu, Jan 23, 2025 at 1:41 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > > > > > > On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:
> 
> [...]
> 
> > > > > > > > >
> > > > > > > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > > > > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > > > > > > +                                  struct napi_struct *napi)
> > > > > > > > >  {
> > > > > > > > >         napi_enable(napi);
> > > > > > > >
> > > > > > > > Nit: it might be better to not have this helper to avoid a misuse of
> > > > > > > > this function directly.
> > > > > > >
> > > > > > > Sorry, I'm probably missing something here.
> > > > > > >
> > > > > > > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > > > > > > in virtnet_napi_do_enable.
> > > > > > >
> > > > > > > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > > > > > > the block of code in there twice (in virtnet_napi_enable and
> > > > > > > virtnet_napi_tx_enable)?
> > > > > >
> > > > > > I think I miss something here, it looks like virtnet_napi_tx_enable()
> > > > > > calls virtnet_napi_do_enable() directly.
> > > > > >
> > > > > > I would like to know why we don't call netif_queue_set_napi() for TX NAPI here?
> > > > >
> > > > > Please see both the cover letter and the commit message of the next
> > > > > commit which addresses this question.
> > > > >
> > > > > TX-only NAPIs do not have NAPI IDs so there is nothing to map.
> > > >
> > > > Interesting, but I have more questions
> > > >
> > > > 1) why need a driver to know the NAPI implementation like this?
> > >
> > > I'm not sure I understand the question, but I'll try to give an
> > > answer and please let me know if you have another question.
> > >
> > > Mapping the NAPI IDs to queue IDs is useful for applications that
> > > use epoll based busy polling (which relies on the NAPI ID, see also
> > > SO_INCOMING_NAPI_ID and [1]), IRQ suspension [2], and generally
> > > per-NAPI configuration [3].
> > >
> > > Without this code added to the driver, the user application can get
> > > the NAPI ID of an incoming connection, but has no way to know which
> > > queue (or NIC) that NAPI ID is associated with or to set per-NAPI
> > > configuration settings.
> > >
> > > [1]: https://lore.kernel.org/all/20240213061652.6342-1-jdamato@fastly.com/
> > > [2]: https://lore.kernel.org/netdev/20241109050245.191288-5-jdamato@fastly.com/T/
> > > [3]: https://lore.kernel.org/lkml/20241011184527.16393-1-jdamato@fastly.com/
> > 
> > Yes, exactly. Sorry for being unclear, what I want to ask is actually:
> > 
> > 1) TX NAPI doesn't have a NAPI ID, this seems more like a NAPI
> > implementation details which should be hidden from the driver.
> > 2) If 1 is true, in the netif_queue_set_napi(), should it be better to
> > add and check for whether or not NAPI has an ID and return early if it
> > doesn't have one
> > 3) Then driver doesn't need to know NAPI implementation details like
> > NAPI stuffs?
> 
> Sorry it just feels like this conversation is getting off track.
> 
> This change is about mapping virtio_net RX queues to NAPI IDs to
> allow for RX busy polling, per-NAPI config settings, etc.
> 
> If you try to use netif_queue_set_napi with a TX-only NAPI, it will
> set the NAPI ID to 0.
> 
> I already addressed this in the cover letter, would you mind
> carefully re-reading my cover letter and commit messages?
> 
> If your main concern is that you want me to call
> netif_queue_set_napi for TX-only NAPIs in addition to the RX NAPIs
> in virtio_net, I can do that and resend an RFC.
> 
> In that case, the output will show "0" for NAPI ID for the TX-only
> NAPIs. See the commit message of patch 3 and imagine that the output
> shows this instead:
> 
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 0, 'type': 'tx'}]
> 
> If in the future the TX-only NAPIs get NAPI IDs, then nothing would
> need to be updated in the driver and the NAPI IDs would "just work"
> and appear.

Actually, I missed a patch Jakub submit to net [1], which prevents
dumping TX-only NAPIs.

So, I think this RFC as-is (only calling netif_queue_set_napi
for RX NAPIs) should be fine without changes.

Please let me know.

[1]: https://lore.kernel.org/netdev/20250103183207.1216004-1-kuba@kernel.org/
