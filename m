Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567542070
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537779; cv=none; b=ip5dHiQDAdFeijppAmLhmokT18qNNdgp9/e26y31wMPvia08kRQ8J8sICIBjyuegVZOy4ngFTH1IPm+37QG7u8omiwpAtXXME9CFg1Rmq9Hb83dyBM1a9hMt6s8zeLLgArNHF7fctXx8fyouJIbY9nHaW1gcLPijhJLCaZ6HiIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537779; c=relaxed/simple;
	bh=qZOC87wxnyikROZQtNQ2vugv9wV1fC3RRcMN5KoKScc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b9ivg/5Rk7W6HbAZEY4zELTAllOdlXB81J3nJfeI3pe/HprosmPhngrRQBnO7StXPcYohyglRuxex/1slLWwv59XfDGPonYE722OB9giU41nE5ZE2Cdn3kqch1AoSHSp7/P6SUufyTtrctqjYZ2PBKQ/CTGz+cj5auwIIJc52aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jTzxB28J; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jTzxB28J"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q26EXR021641
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 18:42:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=mVGFcIi7nxWGluBHbl
	cBkGiP9g7amm6RXFmCZKFjwbo=; b=jTzxB28J8ttefSz+bhNdetveVTSM02gV3E
	J1ZHJ59wrJHkX4kLefjnoAA2QjMVOa3gaVv2uBHmlHFy403ptlcwpOSThlUDMqId
	0S8DjI7ruK5mFKzVGt3braJEuQmU9/T0O0hNuhqavuKeDcMpj6ZT+hczkJfpQAV4
	YNcxqectknNJxEy0cBQr0ehM7opAMka4EvmIwFD/3ii1hM4Xyz4BpO5xI65hpu11
	2IDKlthTGVRhoA0pasudpeqcClG3S/qseQDHRZBQuucvGYLfn70pdWH6p4AS6Xqd
	97Dc7HxpEG+CNRnjmkdI1tg2PKKhNHuJ6oJ8ILFYpoBBV+7il+sQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 451ps39s4w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 18:42:56 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 02:42:47 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A6D6A1875B1A3; Tue, 25 Feb 2025 18:42:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>
CC: <x86@kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [RFC 0/2] kvm/x86: more huge page recovery fallout
Date: Tue, 25 Feb 2025 18:42:36 -0800
Message-ID: <20250226024236.1806294-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vhgZvxnKpf74xXKDm3MD11ej3yeYDHDg
X-Proofpoint-ORIG-GUID: vhgZvxnKpf74xXKDm3MD11ej3yeYDHDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Another corner case on the KVM vhost task!

The crosvm VMM might send signals to its threads that have entered
KVM_RUN. The signal specifically is SIGRTRMIN from here:

  https://github.com/google/crosvm/blob/main/src/crosvm/sys/linux/vcpu.rs=
#L651

If this happens to occur when the huge page recovery is trying to create
its vhost task, that will fail with ERESTARTNOINTR. Once this happens,
all KVM_RUN calls will fail with ENOMEM despite memory not being the
problem.

This series propogates the error up so we can distinguish that from the
current defaulting to ENOMEM and replaces the call_once since we need to
be able to call it repeatedly due to this condition.

Keith Busch (2):
  vhost: return error instead of NULL on create
  kvm: retry nx_huge_page_recovery_thread creation

 arch/x86/include/asm/kvm_host.h |  3 +--
 arch/x86/kvm/mmu/mmu.c          | 25 ++++++++++---------------
 arch/x86/kvm/x86.c              |  2 +-
 drivers/vhost/vhost.c           |  2 +-
 kernel/vhost_task.c             |  4 ++--
 5 files changed, 15 insertions(+), 21 deletions(-)

--=20
2.43.5

