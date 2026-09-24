Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3384AA1F2
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266170; cv=none; b=eU4SjYrLG1aaNZ74Glit5v7ra19NvY8TeFzABtOMZ9oV7zhBNPiwpz61nw/cNfTjlbqwGXLPns9TgsnNu64GF8tVSpuApLewADjbesbhYnq3drHaEX9t/iNDEUU8fRMJIf9J2ilShICZ1aXlgC6cBGqo4Uag+nIlHJeYU12MSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266170; c=relaxed/simple;
	bh=mRM8V/B/GHW0cq2R1yHq9xtQiPbavwz59aLnGlc5Reg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szAzMplQa5e1ENq/S/9PLwNI109nwckn/iC6aZ9ejq2W3IKeZRyPxR83ThNByVSuLXZeQzFzh8mzhT5qXE3QC26yBzXClso0gu8sDuIyb000gBEMNvYHp9wZwod8uv+9wrQuUvdG66nskBiVAI1xaKAfwMDSRb+vo5z96PyKtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LJXbUvqB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aM8BU6K5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LJXbUvqB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aM8BU6K5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFedIW3064929
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b46rZL+UCcNF/EAt0vMbqoRuBIBxVdRfxK4
	jqHeV8pI=; b=LJXbUvqB36gbhriv938ZtMKgs/GB1mQFEd1aWvJNWTA4Dbgf3Ln
	H+d6g2RkIHFYucZSv+3nPqAOSaqDh5kLU9frQk/6QAEITWd/r6Gt7/xJOjrflM1j
	FcEk/NGfi9RYUlCDxNnpJmx1te6/i6XwpxC+CA75ycHVN4AMwmDheDQ0Zf2JSBxj
	JUobASVvpSc2Fao4s9NN1dDcQi7EdQtnvU2ElIvXkXzNkriGSEgtVAz4ejS4SbZT
	CVVWBH6Z3Y0fPzyIpFV97q3zGBsSX1hKuiHaAI0oJ9riCRKTWnFK5/VsuxtF6hhE
	oVFtJ48M3/zWbg/bjwJohjnVcFsOQhU29aw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjhf9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78830f4bebaso595611137.0
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790266167; x=1790870967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b46rZL+UCcNF/EAt0vMbqoRuBIBxVdRfxK4jqHeV8pI=;
        b=aM8BU6K5gelo07rnOG7LZ+8p6pMtRbN5To7YZUqsc8dn9CknRrPbYh0ej9NzAOtxna
         LokxsQQoZt33MRCB9nI6TJAEsbMmgAJz51rQxGOuNATC+U6y0oP0QeM3eY+h7HKbAIvq
         bKNZGhc5UhDG7bpVdcczyC47pKVoZaaGYvKrf0LFhub/EaPsvHAAseO0te/yigzy2sjV
         lcBuTSgH4ogwv3Ux1S70Rsc7uA/KZFjxkndTyMPxcW7EidwCrHklVg+EeeqJGB/je7Wa
         KUrJSuCWbZL0Sj25sO1q+Mw0JpkbjmhBoF6m9UvqpSm4f6B69998+3xUssKRB2CBh58v
         bxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266167; x=1790870967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b46rZL+UCcNF/EAt0vMbqoRuBIBxVdRfxK4jqHeV8pI=;
        b=YQXqV4tifMFDh6WUDSqqp2cMmk05kMMQs6FCCQ16HqqZGcUg6S5/EhuULeT/Zz0kwh
         LIcclWfy5RNoTzBdbParFAM2P1h47cS05IBmSHNT2YJntMdv9lylKGd9T1XSig1K3kvD
         Z970uhCw5NvzdIRblbWjm3Q5/7I/2IXU/bE+ACBZh9PRlWtYdXLChTygOCI+PiAoLO6a
         xs/90wc0vgHPpqvSgRxkA8wHvvZqq2DlX9qtkfWfVjsW+pKnbDuPah24LVCjMleeJzo8
         MN7Ch+lAn0pyFP8UHASL4xxw8IvuzXCFQ9lZ+yVoWzieVsnbtnkTp/bYQ7hQA2LQdEEj
         PRwg==
X-Gm-Message-State: AFuF++nhZwvMFzeLxyNkyg1MPcPqL4eBATFanzV+Xkv+gF8xRM/ibCVf
	UD+5/zG1s6hFtEDnzOgMhzpUreuTFkCqYDPHm57WGCSEUin2H4VQ8L2pe78SO7cftLqPZOraO7Y
	4KduY8KS6aN4yutSxhk9KPbAYuHGlT6hrFobo9okNHT4mZg8g0n591F3Vrc1hZg4Sh/6cdw==
