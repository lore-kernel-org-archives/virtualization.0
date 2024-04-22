Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34C190669
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826640; cv=none; b=qAVAzGNQwOZHka/R1rbG3SuYJgA8kSjCIdwyWVD1g1Z0fF7AGwdAGIrjXQEYLmeOKsIk9NDebkqTmiPXMe/SBX2V688oZddAQLGY3EqbsWKxCn+Ml8NaBAS+dN6P5/HVFxf6QF6fVKcxGXbvFrjk/O4j8dTrrfg2xEvu+tyBKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826640; c=relaxed/simple;
	bh=bfFhpQ5EYefCcVR9G/dMzMdiH6v/IsMO66uK+uCQ3MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gy4+QJRTBLj/eVwFmNV0gBkisms5Mz7o1LHLzGHXNU/H+v9HFC9x+i1ACjkCXaPpE6DhabQXwEWtOnue5bCzExYoorCKj1J4XFB+R/uivV91dC23msJsyvs0cun6r7r57w7LMQcOSADM8hF9bW6QNf6iNwCMbF0Flun3cQNNuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UYaism14; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UYaism14"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-60275a82611so547772a12.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713826638; x=1714431438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJPGtZqzdd9ZJG8gTToIxNsoCLvLLMCdMU2sH61J3oA=;
        b=UYaism14CfUiXvUTDvpp8ceKWwEA7kPQKS5f21NzeN9+Ad6/S3DlYPQ291Nt96da1H
         Husy9BTLvCOZFk6qJnvHayCUWy2/oQI+YVkvmzUS0R5q2GpB+0gNdGv4dkeUzK09AUY3
         7hczQjIaiKzltBbekLX8dT3Q718rL2RTodobc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826638; x=1714431438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJPGtZqzdd9ZJG8gTToIxNsoCLvLLMCdMU2sH61J3oA=;
        b=K7opyA2V61Umz16ttG6A3n3BpxMv+iQQc4hpsDipyjdJpcpDtj2UZIc+3vj2Uxmo7G
         cJfseOlgg6JTcbtZY5DWD1G1yWZK4d3j3ymuSlXbjpGs0puMNt7i8cjqp90GFn8Qd55L
         Gg9rzpLLGqOiny9DozTwJK0JiiJ/LMzdMuEc0kw+NttbIByR7LijbyHb6QMiQCbv/CFn
         gY9mjvMuESuqsDJvcGoFlTIa25SqKb8Fys5GEtHCLkbqlRCjFvz55025q35/Z3JGhSFb
         UcMfETW5GjOmUzjlgpNIb0kK7zi5RuQ4gygc73JU8WMlPGewrJTCedeHWXivEI9vKkLt
         jqqw==
X-Forwarded-Encrypted: i=1; AJvYcCVOGTdki/FK3t9LTjK9NU0d/vQHjstEzYJZ4APpAUapRMIsENV20Pow4X5QiADNZTc4X2DZMbAXlfQuOfeuI0sayYYmxlSsqtUSp/rlaYU=
X-Gm-Message-State: AOJu0Yy93KaZaymtxeB/4zh7uI7oUaw7qmyUP8mDBh4rctfe7POf3QTU
	xt1pHTS1xVypvbSX8Fuo149ZODMFzsZHn2bnNvmMWbj6xiPeozxXAi+tf4SCsQ==
X-Google-Smtp-Source: AGHT+IGNUpwAUbtSH6ag9ujMWSWTNOmdUSXWH8FotgcUA58NTT/rC3cr+iqC9zObQedKz+chYLq7AA==
X-Received: by 2002:a05:6a21:4995:b0:1aa:930d:3dd7 with SMTP id ax21-20020a056a21499500b001aa930d3dd7mr11425748pzc.6.1713826637879;
        Mon, 22 Apr 2024 15:57:17 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id e131-20020a636989000000b005e43cce33f8sm8093597pgc.88.2024.04.22.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:57:17 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v8 4/7] input/vmmouse: Use VMware hypercall API
