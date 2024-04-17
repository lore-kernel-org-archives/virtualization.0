Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEC17165C
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372366; cv=none; b=e5RGR8IxYidWJoSE+deZPkuSR95pMAvKY12iy2R8bLp7qVlbMi5+6/0ndQVVhVe3H1Xs1ysh4dkXX+HzpKuB/N6dYp8tBoyqTF2Jx83o6n4X94A7qLyJMyzTg8tDoHhpxy8kjSlAym7ly3XbEPmmAeg4DjLCyzFpulv7uCUfsnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372366; c=relaxed/simple;
	bh=NArpel64x6HJ2BR6Xpz3gBx1vpaFxO5gSoTpsKJXupk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R95u/zh8JJt+x2yiML+PoTXRdYa9BQl+ceU3LhfFS+IpUnH7b3dWWcTMo47AM8oix9U8D9FZxkYYQFB+E2wuLDs5UiuN3tLU9y4/7z3w0WQDwgIOdvWpuvqG+/+C4CKmAM2uvTVyvBOEoYZq81h3c78s0i3b+RoYQHLbg6QK+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O3KHwjSO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O3KHwjSO"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1882121a12.1
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372363; x=1713977163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iDSoNx4io0wz5kFgpirLfiENKR8M2isWO5Sk2gRu9I=;
        b=O3KHwjSOxOFaltkzBwHfimbhdr9KALAXXVdkRAfz6QHoaxqmji1VlvtQW6JauHQ06y
         ysA0Y70W50m0HtYPsWNHPXLiq1o3+6JlPbtgrY4cfu97gT9ItxZ/l/lteBQ/3YnajEfe
         6Pfy85E4/MgNX1XqTTDE8YCoY7mbSeuO2+oywZXh9PxhJ9oRDN+55Qj2Kjse4Qd0Cw3E
         qPxJiKgooGafvGl6wQGvClMsquoIZtEmjKT0geMJAp/S2gyQc1Mq2KImRpDkych220wv
         RBk1lQNkuk9j8xVKPhQ1yFTkBnoipb0u/JTJwc4in47bkBhroqNRtBsscSw3evjTgCV4
         MR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372363; x=1713977163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iDSoNx4io0wz5kFgpirLfiENKR8M2isWO5Sk2gRu9I=;
        b=FUUU+HwTSpELp2jEns3kLc7BlHbHPvJLNEs9rtZwdTLQSrhIym67RPhcdXGjjCjM9i
         MDfRJIg1qQt3MZcSIFPJvixMSBEMYnJCxhHq2chGiaKvL0cZ6x5Ac3b57z8EoMJ4zjDl
         IVgKDqDh5Co3yxrGWtNM+1ISqTD76yK6crsPTx1s/T6cg7h6M1TitS9L4AKr8sfIIER5
         GgiHx7XSkRV4FPKitfIazdXIPiyV9023Jq4iA6qMmu2/W4RzwRt2gWoGRSfT/DFeQ9i3
         H5BK+o4pT6kmmys+zlzQYWV9+TWKeHH9U5th9F0sDXv2p1F7fjTReRr8RlA6x3FtbRK9
         wWaA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1Sh7PQh008oR/RHTMCNgZ72+5vf8inuQ7+7YQCBSjwEzNK9ANZ+HjpEXDpZdpyHP5d5WAGTqZGJlbdivYjBhLtUHXFIMH6vFzTP6PzA=
X-Gm-Message-State: AOJu0YxqJyexO3EZyYr8HwWcLLTPFt164GTnKsPu3nVkqNgBN8HHcTuD
	8C2HBrY+VaZpCalDbEmvz/SzWhtjqoizoioLgvj2SjHEhaP963Zic62qRgz1aWQ=
X-Google-Smtp-Source: AGHT+IHZlMqMIGtxRS4VPRipmPp6ctstGqWnjPeHHS6MRuX7c9jXyizMoNyEw4tsWSDIIz4pcqv8hg==
X-Received: by 2002:a17:907:985:b0:a51:b49e:473e with SMTP id bf5-20020a170907098500b00a51b49e473emr5476534ejc.19.1713372363586;
        Wed, 17 Apr 2024 09:46:03 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id ox2-20020a170907100200b00a522bef9f06sm7720607ejb.181.2024.04.17.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:46:02 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v3 4/6] selftests: forwarding: add check_driver() helper
Date: Wed, 17 Apr 2024 18:45:52 +0200
Message-ID: <20240417164554.3651321-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417164554.3651321-1-jiri@resnulli.us>
References: <20240417164554.3651321-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index b3fd0f052d71..edaec12c0575 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -290,6 +290,18 @@ check_port_mab_support()
 	fi
 }
 
+check_driver()
+{
+	local dev=$1; shift
+	local expected=$1; shift
+	local driver_name=`driver_name_get $dev`
+
+	if [[ $driver_name != $expected ]]; then
+		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
+		exit $ksft_skip
+	fi
+}
+
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
 fi
-- 
2.44.0

