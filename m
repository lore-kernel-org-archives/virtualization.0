Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8ED3BADA9
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393070; cv=none; b=tlHf7R8MQDE6a0zDX/IgP9+W7YmbDMdX6nJ54VVYqPOhF9M+3kGLq/22Kf50YCwBSEK9rDjfcQiiDj0FdrRG62bPOoLkx75ZkzFnZ/336OurJXp098YbOAGeeX4JZWgHq3RUvlT8vp8z5XdkeJpy4QGjXxmUiHbxZzVQzcgP2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393070; c=relaxed/simple;
	bh=1Lru7JP9GAuuZi6rTqk0Y4BTP/g8OZXnNQPKFszs/qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh6aSf3vaJEEJnSCVZ8UqMspFjyjXqqcmgazXlo0QldX9DAAC9SXcSWMrZzIG9iZnNO34kwhHvOIHM8B1KCVXgmzv8SYkWbbiGYUIcW3YT3I6guAfjtZJejwZE0+mcdxrX4oO8MB3wia09e8V3ciFCHKlWFModQ40rLHYZWICZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G3KAKFFn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RiRc5Eos; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G3KAKFFn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RiRc5Eos"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0UGd510998
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pklwXAAIq1Ig2ZvDmkN6OFjS+5G8VOhcNQA
	9piH/HrA=; b=G3KAKFFn+SKCOp3tbFd8NQO1uWzpf7CVF1srOEHkLsohE082pcu
	4mlaUs+SSOZ1k9jvHzroAljCURUhTioCa9Cc8o9RkPoYo1bxoPDY8xwtVJ+/sOxE
	N1GaZ0IY52s54Ud1Nxbu+JtcDljmM4KY6BfKBpIBOpodjfXcWr+4o65sNZ2tpuRc
	zSQA8R80/okc0UttlWzF/R1QBCZIjG7ID0+4+nQP5CPPaHwKXXIVxnsganEnt8eb
	xQFxaBwODSW5xY307lH055H++E/m3mCf1KNcvNmcS4CTbFUk5FeoFwEZ4aQ8o4xR
	z+/H+Xh6OAVsPtHPdVU9+FKkUpmHL0qa6jA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvtg8df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:37:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d54187d8b0so72610755ad.0
        for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789393066; x=1789997866; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pklwXAAIq1Ig2ZvDmkN6OFjS+5G8VOhcNQA9piH/HrA=;
        b=RiRc5EosSXtTQAlkmmTheLSzXZ6VCWdC81G2Ly6pz6FhdrLV1VLPf/QKwn0n8B0eil
         dzb2p/NkvrImlflWAwNgNF5yZP0C+G/UwoshiJGU1kQWvIWIRx0dvd9ieBXEMgT3yrS6
         ozCcVZWgSbuv/UNCX796hlx4CwW/vxjCLXJD/T3zk5Lq8kRH47kxWlaqsrp5daEFQDJd
         psMAcBd5x2r4xs6GHoJ2bgIJDBfu69BPhtatwNCWkGa2VbIa/9gDtEJYEac5X/qtx8LO
         kcoBtMTr4xAlGARos3tDEf8eTx5qZ2tEN47/1fNux7rGKLh84O1D78mO9wxRa88Q2IE9
         N0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393066; x=1789997866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pklwXAAIq1Ig2ZvDmkN6OFjS+5G8VOhcNQA9piH/HrA=;
        b=W069Q7Zp9Xr9jKyhtgCl81A8Ahjy7To51fJwwEbVb5m/JSJyoo4ME65wHCP+FhuOFQ
         AW01QB2vnu9gmLSVZDdI6QZo1sJ90nj/O9zG3uT8RT3D2x3/ReGoMAW/pyD84o4gEwrU
         ewXI0blCf/7F3gLL/YClaY4RrHreNQ1tKS54AYlh0nlx1VCtm8FJznkyWafuvKRe0v+E
         1SgRY8SVO5E9eJ0Hm40kCn2WILcS21AAsOSzxYPlCxajdmrFbFSn8x3SJaSd/iTvmWx+
         foesqkrI2taTh3jG2OlrmBVW/Vl1U1TpAYNNQ4ISLSuNMxvDQURIa6TJ5kFWQw9Y4Gfo
         QZfA==
