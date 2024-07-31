Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D12F22
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396079; cv=none; b=DhvQPiXgCtmo1OPvbDXubiQNH8hqnv3szD0HX6+zmxwI6xy/W+t6TueXvGBmgWev2WFkYflEH4N1UWFyGSWES470XY6iYZGpAosANCtDPWhH5p8tvlDdqvZywIst2j+u5rS+RStwv4vaiJucEKUnNAl46S6Q6sBCwOobUj4/Mi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396079; c=relaxed/simple;
	bh=xJH43k8URImlEysYb2ZtwSkGIsRnlK2Txi02lgGh/Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwhWRtMYxmaBL2Gpqs4GLNGTO0Bdu2bk/w7nfCz47MaVnpvUnXWg3cHny+5/gJQLUyvVXLhFlJNIMCh8uMhQ9tnfXTUj4k0jZYSZikGZGzquVGoY/W3e+HhYdzsRPX9MQ+FpqOlbtsNMRjmV/5FFFGK8VfA54Qc2jdSer8JYFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VF2rnBCm; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF2rnBCm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0172160A76
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lm9HJXRsWUaR for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Jul 2024 03:21:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 30F74605A9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30F74605A9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VF2rnBCm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30F74605A9
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722396076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJH43k8URImlEysYb2ZtwSkGIsRnlK2Txi02lgGh/Qk=;
	b=VF2rnBCmHcjZKzHOs1XkyFttjqruMjHzTdvmDecyme7zzmFlBBd8T6xgHuF3M2xiMDzbff
	ZyF8Mjkp18DBUHwv3p5E4XvSGRxQ/1PThYyNSTTZK41tCq477kbqVjnlL/esZZXa4TDDPj
	4QjUiHEZJpkChG2uc7ktNVrejWxP1X8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-Rlb55aPjN96_AjFFZxVZ5w-1; Tue, 30 Jul 2024 23:21:13 -0400
X-MC-Unique: Rlb55aPjN96_AjFFZxVZ5w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7a242496897so3938298a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 20:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396072; x=1723000872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJH43k8URImlEysYb2ZtwSkGIsRnlK2Txi02lgGh/Qk=;
        b=T9W3Q+KMz0abYtIS9u861YycwxCXaY2DOgqPOUUBLWy0tSceMSAgmf7A++n8twq428
         FPTgQLU9DM8hUquD41J/zwZBCO1aeAY05VEM3HH5+gK5SOPO+PMmj8ixo4Gfm1h0ttYd
         jV2OJOYvBksjeXF8v77hjYOOL1MXuyl+IME+4ObfvYBAYgOPiGES2aGBHNkh3BpVyabf
         bb682ybbognVMUP26GP53qybxlT6oTPVDl5Hs3DeZL6CLxWAhXpbeXMuWXA/sgguatnp
         D1J0NyT7eU3k79xL0hm4ZvdU528YNz3+RUIU5Z2vIsk0YinBku62uA6F1LZSrUW7NFCo
         +gww==
X-Forwarded-Encrypted: i=1; AJvYcCUonb0FGuUaAbIAomhlHss1eRZlV17jzY65QdqYLUELLJ3LDsUC0FTeFb/OKO2Kgpb8F0jqPho2MO5JD4T5as8OqY0GyHN7iVVLuKxPlntB7YHMaTsW5FdwQA==
X-Gm-Message-State: AOJu0YyR6HkVSYYc4lYK4IUfpX2MAALvUgLFSBwXayo468AS6Y4oOz8y
	jemgVvJ9S7dUUEhfUarCWfc+wWuILx01UR3BeQZOj7RwQ1sZqFD0CDKQcGRDkwHLF4Ecckvh9qg
	4HjbsJCgZAA6ZhPdVIN7mxFZWBRNRHweVwl4XKNU3JuWSr6SNt0+TYOdG7IFcB1HSwTOelgpAJG
	MIcQHvuM8ehN6YJXUm/slJK5o22uRM86adEVpCiG5WhdogHn8/qNIIbw==
X-Received: by 2002:a05:6a20:2449:b0:1c4:8bfd:4321 with SMTP id adf61e73a8af0-1c4a13a1ef7mr12560614637.34.1722396072294;
        Tue, 30 Jul 2024 20:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFOJlwWT2CFUV7HOeE6P2HxO4AGkTGmXU+UVH/PtXBdfYm5264V0djpRLRQIe/OL7105iGiJ+e4nquq3zV9ec=
X-Received: by 2002:a05:6a20:2449:b0:1c4:8bfd:4321 with SMTP id
 adf61e73a8af0-1c4a13a1ef7mr12560603637.34.1722396071790; Tue, 30 Jul 2024
 20:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731031653.1047692-1-lulu@redhat.com> <20240731031653.1047692-3-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:21:00 +0800
Message-ID: <CACGkMEv6K054+HWxocdsf7fsxw64R5MctDaJ0wuWBY_LMrnDqw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

