Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7E18BC09
	for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432060; cv=none; b=e+XQGoPPxCxMFN0BwkqfgtHT6HaPWeRyULbvWZdj6k5qZWmrh0T6lHUIx6bfcj2E10TZ6jNrt49aBJ63IoCsdaJvw2y9R8fwnJRWjZzoRjYPOIWlXSqKfnmyNnVTeYo9B+GT9DLcDmS7q6hWxx/NoGXe0WV/hkFk01EAUOFp+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432060; c=relaxed/simple;
	bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=adMrBlnxbXsDJUIklZ8QaBDhagBFHCaJuYW1i2K4bi7H4KQUeLJJ1ldqa75W1nvmNyf3EIpvNOyYrWV3jRHrHFBMqy+Obr64pDwWIPiIOAaqbyJJFu6aTBIN8HqhhdHpSny6SXHKw1oIJkfi57dMPNclR/rnEjq/Lci8fUNS2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=eJSWA+KA; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="eJSWA+KA"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 262C2401C0
	for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 16:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBWH9_tRQduy for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Aug 2024 16:54:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b31; helo=mail-yb1-xb31.google.com; envelope-from=cbilbao@digitalocean.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 370124002C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 370124002C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=digitalocean.com header.i=@digitalocean.com header.a=rsa-sha256 header.s=google header.b=eJSWA+KA
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 370124002C
	for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 16:54:17 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e13c2ef0f6fso2249114276.3
        for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724432057; x=1725036857; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
        b=eJSWA+KANV3l8AkbdH0b+B1WSTPUQaKj/BTgQ56kTsZKpCyrcvtMgKnpV+ds4F8BBV
         1q4eTpDMgOOFkBi67GJGJohMlg6R/d1ZSXx7Mbc/bN/Q6GiQVcHiixuF/fmMMA9aMqYW
         yr+crbYvlsO4UTWhdjOrSFiCISA5LUveTrYcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432057; x=1725036857;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
        b=SkI+jBJiDiDm+4jfFvpZgpa65TJj03PZD+c3Cd/OeqR4MvcZmUcJb0hbGfiBpub9To
         K02xN4yv3AizkFIka5pQcNlyfRItBFsNY4gqu8Axugu/TBSkyEyrS8SzDk+JF1Tn0qvW
         rCpRrPa/y29zq/JKaIADPZHuh2sF+8/IaYwlP+cQUP+Fr6CmGhaLIOOuJ8A/5kLqrO0+
         HnRlhRx1RYYLPsQLTn8zYf/hdIiN/X51WAtcmkQv4XTdGR+P0e9Hlc6UsiqQruR1NngP
         mhe9cv1wvm3tsE2CH14QEmHas5tyK4m9ZUsWLpeHMN/DCxrLedlHOLiSVRNc/ahExFum
         l6/A==
X-Gm-Message-State: AOJu0Yx8coFzMu1XSyq3aXxwQMf7e8vD0sIfgVvVpZCVamRKhxktzprj
	ZpGSaoGY3KE7H5aFLbIqy8+NPDbx4Sf7Ixr6ZOflRlQiR2BmestOzUdiqBChQFY=
X-Google-Smtp-Source: AGHT+IH+lZIalG0ZppdDUStKyMfxmA2xRM0YnXPLiu2xPW0X1PX57ufunWwRCXTvVh1qWh0OpYdpBw==
X-Received: by 2002:a05:6902:2383:b0:e0b:e4ce:9047 with SMTP id 3f1490d57ef6-e17a83de244mr3495755276.18.1724432055984;
        Fri, 23 Aug 2024 09:54:15 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4406b0sm720032276.12.2024.08.23.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:54:15 -0700 (PDT)
Message-ID: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
Date: Fri, 23 Aug 2024 11:54:13 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: eli@mellanox.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, kvm@vger.kernel.org,
 eperezma@redhat.com, sashal@kernel.org, yuehaibing@huawei.com,
 steven.sistare@oracle.com
From: Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [RFC] Why is set_config not supported in mlx5_vnet?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'm debugging my vDPA setup, and when using ioctl to retrieve the
configuration, I noticed that it's running in half duplex mode:

Configuration data (24 bytes):
  MAC address: (Mac address)
  Status: 0x0001
  Max virtqueue pairs: 8
  MTU: 1500
  Speed: 0 Mb
  Duplex: Half Duplex
  RSS max key size: 0
  RSS max indirection table length: 0
  Supported hash types: 0x00000000

I believe this might be contributing to the underperformance of vDPA. While
looking into how to change this option for Mellanox, I read the following
kernel code in mlx5_vnet.c:

static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
                 unsigned int len)
{
    /* not supported */
}

I was wondering why this is the case. Is there another way for me to change
these configuration settings?

Thank you in advance,
Carlos