X-Forwarded-Encrypted: i=1; AKwUvBzX0SUQLNFhmcDUx8V3EhuDn9pTcYMHHjZt+o1YOgZzIr9DUmrWsmPtwPvlRupRQrEujnH91K7kpNIP8Haq4Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kiQ5QDlZ4exRN5uVs7TbtpMJAaLPm3YkyO5V9rIEDmtjk31Oo2
	rjUGYlX1Dk0bAjRwFloIxjrAaGHAXkUWUHTOkyA1EN/fgpJhhOXJKhqrPbsAhyHrwFg5FkkGUJA
	I324m6D0SO9z2r12dnBLdmItXAQjJEhGTACdQXXkv+3qLrEoGeC+HY3zyVk3Itk4ytxJdyQ==
X-Gm-Gg: AYBFou0dKHtAJ971CQpKdQVC4D42xbavQ4Ey383uksTkyUuS2UNE4KCqUSzRGweHUmO
	8T901eENDJYb86KGALWwOGuRZS0CLldU0C7avVjXWx2/IGPMwcgfW2O7lfHGqsHF3RbknjHC+PK
	jFeeFuyPyfJVTo2LdixqZxpZOnKo3DoczGrxrd026s74JQodSdJWbe1QwB+XMAX/6zFpI0wAFmK
	1hoca7CuY365/AXG6BJaltwWV6cmYSHOwWgFRxa9EG4vEtyK4r30aFRmklH9WWrbyFOB20zd6+L
	cFB/rQW56Zj4O2vkF4Gg72dQUsFeyp/STn0pE4W8qo1btnHIQuVy94f7Pu5HyK5HX118DYHnvon
	rVfSl/phV5gP5dMmCOJaH9yFmcKlSba+j2s8UFvsi3WiP9PRGDM4x9/nhvls=
X-Received: by 2002:a17:902:e88c:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2dd6c5d0539mr51200025ad.4.1789393066274;
        Mon, 14 Sep 2026 06:37:46 -0700 (PDT)
X-Received: by 2002:a17:902:e88c:b0:2d9:383a:30f1 with SMTP id d9443c01a7336-2dd6c5d0539mr51199425ad.4.1789393065805;
        Mon, 14 Sep 2026 06:37:45 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm49132685ad.62.2026.09.14.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:37:45 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] FBE virtualization: inline encryption for virtio-blk guests
Date: Mon, 14 Sep 2026 06:37:19 -0700
Message-ID: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa7f8ab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kDXN7nACZjSVqT4r80IA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfX8lhqdJvCKRPq
 /KWPTxV1zkakZ6ohLsS3Nb7ODe+A5EypUsiqsNiDI60GiIgjyZXBg5fbH83GjhD1mh1I7GWxxYf
 lHHINwrZwCH/lKMumLCJniiyYiULUPwd9Xn9+pN8kl953Hh61zZiU1J//NvVlknRCx8P6YMCSD+
 5109iMvUt2FeExHsojMxsZYUDnuHEYln3ekQAXCKuqojxxieqhZV81Iw4gVr/fo4KZqxa5aQJpz
 QpUr3rn775tHz6Kwqq9dzN/xVBOfchM8UCwui+qnRL/DWXcfyYfYsdvJIhI9Em/m/e5e/TT/0uL
 j9xB+vsNI1m1l8Q7Lwx+60g2IuXPyqQqFOpJZvOlMShio9OCwK7cTCU0HwoLtXoQcw1mvTRitxa
 MicQl7g4mlCW6Q5a/gmDIET4Mhny4ZF6Dv+8yRmpcv8676Bxb0fWSkrr2QlF5/X3d0amsbiwEl6
 zrje95qlc9ONBnkdlPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfX6+qNVnG6unVk
 HPtRJfEPeuGmg0UIrm+AE2HJ7aRSbOLXxa9OAyibB8HyyA210UumKgMjIile+FV16hQ8R3YBdy/
 qXjyLxueCBot4ld8Qm8lxo2OruuXe0U=
X-Proofpoint-ORIG-GUID: suInZHfSXt6xxv0fur5nZdA1qIx7w3L6
X-Proofpoint-GUID: suInZHfSXt6xxv0fur5nZdA1qIx7w3L6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140194

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

On the backend (blk-crypto-proxy, will be commited in another patch as
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
 drivers/block/virtio_blk.c      | 753 +++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h | 116 +++++
 3 files changed, 865 insertions(+), 16 deletions(-)

-- 
2.34.1

