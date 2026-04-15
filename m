Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFF344D9B
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249497; cv=none; b=N2Wqqu3CltCWEJQ6DqQlUpBFQcR0clyLllJ2xpEHvqtXFehgSbeZxjxw19h5LwAXIw/1iZcEyGrwImamGC8zS/QRQ7oXAHwB3z6jzVzJMnUr2SzGBRXKfMlSf4ThTc17SDAksiiFM3kh+c8T6ubiUsOAgSrXN3gcrmQ716ItIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249497; c=relaxed/simple;
	bh=MTvLj66Y77ArXLSp+TSw8ghHRCXJwgL40oURLnpQzt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eu461JsBE8wLcVVIAjpBi3Ttq0KZu6RS/SEPDn0QX/BWcnr3Mkz0QpzacBKLMPelYhwL7+2HFm5497K2cTW+HTJGTgqjowN0m5RmZcIf6yFdcOZrGzhMTBOkuz2fhJA5hlOpoxl+jrXvmvDhRwKo/p6hH5uTVkPd75uQUml/ISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJrnX99Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJrnX99Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776249495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHOnfYuW3tC+yUaHMZSnrjEvT22LJH6fSZwyXCPhnqE=;
	b=AJrnX99YSbM91yM5IEAYd1hTzUSta3A2/doH1UdZxvvcWgNRzuWtnuLBqnZuWYPNpvpMix
	nTaLHeNOubZesjyizOtecxt+f6ZecKrstn2W0satE1VkrVcA2bc0HGsoJlR3x4bBMcLUm2
	kZEl1U+6AuQzLIkGvZ80b4t3lgY15dM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-RKNSFHyzNwOLThTbzWCDNw-1; Wed, 15 Apr 2026 06:38:14 -0400
X-MC-Unique: RKNSFHyzNwOLThTbzWCDNw-1
X-Mimecast-MFC-AGG-ID: RKNSFHyzNwOLThTbzWCDNw_1776249493
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c74405ecso41888165e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 03:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249493; x=1776854293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHOnfYuW3tC+yUaHMZSnrjEvT22LJH6fSZwyXCPhnqE=;
        b=hwWRWE6DMBRQkKpJYTA77PTrXJxRoCMTFRIV7r5z8rj1Y1WPJYAFPueQrsGcH5t5xe
         c599Xk1/bQG95l6CfdURwbjf4nde08RNODkfJSFnp+qFL0k8RhofSjO0Jp2yiyD2DkaX
         4QgSj0qvelJYKaknB4jDTsTXKZtLIzJiSflJtJDOgLwb5tCSfCDu4lpL/utRzESm+wMW
         fGKo8ChktdKIhL1HhACtMMEczestGFsb3zmiCxifpCS8I2kja72kNye60iWM2l1z26iR
         1xF3eyCk3ZgONAth+t35eW3xeEGNMIkQ+yBwVpoBks5SNZHAMwVMOiyAo1xn11g+yt+H
         tp5g==
X-Forwarded-Encrypted: i=1; AFNElJ9hN1IcL8LZYoU7037Oiukc61/l9ASTBal1XuonjoRRXgk1O77CfGghnE0SJ1UfHDd4etqLSxau2iZBZw1kBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWtK3R1AtoCmzF41fEyUCPekT0guMP6yqLYw8OPBhY05K1cWT/
	YZMvjiyyj48tmFvDjeAT4/LS9P9AbyWvoorBziUm+/VYCxydNibf4ocRwtmdwUhClihpMfd8j2C
	dSkFMIkYPxtvK8O52vlz5i1g8yAuBjfTvghfT5gAaUdGTkFfYh+F9ZJFAtpmbDa6jfS8d
X-Gm-Gg: AeBDieuvnY6GzognNi0/JdnUM8Im2cKKmqXICcQk7kPGhWIif2urqAKvrfRR/0xPBA7
	mAEZtD3imgapuIzPn6qy0+mCCWwuUI+gidtC2aRoxVHjb/m0hMXXSgLN5CxtWQ+yFZ/uj3ThJmz
	QZIJ0WYsE9vEUXV3fJtD8dKc3Py2ijh7huu2a+11rdlvVxg0I2x2Afqa2nJrjWdQotW/T76uxJK
	vtHxw+q5YKyZ40woATYqOt7Z2aodL8dVuvimFWrykXfkmMaaAx3aamwcU94Lg35BB0b/D1OWfyD
	z4cY9NWzlElfQ/S1h5F1zlFh5Ios6K7ejS1K5aN2BNT9sOsRNyfKsS53gCNFzHpl7HQJEByNH7m
	wHGf/Wv46PHeNgsRdhldTBSUyZDoXsRuUZO3S0dG3cDWqLScVUShKqAU0EH1OxuzpbiRHQYk/Dq
	Yge6otbA==
X-Received: by 2002:a05:600c:890e:b0:488:bd79:94d8 with SMTP id 5b1f17b1804b1-488d684331emr195084185e9.18.1776249492659;
        Wed, 15 Apr 2026 03:38:12 -0700 (PDT)
X-Received: by 2002:a05:600c:890e:b0:488:bd79:94d8 with SMTP id 5b1f17b1804b1-488d684331emr195083925e9.18.1776249492197;
        Wed, 15 Apr 2026 03:38:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ec6cc6sm17072045e9.29.2026.04.15.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:38:11 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:38:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ben Hillis <Ben.Hillis@microsoft.com>, 
	Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH net] hv_sock: Report EOF instead of -EIO for FIN
Message-ID: <ad9pPrji1uYSgNir@sgarzare-redhat>
References: <20260414234316.711578-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260414234316.711578-1-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tf7xB3OPBLGCzQ7WkQ6JQQU99sxzADVS4rT8gAJcFNg_1776249493
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 14, 2026 at 04:43:16PM -0700, Dexuan Cui wrote:
>Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
>and the final read syscall gets an error rather than 0.
>
>Ideally, we would want to fix hvs_channel_readable_payload() so that it
>could return 0 in the FIN scenario, but it's not good for the hv_sock
>driver to use the VMBus ringbuffer's cached priv_read_index, which is
>internal data in the VMBus driver.
>
>Fix the regression in hv_sock by returning 0 rather than -EIO.
>
>Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
>Cc: stable@vger.kernel.org
>Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
>Reported-by: Mitchell Levy <levymitchell0@gmail.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 069386a74557..63d3549125be 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -703,8 +703,22 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> 	switch (hvs_channel_readable_payload(hvs->chan)) {
> 	case 1:
> 		need_refill = !hvs->recv_desc;
>-		if (!need_refill)
>-			return -EIO;
>+		if (!need_refill) {

Can we drop `need_refill` entirly and just check `hvs->recv_desc` here?

Mainly because now the comment we are adding is confusing me about what 
`need_refill` means.

The rest LGTM.

Thanks,
Stefano

>+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
>+			 * be NULL unless it points to the 0-byte-payload FIN
>+			 * packet: see hvs_update_recv_data().
>+			 *
>+			 * Here all the payload has been dequeued, but
>+			 * hvs_channel_readable_payload() still returns 1,
>+			 * because the VMBus ringbuffer's read_index is not
>+			 * updated for the FIN packet: hvs_stream_dequeue() ->
>+			 * hv_pkt_iter_next() updates the cached priv_read_index
>+			 * but has no opportunity to update the read_index in
>+			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
>+			 * 0 for the FIN packet, so it won't get dequeued.
>+			 */
>+			return 0;
>+		}
>
> 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
> 		if (!hvs->recv_desc)
>-- 
>2.49.0
>
>

