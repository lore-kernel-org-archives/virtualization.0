Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF28171089
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372371; cv=none; b=cXWa8RCQcGJVg0DL3Ne3sQtBCIc4/IjgvQGuAovHSNIQL83q/3KVOR9s5/04hfx9iI3ZvCEG9rmx3N0JMzmHBLmBAQymAkj5aZk9RZDbh/hivxinZlJcUNbLLejfq9FB0+Fo/ELvwYPzZhgTmFa2CqR6XEIS1SExgJ/EknM/TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372371; c=relaxed/simple;
	bh=cYWBkuVz2OqTjZZvkAAucx9ew5P7UCkfTJr6g5UPk0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/b096RdkHBp4+VS+KUwat2ueoRjdmVJFCqPyg0K0pXtMvza1z+/hrp5xdV+byC+x2Udrgz9DfHYct0dYPyVAJ+taBD46O/1ngQ/UVrS0C0qVj72deUNvk/m1dwRm9h3zrFviHDkTpVWKxAY25hF/qaNFEipW8E6N6TGmUsZYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E6E0hslz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E6E0hslz"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5568bef315so14507666b.1
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372368; x=1713977168; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REEmA/tIzrZxHwQ+eJVrb/dkT1DH8bvTei1p22/X+z0=;
        b=E6E0hslzH3OUBnx3cspjLkPouYuEav+pYt03i2ERZCseA8sIVU7nvkvYmbDEyxWdTo
         2A8a/InYkQATTsfvF9vHFyKgdn/lOJPAhYOrZgSWnxh7OdOSYwerSWA1x6BSSOfSZlVR
         JwiATe3jMwXUG54Vrkjd7wNcxgLGzWGjBdf/GUET4i0nEgEAyccWgg87/8PcMuavvkTF
         BJ9OO6VK7iUkFpmqx6ozMITjiURS9GiSMvozSE6RGilt28715Xyv3sfvZm5AlSEL118q
         Iuz57iHedbPDzSp8aEXEhy18M2sPTCdLN5sLrn7HpQymn57ucTvT9zKWYZu1z387NmVz
         O9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372368; x=1713977168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REEmA/tIzrZxHwQ+eJVrb/dkT1DH8bvTei1p22/X+z0=;
        b=fIRpsIGMgMRiqJsyBZt3DSYXF2SyuEHDhv0M/RGROTAWrQ3EHmbRYXldMn6mv6t1NB
         7GMzYA7h5RS+a+uDq028OoxQ4DoANX2O8aUHJhfP4SG3XfzwagPBe+z7tZjkVAhYIIs4
         JWA3wKOyianKLDidREt/N+YkanbrazXjqEOPXuknDQRRe32qAEfZhXR0vFm+PJSd9mEX
         JFdAmIoZohyqO03N1XDyFGVAGyS+KeaGEoSJZdfOn8K36WBYuEL4qzbwjkhbWUVMEV4a
         vyVtKQTe97vN001n9Rgc7LnAHW4IC/r3sAdAUJCuo1SPuzp6PAxVIJaG27f1jw5sHkw1
         QHAw==
X-Forwarded-Encrypted: i=1; AJvYcCVjod8SW0HqHdUjWpZyL1YHq7J/r1I5l/G7YmKnoFhUzoSpHBhc1Yqx7XhmlEyWyHWXNkTferw2DOWG3cWvRtUXCV3SUF1FOIq64P5D17I=
X-Gm-Message-State: AOJu0YygsHvY0s/ocujbcTFxanrXEKMPnUR4qtn/fOWRQ9wplamiulU5
	5+YFjtW748jL9EyeFjux7Hx1yXgH+uVBUqIdVu5gjdUqmP+AZEUkgTa7lpSAA2o=
X-Google-Smtp-Source: AGHT+IGPBnih1hbsQxAuPoauf1NR1vbfkoyGDLPTYY+zGlT9YkwztfAahhP8SZeYG4YKDO26lfsOCA==
X-Received: by 2002:a17:906:554:b0:a52:30d4:20e6 with SMTP id k20-20020a170906055400b00a5230d420e6mr4536310eja.10.1713372368374;
        Wed, 17 Apr 2024 09:46:08 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b00a526a99ccecsm4161102ejr.42.2024.04.17.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:46:07 -0700 (PDT)
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
Subject: [patch net-next v3 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Wed, 17 Apr 2024 18:45:53 +0200
Message-ID: <20240417164554.3651321-6-jiri@resnulli.us>
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

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- reworked wait_for_dev() helper to use slowwait() helper
---
 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index edaec12c0575..41c0b0ed430b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -745,6 +745,19 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+wait_for_dev()
+{
+        local dev=$1; shift
+        local timeout=${1:-$WAIT_TIMEOUT}; shift
+
+        slowwait $timeout ip link show dev $dev up &> /dev/null
+        if (( $? )); then
+                check_err 1
+                log_test wait_for_dev "Interface $dev did not appear."
+                exit $EXIT_STATUS
+        fi
+}
+
 cmd_jq()
 {
 	local cmd=$1
-- 
2.44.0

