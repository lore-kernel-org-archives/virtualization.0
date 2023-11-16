Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060710942
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6ZUNPsH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3522C61074
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3522C61074
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6ZUNPsH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFaPfohc8Dom
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 08:11:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 77E0E61071
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77E0E61071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700122291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8MVqIBAg0Ze1tKzh/GmKmZK8A/yBNX86ol85ht8VDU=;
	b=T6ZUNPsHKFvJyoROm18xTLxUMNhXFGtC2tlKfXTFMF7szKAkP5G4tMfEtrGgegTDImu5uO
	OBqLlklFb6mqmA19CsW7sKSCrfncxjfPCpieWAU5/xbuIuYQAKjLyLzZUOkjcKzr/avW/l
	a3vCiXJhzvp6g2JzKbL89+W5Ep1SWps=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-LFV8R2kVPnavijWW-hj__A-1; Thu, 16 Nov 2023 03:11:27 -0500
X-MC-Unique: LFV8R2kVPnavijWW-hj__A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5090b341d6bso999490e87.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 00:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700122286; x=1700727086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8MVqIBAg0Ze1tKzh/GmKmZK8A/yBNX86ol85ht8VDU=;
        b=eCcUNJl76enbM9zM7Ptu0xuauTpf/eIAGmaUl4xQiEHlJWVLIBozyyRAnu0FwmZ/i4
         fQLo8TF5ujpvGLGxVCf8vc4flrTewFTDT7v3WJl4OzCb9I0x3Yqy38J1hyViupP/+FeK
         gUQ2NkXhTF1cZZ00Zkzx89Ajicwcpr0KJhgj1s3QJw8qo7XI6lTDQ+ycMAT8tIm4alXh
         YH4eEUYgiu0CZd9DnsjUxQk1NaZzJ8AR5lVU6nl0fz5jJlfewQ6RHtvnHnSij0SRTfTp
         AXeE1tnwQPQNQ4zjaEjItIyEDu4JIT2bKETvDX3l0y4z2sODq7eZfUFY5un9pz6nJk6y
         WEDg==
X-Gm-Message-State: AOJu0YwoLZ/RKUo7Nm1FxFgPiq2bjNJBIOtcIZHJJ6Xr+g+xtyiiP2K3
	THZIgwE3P1ncP06EjtLhwlJeuQl8hP8DVxRIuwfs+EiPC6foS8cgkEbH4NRzGxkdQECi4CnOLCQ
	yb9SCiCJOue++DSjaygBLBHXXs7j/NcOzedLs1ACypUffpgC337GhVWpavw==
X-Received: by 2002:a19:f814:0:b0:507:9b69:6028 with SMTP id a20-20020a19f814000000b005079b696028mr362687lff.24.1700122286163;
        Thu, 16 Nov 2023 00:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIAT2szDZHDni/KcQ1f5Zh1LiW8qjpIDJiiGT7CirI4BPL3koqTYt11Xvh+jEE1U5eUd24Q3GjJnuTBD7v2us=
X-Received: by 2002:a19:f814:0:b0:507:9b69:6028 with SMTP id
 a20-20020a19f814000000b005079b696028mr362681lff.24.1700122285875; Thu, 16 Nov
 2023 00:11:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com> <20231114113104.33994-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231114113104.33994-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Nov 2023 16:11:13 +0800
Message-ID: <CACGkMEvb1wsmfMh_r8x3FFTCjTx1HXz=-ZZxK9aFMo1ZD6QUDw@mail.gmail.com>
Subject: Re: [RFC 2/4] virtio_ring: virtqueue_disable_and_recycle let the
 callback detach bufs
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, inside virtqueue_disable_and_recycle, the recycle() just has two
> parameters(vq, buf) after detach operate.
>
> But if we are in premapped mode, we may need to get some dma info when
> detach buf like virtqueue_get_buf_ctx_dma().
>
> So we call recycle directly, this callback detaches bufs self. It should
> complete the work of detaching all the unused buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c    | 31 ++++++++++++++++++++++---------

Btw, is it better to do this before the restructure, or anything I missed?

Thanks

