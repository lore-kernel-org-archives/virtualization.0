Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84531BCB7
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497408; cv=none; b=ETLBD5NUe+s+Fpe+AkBnByTWbeyWfugOkbeJR0QiF3Y0uewUn3/ibwDcFTWGTF4dSdsIDNiUwz6y5yzSH3mPnSWbgUsz3f11SmyBitPLp+35kru/bsLw/AmvLOmCU9m/+PNvMu3slJM+c3mOSu/HEcSDszwVMBHMhZk9f0SsRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497408; c=relaxed/simple;
	bh=oqw0KlNKIPYnEI20309wgxqKSge7eobGKUbr1LdjuGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SmCVzoMnZ7bQKZ1CoqjIN5JR9qtqEZPd7CRX4dZkgGUCaSdNXDX7MEY7MBzv4OwgO5dIin1pzA8sTAC29Zq5GM6819qe8U46QM7q3F7BW9u8kypKEhj8tp9S2IyHR8jaXhYXFjmA9YXqyCFELBU/KEJ1J7Gwwsu5DAp9lHnYxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMvTI7vh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMvTI7vh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771497406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0HuCXThfRUEeEl7yH4RijL3+g7m+evVIDET2wFtyGPA=;
	b=IMvTI7vhk3vuRkMM2kkV41ium5VGv7PT9IoyOLKQfO/Eu8PZ5TdwKuDhseOAlr5k5vvo12
	b1/S3HPV55lD4FePO7TyemdOfj4e8w2Y1lh3/O1oE2Zxw0PoCyKtTEzgcH7w49ej97W6oF
	WOjlcHbTBcQNG0DsJ2XQeW5Kr6iENdE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-U82G59PkPEmzTo9h9CRU8Q-1; Thu, 19 Feb 2026 05:36:45 -0500
X-MC-Unique: U82G59PkPEmzTo9h9CRU8Q-1
X-Mimecast-MFC-AGG-ID: U82G59PkPEmzTo9h9CRU8Q_1771497404
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48372facfedso12901185e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 02:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497404; x=1772102204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HuCXThfRUEeEl7yH4RijL3+g7m+evVIDET2wFtyGPA=;
        b=q2uF7yXdmsujoSZXTKp6WTA1jLzY9GMYWjw5fdq1NH81lNTupHNNdFvBlcrQEycKjz
         wxHcTzRImkoDOcT/dz7FajzmvcB35WEisRD6Su78FnZJd7Sa5u4n945pR+y6RfGhTrzg
         aYyHWuOZYmZbzs/3H8HLEWJ0KpTRYnm5CfyFuPP3O1I4i4nWW79EyuyNMcn2b7fFfqK1
         NPBpQZPo7T8+lOWvK5p3RiDnPD8q2na1aqvSDRvhnWH4GSa56wgC0JDjqm7gd9D9PDv/
         HQakDwLfwUm624eEstZEtt3Lb/b0PpzZ721CjRbCTaq96rZvdRIh1y5N4FHB15HzqcJ4
         pJhw==
X-Forwarded-Encrypted: i=1; AJvYcCVE/f4UisuqbEa04CD4gp278szEwWOoBB+KKcDh+rSInt4xOuy6DJ8KzsadrXtxmkFGycYaZmDzkDVIFXwigA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXws3ZaqwTyxF0M3Pk/pRjcRdntcec7GGeE4+SmtnPoEapapGj
	BnPPuMDE6gdM0bvxQJHcC+cX7MuhuVxJ+MKgdlutxuAn4T9emCCKLM+iVWYuuEOwB9vHT2ttl87
	CZek02FaXo6XOsLIKWrMsfIbW6o1O9v5OLttYYsLXzKrqP2WeQixeAXAV6EW8tL2PGSyC
X-Gm-Gg: AZuq6aIo4kuJ5Htrzshus4IK5Qx1fbt74RbMnnYmFFX0SXrKhBll5XZeIA86tMSg0/R
	bemVj7gpsg8kaFG2rRzS3DdAvEu4yV+0uqmbIQaYwH6ne72NNdvSVGGa5IPQHu16xskJRUr7hGg
	dNm2ZfJJS9F5gJWUzlTHpWesqIBbAZlQadIvwQorAwhyDQVoETvrle4RMCpPf47bQdv8/N6fNOm
	dbs5wHCTJsvVIM+sqNURQle/R5J/ugS1EWYJci14yJSMXaF6KU4E4MiLXnOn9YK5sbBKizJAIRT
	MSZXWD1JzWfrf+2NTg4kSZqxqdmu1+teQDYwYCy3and9cDUCUnC5SEeJUH2C4ywUhn1K0c1uTkZ
	qs8Ui9vPPSzxhR/XXN9SKBJetn2e32yrog24geGOiARymD1Q73zJYVHS4InRx1T7w98NC1Sw=
X-Received: by 2002:a05:600c:214b:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-4839fe90522mr18467495e9.3.1771497403788;
        Thu, 19 Feb 2026 02:36:43 -0800 (PST)
X-Received: by 2002:a05:600c:214b:b0:47e:e051:79ee with SMTP id 5b1f17b1804b1-4839fe90522mr18467255e9.3.1771497403315;
        Thu, 19 Feb 2026 02:36:43 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f99067dsm17354955e9.29.2026.02.19.02.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 02:36:42 -0800 (PST)
Date: Thu, 19 Feb 2026 11:36:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Message-ID: <aZbN8fXtCkhItSV8@sgarzare-redhat>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
 <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _p-jAe2FxxRG6xsqv70zhPCfYcyESbLVOkvC9J0Fkk8_1771497404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Feb 18, 2026 at 10:10:38AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Update the vsock child_ns_mode documentation to include the new the

nit: s/the new the/the new

>write-once semantics of setting child_ns_mode. The semantics are
>implemented in a different patch in this series.

s/different/preceding ?

IMO this can be squashed with the previous patch, but not sure netdev 
policy about that. Not a strong opinion, it's fine also in this way.

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> Documentation/admin-guide/sysctl/net.rst | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index c10530624f1e..976a176fb451 100644
>--- a/Documentation/admin-guide/sysctl/net.rst
>+++ b/Documentation/admin-guide/sysctl/net.rst
>@@ -581,9 +581,9 @@ The init_net mode is always ``global``.
> child_ns_mode
> -------------
>
>-Controls what mode newly created child namespaces will inherit. At namespace
>-creation, ``ns_mode`` is inherited from the parent's ``child_ns_mode``. The
>-initial value matches the namespace's own ``ns_mode``.
>+Write-once. Controls what mode newly created child namespaces will inherit. At
>+namespace creation, ``ns_mode`` is inherited from the parent's
>+``child_ns_mode``. The initial value matches the namespace's own ``ns_mode``.
>
> Values:
>
>@@ -594,6 +594,10 @@ Values:
> 	  their sockets will only be able to connect within their own
> 	  namespace.
>
>+``child_ns_mode`` can only be written once per namespace. Writing the same
>+value that is already set succeeds. Writing a different value after the first
>+write returns ``-EBUSY``.

nit: instead of saying that it can only be written once, we could say 
that the first write locks the value, to be closer to the actual 
behavior, something like this: 

   The first write to ``child_ns_mode`` locks its value. Subsequent
   writes of the same value succeed, but writing a different value
   returns ``-EBUSY``.


Thanks,
Stefano

>+
> Changing ``child_ns_mode`` only affects namespaces created after the change;
> it does not modify the current namespace or any existing children.
>
>
>-- 
>2.47.3
>

