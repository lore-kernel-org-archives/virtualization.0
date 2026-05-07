Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82223ACA6F
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164124; cv=none; b=D/jkOXgADQ2Re+iELHMBf3Imp/3KHmk4cATYLja0qTn4e26q382HLo6yf+SfE5xh55hb1othGk3MNsNSfrEgAV+PFZPHgTNGj4OnZFN8vBZOz2cWRgrBUCi97PtaVyX9lINErd6u3UQHYViM+YkumbyKCImXqlm3Y1w2fj4ojPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164124; c=relaxed/simple;
	bh=PCbwbQNt4FGuy1Mx/UEcWlVmDbt9jGbh+cLIMf+sZ+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tbZ7YrsyXE+VMY/EP8aLJQnFp5Q1MOdK7bnO9XD14jbzuM4xz/RucAEBuagNc4LsUa/n0ftuYSfoJh22i6EABy0sG6ulrMqGoMuAlqo8TjEV2dcxbEmsyE30VW5rrVpxRvTdbERz/YVWxTgSpILb83otKRceS6q/zi5Zyt2J32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/wPjoYm; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/wPjoYm"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c19d23b19so1683413c88.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778164122; x=1778768922; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m52C9FnSjkJyGIM2Iz6ci+a0fVJqmhLXSC8+wk7x+s0=;
        b=I/wPjoYmSno8Mh15dMQYRmlGExunR6gI+HMXPst0ZxIvwHXCJHNUzKuAAX73IamTfD
         e/O4bUuNQ5yw173QFURwwxFNt7HO6m0gt6Us1QCCw70B7MpTUxn6e3CuVURZwNm/jeXQ
         jICscgh41IZPRF8ISoEoxEKj5BEgUr4XbuJzatzu413y+39EWutTKn2kaFuIvrMuPq1S
         fvrhQaTqGIzEVleXDTFewd4wyyR4MW5AtXOmjBcVS/1Y2ha4cvvLnMxL4XxiicjZN8WO
         hqFf8Zijewlx7GvC1LI0Ibk9Fj1PtQzvazd4eWjyiEG7fuqIsNjpTbgSI94iavMpzSVe
         SIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164122; x=1778768922;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m52C9FnSjkJyGIM2Iz6ci+a0fVJqmhLXSC8+wk7x+s0=;
        b=PTKjEF978TCJPX7yL3fVSZ19J95lqfVGLsQpg2zK6fA9JAz/WM0NoF3O26KiMb4ouU
         fvWm/09uz7Sx74IobNk0BwodO5YLucnrODFzqh5O1JZ083UJqPodVXvtlx/zew6xFNyO
         802Vzx4SsrO5TR6gCUjtcqFrK7eb2HEmh3dCoz6fH9awO4zL6meBo242hYwdBnu7hBy9
         KkYyMxahPB0W2FlZbuxcv5dImt6IcG2nGp902F82Btaz8c99pYwnOtQpvCFJ7UuNYwZD
         BEY49cg1gzRgrqog4IliGASH8GO6H0mx6FR0nrawh8ycPL88tEyLnPaVoYDT3japkGkx
         tBOw==
X-Gm-Message-State: AOJu0YzJZcAJfI/QYluHHCQF4t6LbUZ9W81PzfkDFvzmqJ7klNmj3vh7
	fVI1xjtNRPAL3WN5ovI7YxHF5wNMHq/za7iGf1uUKgBtnVP7Rp8RJ0mb4cnC9e48
X-Gm-Gg: AeBDies/MywyiGDBwaQSmCE7bRa4pzP1kyCgiOZs1X38VszCcg5Y53yYaPYQljxttjn
	HXE+fMd/oxsAzLZ3DU+HZK8RPZIvXC2KHGVTnDBBJufM7QDxCoMxvFHJ4gYX0DCNV8CX6WtsBdW
	rBeXW6rFeQzs6Z/exLOZgoXTL/HF3NcVhVb1iofOpXzBK9JO1zkhjunjoAwhC6xS+mgeAVeUgSU
	/X30bMJjnKGUhZH22QLhoalrfOpysUscvh8IrjyeATU+iokK6obpmKATFL6QoFjZf9/ZExv0Ph0
	b+IShAnPCdi8dJ9AFs+XZFlSVgFJ0B/tzkgK7yDFBxX++cM3S0/u7lerBO2fK9onS8G8tYGEO4h
	GjNV2J0m6Iy8yivg0DnsmXx5gqJpyGapBJk5uWZQk4nZm7vb3MgPgGwjFsFvGVdgTVcx+Cthgmd
	4ZveVD93WmFbbr8KLQJBey9bmnpeIe7GE6d0G1V/PTuL1M5dTjGIULSECQnhVfsFXWzHl+OPAEI
	KdIKNn+8ON9
X-Received: by 2002:a05:7022:6899:b0:132:5e72:43d3 with SMTP id a92af1059eb24-1325e724784mr399692c88.29.1778164121302;
        Thu, 07 May 2026 07:28:41 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f570384e46sm8829554eec.26.2026.05.07.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:28:40 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 07 May 2026 11:28:30 -0300
