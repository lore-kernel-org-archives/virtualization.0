Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2428506F
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017227; cv=none; b=XgtPN/lQkBZq1p6SKaKJFKJn/FSQrwwykOqxegzRNn8IiGGJkELt73lybJduiRyFm7VH9EDg60ocqEzQcZj72b1g1O0Cfb2/bRqH5KFajgeRSSh2gtO4efs9IE0zbNxJKG/IsNJwEbbzEh7upC/q2Op3Hblfx7ltd0zzW9yia0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017227; c=relaxed/simple;
	bh=8q2gl7dKVCvfHUjaXSuSM5bz0HOxw4acBIP28qdKp3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1G8Um7zsNSHFoYPJ4gLwafL+LU8bRJg2WZe1LcXq3DOWsQXy0JjIOZAnsWKPBoe75+GwNVBWT2j1wZkuYspVjkbFnWSC91xKgozyrv/u/eoP/Re8lEc9w4LT3C82g0bqoFwH02DAttgD0ss9I8OC1LMFzwU3GIPy4MLYMDYS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K5f1cT1U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K5f1cT1U"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7a23f5915so26583075ad.2
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 23:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770017225; x=1770622025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSSsmhlhcR3hnxi9j0aiqQD+QrzZ0ETE1gI+27iXB7U=;
        b=K5f1cT1U/hluH6zMSrYbKS9nsadEPikTOVibalykwhll3P9jMjqohPbz3MkPgwgVx5
         NFlhI6/kNAYeV2Bjb1vZMhUIY+8Tw47BvCYn9cisAK1U6H9edMXU33lesbnZPuP/QMir
         PKM7OX4xa1/lFFt8jsGcZqt0RRc2a+P7Uxm+pNOkIsh0mMWpnc8jfS+xkyRfb1JGGIOb
         v/spIjMxpWy6mflvmkq4PzMNrq4OItcCLTlyjOWjuyq07MGJWpC7yt1cQfh+8TVwpqaf
         h1o9U0Z2neLH12DncZoPZkK3GujZTDYHLuF4q8axyK6SUDD6eMKtPyuxDc/YmaP0JGo2
         40ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770017225; x=1770622025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSSsmhlhcR3hnxi9j0aiqQD+QrzZ0ETE1gI+27iXB7U=;
        b=mIdGpUYALnnEExuwBtRREbv0SfF2FCZ1jd7y9yjpjophiCwK7i+3cCB1lsSBeoIVFl
         OPV45UtQ8YUXaNv4Jm83ByBPW0qod91pMFejJu95zj7XhWihcY9eZUflcmOcMrcT40Ax
         7AhoHOWtVUd3MO3DPlEldSlsDCfL5ti/G5/qeulKoqMe4ci3/kDZ8hPfifW3mxnKDJfb
         IT7ISCofcScLE/L4eMQeiR7OnswD7yFgBMRylamr+VzBMRl1YNLq/kInuVfFEdSpGVg5
         VTW3M9EjybprIvVWknAHvRpazeUi2r+T3alH2/uLohuouueMDDY0WHZpPB8tgbSlaHWl
         M09g==
X-Forwarded-Encrypted: i=1; AJvYcCVNhrfV/UYjMNu/0J1pWf2mGNA3KaY6yVIWEYPlSgaQpnfg2/AuOqKFVk5Zx5vqATCvglpP60d9sr6on/+0kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCA2PQsZV8lXMtWJBFMYGkcq9L8S4E7JJQOxQZd9722RZhayW5
	7Mb7kn6SHvTKnbTv1VITkx/HSkhz/utJq+iAbAPzKq1hMjIrKXhGiCrDW64sXr/9cig=
X-Gm-Gg: AZuq6aKz7WNjr4uJNRVJeHH+rvrnLCPJgBodl2ckWxaXIaKd9+PgwvlXwEZN8MT6fsH
	rCwqQmWGomVVKZCZ3MWxSrD9emzo1VORRJbDqQEXdiGdnV2tW/aYSpsZWLQVRk/NrI0APHRde8h
	zhFM0hFAv+JyfkdmlFcgaDtpP3HugxqxkNpa3WC7/vLQdXOsSDn6sahRqt/s5eCu0Ca7yPr5jee
	DaFXiCboNXBWIhrfKDvGPTIJZtTUKUpZdD9Q0UBIW30uUHNStX86pBrHy8ktEZNgjbjiU+8BwYz
	KIX+rBmSNYA7jndmcY62XKxuMug2Gql/401njjOd9UIG9xwm7Gg80TsnEJclEqYTUKHqymgSyWq
	W4uYYZFJjDi/v4dNWM/ygaKfOvhIpCtA9eDqJDqltZzbC8pKtrGv1bDCFb20sbESZ7NaO96ysL4
	FJz7LRLN8dNSX6zSUNRX0D+Yn91LZeGk4Lzhd3AIrj9rMs5p01Mk4glSyL
X-Received: by 2002:a17:903:15c7:b0:29e:9387:f2b0 with SMTP id d9443c01a7336-2a8d992cdeamr102469105ad.39.1770017225013;
        Sun, 01 Feb 2026 23:27:05 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d88f0sm145352365ad.67.2026.02.01.23.27.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 23:27:04 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	marco.crivellari@suse.com,
	anders.roxell@linaro.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhang Tianci <zhangtianci.1997@bytedance.com>
Subject: [PATCH v3 0/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Mon,  2 Feb 2026 15:26:53 +0800
Message-ID: <20260202072655.95143-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Add first patch.
 - Link to v2: https://lore.kernel.org/lkml/20260202031212.26871-1-zhangtianci.1997@bytedance.com/

Changes in v2:
 - Rewrite commit message.                        [Michael]
 - Add Fixes tag and cc stable email list.        [Eugenio]
 - Rewrite one comment.                           [Michael]
 - Link to v1: https://lore.kernel.org/lkml/20260130081524.81271-1-zhangtianci.1997@bytedance.com/

Zhang Tianci (2):
  vduse: Requeue failed read to send_list head
  vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter

 drivers/vdpa/vdpa_user/vduse_dev.c | 36 +++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

-- 
2.39.5

