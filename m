Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E034486E6D
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846906; cv=none; b=pVv6IXKJZXMQ79VoOd0Ep7xk5TfGB0+Gs3wVlkNB9a+83WOBYg0UpUjrW0VNDJVSKxeXp9SISz/aYVrGACSBb5klk/2FwqE8wcnwtskZtWZqFIxB/uKn7jrQm6GGV7CbxddVVKbqPljI7yTaq8yWxfB9BX0yC3OXBwYLgV0oQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846906; c=relaxed/simple;
	bh=InJBi1ft2hBbaFKieY6YZqUXPU/gfk8w7Fh7r9+bQPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IgZACVxIfwpzXGQXgvBKGR57uMprFQvrZixfPu2wox822ZjmK/9wpGk1T+IfQrjg471IAz160HId1o394LSh9dXlgOwHRc+k7KeE6E6Sst6FG2cfrFTosVzGtBu8sUUDzE+iApmn9iyJ7aY4zJ0q30MHJI5v3eqWfaB0ePSTVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4uq6JlM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RbYdG7oA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4uq6JlM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RbYdG7oA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFceLf3943235
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=atRu9g3ecGR/Ax5Jg8bJIB
	651HizDXONPJoQtisnwWc=; b=Y4uq6JlMpmj0npdFeC57HIRdcXHvB1w2M6L9O9
	PwLZ2U/E0etX95l5S3QazbFxtQ84dSCpFhs45XMhhNr3ykMBlc1XAe08rxWKIf93
	ISwIavbNkpr3MlFveW/yD//12y0VEiu3W4O4nTwolGa++uMHbVVNsr38aOU7Ccob
	nAAhMKFTAbbbRqXqxz0wW2chDr7MQ4aF8D7HsMFFWPhL78MCVYcgmQe7N9Jv2Aks
	dANs4IPALWTMepSN4Eu5YdlOwWxdhvCJ5Fo/H19ieoRURWH+ZGvNlorRanqW5mN7
	JP7f9tVZZ3N/9OpCUX+Y6KR5kKq6jRemzqPyb59O9qxQdGMQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga6etv4dt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso165993a91.2
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846903; x=1788451703; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atRu9g3ecGR/Ax5Jg8bJIB651HizDXONPJoQtisnwWc=;
        b=RbYdG7oAygsPhYxfSKF0HTNtwJJM+zhPt0SJPElSzSlfH8USks6Rbzin0xXQx9WE1U
         M5ivH4JU5N+1F7sKuv2luZCJgug9PpwFnblpqIbApZVzY5lSl+m4LL8u/U9GXyfm4nfG
         LIsDbQ+3V41wYS63gsvTh4qQPC9HrlKh5HTXuNfbhp+anTLbJ0uM8INJF8tIJYkmQ3ry
         qWG+hNe0wjXJvk7anZjhehRQBGZ2ZnxftnnavuzN9FT/cY7PHL8HusJWS+9s61pESvvV
         /bTSj0APwwqje8Ug07i0TM+2NZKcYr1Mi/eLqDs6F6gxJNVq/vZ2Xo4vS9+u/qcX1IqQ
         tT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846903; x=1788451703;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=atRu9g3ecGR/Ax5Jg8bJIB651HizDXONPJoQtisnwWc=;
        b=CZbmX/Kz5gNj5ptNx0zNpTDPk6yAoCBbyi2AFDTLK++mfAWujLTv9greme0g6wjyJV
         PqTXJISgWoGHjwysuWZUL3VAsNxVN62w5dK3s47xwf8x+J/HLuwdpHLCWQW6wurPiM0m
         y7OymL1JsyzrhGO+R+cbanCh1C1/L8q74DqKZ6cXY6jzR34x8Qb/y5hOekL5eeqDmRJv
         37vgjJOy/VV3cDnmmQ13d67I0pwgX1ZjrVf6XwS8mtG8OpJJ9k8buLqB17AnXnNiLuhr
         6Bb5vVIR+s5d9NXv5Pdkzv6feXLWbwjhtLLFfkY/13TZ2LkUqpvub5EqclrkZYnIpHe0
         3qSw==
X-Forwarded-Encrypted: i=1; AHgh+Roj3+NkcAKfFSLN/9h2XB9vGl+HvhJwqDsiMXwAL5UYh1S9gmAupJByvQiC406cGoSIt/2lUHXYJltT0AWwnA==@lists.linux.dev
X-Gm-Message-State: AFuF++nFbygRAvCX0+/vhiqPHuDyavV5unQu7MV+OySuIICqmgNDVkYS
	BsncVVJ7PQu0Ynq8TTkJ+yx3Lj80g1kF6o0fHqrLurl9RahITeOZvSOfbFIm/r4PR139c0+HEgN
	rvcsY1o0KUrUmLcPiG5PJb5Rj4U0DDNGBw+Oer7l5YnDeCW/aEyx0u0v9F49b/GmdVRH9kQ==
