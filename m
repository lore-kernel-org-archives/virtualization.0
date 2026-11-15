Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794781894;
	b=r6AzMwacSmsbNZXFh37mvOK+vIqhWN86h/GVr05ZIRkBJK45/7V7AKjQS0l7hBhkULzt
	 1B+YQ0NJ6TCARKZv6hIxdsVah7vkf0q38195g16DYOlTJkKMv7Pe4MMc9x2kVMEJD0F3I
	 15xTMBBIhXCM+UrQDypJOauil/D3ZBcGUVgWtWk8F2/KUykg7u5iAJkyWIiH5G8NT3UCV
	 XoVYW/aUx9up2eK0sMnlkieQULfgnbmLmBH9U7o4GjdtLU7V1ENGF06hKituKWK/UuWAu
	 Hxy4pMQg1mu3dnU2BDeRPxsua+7eeXLQrl+CZ9gGfaRXRnodBXkYItOGV1pfU+5J5kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794781894;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=ykt8FTUNX1/fdxCk4A4DHYN7Y2tblUILl4FGUFZzAXY=;
	b=jH7DV48RgR7kKh0KkOh3OTsQaq2GCjeWwGUwCu11WSLMMap7OzczTIrm/VbgTN/OMALA
	 WWtq64JBSDN5ZUQjjXy7bQuZeFfqJlLp25RaSi+wz4I+B7cWISWlqo4teQE+G39MqHbkI
	 XbwbR1sQTwZB3XaaWoNsFgbOd98dwLR3dzoJFixRj73rrPADDLC/83neOaAh+S07fwUNx
	 PgKaDs6VrDLC5Eb8xxPXjZn95S46bt8092mJCrLoUcbIogVFMn5GMrlw7vtiQtUUNyaZh
	 TkSJerog6y2nrD+5aq23IHvJosTrwgzykemjVvKRHHPG/iXKzxrcHNax6eZ0ingjTaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SJ1mxSb+;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480B606A31F
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 22:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8480B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SJ1mxSb+
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFLmgRp538015;
	Sun, 15 Nov 2026 14:31:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=ykt8FTUNX1/fdxCk4A4DHYN7Y2tblUILl4FGU
	FZzAXY=; b=SJ1mxSb+jBspwpZ+RoOy/Lr5CS/7QRNeo6OhUzjml3l34B3DOQryV
	YTrD7iaqc9bgjeOvKGchb/xXrv6VyJK/Gnz553rSSAdGLesUpyD5Iz2tjzkhAy3E
	AiQphbyhg194wLcmkgxeLVgI8XyXEp9YyBcP0aAXzVQgJQUXnKZErZIoGmaclPQE
	xGshwi14J+WZvgkcMRCwpNXSsDFUyFSi8i6x4g5eKeCkVNk/jhnHQntZSJqtPYaC
	tvixv1d5+1mVFqDxanbVp8+94a3/32sOffAJJp0HYLsn4xOrSypZSbsV/oTIJabd
	VFAOlvk4X4FxeeglzrPDyjhY9FIx+7AUA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxmj45x9v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 15 Nov 2026 14:31:15 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sun, 15 Nov
 2026 22:31:14 +0000
Date: Sun, 15 Nov 2026 14:31:13 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <sgarzare@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <stefanha@redhat.com>, <mst@redhat.com>,
        <jasowangio@gmail.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <shuah@kernel.org>, <rdunlap@infradead.org>,
        <donald.hunter@gmail.com>, <edumazet@kernel.org>,
        <georgezhang@vmware.com>, <acking@vmware.com>, <dtor@vmware.com>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>
Subject: Re: [PATCH net-next v6 5/8] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <avoysWTR++rTKfKL@devvm29614.prn0.facebook.com>
References: <20261113-vsock-guest-ns-v6-5-3737ce4673c0@meta.com>
 <179471528940.2199510.18137700517588437955@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179471528940.2199510.18137700517588437955@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA4OSBTYWx0ZWRfX+ZQB0ppP8ScL
 5zEoQ8ohV0T1CuBY5u/tqmj8DzX5Ljagf1soUB7AVYidkRKRsqhQDkRRZp+pVhEMtjBS5jfK7P+
 ZeO7st34x107s/XRqb/3LcQol9zeezk=
