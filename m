Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EF1D1728
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Aug 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350880; cv=none; b=snIu+CM5Vbx8AexM7HiEA2904pwEUKR3QnoumVEUxtjDG8LW4IlcpI7xZdOD27IDz6wVqKXuBWYl1Ml2Tf9uitzqRgj3+svia39RrYquiTJMhx65YMhEdsGlZsZUXeRYsso9Z/wu97hJc3U/FcHI2/YA51qfUvkM6rZAhyAb6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350880; c=relaxed/simple;
	bh=RLs+TgOeDB9U+OeJ5ILJJE/1qQupOxoL4NtsHLcUl2s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=ChjwKOei8kF19a9M+Be1xjcvrkNJhb4fPQX6ZYBQmZwrOI7DPtRrozAxOs+SoK/OS9UIzLGJubYbe72O+1X67V+ZrOvQQXR55uOHz8GJN9xxxafQFI5unEVpIUCqeyct+hFgjZTaulbBjmrdPzII6YtqQ1va3Zhg4zScZepH250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=LZqnO0u3; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="LZqnO0u3"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA5064028C
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Aug 2024 18:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_FQrNMdrj5O for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Aug 2024 18:21:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=cbilbao@digitalocean.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D9E7F400D2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9E7F400D2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=digitalocean.com header.i=@digitalocean.com header.a=rsa-sha256 header.s=google header.b=LZqnO0u3
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D9E7F400D2
	for <virtualization@lists.linux-foundation.org>; Thu, 22 Aug 2024 18:21:17 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-6b3afc6cd01so18402347b3.1
        for <virtualization@lists.linux-foundation.org>; Thu, 22 Aug 2024 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724350876; x=1724955676; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLs+TgOeDB9U+OeJ5ILJJE/1qQupOxoL4NtsHLcUl2s=;
        b=LZqnO0u3HAwp3QWcVET4O9ymlhRXsDmvDiDRtl02qpA1LAZZbtQQzh1cU5/E7zGr/H
         xAsMvzw1b9xCbFOPxHgWwSJrwq4bnjdtVtx/NmkBbdxXCM/bKSpRzwCdiub/qHIqsDyD
         P7mJ4YipD+X5hO0Gb8Q3bLVonOY0KcpHDsXdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350876; x=1724955676;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RLs+TgOeDB9U+OeJ5ILJJE/1qQupOxoL4NtsHLcUl2s=;
        b=ARrS+1IUvdphX0cYniba5OTPA8d3n+KuTy71OiFHv+WdDUhzzRMz/JE7NiwBtWCDkl
         Q3oaWd/VjSj+mvmPVqYh33653tcvdMoXASZ+Y+d4MBWUGZKmohSEnFQEOwQeh5Yv5IZJ
         o6K+LUF2Lri/jxjdvediwF6u2IhVaZKu42mPgmg9SlPB2HP+lR3GOl9jlW1Z6+iuB/WR
         /VcnPJeg2ZAOjMER8QkwjHmVeT8VO/6Hx70rcI+Gtdi77/hun0hTRxlOT5KUQFXzaFfq
         2Te9M05gf9JcivArrFhMiHJaR1CgjRpuDCa7/fTM9caFgM9rDgZqrir5BNza9LAJq7he
         IrNw==
X-Gm-Message-State: AOJu0YxflBQOzz/k1ZJefFRjHbcJ2gD4VUBdxYizYCcYbUF3K0puwjEb
	Npb/wZchTf1POFkSvvgy1qL9HetqK0oex+mOc9Am408HIVU/FHqrFxzOSaF/FrBvKeYzi58QyvU
	rRattVQ==
X-Google-Smtp-Source: AGHT+IHtXIMIiSwuBpmYLdcwUNBMd26Nuu8pfXN1VwE1UCqgTVayCXIzfx3aHHiMJ03T6ZoVnLerIw==
X-Received: by 2002:a05:690c:6d8c:b0:665:71a4:21ac with SMTP id 00721157ae682-6c303cf699fmr39887947b3.10.1724350876111;
        Thu, 22 Aug 2024 11:21:16 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a7525bdsm2992047b3.31.2024.08.22.11.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 11:21:15 -0700 (PDT)
Message-ID: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
Date: Thu, 22 Aug 2024 13:21:13 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 jasowang@redhat.com
From: Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [RFC] vDPA: Trying to make sense of config data
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello folks,

I'm using the code below to retrieve configuration data for my vDPA file
via ioctl. I get as output:

Configuration data (24 bytes):
5a c3 5f 68 48 a9 01 00 08 00 dc 05 00 00 00 00
00 00 00 00 00 00 00 00
ASCII representation:
Z._hH...................

Could a good Samaritan point me in the right direction for the docs I need
to understand these values and convert them to a human-readable format?
hank you in advance!

Regards,
Carlos

---

void check_config(int fd) {

    uint32_t size;
    struct vhost_vdpa_config *config;
    uint8_t *buf;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG_SIZE, &size) < 0) {
        perror("ioctl failed");
        return;
    }

    config = malloc(sizeof(struct vhost_vdpa_config) + size);
    if (!config) {
        perror("malloc failed");
        return;
    }

    memset(config, 0, sizeof(struct vhost_vdpa_config) + size);
    config->len = size;
    config->off = 0;

    buf = config->buf;

    if (ioctl(fd, VHOST_VDPA_GET_CONFIG, config) < 0) {
        perror("ioctl failed");
    } else {
        printf("Configuration data (%u bytes):\n", size);

        /* Print the data in a human-readable format */
        for (unsigned int i = 0; i < size; i++) {
            if (i % 16 == 0 && i != 0) printf("\n");
            printf("%02x ", buf[i]);
        }
        printf("\n");

        printf("ASCII representation:\n");
        for (unsigned int i = 0; i < size; i++) {
            if (buf[i] >= 32 && buf[i] <= 126) {
                printf("%c", buf[i]);
            } else {
                printf(".");
            }
        }
        printf("\n");
    }

    free(config);
}
