Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2976153561
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799992; cv=none; b=PNbR61ZjUPsL5hlVqD1qZOYpTJ3R5ArYLwMzBEvlNmUecAk6dn6kS9VrNjCzzhUXtD5p/2M058WzF3p6nC687SZWg2OCPG6y5QB/EIcg26RBoklasgXy8EDbzpoY9UXqq8zQGXggXH/BO8PQ3AhMuKueJIKFdsNuuwFxdnQ1v3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799992; c=relaxed/simple;
	bh=skJZVZU2JBI8WGJ+4NhCiFRl3ZLQsAGK0b5U2Pn3qOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2kWuXd+NvnDGZNqmurw8R1cAZfhUGkDBpw3aDMaa9jq9zo+74346okqs/KGkCPXOf8bl/cjkkS245W5t7XgCoqnTDOCO/pF6Hp8OhVb1+qQy3wNDhquo+e76ulQdpFW9fqrWrxgQJT97JFWMpPnPpkQqtiuHECalXWpW4ADvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ymgT8een; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ymgT8een"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so6061587a12.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799989; x=1714404789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=ymgT8eenQnF2gi6tziZc2jOXxH5EJUQuKmxw2uWuTo+Q4voEE8Bc258VEReZU7kQef
         5lBO3Q+1jROcXdusxZylTX35FJzgdki6yK1GHY28Hs1hnYuUYsURodzgNM7q6W5A3FPY
         gwGXzRn/g3Meu2JsiGYHtE1xWLpit/Rt8w6UsbR9y3Y5FWDybN5Wm9l8mG7RN8CvFJSJ
         qMuFlh2uQNhuRnPhOE+youBcqblZxQ1ZOxPM7ywa5eGK/7UJp0jPCbfjvEI7nBiYJWmQ
         denc2JeNR3vsEnQ8nhCJyyYPH2oBr0d+hUt90+vzQRGyGF+3ulvnq+Z/iVGXM3LkzZ0w
         MByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799989; x=1714404789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=cQzF/v3Tp6jaodySlCGljvoOk2ouxgIIzzDT0qyWBTRkP50LqKj4LgAnbSgEvFQHZ6
         AApbo06R7hRUkhsJY+V0nHjf2wBhQopFV/LtlFrGPH5fOSjnyEwnl/GrhQY0COH8Ckap
         YkPvCjUkWHY3AMhCNST43B/8cf5fr7rSbnTwRy+E5XZoDQoqPEitRASr0u5185PWMioq
         qXL9kmxk/HC0ZoQcmDAs3oe9iwlOGSGa3cMMHvJy+x4u2xp3+qWb/xNTIUBEMJNcQg2f
         gGWJR+di5ZaGP0Ax2fadxN9G4qq9bkpNXEKckLnoTVLUXmadGP4J9LMuYjD3o+yLv+aL
         WRUg==
X-Forwarded-Encrypted: i=1; AJvYcCXOrC1XcyMswB1qT7yH32Pbz9DCssxOT/da9vQUiH5FS8XSA0zlyzgWqinpSU54qP3AIOrNLjVQDS2hyaVcg12YGU1EC7wAUyUM+Z3AjIE=
X-Gm-Message-State: AOJu0YyyXvO53rBX2jgPv3zaUxN4D8wx1PegFZoyEhAkbT/Cn+kaXdC5
	P/mCWCXBt/q0+DZ/ybLaRbPx9cmZSv+WLfnHxh93Fon+Nv28edFL2fSVOfmUf0Y=
X-Google-Smtp-Source: AGHT+IHiS8PFHdDPbSER4uV1DnQ3cF2U5SMqkAyux8sxGiCt0YEkFKykDoxzO5Jsq4lWpSkPyp+UBQ==
X-Received: by 2002:a50:d4d9:0:b0:56e:2452:f864 with SMTP id e25-20020a50d4d9000000b0056e2452f864mr7375041edj.35.1713799989283;
        Mon, 22 Apr 2024 08:33:09 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b005705bfeeb27sm5619252edb.66.2024.04.22.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:08 -0700 (PDT)
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
Subject: [patch net-next v5 3/5] selftests: forwarding: add check_driver() helper
Date: Mon, 22 Apr 2024 17:32:58 +0200
Message-ID: <20240422153303.3860947-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418160830.3751846-1-jiri@resnulli.us>
References: <20240418160830.3751846-1-jiri@resnulli.us>
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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9d6802c6c023..00e089dd951d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -278,10 +278,17 @@ check_port_mab_support()
 	fi
 }
 
-if [[ "$(id -u)" -ne 0 ]]; then
-	echo "SKIP: need root privileges"
-	exit $ksft_skip
-fi
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
 
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
-- 
2.44.0

