Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB715E5C3
	for <virtualization@lists.linux.dev>; Tue,  2 Apr 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092911; cv=none; b=NX7uRRDV83hjYctt5G+BgfcmPfJlwxnimaP2TNPXmU/vJ+QAfAa77DyG1kd9Lw7c+wKfk9gdx39hqfLp9uPlMICW+UXEsJdQYhl2m/dZ2XnAeJVkdqVFryHPgpCBP85/pNxYA/vaRHHLAkBx1rRX+b8NMSqRDBtL9PYB82UG4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092911; c=relaxed/simple;
	bh=CeTf1GnLqEGbq7mpbpnjAmCKKQFZ0fqT+cHVafZlASk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JKnhyyD9X3cJZFOGCWAzrlwpNl1zdVkRmvmJkikdOQbhVbX0hkAoa1IUAMtuNGM/UGSqGcDZTSbSyUl9uY5EQlY5idd0oCKPDMORQqqSu/dBCL8Tx6E2vBTDsL1yAonN4ZrXPhYE5hHg1QNtT8l2/D3JuS5CZ3zLuZOvYxzhMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfCdzcri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfCdzcri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712092908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=L+alDoiqMN7Nxu8CAo+qwAjzO+OBQsTVsBJwYvjZdYY=;
	b=RfCdzcriacYhsrbVzbOL+yyex4NXtv+mSZS0gTqfuC37QHrErSKAU9gbR7BWBgqfUZKYxi
	3kTk2wmOXzT9oDauMNNRaKnXzqeeFV+WSqnvshyXjQc3zSt1c0FabGn1Z0aK4NGRCT6l5T
	EoMvwEGfEllw6kjkRqe72Qz5ncE1lvA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-fd3rbz6fM6G8CQx70eFOKQ-1; Tue, 02 Apr 2024 17:21:45 -0400
X-MC-Unique: fd3rbz6fM6G8CQx70eFOKQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3435b7d65efso757938f8f.1
        for <virtualization@lists.linux.dev>; Tue, 02 Apr 2024 14:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092904; x=1712697704;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+alDoiqMN7Nxu8CAo+qwAjzO+OBQsTVsBJwYvjZdYY=;
        b=GB8SEJqCRH8uT8MT5JEmZ8wdY8P/6TwWZdFAOZec2pAO726yxtsnXLcDJxZxuF+9Wd
         HdBFpXLm9YGfkcWDvvomWVFg8AifoeviC38CV8wXD0eqwUW+npHfo7uK8uq25rJsUBz7
         Je6d3s9EIh+rQcUJwt7P/lAcYor4AxioOh+hh1guuyTkfPb/uitRXJ9gFFLQACKQd4yr
         exb3wUO07WG1Egv7IV5w1ENcCu2vr4dibTFdf1KivVO1WmA2vGAXr84k8Ru5XzVw1Nua
         7ok06T4zxd0/AcenOdcJrETJbZtylBa3E+fvJgKaOLUjYoV9AmloGdGkUlmGNMc5FWyh
         Lq1w==
X-Forwarded-Encrypted: i=1; AJvYcCXq4AI9jojnsgUW4mHBNjbUZbOlxoAG012Zv12hNbCtyg/rhkWAxcaxdTeNDDxat5Aeylz5tPiWOKC2xnVdds9HoxXMmjP+Jo8VJWaxQMI=
X-Gm-Message-State: AOJu0YyhxFc/eymWHTTzBSKbGdgfC4+ebDrBITn9xoz2nHfirwc/V8JR
	42IucMOor1vNn16k4YdVaYHvVBiPCJi75pMgE0eiBhk3Rf5qdU32W2Nm1LD0muxbrCcJH6mCD5u
	DyXGB0HVBonpOuhmLZarK/PR0xmUa/Bz+FpCBhdpJ+5PHH125JmSS9MfoTDM1VdNu
X-Received: by 2002:a5d:598e:0:b0:343:4c43:b38a with SMTP id n14-20020a5d598e000000b003434c43b38amr6924826wri.17.1712092903836;
        Tue, 02 Apr 2024 14:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoLR2TiY4NlePQYEkpCrVsZpefzcsOU3LO3zWyGpNr1faKWUSZIEppdou1j4Es/gmuSNpz7Q==
X-Received: by 2002:a5d:598e:0:b0:343:4c43:b38a with SMTP id n14-20020a5d598e000000b003434c43b38amr6924812wri.17.1712092903398;
        Tue, 02 Apr 2024 14:21:43 -0700 (PDT)
Received: from redhat.com ([2.52.21.244])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709062c4d00b00a4df82aa6a7sm6888784ejh.219.2024.04.02.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:21:42 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:21:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE
Message-ID: <41c1c5489688abe5bfef9f7cf15584e3fb872ac5.1712092759.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

VDPA_GET_VRING_SIZE by mistake uses the already occupied
ioctl # 0x80 and we never noticed - it happens to work
because the direction and size are different, but confuses
tools such as perf which like to look at just the number,
and breaks the extra robustness of the ioctl numbering macros.

To fix, sort the entries and renumber the ioctl - not too late
since it wasn't in any released kernels yet.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Namhyung Kim <namhyung@kernel.org>
Fixes: 1496c47065f9 ("vhost-vdpa: uapi to support reporting per vq size")
Cc: "Zhu Lingshan" <lingshan.zhu@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Build tested only - userspace patches using this will have to adjust.
I will merge this in a week or so unless I hear otherwise,
and afterwards perf can update there header.

 include/uapi/linux/vhost.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index bea697390613..b95dd84eef2d 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -179,12 +179,6 @@
 /* Get the config size */
 #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
 
-/* Get the count of all virtqueues */
-#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
-
-/* Get the number of virtqueue groups. */
-#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
-
 /* Get the number of address spaces. */
 #define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x7A, unsigned int)
 
@@ -228,10 +222,17 @@
 #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
 					      struct vhost_vring_state)
 
+
+/* Get the count of all virtqueues */
+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
+
+/* Get the number of virtqueue groups. */
+#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
+
 /* Get the queue size of a specific virtqueue.
  * userspace set the vring index in vhost_vring_state.index
  * kernel set the queue size in vhost_vring_state.num
  */
-#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x80,	\
+#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
 #endif
-- 
MST

