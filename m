Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AE3B4E95
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519474; cv=none; b=HCeamopfb6WKwAGBCivb5/PSvGtzO7gvXe5N5mFjjWxccU4ZIO9DJyijhAOtiJ656J5HhdyTFih4lPS99vtKpYeKYEgkfoyXdNwrWcqPjemldmFv+53QeMO+i6YYWuBTTNSs0mYqHs/1zTeahxAgVs+nqpn6M+BwLhMF3nZIb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519474; c=relaxed/simple;
	bh=ArEt6J4Pz8BVaQ9V7RnYbDwPTSPD+73G/AbZIcIZ0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EabTLbbhFAlkq+bfIPmQ9XaWPxYq3Z8p54mFv9bsDUrNcOkPgxpSdNko9QgLrcrtf7cM5j7TGC4FCQAkBD8NvavrItPJEims+NSlNbs7aKzog3hik4F8PfAhona7QJEF7HDkuAYie78pjhAXiRnsRU+SuSh2f8Lafm2K/Q3YOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iI1ecwke; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vy/0ow9y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iI1ecwke";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vy/0ow9y"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HL1C966505
	for <virtualization@lists.linux.dev>; Fri, 9 Oct 2026 04:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f9f6qB3zTnDkNrHuwUp0Is
	PSkh9MuBPmByN8qEMV7MU=; b=iI1ecwkeD589xH4UrosQzwlg2VPuWufTAITGru
	lDtLglYp9tN4rP1Z5mG7NROf0kxRdtVNB5cLK4crawvcoc73pimeoNY5/3pG1d/6
	/GJwsj4J15Xr4xqh7nC8jz4i6DY7OMwluoJl/BUaPYxgtH8FEWfq6D3qrnR30b3m
	udzusKFKXD6vZtJngo4JBRahVA4WZXsVOh4WK4opYM3oXHGQ++31Gfu5B69UK7CC
	0cEI2MjOxkWgQ8igG+AV5no5JlOi3cRJrehtSv9IDzsgIzsWCn0NbCJ/55BSeZms
	7CT52ukKXwQFsZhC0aycDkK8BjDFouv2C06A8UjB9qi/tOXg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj1swe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 09 Oct 2026 04:17:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so12537937eec.1
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 21:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791519460; x=1792124260; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9f6qB3zTnDkNrHuwUp0IsPSkh9MuBPmByN8qEMV7MU=;
        b=Vy/0ow9yTij68g/HvCuY/crozKx1LMgwtxQEVwXNzkdu2wHQA2zbjPvQFhqLUVNxTN
         8pvv1fxYWgEdF6O2iocGcUY035Lgq8G88OjpAxvE7ekGT5ky+qNEA090DmJZaL85GEog
         ajDjZFLuzcZoY7KoZDhMofsiza/KYGqlpid3yWH0501w98+e6p7EafEbLT8xkpAkT+0d
         HTOL+t0Yl4YhDS0LF3XV/KcLJCfwRryB2hu6biTjjc7t/kxVUAeAhTaFEYmxXkdeyUBB
         ZCsc68xjY53sgab+Qnd8wq8pckfSarHoufiSUrgSdcuqif7us+3RVlvSSEHrr/Bqo02T
         QxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791519460; x=1792124260;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9f6qB3zTnDkNrHuwUp0IsPSkh9MuBPmByN8qEMV7MU=;
        b=KZjcoPpxNYrfXi/ZzRIA1grgSLL+Wx8aOmH4a5avBQdal7B5J8vc/w+IAeyl0boZhR
         1jBrNkcnze+aemK3srk1v73i+2utyYoVV9fv4O0tzGjRKv/EqdxmjxoWC0BF+jUwxUCo
         O1mL2LoeopyjQz7y9OnAhLpAI6CSt4FIbYND5IEGRJQv+DACcK0H+BHFqiTlw+oMWAFn
         N1JFRI47hkD9BfBhA33A6XfK8ggKAqD8my+PFKcsUzU8AcWe54erjjYnSCYB4IBGGrC/
         S8l8e+j3jLSDkt0NZg0Xgd0+dhu2xYOlPMOHqw+ZuI5uQA2GNcyJExktc6vER+mle5sl
         qtAA==
X-Forwarded-Encrypted: i=1; AKwUvBxHw+2EB6stGwsG3Izaf6nWqlLkrHIDEBpFohzkXIs0eGI1NmhGC+TH6zBz63UoNsfTqnlsWDXmxawvuE1XnA==@lists.linux.dev
X-Gm-Message-State: AFuF++myiA4Iuad/nd4epQzdAvu6XxwjJ/ujP/31cClrrIab2K7u0ReK
	XpiTmM+3tZPIlQ2JTcJBPa5Y/4VuADEuDJhHhROXJaPPP4U27hHVbFf9QqpMYZ3F8WqSjQfjMpC
	UD8PeCJ8MB8No7f86iTc8BTz+9m0Qh96PrrEvZ1/kcZPiXFFo+szZY9exySTC+mmtUJ0ZtQ==
