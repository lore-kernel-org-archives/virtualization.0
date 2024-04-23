Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3678C9A
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868885; cv=none; b=kHgupIVrHxuevx2OpuFNwpjnAhnwx9T69F6zopAzOXyJXMqNNCM6EaYU5fIeQXP84xhBOcrAC7uUTVJHdY94w5tr9wwiuHF/USMMUks7rKv9b3pEEhGN0WdYRDG9z11JyXqEd/IbfnxgRMdAw9fk1/baDMlKOtq7BsjCWMf9sc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868885; c=relaxed/simple;
	bh=skJZVZU2JBI8WGJ+4NhCiFRl3ZLQsAGK0b5U2Pn3qOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ0RSzukkadq8PmuKidZ2Ek5a4ochqUftvNo5Fimh9HpQX0qrXbaTw3hNZF2v2cwwEU/Mfx6+/+Z1dhSVRHn2wfTDrwc08FGAVk1iV2MjO06Sa7h/lxMcvVqs6/0XGMDUpmKWUpfMBqQfDVVAlwDBo0zaFzoGptH7YR+blheNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aPTuKjmk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aPTuKjmk"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso7663446a12.3
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868882; x=1714473682; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=aPTuKjmkUczXrevotFj6n8awxHzNwZlb81Gfd7NdJm7U84gcki9BjC+kLeqoWAZ6BS
         5DYpciW0ZNyh4/Dakp47CBZJ73eLf2FOpQ08suGRz3utl/Lr3fHGkqzfs4mjaRE3RADT
         IUbs9uggByBI2vz4FVXR/dMsnHa/Y5KQTXjJdvS+hZIv9J7NqtzYPru70y/l+A6+falH
         i7DlGxRQNu2LgBQnNrnGhAOfx3VacqWT4GQcbKENV7ZReCA5ec3cuGdPnBJ0ujITmHcm
         4IUYDt0fynZKlhXOZHskrfBrX4SJbCKJTYTKH4ayPuXPMzVsbbhXaBNE2zgAUApaKXpU
         PTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868882; x=1714473682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=SZHje3nlktWyu9YweBQiuHec+yTvcKxpV8h8LEu/HzspXzhzBPBkdajk2PfjfatsRn
         +eoROV20WQ0SIVCrSTOlpZCXtu5eG9zWNQNT2aUVBO08LRBX8IQcOv5NOMz0UKe601eW
         FqqBJCmeLY+r1al18KvuKSKm6MXsUlUXrGacl6kSnZdAhYq/khwo3vnG4YY+MiPXHbEr
         z1jb+iWgcK4kziiiNx6tD+SdYE3i3xLfh/oRWjk8JLlUWkkcgRa9W0l4WIzKjrtkFHwa
         vC53y1OynZFuFoO5RHUQdeFKJXD2M7KeYbO963vvHEwsbMEAqoET5VP3MRQzqrGQ1Om+
         kltw==
X-Forwarded-Encrypted: i=1; AJvYcCVqWr3JJc26HzJCjX64FeWpYjpYp8TaC6hK3q+s+SS4Kb5ANDPZtknyFocEmtKNv18VgXkYWypIKKrontYOh+annzF2v492WE+huVYA8Bk=
X-Gm-Message-State: AOJu0Yzo+IE1g/fBcDUXl+jVzaLiWwgVTGBGcwxmiraXCcZFsPsTP0vE
	DShrMEr77H76A1a3vDpWKVirtH1+aj8PKEKVxLDSFtvAPBzeIrj7gTJT6KnpVX8=
X-Google-Smtp-Source: AGHT+IH9gXunuU/J5xzGqAVceintwfiAZYNFxqLDRge/NzifRKTF5QZg7qXyi6QexPnSbsuTD1icXA==
X-Received: by 2002:a50:8717:0:b0:570:34c:91cb with SMTP id i23-20020a508717000000b00570034c91cbmr9656056edb.32.1713868881992;
        Tue, 23 Apr 2024 03:41:21 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id g1-20020a056402428100b00571bbaa1c45sm6428717edc.1.2024.04.23.03.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:20 -0700 (PDT)
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
Subject: [patch net-next v5 repost 3/5] selftests: forwarding: add check_driver() helper
Date: Tue, 23 Apr 2024 12:41:07 +0200
Message-ID: <20240423104109.3880713-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423104109.3880713-1-jiri@resnulli.us>
References: <20240423104109.3880713-1-jiri@resnulli.us>
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

