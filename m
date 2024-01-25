Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F2125BB
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222945; cv=none; b=qE4alynYW7R6ovAYJyi78ThQQ9FPqvIUAcl6ipNRADm2QLaipO3Rf0xXnf2yHyvpWLlKhjf9xomFSlb/aKo/x+DSME1Bx/Wia0y2H6Ickamp3p1Q0BabR0jPsysk2xBRhjmXYhgp46FthoSjCc0OKcDMraWHxKN50MhuToxBTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222945; c=relaxed/simple;
	bh=CbmW/228GCi3mqE9tnHZSnzCJD3NGsjyla4RSnkrJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=opGs7ZaC9EzIEMt9IPQ+tGZYx7FBjIiDdQkCQjbkYqzBdWScdtfmrZt2Xtg68XS3Flf6CWryUF8ubGYPcQLXzcJuqMrelcKNa6N3P5RVSR6Xi0O1EqsBfQ8raxfkmPWjvAv0Pgy+TEd2VRnIF8g5eQMG9VPr1O8FOxvMk2+vxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5j5nBC6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5j5nBC6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 096A36FB0F
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 22:49:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 096A36FB0F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N5j5nBC6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5DPmWv05U0sE
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 22:49:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD2776FA9D
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 22:49:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD2776FA9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706222940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4Crka9/JgHcU0ey0pI+XUxXs9hF7aNw/5Jtdg8P4KE=;
	b=N5j5nBC6PXcvXuW5fmoXcfVAqqydqTzu0WTZvC7GiKxX2bjjFRtv95BcPeErdgn9Xp42nK
	0+Fey16/S+J+wwrcLklbVZL+Mewsru9eDEH9fh7IpLbxhRSoh7ngLcq8n7SHlK+fGA2hOc
	6S3sQ9AeJPz7NPY+iCpQO2I/pepaGf4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-tkE-MiQmOsCu8DVefd5wOA-1; Thu, 25 Jan 2024 17:48:59 -0500
X-MC-Unique: tkE-MiQmOsCu8DVefd5wOA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337d6046399so3988369f8f.3
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 14:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222938; x=1706827738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Crka9/JgHcU0ey0pI+XUxXs9hF7aNw/5Jtdg8P4KE=;
        b=xBHdQWyNLa2AByko4vvcuUism3rc3D5n2rsHOOx1SM2x6+Z7UbOj6s+cCFGM8YPabx
         GBnIgQ3W2wg4trq8HgV7SIDVVL/rp0PAb1RY0Vbh8Iax6/fVM1PLd61Rn4Z32FQnYcQM
         GL4pJIVoerjXwN7Xt/qFI02uX5MuXziIZo5gckeq426enO2NvCmqL+JTMehXcm5Hf5hK
         g6lHU055g/NuEXrrNspXvtd3XoFvkhqRMbGsBaaRI7XuXxRV26s4lly5wMi+mtm5LMqC
         BtX0yoed85d9ZP2PQ1TR+QrGcfbU/q6RofM9LQrt5FNjNcU4grvTSPHpx/7n+tM9ieBk
         4mVg==
X-Gm-Message-State: AOJu0YzxGK/FXfF4dEW8FIgV6HkBIItH1XRYbfHenaENXG8oHjeAVV3W
	hxUWEuL8IfIFRLNBOcZrUbKmT/JD7qucCzicdpd/JiQ/tfZjggvADcRBtakKKCSnV2hqANTvre5
	3pcoj/zuzdOB9PTtgpoguJanc1/3XPOxvPrvXHbznHhh9vl2dqdEwSYfp4T+m2i/A6l/tX6e5gS
	7iBVU=
X-Received: by 2002:a5d:456f:0:b0:337:bfd4:8c1b with SMTP id a15-20020a5d456f000000b00337bfd48c1bmr209623wrc.23.1706222938144;
        Thu, 25 Jan 2024 14:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYwVPAR3CAgbGUu1SF1zj6JUO3aXtfnw/UqEkEi86zKYeiQ92JA4m9kDpOpg8QaBLVc0gbMg==
X-Received: by 2002:a5d:456f:0:b0:337:bfd4:8c1b with SMTP id a15-20020a5d456f000000b00337bfd48c1bmr209611wrc.23.1706222937744;
        Thu, 25 Jan 2024 14:48:57 -0800 (PST)
Received: from redhat.com ([2.52.130.36])
        by smtp.gmail.com with ESMTPSA id x1-20020adff641000000b0033922db3f74sm15876156wrp.116.2024.01.25.14.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:48:56 -0800 (PST)
Date: Thu, 25 Jan 2024 17:48:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1] vsock/test: print type for SOCK_SEQPACKET
Message-ID: <20240125174845-mutt-send-email-mst@kernel.org>
References: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2024 at 10:32:55PM +0300, Arseniy Krasnov wrote:
> SOCK_SEQPACKET is supported for virtio transport, so do not interpret
> such type of socket as unknown.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/vsock/vsock_diag_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
> index 5e6049226b77..17aeba7cbd14 100644
> --- a/tools/testing/vsock/vsock_diag_test.c
> +++ b/tools/testing/vsock/vsock_diag_test.c
> @@ -39,6 +39,8 @@ static const char *sock_type_str(int type)
>  		return "DGRAM";
>  	case SOCK_STREAM:
>  		return "STREAM";
> +	case SOCK_SEQPACKET:
> +		return "SEQPACKET";
>  	default:
>  		return "INVALID TYPE";
>  	}
> -- 
> 2.25.1