X-Proofpoint-ORIG-GUID: DnfmZE2Va31yL9pMIgnnC5detjkL3Jk6
X-Proofpoint-GUID: DnfmZE2Va31yL9pMIgnnC5detjkL3Jk6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA4OSBTYWx0ZWRfX0OsD6yWxMwIx
 0eZPLstlNAs7lKlPNceGqzSKTDjDVlTQ8eyUjLvERfU+AVrymQITadzDMNe6//+ObxP4VVoDsDi
 PtfEjV5VvmmKEO4UOE1nDpJKK7pde2D2jZcbeeQKi7FhIJbhCt1Zn96tR09NcwGm0DrG79aUI2w
 7waXvI2nBWmzsmdvP5m6fUzi7e3AEmTbPRlkkM71iU3BQgwiFM7HvNnj/FbQxMrsWfSzRWxnyYl
 RmIoL8BgU+5gLMYoTLNjeqpjs4r9t4zqlQEtiuRu48++m8CutKsrxmTLLDA412TrOZTRGeO/9qu
 tWqdZPESNn+B8cvuFQMHhjqGoRus/Z9jPR7eMtzSatOkjYmg/TBUTQ1pwPhlVuVRqoVWo1a5Ykt
 ZpDhImJHp4PlMvxMImAYZlfqBSypP+uKOi3oo55f5oAk3IstOyhBmlaRPMHE8us4htBgO9vLvxr
 DalggzfOW7SMsENxYvA==
X-Authority-Analysis: v=2.4 cv=Vp+2kO2n c=1 sm=1 tr=0 ts=6afa32b3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8
 a=9R54UkLUAAAA:8 a=VabnemYjAAAA:8 a=RAyg9Hr4hlSmefgnMj4A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_07,2026-11-11_03,2025-10-01_01

On Sun, Nov 15, 2026 at 04:01:29AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The new `vsock` generic netlink family defines `dev-netns-set`
>   (VSOCK_CMD_DEV_NETNS_SET) as a do-request with no reply.
> 
> --
> 
> vsock: add a netlink command to assign the g2h device to a netns
> 
> This patch adds a vsock generic netlink family. VSOCK_CMD_DEV_NETNS_SET
> moves the guest's G2H vsock device into a given network namespace, and
> VSOCK_CMD_DEV_NETNS_GET reports the assignment as an nsid relative to
> the caller. Connected sockets that can no longer reach the device are
> closed with ECONNRESET, and an assignment that would cause a CID
> collision is refused.
> 
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> 
> > diff --git a/Documentation/netlink/specs/vsock.yaml b/Documentation/netlink/specs/vsock.yaml
> > new file mode 100644
> > index 0000000000000..f260ee88b1402
> > --- /dev/null
> > +++ b/Documentation/netlink/specs/vsock.yaml
> 
> [ ... ]
> 
> > +operations:
> > +  list:
> > +    -
> > +      name: dev-netns-set
> > +      doc: |
> > +        Set the network namespace of the guest's vsock device.
> 
> [ ... ]
> 
> > +        The assignment holds a reference on the namespace.
> > +      attribute-set: vsock
> > +      flags: [admin-perm]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - netns-fd
> > +            - netns-pid
> 
> [Severity: Low]
> This isn't a bug, but should dev-netns-set have a reply block here?
> 
> The spec gives dev-netns-set a request and no reply. As a result,
> vsock_nl_dev_netns_set_doit() only returns an errno and the caller gets a
> bare ACK.
> 
> The netlink guidance for new families says every operation should reply
> with a full message that identifies the resulting object. It also says
> that once a command only ACKs, the ACK-only behaviour becomes uAPI and
> cannot be changed later.
> 
> The v3 revision replied with netns-id. The v5 changelog says the reply
> was dropped at Stefano's request, so this looks deliberate. Since this
> family has not been released yet, could that decision be checked once
> more?
> 
> A netns-id reply would tell the caller where the device ended up,
> relative to its own namespace, without a second dev-netns-get request.

Actually, now that we're taking a netns-fd/netns-pid, the reply makes
sense because it can be something besides the current netns.

pw-bot: cr

-Bobby

> 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 37abde1ca26cd..d4d88c8cf142f 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> 
> [ ... ]
> 
> > +int vsock_nl_dev_netns_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> 
> [ ... ]
> 
> > +	err = vsock_g2h_net_assign(net, info->extack);
> > +	put_net(net);
> > +
> > +	return err;
> > +}
> 
> This is where a reply would be built, for example by reusing
> vsock_nl_dev_netns_fill() as vsock_nl_dev_netns_get_doit() does.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-vsock-guest-ns-v6-0-3737ce4673c0%40meta.com