X-Gm-Gg: AYBFou0yUyGjHh2hDsy4H992WQ4ZGzSMwxANGypGL+/l8tedz11bQrsY6q/CxBqPbca
	sHIoxYwvH1wqV/lVRDxogg3wBYxXe5r9EHSFrFPXO6M+XWpnxoR+AgzuC4qvM9vEhIgZ1zN937r
	yBZuJepHXgWj9dKhJEmpdI/Sz3jENUav6xN/lsx/7oiL7llPGrJBLICIAGWp+EpBvvKw+Ei57AK
	LtwQU1VgHWoh26vJh1lU9yAk85XP/v8wIS51zpZKKoQB9EundtIlzPdzsdVDEfyPaOqqDicwcog
	9yU3FQ9YhwgjgY8exTxQxmmB9sUKVCGZ2J+Bo9kij/6PfWkhTPTQE7EZXQXhwynLOavlxOfKUlj
	arBSmTIKYoXElkbd1Mfxd3yhTlUcO7ZY=
X-Received: by 2002:a05:6102:2d04:b0:7a6:accf:72c1 with SMTP id ada2fe7eead31-7af19740319mr1403802137.0.1790266166695;
        Thu, 24 Sep 2026 09:09:26 -0700 (PDT)
X-Received: by 2002:a05:6102:2d04:b0:7a6:accf:72c1 with SMTP id ada2fe7eead31-7af19740319mr1403774137.0.1790266166095;
        Thu, 24 Sep 2026 09:09:26 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5c4csm328306766b.18.2026.09.24.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:09:25 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 0/8] virtio-usb: add dual-role virtio USB driver
Date: Thu, 24 Sep 2026 18:08:59 +0200
Message-ID: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gFwgpkjT3RxD8SBWVVLTkUKAl6-khHfO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX8hIkFnCoZx2N
 5i9VYfTevr5QNy24FUysCoAlPLaQnG+CZ/ZvLiaOQY5C6VLbV5paUo1sl6IGXetP4njlrfTRk+T
 vl/xUx9FSfJnXieBXQfXHqmN6JmCKdzETBAH6U9aAqmfVnuprQVf4wolTZloO0dol0neDkTJNTU
 9nWmMB5RnqHZD4aplvJR5qJm58I8RJGMIrwVMYj9amhWud1I1wtk/RI6LAlF1iDjh+F/JqVYnbP
 fHUcqRbQWRbDMqJeVrOepCSMwwDleBxwwdW/xIAPYRAcUjiOt9n0qbQQFHPxLPV93AOPcNRy0J+
 uSc2wawnIKenokln6zN6TAFS/fAvzeJuLEZyl2UswaGUv+SItC6csuZ91kn7d+WHIeWtT2rkAeo
 HFv2uCAv3asnik2z7MV/Vjh/DqRrFaAZTxqmSPBVooSUAiR0zGfvnp8ypZEncDfHzb5LSEoreuz
 aKiwvn9wH0VsV9Rk0ng==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab54b37 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=q6LqD5CuZsS-vr7wHY0A:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: gFwgpkjT3RxD8SBWVVLTkUKAl6-khHfO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX+M1Pwjo5M7ed
 GUIgzo96QzuHBAMPEIuKWsDFeZfCKNwdDeXTRA4WuS8EDgrWPwJWHHYEr303N/wujNfBOua6aj4
 EDrwhL2mh06tEpQPnqXgzH1Qkoro5tc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240066

This series adds a new virtio-usb driver: a dual-role virtio device
capable of acting as a USB host controller, a USB device controller,
or both simultaneously with runtime role switching between the two
(USB OTG-style role switching) on ports that support it.

