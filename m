Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637227;
	b=o9PWEqJwlM0qhTrPDW2/jqd4Zz7K3ZeOVK55MevinHOZdV2WJtNiTKHNf/JSAktMo9TL
	 dBTvC/srXJj3Smw3DAlKv3sJTwcYKQA8vonpMgGfYc/en47O3D4woy47h2NST1567nXWV
	 Yj4wj3luT857UjaDyYXFgXUX3+/w0DrAW+hGjgxLHtRZZYzV1XUK9NbdIJjwDTMbzDqTd
	 b6mVI7RJw8xfocacUu2ce4GfIMPQ37RCAK36YtVGY6deGT9bjCwBWBNuWr9EO+hkadhqr
	 3n6K6+xofx4pfn+6IXNCp83TS+0qrjue68i0BD8suRzH4SgbQ6ziuT14X82B7g5nm8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637227;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=bZDM7pjFprraJZ4e9RLnqLxhxQi43j49i/Xcsi5OwC4=;
	b=FH2ZcUTKzHb3ydOvL6w65lFHftOjyu23PDWbUQ11F/XpDPzhckhUp3Alpyllq68oUoue
	 aMQ7CktdoXroUAtdJlo2GBW7ejnOKLMRPdSuxu60zT5Rlr1mzfimjV6qu2y6jEOg1xsua
	 zJRwgJ3ahaVlbJfhp1fKA1RQUaIN4JCL/vxsfb/GBZV9G4lA3DEBNZoQrcbhow+gq64Rt
	 jKtEZ2UjGFXns4PeNNtA6BHXsvCPlA77MgbnFFftBpPVT5DvpIdTZgIxcl97e0acx8Svr
	 CyJh7J51/OkXOm42pTklhUpaFdv2g5cBl2ewr7Gv14peVnEWDsLiWVoQqPW2XX27uag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="HaDx6F3/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3D608B04C
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 16:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A3D608B04C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HaDx6F3/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793637226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZDM7pjFprraJZ4e9RLnqLxhxQi43j49i/Xcsi5OwC4=;
	b=HaDx6F3/qhQuQkJOCALLDZyLuq9ed+PDnqpfr2itZaMYZUvwha13ybskQuyCYDj44Qx3+F
	XqlnvDmQU6S1UdO2xaaQBZrbw5LPV1CyvuYGuwXsUFFA4HpvUsP2B9e64IRp8y3asRzUhJ
	jaf5HOjhaQgZkHb7NNgFZEhktZql+Qo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-HdBsNhl0P4u8dm24u1XdNw-1; Mon, 02 Nov 2026 11:33:43 -0500
X-MC-Unique: HdBsNhl0P4u8dm24u1XdNw-1
X-Mimecast-MFC-AGG-ID: HdBsNhl0P4u8dm24u1XdNw_1793637221
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e6d6e780fso1499483f8f.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 08:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637221; x=1794242021;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZDM7pjFprraJZ4e9RLnqLxhxQi43j49i/Xcsi5OwC4=;
        b=rMWt7kXo8ubeyfvL10dsdNuXHsS5fPi9cPTJfVJ/P7FQsh9K0+DW62P57/hfzNgzWL
         RL3CYRBiCW2L6vh10Ht4oOjSY0g95l/pOgIvGRH0p6VvVxbiTiqCiXtPR9I2sEL2SGcs
         6A1855lpB8v2rVg0eWkW3OGvxMVxjrnVZKtFy/auO1PffoyodA8R7YwG0JEG3sDd0SnE
         GuKv2lDHDRJbNXoiEyFejuZcA2PVtWCmWCF0dGw7CDQkNHsfAFhErgKZw8PbH2wRduSL
         nIDXIp8xReArG5FUET64hfCAtx7kos9QmxyMm1KISnG6ML/iCFuys7CDjkojYjbieH2+
         dCyw==
