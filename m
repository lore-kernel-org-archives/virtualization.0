Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DCCA66
	for <virtualization@lists.linux.dev>; Tue,  2 Jan 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccsuBQIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704189628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41ZHkYLIzXdzlI467/3yvpKL+LfhtQ/UVRwyY0aP7do=;
	b=ccsuBQIb8ysJvI+AcxNtyDAMQeK0IXmV050w+4fOtNDtG5vcEBp5tLS4fYF6cHvtj75gtC
	2WM6g/geJwdPikxJSiVXr/cZAulTJkN+ODLNbCaoO3O50XQwKRH+eZy1FbK5949G7PFvP9
	WkbaMigDHqBxAv6Jdb6Kl7+GE4CUPug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-v8XyOsSWPnS2a8kd0G7B2w-1; Tue, 02 Jan 2024 05:00:26 -0500
X-MC-Unique: v8XyOsSWPnS2a8kd0G7B2w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d76064581so20463105e9.0
        for <virtualization@lists.linux.dev>; Tue, 02 Jan 2024 02:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189625; x=1704794425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41ZHkYLIzXdzlI467/3yvpKL+LfhtQ/UVRwyY0aP7do=;
        b=sJF7D0cs2wK3IniyCd4948X3ZbSPJbfvZuMu+2Cmo49RP9TGDHVmdxz4ZuLV6F9jS4
         tu1ib3/ovMXTlNdBARvJehcG/U2elZPFDZwiL9aFWuSguVEJPKGvZIYrEE7CygD1LuW8
         pfI1/gxXFKXp3S23e/nqBHvuhSHWhmy5ru04smesohb2ocFP6JjxZE0yAP9PSDz3rpzL
         1hFFTmhjqP2XPNwF9ooa6cATFcbPIa7tdCaShyzPxThRLJexIlbmMZ+L+fyWQQl/2Fmf
         cJZHy/4mIv6l7SlCPi1+EYAJg6nAO6dudLITlGG022/D1M4IDsn8mUE3tzlkPbPMI4yk
         y0eA==
X-Gm-Message-State: AOJu0YxSCIR28ipjP8aY+F8bzTZ0iA8DTQEB6n6QT8/Z8O0BWx8gtyZ5
	KIVLVWvmyoxB+Jq1UFWaWt9laVfsNtsa+M+F8U4Q88uh2+K59OLU++CMq1mvAtMUH9KCQEllw7/
	sOH+8BSNbu0u55MIZlfOyhMIKXwaj2lDM4KU=
X-Received: by 2002:a05:600c:19c8:b0:40d:4da9:db82 with SMTP id u8-20020a05600c19c800b0040d4da9db82mr9938199wmq.45.1704189625784;
        Tue, 02 Jan 2024 02:00:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3Agx/gwP+fFgW2C3mmhZgnjPwndajkXWg4EnlVYuLP0ev7FiqSWkpu0/oR90z1A1crbSQvQ==
X-Received: by 2002:a05:600c:19c8:b0:40d:4da9:db82 with SMTP id u8-20020a05600c19c800b0040d4da9db82mr9938186wmq.45.1704189625439;
        Tue, 02 Jan 2024 02:00:25 -0800 (PST)
Received: from sgarzare-redhat ([5.179.173.123])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b0040d802a7619sm13228741wmo.38.2024.01.02.02.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:00:24 -0800 (PST)
Date: Tue, 2 Jan 2024 11:00:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, David Howells <dhowells@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] vsock/virtio: use skb_frag_*() helpers
Message-ID: <ezudlfnvquoxnb7jsd6u4vkyu6hd4waofum6u5s3fhm2cihjqx@5lfgbk7pmm75>
References: <20231220214505.2303297-1-almasrymina@google.com>
 <20231220214505.2303297-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231220214505.2303297-2-almasrymina@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 20, 2023 at 01:45:00PM -0800, Mina Almasry wrote:
>Minor fix for virtio: code wanting to access the fields inside an skb
>frag should use the skb_frag_*() helpers, instead of accessing the
>fields directly. This allows for extensions where the underlying
>memory is not a page.
>
>Signed-off-by: Mina Almasry <almasrymina@google.com>
>
>---
>
>v2:
>
>- Also fix skb_frag_off() + skb_frag_size() (David)
>- Did not apply the reviewed-by from Stefano since the patch changed
>relatively much.

Sorry for the delay, I was off.

LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Possibly we can also send this patch alone if the series is still under
discussion because it's definitely an improvement to the current code.

Thanks,
Stefano

>
>---
> net/vmw_vsock/virtio_transport.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f495b9e5186b..1748268e0694 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -153,10 +153,10 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 				 * 'virt_to_phys()' later to fill the buffer descriptor.
> 				 * We don't touch memory at "virtual" address of this page.
> 				 */
>-				va = page_to_virt(skb_frag->bv_page);
>+				va = page_to_virt(skb_frag_page(skb_frag));
> 				sg_init_one(sgs[out_sg],
>-					    va + skb_frag->bv_offset,
>-					    skb_frag->bv_len);
>+					    va + skb_frag_off(skb_frag),
>+					    skb_frag_size(skb_frag));
> 				out_sg++;
> 			}
> 		}
>-- 
>2.43.0.472.g3155946c3a-goog
>