The corresponding virtio-usb device specification has been posted to
virtio-comment for review. This series matches the v2 revision of
that spec, which reconciles a small number of protocol details
(per-role virtqueue presentation, host-role vp_idx for hub/multi-VP
support, and the device-role BIND/UNBIND event split) that were
clarified while integrating and testing this driver against the
spec:

  [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
  Igor Skalkin <igor.skalkin@oss.qualcomm.com>
  virtio-comment@lists.linux.dev
  https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/

This driver has been tested end-to-end against our own userspace
virtio-usb device implementation (host-side backend) in two setups:
  - arm64 hardware with a type-1 hypervisor, exercising a real dwc3
    USB controller on the host side.
  - x86 with a type-2 hypervisor (QEMU/KVM), using dummy_hcd/dummy_udc
    on the host side in place of real USB hardware.
Host role and device role were exercised in both setups: testusb on
the guest, over a virtualized host port, against g_zero running on
a real hardware UDC or on dummy UDC on the host side (host role);
and testusb on the host side, against g_zero running on a virtualized
UDC on the guest (device role); plus real USB mass-storage
hardware/gadgets and iperf3 over usbnet. Role switching was exercised
in both setups as well, but not with a real OTG cable/ID-pin connection:
on dwc3, role switching was driven through its "role-switch" sysfs
configuration; on dummy_hcd, it was emulated by toggling between two
simultaneously-configured dummy_hcd instances on the same port.
Testing with a real OTG connection is planned as a follow-up.

Known scope: this driver virtualizes an entire UDC per device-role
port, with each port owned by a single guest. USB function-level
virtualization - a single physical UDC exposing a composite gadget
whose individual functions are routed to different guests - is a
separate approach currently being explored, and is out of scope for
this series.

Patch summary:
  1:   protocol header and skeleton dual-role driver (probe/remove
       plumbing, no role support yet).
  2:   USB host controller (HCD) role support.
  3:   USB device controller (UDC) role support.
  4-5: USB OTG-style role query and role-switching support.
  6:   endpoint-lifecycle robustness rework (async split-phase state
       machine, replacing an earlier out-of-tree gadget.nonatomic
       patch that didn't pass upstream review).
  7:   SuperSpeed device-role support.
  8:   guest UDC naming fix (name prefix from the bind event).

Aiswarya Cyriac (3):
  virtio-usb: add protocol header and skeleton dual-role driver
  virtio-usb: add host role (USB Host Controller) support
  virtio-usb: add device role (USB Device Controller) support

Igor Skalkin (5):
  virtio-usb: add OTG role query support
  virtio-usb: add USB On-The-Go role-switching support
  virtio-usb: rework endpoint lifecycle to an async split-phase state
    machine
  virtio-usb: add SuperSpeed device-role support
  virtio-usb: support a guest UDC name prefix from the bind event

 MAINTAINERS                         |   10 +
 drivers/usb/Kconfig                 |    2 +
 drivers/usb/Makefile                |    1 +
 drivers/usb/virtio_usb/Kconfig      |   21 +
 drivers/usb/virtio_usb/Makefile     |    9 +
 drivers/usb/virtio_usb/controller.c |  422 ++++++++
 drivers/usb/virtio_usb/controller.h |  152 +++
 drivers/usb/virtio_usb/device.c     | 1893 +++++++++++++++++++++++++++++++++++
 drivers/usb/virtio_usb/device.h     |  115 +++
 drivers/usb/virtio_usb/host.c       | 1368 +++++++++++++++++++++++++
 drivers/usb/virtio_usb/host.h       |  203 ++++
 drivers/usb/virtio_usb/otg.c        |  403 ++++++++
 drivers/usb/virtio_usb/otg.h        |   38 +
 drivers/usb/virtio_usb/vq_common.c  |  740 ++++++++++++++
 drivers/usb/virtio_usb/vq_common.h  |  163 +++
 include/uapi/linux/virtio_usb.h     |  346 +++++++
 16 files changed, 5886 insertions(+)
 create mode 100644 drivers/usb/virtio_usb/Kconfig
 create mode 100644 drivers/usb/virtio_usb/Makefile
 create mode 100644 drivers/usb/virtio_usb/controller.c
 create mode 100644 drivers/usb/virtio_usb/controller.h
 create mode 100644 drivers/usb/virtio_usb/device.c
 create mode 100644 drivers/usb/virtio_usb/device.h
 create mode 100644 drivers/usb/virtio_usb/host.c
 create mode 100644 drivers/usb/virtio_usb/host.h
 create mode 100644 drivers/usb/virtio_usb/otg.c
 create mode 100644 drivers/usb/virtio_usb/otg.h
 create mode 100644 drivers/usb/virtio_usb/vq_common.c
 create mode 100644 drivers/usb/virtio_usb/vq_common.h
 create mode 100644 include/uapi/linux/virtio_usb.h

-- 
2.49.0
