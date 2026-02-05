Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32690156677
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770264752; cv=none; b=d38jj9NgydOFBHDSqqBdv+jEHw0Vtg53/ZD50GjaCihL7M4lxBENRW2g6IOYLbXQUahOfqiP5elZivk+MCAzEZU4LM/vyuUHJI1yTq2obbGkFjU+wDbQPr04a8cxfgHKE71053iqa5/BTX53Wz1olfFF7Wzo8AwG3+LT4NWqR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770264752; c=relaxed/simple;
	bh=3TYZrhXeLdwlvT3HOHosF3Zz6ave+UyXvM0VGb5I6kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy1xyqjXdZjxf8hjMPtUOdXOf3suRbYAE5bapbZCf7fEJoH70mqXcH3shOavFqiWPxHeju1LgXxMlrV0t6b5J4qT5SmOWwpYygdN4dFdYgoqyY47wI29jbAvTI4eSy9BswlILN/RfrPk9FThXeoYzQqddIEsW6yr6i+sfH0+Ujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te1rryoe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te1rryoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770264751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zewgyfu9wLqA2DfawEOVacfHlxdGI5cP4c+2P+5IbE0=;
	b=Te1rryoeatP0zGcM8aiXssEDuuJZtD5qguichaIf6NoHLagKRLMGgyTCsb+1VCB4K3jeY5
	L52gnyWHUtHBPIlvdXSfm2B03LafBNL5mNc4p+neAYL1ci9S3pZgbCg13G4QC2Ja6JWx8F
	UjuL8I8nRAEK5ZF965wuqw809ZHK5xc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-JQQ7qpZVOnCLKNMGwNZVrA-1; Wed, 04 Feb 2026 23:12:30 -0500
X-MC-Unique: JQQ7qpZVOnCLKNMGwNZVrA-1
X-Mimecast-MFC-AGG-ID: JQQ7qpZVOnCLKNMGwNZVrA_1770264749
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ec823527eso851222a91.2
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 20:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770264749; x=1770869549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zewgyfu9wLqA2DfawEOVacfHlxdGI5cP4c+2P+5IbE0=;
        b=VXJpb44rUd5zwbMWARYzhOshPe9DI2JVWr972qpzQNHbDTgHPRchGAj/B7WlUv+Otl
         Suj3eDRlHi3jYIs+JkrLhSLC2AduCXlLdvvm/P6SJUhO7Rn3rXDj9oGaBZxk2JMxnfEl
         Aj7G8kE2cw51IkimB/idCCn4llgmVY+xnkc3SnbBUP8veWqwOrmtBehc1D0ti0fE1DyL
         FSlchhEAEoYsHTL9vT23uD1IrTT7sL3UbCM9kbp+4tKWA3nw+SKedgcx2/cIQqvcJyeX
         ncBSm0HO3oL487PFzEEEIq5+ikkyovYVKmJ1sM++9bOnUORjjf7Lw0/TP7KMGsMvq3dY
         sMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp87dXq3EfiYw9e12v/7CedVSVgEvQcxwNCw5IMvngYpOhoDq4Q74l/c8iIIl52FtWIZHBVIWltkKMENqlMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylrgQ/KN0xikkK5QIZ108ybqTgPuNm7zhPjCO3ZuTGCu8UO4X7
	DUvUsBde92+TnVKvx7cbS0vrYvOy5LC6NA/dlZtlaedLzcElmyWtzbV6HHTiWEm72k2s2R+68P7
	rIUhGZSa5kvoYYYORpCg3rBUPI5hjkYILWEgT7QDTyNdA178auPeyeDfmjgsV2W5Q9CYza3MzCF
	+Ql1X2vf9JLGM8xAPf0EsVVM8y530iGaxQCMrKa1+E6JE=
X-Gm-Gg: AZuq6aLHwZ1C9SrQUorYRI4Aq0r72H3Dc5vZidjkerJG2QO24yP/vwfTDNy4lIDxs/9
	7I4SZpBmORFxCV+yz3he+SwyR/8dFrpbFNgveCa8VEXn09O1wHITjZg+NO4lLrceAC7iaj4LbYV
	v7xhACMDpu8PiDAsvELI2a2pSMiwxYV8nHAxRWcl5nZtI8LicxMdFmqJksyA+wYq1NTg==
X-Received: by 2002:a17:90b:584e:b0:354:a065:ec3b with SMTP id 98e67ed59e1d1-354a0662c95mr749306a91.27.1770264748984;
        Wed, 04 Feb 2026 20:12:28 -0800 (PST)
X-Received: by 2002:a17:90b:584e:b0:354:a065:ec3b with SMTP id
 98e67ed59e1d1-354a0662c95mr749287a91.27.1770264748561; Wed, 04 Feb 2026
 20:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204193617.1200752-1-vishs@meta.com> <20260204193617.1200752-3-vishs@meta.com>
In-Reply-To: <20260204193617.1200752-3-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 12:12:17 +0800
X-Gm-Features: AZwV_QizAHLNWkiETUatO6ZkdAJ2xnGs0u3Ghu1W7Yk4-H7oDiMym-wpgKMXGqk
Message-ID: <CACGkMEtMgNpoSeUUFt10LJZqtTpi1atbPJwpXDf94AyzVKxvqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -6Df-BeBVB1sbQFvEQflbqNqyKGZZyXCVs5ISpe4iHg_1770264749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 3:36=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.com=
> wrote:
>
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.
>
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  .../drivers/net/virtio_net/basic_features.sh  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_feature=
s.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> index cf8cf816ed48..fa98505c4674 100755
> --- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> +++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> @@ -6,6 +6,7 @@
>  ALL_TESTS=3D"
>         initial_ping_test
>         f_mac_test
> +       buffer_circulation_test
>  "
>
>  source virtio_net_common.sh
> @@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
>  h1=3D${NETIFS[p1]}
>  h2=3D${NETIFS[p2]}
>
> +IPERF_SERVER_PID=3D""
> +
>  h1_create()
>  {
>         simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
> @@ -83,6 +86,84 @@ f_mac_test()
>         log_test "$test_name"
>  }
>
> +buffer_circulation_test()
> +{
> +       RET=3D0
> +       local test_name=3D"buffer circulation"
> +       local tracefs=3D"/sys/kernel/tracing"
> +
> +       if ! check_command iperf3; then
> +               log_test_skip "$test_name" "iperf3 not installed"
> +               return 0
> +       fi
> +
> +       setup_cleanup
> +       setup_prepare
> +
> +       ping -c 1 -I "$h1" "$H2_IPV4" >/dev/null
> +       if [ $? -ne 0 ]; then
> +               check_err 1 "Ping failed"
> +               log_test "$test_name"
> +               return
> +       fi
> +
> +       local rx_start=3D$(cat /sys/class/net/"$h2"/statistics/rx_packets=
)
> +       local tx_start=3D$(cat /sys/class/net/"$h1"/statistics/tx_packets=
)
> +
> +       if [ -d "$tracefs/events/page_pool" ]; then
> +               echo > "$tracefs/trace"
> +               echo 1 > "$tracefs/events/page_pool/enable"
> +       fi
> +
> +       local port=3D$(shuf -i 49152-65535 -n 1)
> +
> +       iperf3 -s -1 --bind-dev "$h2" -p "$port" &>/dev/null &
> +       IPERF_SERVER_PID=3D$!
> +       sleep 1

Nit:

It's better to use a more robust detecting instead of a sleep 1.

Thanks