X-Forwarded-Encrypted: i=1; AKwUvByHYkRoxAGb2imS14mgrqHO1omI/NOrJAPVVEmkhmCNlopZRn+H0eELBU0M/ZAAf1RZIlHqzdAYXS821E6I2w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+noFsNehEx+axSV5JBrAxrx1qyDlJOz/E5hfMq94CgVWMO1JVW
	+wq69KlU6llwaZ0WeUgdUQ1gR+Ntp+QK1wtdZYLHDkAeQoPVlIsdA9S+B1UN5WHQgvCIciFwVPY
	2tvZjfHs2ERTiK0zOrE5erm2ReMVtjWJXp3E7Ja0raVkctMMvl3nbp6GddbiSXnj9xLi9
X-Gm-Gg: AYBFou2xFM45fA97k4XXYvqzx22cL4EpzLVHtD9HA2JmurJyTg8Cau4eP45C7X6JYTq
	RWRBXCozfKaQswMmt6PkLysZUMuxWldEJYaTFw2sCbReytC1SP1Q/ptpUpH4xcGLKRBFmhG4L4K
	yhl1Qgd/W5uPIZGa6xRSBWTPA3IkqL4vYUlaQk6MOL4kU2XB35EbngWlI1YjFORV9q83GzmgVNK
	Hb0bE0FIHiGCvMeS3D9KX2wRf9WafX+QUuluHijV49tI5EtSgJhFDOPav4dxzkgU/SmDMt6wp7k
	vv/hIxQPJ0j7955yjc+AQ01ZhfrxyHNV3DgiHnXHxBHx72b0St7RzFrRrZD8CG03EGQMDUwFtCO
	uLduej5DdqbzU/H9uP6QJH4HfAyhEBWoRn3QMlqSD5Q==
X-Received: by 2002:a05:6000:4311:b0:48e:75a1:1e38 with SMTP id ffacd0b85a97d-48e75a11e48mr17141434f8f.56.1793637220640;
        Mon, 02 Nov 2026 08:33:40 -0800 (PST)
X-Received: by 2002:a05:6000:4311:b0:48e:75a1:1e38 with SMTP id ffacd0b85a97d-48e75a11e48mr17141372f8f.56.1793637220112;
        Mon, 02 Nov 2026 08:33:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20861861f8f.38.2026.11.02.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:39 -0800 (PST)
Date: Mon, 2 Nov 2026 11:33:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] virtio-mem: only mark the device ready in kdump mode
 with vmcore support
Message-ID: <20261102113328-mutt-send-email-mst@kernel.org>
References: <20261016023521.747447-1-oss.patchbox@gmail.com>
 <25a35fa8-9540-4892-8375-1788e6795dfb@kernel.org>
 <CAGG=RgDUFpDqtbws4YO4T8A3pS4Dr9twVqP9hSD3J_zP5Dc_mQ@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAGG=RgDUFpDqtbws4YO4T8A3pS4Dr9twVqP9hSD3J_zP5Dc_mQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _czrPx2r3_y_hpRDOj0DZOY5tKmueon3e9lRIztehXw_1793637221
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2026 at 07:46:50PM -0400, Yuho Choi wrote:
> On Mon, 19 Oct 2026 at 09:05, David Hildenbrand (Arm) <david@kernel.org> wrote:
> >
> > Which kdump kernel exists that does not enable CONFIG_PROC_VMCORE?
> >
> > IOW, why should this be stable material?
> 
> I tagged it because a9403425b3cf has been in releases since v6.14 and
> PROC_VMCORE can still be turned off with CRASH_DUMP enabled, so the
> -EBUSY path is reachable in a valid configuration. But as no practical
> kdump kernel disables it, I'll drop the Cc: stable in v2.

still did not get v2.

> > LGTM, but I am pretty sure it does not make any difference in practice?
> 
> Right, nothing is queued on that path, so the device has nothing to
> access.