X-Gm-Gg: AR+sD129OuwM9U2JkTQbbAVEaMnyMxLVoeAgxg+ebu/fBnVjL4xTZ10UpWb+lG3j/jy
	bBRW90Sa7GNCUuVmTHHG1foXBPrvInadPmefSYP7JxV9IfME2G2/lb+fo2HQ7f/T2+v/6XSODvw
	3MwIQZfFhOlAI+MHLqszVn7v+ZyI2x2AXC4stty7BMj2vwYs6hVaeuug8JqZU1S06JMF9gds5fq
	SzmIbPDIbeG2oCB85Q6sWwXvmCilH3TZ7FnZfBG0L04/Cidu/dqqQFvUM1gM4a8ceNvMDh7aX7q
	IQgZFEXUmOjl3EgNMiPMVNkLsQoTt+NNO9VG/3j/bh2l0d1/Y/i0P9gm3iCWx5pD1Qh0mPfyjYa
	6prtzXgvRjkjIGwVi3yawj+0xBYHkMPwzVsnExmqaXZFlBEsxTXJsCyWYCE4=
X-Received: by 2002:a17:90b:3c8a:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-396d10076e9mr459867a91.13.1787846901363;
        Thu, 27 Aug 2026 09:08:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8a:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-396d10076e9mr459325a91.13.1787846899408;
        Thu, 27 Aug 2026 09:08:19 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:18 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: ebiggers@kernel.org, axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/11] FBE virtualization: inline encryption for virtio-blk guests
Date: Thu, 27 Aug 2026 09:07:09 -0700
Message-ID: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a9060f7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bZYwddHGPv9KEr_TRj0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: LVgCw5zmRO--_yBMekeTGNLbV5crMk9y
X-Proofpoint-GUID: LVgCw5zmRO--_yBMekeTGNLbV5crMk9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX8UdieUjSb+To
 RmeIhPQntLjbZ1WzCVm5uodmiO5/FX17CDDf6u9tTEalWwnd79wSGU7C2WNwfIgph+q/e7VbJey
 xQylnHzvfx5A1nVnSI766LMxY/j0zqUlrAunX/8IJpIV9uyEl6tLp/zLdHn29k7eqiNKPoadtfD
 IRZqUnQzw69ePfB1AqC6RaxsWksFnEz3itGIHZRGcfO6f4YtiMTVS/Y6oGdzB1Tet82vKInzUDr
 R689eUw1ihe4tTKm22s/wLkfdVy+WYjMQF9ejZnZIIA4BW01h4tETmQ3s9Wq7ol67QkfxcVZRi3
 9xCUYACKrlo/FHXL52BUeVneH/wEUlelVm+xsaWt7ck/ml1Kuch4nwEjMddWgq9dU7azwVlqdiG
 +ErfEWB+EcI5XQe6Dtws+6coomthf9iAzNqSlMOBzT5wvCag5EywrHHS4HRprAlxC6prRWSoxbP
 C8v2bwNPABS4iCACHiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX0NZh35oXuNE7
 JLP7oa0NX0YgEAEjJgNaoEmwM2suZvsh7Dj4SI9QF3/Emkms/33WM01dmcKhK8vHTWbI0J4oMSF
 bC+vhuySRV+hTMgOhnNU7zQi/8s9hFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Current virtio-blk does not provide a mechanism for a guest to
program hardware keys or submit encrypted I/O using pre-programmed
keyslots.  It drops the crypto context when issuing a bio request
to the virtio-blk queue, preventing inline-encryption-based FBE
on virtio block devices.

This series enables File-Based Encryption in guest VMs on Qualcomm
GVM platforms where the ICE inline encryption hardware is shared
between the host and guests.  In this environment the guest kernel
has no access to the ICE hardware directly; it supplies a virtual
keyslot index and data unit number with each encrypted I/O request
via VIRTIO_BLK_F_INLINE_ENCRYPTION, and the host must translate the
virtual slot to a physical ICE keyslot and submit the bio — without
transferring raw key material across the VM boundary.

             +----------------------------------------------------------------+   
             |                                                                |   
             |               LA GVM                                           |   
             |                                                                |   
             |                                                       |        |   
             |                                                       |        |   
             |                                                       |        |   
             |                                                +------v------+ |   
             |                               +----y-----------+   blk-mq    | |   
             |                               |                +-------+-----+ |   
             |                               |                        |       |   
             |                               |                        |       |   
             |                    +----------v-----------+            |       |   
             |                    |blk-crypto-profile    +------------v       |   
             |                    +----------------------+            |       |   
             |                                                        |       |   
             |                                                        |       |   
             |            Control path:                               |       |   
             |            generate/import/prepare key                 |       |   
             |            program/evict/derive_sw_secret key          |       |   
