Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAF43B6DA
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907121; cv=none; b=THkdMPVM4f6W2dHknOKPAwxmifAXirTQ7M7UiP1ddkVlzaO888/p3Ld8pe3788bVfmHjDbgj9Hr6qcEffci0SE85vErj/haPfqbaP6dL9GXKNphuEnOStegmLsMlZMX9fd2tEAT6E2LIRZOtqAwaFRM/ghJJz4V0zWwyJl7dOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907121; c=relaxed/simple;
	bh=9ys3681p32APqj6Z88pRcCV7fPw5mjcOa7rsGo8U5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1INZ17W9QjujTX313TAVOI1HCZDHni0+C4ngeDoj6KBmEKsv+rtmaxVTPfl4ex0pc//tWCBQDRHfBxF4vNCwNQ/3A4gz+b7ePgwGWLQ8VUcwH4ydjKeGR5WOCBnE5J8LZ/YmfRvVdjs4YhbZsI1eIYroMhvVK+Ix2M8NCThtjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INB501Xm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NajDhKfI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INB501Xm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NajDhKfI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBoNZw975928
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nHGqvNi0X1PSleAmas4B81l/3KNqRkeiVL8
	aUDF2Tt4=; b=INB501XmUi1cS4dB9XVFh2i0kPwkEouV/hwHE1MOXGc7wyjC95j
	MlhrxBIekXsN3RGomAUacgzRgFqLHgMWFpBgoae6l4KSCuL+cfK+QsqcbAV683xf
	isFz4g/1wDqKYPvSP75ao5SfDWePyU97jFoUR6bjBDX0WkRkOAY9nUBGoOErxPy0
	007nSfu88b5d1qA+J8IDBKt/buA0yEJd/w/8boLWO6m13RBDsaUAWuwAlTUclCps
	3nJWvQgJs2kpfpDWOPHudNbgwYcr1m/AeULUzL37FEvrATEGLxgx0wCsEZCxitaS
	HSzT8bb0XssSEhK1TwsQtzhgzdea1gZhoSw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gskjk2udm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:24:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso29602095ad.0
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789907096; x=1790511896; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nHGqvNi0X1PSleAmas4B81l/3KNqRkeiVL8aUDF2Tt4=;
        b=NajDhKfIJKz9zYlu0SfyT35rwyxxWtSLgsAQYSRYZ/ofk13OPCgSyb1sg2O1KKaeXF
         VHSH3DxyZMcdu0CM5nJCqdtVy5C+kguAWuSmUCXFp/gEPs0RE4ozTFpTg5N7FpPi9Yt+
         mIQU9/qBDuuLYZDlr+QJqLYr9PTejMSjdwC6IeJw0DfMimFtg/O9BRIb6KevEUz5h2Y/
         MaXdmW3NTJ+45f6InFq3m6Hi75FayMg35kakDwrmL/d+V1jU64gUEsdCzJ9xqqlKr6mk
         i7vdU0rEipWOODHlOt4s6lxpeocffWvCu/Bo1jps640/AzaxFZP5gb7sYNE6if7ZXTaM
         BzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907096; x=1790511896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nHGqvNi0X1PSleAmas4B81l/3KNqRkeiVL8aUDF2Tt4=;
        b=R2QYmPZbtSGTTimvB13IgZ8gAheD2NRKzOX8TAIj2hJPer+XpeLb7gGNcAGgL0a/4m
         7jY5BehlrJ9GjU+oHS//HE3AzVnnILeM4/uBzEcbeovZ1tPrz4G/vMP+ygUI7WspQE/F
         G/aLAJOVhFWdkOtuwRMWjVtfaod21kD7dMKfknyF/wtFBKwRT8A8Bh8VI9ffLCyMJQXC
         Ong8icDe4zOWiNam6luBTCPoTu9GLJsF2e2kxJWa/SChz+bFyeUa6B5bqn7DaNkB7hHY
         4b53M2jq7T255rQSSrr2jXLmSa59JrsFpE7ddIKIGPiaM/no5cPXirB+rcrAcLlfXoP7
         0uxw==