Subject: [PATCH] ALSA: virtio: Validate control metadata from the device
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-alsa-virtio-validate-kctl-info-v1-1-7404fb12ec37@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ7CIBBA0as0s3aSiqULr2JcDDDVUQKGocSk6
 d1FXb7N/xsoF2GF87BB4SYqOXUcDwP4O6Ubo4RuMKOZx8lMSFEJm5QqGRtFCVQZn75GlLRkNM7
 xydlgw2yhR16FF3n/Bpfr37q6B/v6rcK+fwDp1AvdggAAAA==
X-Change-ID: 20260424-alsa-virtio-validate-kctl-info-2bbe3b5d5d65
To: Takashi Iwai <tiwai@suse.com>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: virtualization@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=PCbwbQNt4FGuy1Mx/UEcWlVmDbt9jGbh+cLIMf+sZ+o=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJl/Fk7cXbMuuOnqBrbkK5Ix27yez6pyilfSjmraorb7I
 N/70/t8O0pZGMS4GGTFFFlWJy2y3NP14Gp93AoPmDmsTCBDGLg4BWAiS7oYGc6kRSboX3+SH/6F
 oS2pb88fnj+h641Oul1etjx0/azE2MeMDEun6J4L0D14TXz53ZuvshrnLWZaalcjymqbkbdmRnp
 wGgsA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

virtio-snd control handling trusts the device-provided control type and
value count returned by the device.

That metadata is then used directly to index g_v2a_type_map[] in
virtsnd_kctl_info(), and to size loops and memcpy() operations in
virtsnd_kctl_get() and virtsnd_kctl_put() against fixed-size
virtio_snd_ctl_value and snd_ctl_elem_value arrays.

A buggy or malicious device can therefore trigger out-of-bounds access by
advertising an invalid control type or an oversized value count.

Validate control type and count once in virtsnd_kctl_parse_cfg(), before
querying enumerated items or exposing the control to ALSA.

Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/virtio/virtio_kctl.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index ffb903d56297..45f7b6a5b308 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -18,6 +18,21 @@ static const snd_ctl_elem_type_t g_v2a_type_map[] = {
 	[VIRTIO_SND_CTL_TYPE_IEC958] = SNDRV_CTL_ELEM_TYPE_IEC958
 };
 
+/* Map for converting VirtIO types to maximum value counts. */
+static const unsigned int g_v2a_count_map[] = {
+	[VIRTIO_SND_CTL_TYPE_BOOLEAN] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer),
+	[VIRTIO_SND_CTL_TYPE_INTEGER] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer),
+	[VIRTIO_SND_CTL_TYPE_INTEGER64] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.integer64),
+	[VIRTIO_SND_CTL_TYPE_ENUMERATED] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.enumerated),
+	[VIRTIO_SND_CTL_TYPE_BYTES] =
+		ARRAY_SIZE(((struct virtio_snd_ctl_value *)0)->value.bytes),
+	[VIRTIO_SND_CTL_TYPE_IEC958] = 1
+};
+
 /* Map for converting VirtIO access rights to ALSA access rights. */
 static const unsigned int g_v2a_access_map[] = {
 	[VIRTIO_SND_CTL_ACCESS_READ] = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -36,6 +51,37 @@ static const unsigned int g_v2a_mask_map[] = {
 	[VIRTIO_SND_CTL_EVT_MASK_TLV] = SNDRV_CTL_EVENT_MASK_TLV
 };
 
+static int virtsnd_kctl_validate_info(struct virtio_snd *snd, u32 cid,
+				      struct virtio_snd_ctl_info *kinfo)
+{
+	struct virtio_device *vdev = snd->vdev;
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+
+	if (type >= ARRAY_SIZE(g_v2a_type_map)) {
+		dev_err(&vdev->dev, "control #%u: unknown type %u\n",
+			cid, type);
+		return -EINVAL;
+	}
+
+	if (count > g_v2a_count_map[type] ||
+	    (type == VIRTIO_SND_CTL_TYPE_IEC958 && count != 1)) {
+		dev_err(&vdev->dev, "control #%u: invalid count %u for type %u\n",
+			cid, count, type);
+		return -EINVAL;
+	}
+
+	if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED &&
+	    !le32_to_cpu(kinfo->value.enumerated.items)) {
+		dev_err(&vdev->dev,
+			"control #%u: no items for enumerated control\n",
+			cid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * virtsnd_kctl_info() - Returns information about the control.
  * @kcontrol: ALSA control element.
@@ -385,6 +431,10 @@ int virtsnd_kctl_parse_cfg(struct virtio_snd *snd)
 		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[i];
 		unsigned int type = le32_to_cpu(kinfo->type);
 
+		rc = virtsnd_kctl_validate_info(snd, i, kinfo);
+		if (rc)
+			return rc;
+
 		if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED) {
 			rc = virtsnd_kctl_get_enum_items(snd, i);
 			if (rc)

---
base-commit: 5bddc5123566e6431fff826fe76a8e378ae9db78
change-id: 20260424-alsa-virtio-validate-kctl-info-2bbe3b5d5d65

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>