+----------+ |                                                        |       |   
|          | |+-------------+     +-----------------------+     +-----v-----+ |   
|Trust Zone| || crypto-virt <-----+ virtio-blk-crypto-ext <-----+virtio-blk | |   
|          | |+------+------+     +-----------------------+     +-----+-----+ |   
|          | |       |                                         Data path: I/O |   
+-------^--+ +-------+------------------------------------------------+-------+   
        |         SMC|call                                (virt_slot, DUN, DUSize)
        |            |                                    appended in virtblk_req 
    +---+------------v------------------------------------------------v----------+
    |  +--------------+                             +--------------------------+ |
    |  | SMC trap     |                  Hypervisor | MMIO trap/VIRQ injection | |
    +--+--------------+-----------------------------+--------------------------+ +

    +--------------------------------------------------------------------------------------------+
    |                                                                    PVM                     |
    |                                                                                            |
    | Crypto IO    +--------------+                                                              |
  +-+-------------->  QEMU/Crosvm +-------+                                                      |
  | |              +--------------+  IO data                                                     |
  | |                             virt_slot, DUN, DUSize                                         |
  | |                                     |                                                      |
  | |+----------------+       +--------- -v-----+                                                |
  | ||  blk-crypto    <-------+ blk-crypto-proxy+-------------+----------------------+           |
  | |+----------------+       +-----------+-----+             |                      |           |
  | |                             slot path based             |                      |           |
  | |                               bio_crypt_ctx             |                      |           |
  | |+-----------------------+       +--- v----+              |                      |           |
  | || blk-crypto-profile    <---x---+  blk-mq |      bcp_hypervisor_ops             |           |
  | |+-----------------------+       +----+----+              |                      |           |
  | |                                     |                   |             bcp_slot_virt_ops    |
  | |                         +-----------v-----+             |                      |           |
  | |                         |         SCSI    |             |                      |           |
  | |                         +-----------+-----+             |                      |           |
  | |                                     |                   |                      |           |
  | |                 crypto msg in UTRD  |                   |                      |           |
  | |+----------------------+        +----v-----+  +----------v-- ---------+ +-------v--- ------+|
  | ||    ufs crypto        <--------+ ufs-core |  |blk-crypto-hyp-backend | | keyslot-partition||
  | |+----------------------+        +-----+----+  +-----------------------+ +------------------+|
  | +--------------------------------------+-----------------------------------------------------+
  |                                        |                                                      
  |                                        |                                                      
+-----------------------------------+   +--v---+-----------+                                      
| +------------------------+        |   |  ICE |    UFS    |                                      
||MMIO trap/VIRQ injection |  HYP   |   +------+-----------+                                      
+ +------------------------+--------+                                                             