Date: Mon, 22 Apr 2024 15:56:53 -0700
Message-Id: <20240422225656.10309-5-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
References: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/vmmouse.c | 78 ++++++++++-------------------------
 1 file changed, 22 insertions(+), 56 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index ad94c835ee66..fb1d986a6895 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -21,19 +21,16 @@
 #include "psmouse.h"
 #include "vmmouse.h"
 
-#define VMMOUSE_PROTO_MAGIC			0x564D5868U
-
 /*
  * Main commands supported by the vmmouse hypervisor port.
  */
-#define VMMOUSE_PROTO_CMD_GETVERSION		10
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_DATA	39
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_STATUS	40
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_COMMAND	41
-#define VMMOUSE_PROTO_CMD_ABSPOINTER_RESTRICT   86
+#define VMWARE_CMD_ABSPOINTER_DATA	39
+#define VMWARE_CMD_ABSPOINTER_STATUS	40
+#define VMWARE_CMD_ABSPOINTER_COMMAND	41
+#define VMWARE_CMD_ABSPOINTER_RESTRICT	86
 
 /*
- * Subcommands for VMMOUSE_PROTO_CMD_ABSPOINTER_COMMAND
+ * Subcommands for VMWARE_CMD_ABSPOINTER_COMMAND
  */
 #define VMMOUSE_CMD_ENABLE			0x45414552U
 #define VMMOUSE_CMD_DISABLE			0x000000f5U
@@ -76,30 +73,6 @@ struct vmmouse_data {
 	char dev_name[128];
 };
 
-/*
- * Hypervisor-specific bi-directional communication channel
- * implementing the vmmouse protocol. Should never execute on
- * bare metal hardware.
- */
-#define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
-({							\
-	unsigned long __dummy1, __dummy2;		\
-	__asm__ __volatile__ (VMWARE_HYPERCALL :	\
-		"=a"(out1),				\
-		"=b"(out2),				\
-		"=c"(out3),				\
-		"=d"(out4),				\
-		"=S"(__dummy1),				\
-		"=D"(__dummy2) :			\
-         [port] "i" (VMWARE_HYPERVISOR_PORT),		\
-         [mode] "m" (vmware_hypercall_mode),		\
-		"a"(VMMOUSE_PROTO_MAGIC),		\
-		"b"(in1),				\
-		"c"(VMMOUSE_PROTO_CMD_##cmd),		\
-		"d"(0) :			        \
-		"memory");		                \
-})
-
 /**
  * vmmouse_report_button - report button state on the correct input device
  *
@@ -147,14 +120,12 @@ static psmouse_ret_t vmmouse_report_events(struct psmouse *psmouse)
 	struct input_dev *abs_dev = priv->abs_dev;
 	struct input_dev *pref_dev;
 	u32 status, x, y, z;
-	u32 dummy1, dummy2, dummy3;
 	unsigned int queue_length;
 	unsigned int count = 255;
 
 	while (count--) {
 		/* See if we have motion data. */
-		VMMOUSE_CMD(ABSPOINTER_STATUS, 0,
-			    status, dummy1, dummy2, dummy3);
+		status = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_STATUS, 0);
 		if ((status & VMMOUSE_ERROR) == VMMOUSE_ERROR) {
 			psmouse_err(psmouse, "failed to fetch status data\n");
 			/*
@@ -174,7 +145,8 @@ static psmouse_ret_t vmmouse_report_events(struct psmouse *psmouse)
 		}
 
 		/* Now get it */
-		VMMOUSE_CMD(ABSPOINTER_DATA, 4, status, x, y, z);
+		status = vmware_hypercall4(VMWARE_CMD_ABSPOINTER_DATA, 4,
+					   &x, &y, &z);
 
 		/*
 		 * And report what we've got. Prefer to report button
@@ -249,14 +221,10 @@ static psmouse_ret_t vmmouse_process_byte(struct psmouse *psmouse)
 static void vmmouse_disable(struct psmouse *psmouse)
 {
 	u32 status;
-	u32 dummy1, dummy2, dummy3, dummy4;
-
-	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_DISABLE,
-		    dummy1, dummy2, dummy3, dummy4);
 
-	VMMOUSE_CMD(ABSPOINTER_STATUS, 0,
-		    status, dummy1, dummy2, dummy3);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_COMMAND, VMMOUSE_CMD_DISABLE);
 
+	status = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_STATUS, 0);
 	if ((status & VMMOUSE_ERROR) != VMMOUSE_ERROR)
 		psmouse_warn(psmouse, "failed to disable vmmouse device\n");
 }
@@ -273,26 +241,24 @@ static void vmmouse_disable(struct psmouse *psmouse)
 static int vmmouse_enable(struct psmouse *psmouse)
 {
 	u32 status, version;
-	u32 dummy1, dummy2, dummy3, dummy4;
 
 	/*
 	 * Try enabling the device. If successful, we should be able to
 	 * read valid version ID back from it.
 	 */
-	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_ENABLE,
-		    dummy1, dummy2, dummy3, dummy4);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_COMMAND, VMMOUSE_CMD_ENABLE);
 
 	/*
 	 * See if version ID can be retrieved.
 	 */