X-Forwarded-Encrypted: i=1; AKwUvBzSILPRu6G29AAh7+F/L/Dic4YDnJaTDaIg6lh7eL9d2BP/aawVfyTnIFTJ+WHpcxRG+KHVYSHCWNYJhRDdZw==@lists.linux.dev
X-Gm-Message-State: AFuF++motRVKcL8iXsJbRKgQhfvCbJfGQl/veLpDW1LLcPszqnIkIPWX
	9F1QHL+U+E+NKlzUJVFdjyCBMn/clAs1uMQOI0gPd/qTSE2n/2+zmrtcuxPAT0ACIJf3jAI4VfF
	jpr/V1gGRujZJsYjg4PPKNny1hS2YbeK4NoO2z7gPa/ku4es2FsGxxg5h90AXG2xIWRmdXQ==
X-Gm-Gg: AYBFou35yYNh0jq0Z7aGjfMwfVkZDLXPSHyVdAsFbYAVwg53VTK9KxdyXdfo5UP0ZLD
	ldSWs0ZRLVroCe2NAedOqH/+9z7SvGzsFCHHY1UQN30GhnH128bbAQ94Sz28qBhBpCMj43hfMDF
	feDc0q+Hy2C/0nuOXP8qkYUyBbEfOlCjRh4ul51pVFk23PxmCCTxaaTDXvy/v+OGChqHO8pt2Ue
	ZGdbklRyqDcgR2Uf9ZIXviuIsJr0RLdPmTQP/1/QCZrZ2GMonXcI4nJdoBbiqsLDcJA7Scrubqu
	27FZ1SxAMYZ9tIdTC0zW1C2bYgzTJD1Bp70zfIxM7qrDRtTRSLh4TGfzWHqHvTQkCDWxasYPcl0
	Lly16GTAC3YngccDrIX9SzHYQqIPYuYi8gtf0VUEhTL/JLpCvlR9MhTePnQ==
X-Received: by 2002:a17:903:46c6:b0:2dd:ad73:5b67 with SMTP id d9443c01a7336-2ddb1c196d2mr119168875ad.23.1789907096575;
        Sun, 20 Sep 2026 05:24:56 -0700 (PDT)
X-Received: by 2002:a17:903:46c6:b0:2dd:ad73:5b67 with SMTP id d9443c01a7336-2ddb1c196d2mr119168665ad.23.1789907096095;
        Sun, 20 Sep 2026 05:24:56 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef9bsm12007386eec.25.2026.09.20.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:55 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] FBE virtualization: inline encryption for virtio-blk guests
Date: Sun, 20 Sep 2026 05:24:30 -0700
Message-ID: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H6JOUOYi c=1 sm=1 tr=0 ts=6aafd099 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=82hO2hxRqmGPxkN32ysA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfX4kK2i8Su2iHu
 DonBT+PxGZ01/2MIRgEp3aLgOzD3E8bYgcNLnTHtita0S+iSDP4/C/wlrubN9z+F2SktR6Vvwww
 u8PuUcnxU2mqnpyxxarvMN+cOBDIoSqrHzJhq2RHvNGuIEsE3fjurpdB/B4QM+vORgXmW+U2fM4
 AOH6ncebi0WIjhK0dX39KsncigeuYDxDp2JlmfSAT3OEtf55X2RbrzSQ9ShCPFsTsOT1OP6L0+A
 mYQL+Vrvt3ROLm8XJWJrmiFvE5Dext+9VsbLqW3W9xlZiNb9tVTE6b2B3PuS3T2TUNlF59ZT0O+
 gEAKnL7pwUuwlCIiXpN0bsBbdV/7j0dgzOlLhR7qYHPBZsbddTC1zdgNtFToBKzMBBsQhxdaZ8m
 QSUCq7SWIgrPyWTYTGuoFtKRVRYhhp0oALSAFqLDVTkDj0OZNCjfoxpY9pxe1fwUGNZzYo4ms2y
 Zt7tmA7XOsAEMWtaNUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfXxhZgL5RN3Eap
 q5F7s3WJW3qQgG6Y+bhrBJpnMEgmw+DTZZklBsqhvLB2z8BPrFl1fCRrXAj+R6LxT8XTPBSQ5Gr
 HGGYAdECfYPAlLzC9KCcliY+D9ifL+Y=