X-Gm-Gg: AYBFou2qdCeAJ0Kuk1G5uKzaQLkEB7zbeHMFcmC0QDRKENkdQZ1hPFEAKyXyALJZSAp
	aOO3imeS/TQiqAtswH4t2RoewQNPxOYT4g72OvhAGduOACr786PPU1oj5v++VEJ0cnTE0GwT39D
	gLgY5gsRkrCBOiPN+plW9U5VhHBQEduCwf+4JLCvrakWT2EJrA9SgxDK8rHwOyReZnMcqweM9Cr
	dC33slaRoWFEAdPE8G9gaHjvxPupc+I4RUJUBxI6CYVqrxr2JamF9VZrThRC04osL+NalDA2CA0
	iJxVWM1KrLuYPStbhSunhMue02HvxMaPPBVpIOM4SFUizG8r215X54zQTpef5FGX6AnVUbCqR1/
	IhxJNBsvwOaftZ56aA5eB21TWPTQvJC1TwRG11yTaO8OTKyCJv3/tZdsfXw==
X-Received: by 2002:a05:7022:b055:10b0:148:4d6c:201e with SMTP id a92af1059eb24-16a5faa6965mr894834c88.23.1791519459435;
        Thu, 08 Oct 2026 21:17:39 -0700 (PDT)
X-Received: by 2002:a05:7022:b055:10b0:148:4d6c:201e with SMTP id a92af1059eb24-16a5faa6965mr894816c88.23.1791519458813;
        Thu, 08 Oct 2026 21:17:38 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm3530749eec.0.2026.10.08.21.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:17:38 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] FBE virtualization: inline encryption for virtio-blk guests
Date: Thu,  8 Oct 2026 21:17:12 -0700
Message-ID: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac86ae4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=82hO2hxRqmGPxkN32ysA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 8-0esUkbFzYryfuSt5PPI_EewlIr42Fb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfXxsyaSuQOvO77
 BXUOLW+lI7Yo0MNkK160E1iCcegjDAfZBm/07bllWkAfoTEp483BIneh8aQyac4M63X9gwHhXDg
 4RlN1a7YkUTZSdSW1mGCrmgd4XZQEgTuoJliLtScBeaBhQ7waQsSO2sSrx+VL1pXS7UDQ5+PXwc
 8h8Ou+/hc0qOnFpch1xeKrPBD16kH4dE7ppOpdGVF7O8xApFJzDP6TyDtedYGJBhDgLcoT9AoRD
 JPASrC3liTy1R2vgExhzNxIpkpq/qm+QHml7zoRq3DSz754V4AnnTiOjKm3npFZl2IcYwN3Su4u
 swhe8o48GYwjA0GFUaA52DILW0fSt2/X6iYhNvRSmv0V7vAiGu3lLpjxWdbpaj7stmUT3pNPmOI
 EzPPtIgaNxQC/OGik/J0UPJVvvJX4kXbRy+3hOg48pfQwt3/mRWOO9n5Gnh+SOkO+48tQ4uU4yr
 nApMipi+zfgpoaZtILA==
X-Proofpoint-GUID: 8-0esUkbFzYryfuSt5PPI_EewlIr42Fb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfX3JE3L9/3rPLt
 b5GmoSG6KcCLJbPwDIL/eX8NPjiAL+0y31T3Of3rWPMUVQWxJ6fpQ2dCsy/Jh778F/uifWbbNfF
 9jZbVHOJ4XdyrN4/nPnnFq137mW2LRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090016

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
Changes v3 => v4:
  - Fix issues reported by sashiko-bot
    - Move struct completion and bool abandoned in the control-queue
      request into a pointer to avoid DMA cacheline sharing
    - Lock the control virtqueue when virtio block driver handles the
      response from the virtio device or forces stopping the control
      request due to timeout
    - Use kfree_sensitive() to free the creq buffer containing the
      plaintext or wrapped key descriptor， instead of kfree()
      defined by virtio SPEC
    - Replace GFP_KERNEL with GFP_NOIO when allocating the memory for
      control-queue request in the key derive_sw_secret/generate/
      import/prepare flow
v3: https://lore.kernel.org/all/20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com/

Changes v2 => v3:
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

Linlin Zhang (2):
  virtio_blk: Add control virtqueue support
  virtio_blk: add inline encryption support

 drivers/block/Kconfig           |  12 +
 drivers/block/virtio_blk.c      | 918 +++++++++++++++++++++++++++++++-
 include/linux/virtio_blk.h      |  87 +++
 include/uapi/linux/virtio_blk.h | 124 ++++-
 4 files changed, 1122 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/virtio_blk.h

-- 
2.34.1