-	VMMOUSE_CMD(ABSPOINTER_STATUS, 0, status, dummy1, dummy2, dummy3);
+	status = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_STATUS, 0);
 	if ((status & 0x0000ffff) == 0) {
 		psmouse_dbg(psmouse, "empty flags - assuming no device\n");
 		return -ENXIO;
 	}
 
-	VMMOUSE_CMD(ABSPOINTER_DATA, 1 /* single item */,
-		    version, dummy1, dummy2, dummy3);
+	version = vmware_hypercall1(VMWARE_CMD_ABSPOINTER_DATA,
+				    1 /* single item */);
 	if (version != VMMOUSE_VERSION_ID) {
 		psmouse_dbg(psmouse, "Unexpected version value: %u vs %u\n",
 			    (unsigned) version, VMMOUSE_VERSION_ID);
@@ -303,11 +269,11 @@ static int vmmouse_enable(struct psmouse *psmouse)
 	/*
 	 * Restrict ioport access, if possible.
 	 */
-	VMMOUSE_CMD(ABSPOINTER_RESTRICT, VMMOUSE_RESTRICT_CPL0,
-		    dummy1, dummy2, dummy3, dummy4);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_RESTRICT,
+			  VMMOUSE_RESTRICT_CPL0);
 
-	VMMOUSE_CMD(ABSPOINTER_COMMAND, VMMOUSE_CMD_REQUEST_ABSOLUTE,
-		    dummy1, dummy2, dummy3, dummy4);
+	vmware_hypercall1(VMWARE_CMD_ABSPOINTER_COMMAND,
+			  VMMOUSE_CMD_REQUEST_ABSOLUTE);
 
 	return 0;
 }
@@ -344,7 +310,7 @@ static bool vmmouse_check_hypervisor(void)
  */
 int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
 {
-	u32 response, version, dummy1, dummy2;
+	u32 response, version, type;
 
 	if (!vmmouse_check_hypervisor()) {
 		psmouse_dbg(psmouse,
@@ -353,9 +319,9 @@ int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
 	}
 
 	/* Check if the device is present */
-	response = ~VMMOUSE_PROTO_MAGIC;
-	VMMOUSE_CMD(GETVERSION, 0, version, response, dummy1, dummy2);
-	if (response != VMMOUSE_PROTO_MAGIC || version == 0xffffffffU)
+	response = ~VMWARE_HYPERVISOR_MAGIC;
+	version = vmware_hypercall3(VMWARE_CMD_GETVERSION, 0, &response, &type);
+	if (response != VMWARE_HYPERVISOR_MAGIC || version == 0xffffffffU)
 		return -ENXIO;
 
 	if (set_properties) {
-- 
2.39.0