X-Proofpoint-ORIG-GUID: DLtOs0xzN2YeRwYdMUc74pQAh501MOaq
X-Proofpoint-GUID: DLtOs0xzN2YeRwYdMUc74pQAh501MOaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200180

From: linlzhan <linlin.zhang@oss.qualcomm.com>

The virtio-blk driver currently does not preserve blk-crypto metadata when
dispatching encrypted bios to the virtio queue. As a result, inline
encryption cannot be used for virtio block devices.

This series enables inline encryption for guest VMs on platforms where the
Inline Crypto Engine (ICE) is owned by the host or another virtual machine.
It extends virtio-blk with a crypto control virtqueue and carries the
required encryption metadata with data requests.

The series consists of:

  1. Add control virtqueue support.
     This allows the guest to exchange key management requests with the
     virtio-blk backend without mixing them with regular I/O requests.

  2. Add inline encryption support.
     The driver advertises the device encryption capabilities through a
     struct blk_crypto_profile and carries encryption metadata, including
     the virtual keyslot and data unit number (DUN), in virtio requests.

On the backend (blk-crypto-proxy, will be committed in another patch as
suggested.), the key table mapping virtual slot to the block crypto
key is maintained, so that the request metadata can be used to resolve
the guest keyslot to the corresponding block crypto key and to reconstruct
the blk-crypto context before submitting the bio to the underlying block
device. 

This keeps the guest integrated with the existing blk-crypto and filesystem
encryption frameworks while preserving inline-encryption semantics across
the virtualization boundary.

This is compatible for the virtio SPEC update which is under review:
https://lore.kernel.org/all/20260913161628.368484-1-linlin.zhang@oss.qualcomm.com/

Known limitations:
  - Virtio block inline encryption depends on the new control virtqueue
  - Inline encryption is mutually exclusive with VIRTIO_BLK_F_ZONED.

Testing:
Compilation pass on Linux-next.
End-to-end FBE virtualization with wrapped key enabled was validated
on top of gunyah hypervisor.  wrapped_key_test is a local utility to
get wrapped key and ephemeral wrapped key via storage ioctl interfaces.
  - /data/wrapped_key_test /dev/block/userdata generate
  - /data/wrapped_key_test /dev/block/userdata prepare /data/lt_key.bin
  - /data/fscryptctl insert_wrapped_key < /data/eph_key.bin
  - /data/fscryptctl set_policy --identifier=20f553802e64e36b43469211266a5f1c /data/testing
  - echo "data" > /data/testing/file.txt
  - sync and reboot
  - /data/wrapped_key_test /dev/block/userdata prepare /data/lt_key.bin
  - /data/fscryptctl insert_wrapped_key < /data/eph_key_2.bin
  - /data/fscryptctl set_policy --identifier=d8ca51d6d2094b73b2dae5ee7e3a10b6 /data/testing
  - cat /data/testing/file.txt

---
Changes Changes v2 => v3:
  - Fix issues reported by sashiko-bot
    - Change to the pointer of struct completion in the control-queue
      request to avoid DMA cacheline sharing
    - Submit a control-queue request with a timeout monitor
    - Freeze the data plane before marking the control queue as dead
    - Transmit the kernel blk-crypto-mod-num and key_type to those
      defined by virtio SPEC
    - Replace GFP_KERNEL with GFP_NOIO when allocating the memory for
      control-queue request in the key program/evict flow
    - Move the check of inline encryption support to a independent
      conditional branch.
v2: https://lore.kernel.org/all/20260914133733.15429-1-linlin.zhang@oss.qualcomm.com/

Changes v1 => v2:
  - Use control virtqueue to perform key management requests
  - Extend virtio_blk_crypto_msg::dun from a single __virtio64 to a
    four-element __virtio64 array to support larger DUN sizes.
  - Remove data_unit_size_bit in virtio_blk_crypto_msg struct
v1: https://lore.kernel.org/all/20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com/

linlzhan (2):
  virtio_blk: Add control virtqueue support
  virtio_blk: add inline encryption support

 drivers/block/Kconfig           |  12 +
 drivers/block/virtio_blk.c      | 907 +++++++++++++++++++++++++++++++-
 include/linux/virtio_blk.h      |  87 +++
 include/uapi/linux/virtio_blk.h | 124 ++++-
 4 files changed, 1111 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/virtio_blk.h

-- 
2.34.1