Patches 1-3 land in the guest kernel.  Patch 1 negotiates
VIRTIO_BLK_F_INLINE_ENCRYPTION and wires it into blk-crypto.
Patches 2-3 add the Qualcomm GVM-side crypto backend, which routes
key programming and software-secret derivation through SCM calls to
TrustZone.  These patches are sent for review; the virtio-blk inline
encryption protocol is also under review (see
https://lore.kernel.org/all/20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com/).
These patches and the virtio-spec depend on each other.  They must be
kept consistent for upstream merging.

Patch 4 adds the dt-binding for the Qualcomm crypto-virt node used by
the guest-side backend.

Patch 5 introduces a "slot path" in blk-crypto that lets a bio carry
a pre-programmed physical ICE keyslot index in bc_slot rather than a
blk_crypto_key pointer (bc_key == NULL).  This is needed on the host
side where the hypervisor has already programmed the keyslot; the host
kernel has no access to the raw key.  Patch 6 extends
ufshcd_prepare_lrbp_crypto() to handle this path.  Patch 7 moves
bio_crypt_dun_increment() to the public header so it can be called
from drivers/block/.

Patch 8 adds /dev/blk-crypto-proxy, a misc character device for
userspace virtio-blk backends.  The interface is three ioctls:
BCP_BIND_CONTEXT binds a host block device fd and a hypervisor VM fd;
BCP_GET_CRYPTO_CAPS queries the device's inline-crypto capabilities
and the VM's ICE keyslot allocation; BCP_SUBMIT_IO_BY_VSLOT resolves
a guest virtual slot to a physical ICE keyslot and submits the
inline-encrypted bio synchronously.  The driver is
hypervisor-agnostic and storage-vendor-agnostic, using two pluggable
op-sets registered by platform drivers at runtime.

Patch 9 implements bcp_slot_virt_ops for Qualcomm platforms: it parses
a qcom,ice-keyslot-map device-tree node that maps each guest_id to a
contiguous physical keyslot range.  Patch 10 adds slot_offset to struct
blk_crypto_profile so that blk_crypto_keyslot_index() returns the
correct physical slot number when the host's ICE range does not start
at slot 0.  Patch 11 extends ufs-qcom to read the host's own slot
reservation from the same DT node and initialize the
blk_crypto_profile accordingly.

Patches 1-4 are technically ready for review.  However, since they
depend on the proposed virtio-blk inline encryption protocol, progress
on these patches is expected to follow consensus on the protocol design.
Feedback on the overall architecture is therefore particularly valuable,
as it will also help advance the associated virtio-spec work.

Patches 5-8 implement the core host-side infrastructure and are
believed ready for review.

Patches 9-11 do not depend on any hypervisor-specific code.  Of them,
patches 9 and 11 provide the Qualcomm platform implementation based
on a static device-tree keyslot mapping; this may be revised in a future
version to use a TZ SCM query interface.

The kernel-internal header declares bcp_hypervisor_ops, which
translates a hypervisor VM fd to an opaque guest_id.  No upstream
implementation is included in this series because the series was
validated on a downstream Qualcomm GVM platform using the Gunyah
hypervisor, which provides a stable per-VM identifier but is not
yet upstream.  KVM does not currently expose an externally-visible
per-VM identifier that a kernel module could use for this purpose.
Input from KVM maintainers on whether and how such an interface
could be added, or whether an alternative identity mechanism is
preferred, would be welcome.

Known limitations
-------
  - Only AES-256-XTS has been tested.
  - virtio_blk_crypto_msg.dun is a fixed __virtio64; the driver refuses
    to enable inline crypto if the device advertises max_dun_bytes > 8 to
    prevent silent IV truncation and reuse.
  - Inline encryption is mutually exclusive with VIRTIO_BLK_F_ZONED.
  - The qcom_ice_slots driver uses a
    global singleton and ignores the blk_crypto_profile argument to its
    callbacks, so multiple storage controllers sharing a single slot table
    are not yet supported.
  - BCP_SUBMIT_IO_BY_VSLOT submits each bio synchronously with
    submit_bio_wait(); concurrent in-flight bios from multiple threads
    sharing one fd are not supported.

Testing
-------
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


linlzhan (11):
  virtio_blk: add inline encryption support
  soc: qcom: add crypto_virt backend for virtio-blk inline crypto
  soc: qcom: crypto_virt: add support for create, prepare and import
    keys
  dt-bindings: soc: qcom: add binding for qcom,crypto-virt
  blk-crypto: add slot-based inline encryption path
  scsi: ufs: core: add slot path to ufshcd_prepare_lrbp_crypto
  blk-crypto: move bio_crypt_dun_increment() to the public header
  block: add /dev/blk-crypto-proxy for host-side virtio-blk inline
    encryption
  soc: qcom: add ICE keyslot partitioning driver for guest VMs
  blk-crypto: add slot_offset to blk_crypto_profile
  scsi: ufs: ufs-qcom: support ICE keyslot partitioning for guest VMs

 .../bindings/soc/qcom/qcom,crypto-virt.yaml   |  39 +
 block/blk-crypto-internal.h                   |   5 +-
 block/blk-crypto-profile.c                    |   7 +-
 block/blk-crypto.c                            |  57 +-
 drivers/block/Kconfig                         |  28 +
 drivers/block/Makefile                        |   3 +
 drivers/block/blk-crypto-proxy.c              | 667 ++++++++++++++++++
 drivers/block/virtio_blk.c                    | 199 +++++-
 drivers/block/virtio_blk_crypto_ext.c         | 283 ++++++++
 drivers/soc/qcom/Kconfig                      |  30 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/crypto_virt.c                | 197 ++++++
 drivers/soc/qcom/qcom_ice_slots.c             | 232 ++++++
 drivers/ufs/core/ufshcd-crypto.h              |  14 +-
 drivers/ufs/host/ufs-qcom.c                   |  91 ++-
 include/linux/blk-crypto-profile.h            |   9 +
 include/linux/blk-crypto-proxy.h              | 100 +++
 include/linux/blk-crypto.h                    |  28 +
 include/linux/virtio_blk_crypto_ext.h         |  78 ++
 include/uapi/linux/blk-crypto-proxy.h         | 122 ++++
 include/uapi/linux/virtio_blk.h               |  62 ++
 21 files changed, 2224 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
 create mode 100644 drivers/block/blk-crypto-proxy.c
 create mode 100644 drivers/block/virtio_blk_crypto_ext.c
 create mode 100644 drivers/soc/qcom/crypto_virt.c
 create mode 100644 drivers/soc/qcom/qcom_ice_slots.c
 create mode 100644 include/linux/blk-crypto-proxy.h
 create mode 100644 include/linux/virtio_blk_crypto_ext.h
 create mode 100644 include/uapi/linux/blk-crypto-proxy.h

-- 
2.34.1

