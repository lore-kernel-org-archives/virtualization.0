Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC71A08AF
	for <virtualization@lists.linux.dev>; Sat,  8 Aug 2026 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786188312; cv=none; b=QdZoFT/TOpbyU/v0gFSOGkObYx30BOQ3B5hmaWPUIgzY9r7CRhH81pLCTFydeQdCRvQbFTsUTbClpjuspwl+T2oITzzwkP4XwN6/eDqMSHYQJ06UuNhpJwkIY5v+IjbVTKdJdUKjGJYoR1bKrvajfQzBtFZiU8mi0n5CibsyvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786188312; c=relaxed/simple;
	bh=S06gw4GaTWEIrO/scYSHRfENLicYT3okDY8QqVj7Uok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WdxaNq9XsYrr0wqV7xt3EMbuwdr7sXEOWgFyE0s5rM7fRcMvssmL4zyuzuf4dL58nIAdBjoEEY/RPXRRqQT+kzZ6k7cHzAevfs8nOqSRiWG9C3/fpc6VB49sI++3m+07i/qJEG8PRIQYE8m/ovpMSSYSfxOFzTEWl5xZkwB6Xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWbRckPG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWbRckPG"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca88130e09aso224917a12.3
        for <virtualization@lists.linux.dev>; Sat, 08 Aug 2026 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786188311; x=1786793111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1TJD+ZNU8p0QF/zIOcyyYdEmIZzKa2aJynIM7jFFyUQ=;
        b=NWbRckPG15+C7alMT3zXlzKfXmREynt8+OR6yodeIGOAFJvfblJMrlAOWEtWW3rFut
         IoV81iSkHfWhs2q0QzcLJWqQN0kL7vBQ0SzkcFFidRqupeUnb/p21I+buYwT+GJ/umMI
         UItoEzSK3tKD5pgBn28BXEA2vbesYbBHqo7l2CPEQ03S7FBI4SmUSs9qnmK5gGrPxIBD
         taaXbWqjClMI1N/ZI369MFQ9dUkfhlrtr/ubaa6N/UjfRzqEOmaVx9sZDjvjBBe/N9/A
         zV+IfKe5JHUfkdx81CUXP8U2ByUFGKzuHBX+SNkIbqkwQo3h6zlu8JjsXAhDCx/wlOWk
         M8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786188311; x=1786793111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1TJD+ZNU8p0QF/zIOcyyYdEmIZzKa2aJynIM7jFFyUQ=;
        b=DEx1+FCqnWtacx1i3FcGUrVzqPMd0XydIb90zSbHJV/Yh4DB2oUuEQ0KUbkQCWrH2C
         6puAenF47d1n4Go1r/Y5oK3vlC4cU6B+3GK5EueHQChjJijFhehUM2NwGFz049JiF6ID
         Gxcs7oMAjcJ4nnW/aoJl1fInpOzYnojIeYLgCZ/rghIhrjoxfakiz9HKhhTqkD5KgWjM
         jD48f5/ORDoKgJ1MSHQB3t2qp3Ed5+pIguXqQPzoFH4FOkuM3/72GEOJOPkmEgyGU6Xd
         G3Xj8gt9EbJZD0nV65eTjbahWNu13gzovoYu9bPlx1lT8EjnZAxGik0JT7xiqaqUTp+d
         DhfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrT0LJ2tutPpMzo2IokD2tQeQ58TaXz+TNFhR82tlVFkJekPQhakraMrIseZ+Vhp7jQGwjNnmunD8/lOxuWBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWWVuHBq7csfBAWKh1dPTZUQIYVo8HyokPm7JuxXF8jcSbFhdd
	jrf3Yfa6YPsNJ7/MU86fNX9VzIP/Cd0FjNXTto904ka3Uuzoq+qaXbLL
X-Gm-Gg: AR+sD12EDUgFiwuLUpT6hESPzeOkKxYLAHJbwl/utcxxbPitbyBnLWLhXxSM/JRVU9O
	OpHGlrM65tyB6U3TQ6GauBbkK5XN4MV9fUYwtxM1p4eGF44vcfl7iTg1lrDbQ7ojuRxccmTXisI
	lhKO/jztBDpuJc19vOUtzQ6ORXYJMVWRV1AJx2acyQpQnPZ5KS+q29ne9MToMOgOpj4aEXwDwqL
	nb3cC41z2Ges58lblJ1XMzCSH2d1F0QQl4pqJy3754fX/spVjIYfQp6Y08/+5qoac9pWduwhZmQ
	Ms1NFVnS8vHCwOy5g0PHvGFFrGvv5qqbIzUp/Z8DOGATVUh90ELxxC5qosS1k7RZ4m+00HCW51k
	9RiG78BsOOCSynTMfsm6bxafX54IUvwcOKrGuaRA4yJW4bVryS0FJJoV06YsACvuCFwbKMg4DjN
	dKs/SNO8S2IIBd1YgNxXK2rWN5s3NeR53qHq02UGO24pMEE3+SUFy1D2CCUPvg/EJw7VymDlc=
X-Received: by 2002:a05:6300:4045:b0:3bf:83f3:b810 with SMTP id adf61e73a8af0-3cb85ef7f63mr36662806637.29.1786188310005;
        Sat, 08 Aug 2026 04:25:10 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebee8d0sm17746334eec.24.2026.08.08.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:25:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost/vdpa: reject VRING_NUM larger than device max
Date: Sat,  8 Aug 2026 19:24:58 +0800
Message-Id: <20260808112458.101616-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() only requires a non-zero power-of-two that fits
in 16 bits. vhost-vdpa then hands that value to the backend through
set_vq_num() without comparing it to get_vq_num_max().

A local process with access to /dev/vhost-vdpa-* can therefore set a
queue size larger than the device advertises. On the vdpa_sim backend,
the worker then walks descriptors beyond the mapped descriptor ring.
KASAN reports a 16-byte out-of-bounds read, corresponding to one
vring_desc, in the vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Check the requested size against get_vq_num_max() in
vhost_vdpa_vring_ioctl() before calling vhost_vring_ioctl(), and return
-EINVAL when the request is too large.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v2:
- Add the missing Signed-off-by tag.

 drivers/vhost/vdpa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa0d0..b2083e1ef150 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -716,6 +716,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				vhost_vdpa_unsetup_vq_irq(v, idx);
 		}
 		break;
+	case VHOST_SET_VRING_NUM:
+		/* Reject sizes above the max reported by the device. */
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		if (s.num > ops->get_vq_num_max(vdpa))
+			return -EINVAL;
+		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-- 
2.34.1
