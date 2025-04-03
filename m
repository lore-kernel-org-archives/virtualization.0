Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F4242905
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685488; cv=none; b=YPTMgtw6OKLTsvNPYc2/KRseNeAdvreSvmxFc4j3li5cIEj1X3M9by4HOkojupT15jyHSowR/qedGI5UZJ7m9mgMOb/bYRxuRh3/72SQs90Q26yCi4FN2fwa+kE7Lbjqh1GHcAo551o9i9wB84d8ACxV9ZrUxVvEvgIMeYM0jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685488; c=relaxed/simple;
	bh=xTHY4RqEjxr86dYlWDDlxCi7O3MBBVTaufQtaP1th6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ta2/+YJseUTpH+AlRl70z+DFXmzhphYy71lyJ2yIUwHnpPfPfnOidp2S1Qt26M6aI2cHBokJ6shLMMIQugAi1OyR0t1USmPMHnUFiiw+m2euWNunVU5eFznrKRmJFWK8uTroZrPfk5BEqOo3YG1jpel2lkpiefQO5thLCLEqG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpWrolEl; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpWrolEl"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 056594180D
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 13:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQivzTZV88lU for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Apr 2025 13:04:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1A8B14129D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A8B14129D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NpWrolEl
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A8B14129D
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743685484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiWiLDEE7GXuot+rO5fuKhXP+Y+h9zA73k2z71ZTW1I=;
	b=NpWrolElrooxQY+WBR4seSfVf3iSqJQcndxWyYJ56PBcMm5LDcwHELwdJJFWA4GP/bziBC
	lrYka9c6BRRcKQv0GrW2uYghqo3LTBjMUXXECotypZwo1npQ9i9NEkLBwca6O4cJ5X4cub
	6eaR7LERvwB5hr1z2g5To79hADy+zIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Cj_dUkvYNWW0CMd2S5Dz7g-1; Thu, 03 Apr 2025 09:04:43 -0400
X-MC-Unique: Cj_dUkvYNWW0CMd2S5Dz7g-1
X-Mimecast-MFC-AGG-ID: Cj_dUkvYNWW0CMd2S5Dz7g_1743685482
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39c184b20a2so509352f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 03 Apr 2025 06:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743685482; x=1744290282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiWiLDEE7GXuot+rO5fuKhXP+Y+h9zA73k2z71ZTW1I=;
        b=cghJcmGqwGyiVHWPuaz9Z07Xbn3DVuRUIxH8xk1N7VE6evM9lOonhwe48HXxqmGAYG
         ITTxPFjXhN+OiF6oZPsscFop0lm03nIBcvbEnr6JymCntkgvzMvgy7+Wx2yGKXh5ItEP
         i5mQS1XIxAR8LB7TaH4QH40XvXZHIokqUKo5wNDiqIxPSzGwhKqf3r8Tlf5e4pqaY2hY
         vKL2vmenaSD9mMIbTIA6kWARpXgyW4jxgKYFICahMUaI7z7D8sG2tB/N4dOayyFnnyWY
         2hHoXUmSVvZ6ZmlqbmXl8yB78/0rXojii6Z0wu4rK15yJ0gOmZVTpTB0w7ucaSM+HOcq
         Ky6g==
X-Gm-Message-State: AOJu0Yz8Pa2okBSzQAxRYEq7Wx5T1sgPrj8PYbKmej7DVV5KlXeQTsC7
	z7qooVjI3ac4JFrYwV1V/TdZ+vjsM3TRmlcBgOrcwmHnKbGQ2EUxhfEJQMpm5rdqt+cL7txX9Fu
	c6aS1efQ3Xazx3tbezxLmbXv/X+QldmszfsVpwp+JNXgQTdld5vAPUPeW7ITvzakB8Qe8pFEefH
	V33kI=
X-Gm-Gg: ASbGncvxeVrfAbV39aXJhDEuAYmBjpBCP+HWRYYLIt7IBMETnwr0l9eJ0cNjB74wBey
	lVLz7O+9F2SYQ2M+8XbypmNhvDREJMdMx1Bt4mHfjqQxPGZfMTS7mO20YVAzE6n/7GKIPMCfitO
	kDsg7tzP5cFL5ZxR5xcW29+GgRj3AbmRjB1pWle4Q8VTMWCZjqei6w9wtI4C38tIYjJNJ4qvSF0
	KeXEShuZba1mxUCUdMv1x64cRfb42Dgep2pAnU3p2MMrK+BplBGeJCMXtJAKUEthgRjg/OvVcqM
	115mZ5xNmA==
X-Received: by 2002:adf:9c84:0:b0:39c:1257:c96d with SMTP id ffacd0b85a97d-39c2f966641mr1596392f8f.57.1743685482163;
        Thu, 03 Apr 2025 06:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyvtZMESrru/rDb7nkZxZrQw7eiIgzM7eJY1ncVRnEeIZHyQ07e7ml/r0pMPgg9T3VfQ2QCA==
X-Received: by 2002:adf:9c84:0:b0:39c:1257:c96d with SMTP id ffacd0b85a97d-39c2f966641mr1596357f8f.57.1743685481755;
        Thu, 03 Apr 2025 06:04:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364ec90sm17785675e9.27.2025.04.03.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:04:41 -0700 (PDT)
Date: Thu, 3 Apr 2025 09:04:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Fohrer <markus.fohrer@webked.de>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Message-ID: <20250403090001-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f_cAHyUpeaaxhyv2gBYTwQsIbqv6aqtMTUq68oR4X8U_1743685482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> Hi,
> 
> I'm observing a significant performance regression in KVM guest VMs using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> 
> When running on a host system equipped with a Broadcom NetXtreme-E (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the guest drops to 100–200 KB/s. The same guest configuration performs normally (~100 MB/s) when using kernel 6.8.0 or when the VM is moved to a host with Intel NICs.
> 
> Test environment:
> - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> - Guest: Linux with virtio-net interface
> - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level)
> - CPU: AMD EPYC
> - Storage: virtio-scsi
> - VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
> - Traffic test: iperf3, scp, wget consistently slow in guest
> 
> This issue is not present:
> - On 6.8.0 
> - On hosts with Intel NICs (same VM config)
> 
> I have bisected the issue to the following upstream commit:
> 
>   49d14b54a527 ("virtio-net: Suppress tx timeout warning for small tx")
>   https://git.kernel.org/linus/49d14b54a527

Thanks a lot for the info!


both the link and commit point at:

commit 49d14b54a527289d09a9480f214b8c586322310a
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Sep 26 16:58:36 2024 +0000

    net: test for not too small csum_start in virtio_net_hdr_to_skb()
    

is this what you mean?

I don't know which commit is "virtio-net: Suppress tx timeout warning for small tx"



> Reverting this commit restores normal network performance in affected guest VMs.
> 
> I’m happy to provide more data or assist with testing a potential fix.
> 
> Thanks,
> Markus Fohrer


Thanks! First I think it's worth checking what is the setup, e.g.
which offloads are enabled.
Besides that, I'd start by seeing what's doing on. Assuming I'm right about
Eric's patch:

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 276ca543ef44d8..02a9f4dc594d02 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
+		if (skb_transport_offset(skb) < nh_min_len)
+			return -EINVAL;
 
-		nh_min_len = max_t(u32, nh_min_len, skb_transport_offset(skb));
+		nh_min_len = skb_transport_offset(skb);
 		p_off = nh_min_len + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;


sticking a printk before return -EINVAL to show the offset and nh_min_len
would be a good 1st step. Thanks!

