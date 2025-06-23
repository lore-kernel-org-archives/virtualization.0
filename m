Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7697233D8E
	for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672869; cv=none; b=S1tByhv+bBen5lWqMJNGvT7L7qi76eJc3O2BnK4ePrGai3UFjK2QQXiS1qJV99oawydc5VbxpLeA7yxWxpgyarRHe3zAmPU1+OXoIc440czF9rs3bRupWzeeY7YvA5BeIuFmBfUuv5TeyyyRP/S0ZfJvZBgaYAgUdvK3aPHmbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672869; c=relaxed/simple;
	bh=Q5iqcjL9Nx3GILkRpH3081upzUIxlt4JKXojGl4BQ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ECn1bQxQbfsHM2PfpavJ4CGZpVe9QCNawTSc+qUGDrL5Nm7pDq74rrG/kSpRg1iPRX2tV4s1LiDSj06o5JL7E9OVBmw2j0xf66HM4uR8E8bIKO2mC1Y0SXCmGB60lyJeB+lNvTqQJz6x297l8/PO66IgtGvP7b8x+DGmWk7tLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChFbGFRK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChFbGFRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750672866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cg11dcRkqMpCTj1960kW5hmHn/C5yTPB14wnt8MXdok=;
	b=ChFbGFRKaOJJHVYPTldcf9QV5yPUJV1hOkDhmnXaM976yQHmkzc2tfwNL0jIvdg0w8a3MD
	b7B9/hM6O+MSsaQ1FAme/mMGI1tXkJ2/BgubQiPUOSIFvmIdiWZmEDmbkZ3wFD/rHMcWO4
	naBtwzrpyPhNgj0HGyH+DCnj7yx9AiY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-Dv5gtbE_OtKEGgPMltbZew-1; Mon, 23 Jun 2025 06:01:05 -0400
X-MC-Unique: Dv5gtbE_OtKEGgPMltbZew-1
X-Mimecast-MFC-AGG-ID: Dv5gtbE_OtKEGgPMltbZew_1750672865
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a716cf4345so138779391cf.2
        for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 03:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750672865; x=1751277665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg11dcRkqMpCTj1960kW5hmHn/C5yTPB14wnt8MXdok=;
        b=w8c5qubGBGo8WuJeqKlLMh3qaYtmMH54Kg6lLsn7dW2b0PTs7GG524XWunrXkbJ/8d
         kVMOIsLeR4axqH0SHDpnrOdUieshLnY0wuDOBscIoaISSXbk/g1JgPn3v39f5i2BdjzH
         +u9bZbU3b5jpoq2dBAtSZE1gRuvsDBrlv8Rb9Iq6wTx4+BTZiSDs2EXYMMCH54/J8G/i
         y0gB1M2XI48yrHySBSlZKau42i65xEIAdM6zwtFdyeU2i1OmXnOAT6+o1ZeD4i2pDJ+O
         I8wt9TBTSUDY3PdjheIG9qpuhNl0cPSyvgGo43GgiHmqprQnCF9MvtHo2luW2jt46Tpf
         YGNA==
X-Forwarded-Encrypted: i=1; AJvYcCX5dGqtfpAuJbQay11LBBfSO/sbyxSq5JSYdip1oWTGPD8NDZCvd02TAw/W6bsFi6HaPgThxn1JXQ/Rbte76Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVwlqGBmr+E0Ylqds8QYfcBYcxgP7pccyaSqV7W88Ajd1tjjsO
	nEQ0EM29tlycUwfW1PNMNjSmObLH23q8XdGgxPZsjUOvWy0MnOR+l3IZPg7xT/+qrg8DT9zao4u
	oeaGcA2VdR4/UZ2IBK2SCF9i/vt6TJ/UDIYUbvbdPyaL0LbNSxHCNnd8HqF8xO9mSEtAE
X-Gm-Gg: ASbGncu4WD9sgqzX4GILuB0TWGSEN47YXiePz1v//RNqBdP4EvuD0uitwI97AndLAvO
	+dNeDwwk8Vef5bl7qTBGH7DMM3gyWuI97NZ5JkfF5O9S16bnasmtFIpL0OGUKCP7CvjeCv+OHqX
	zrGxVBenvgJbJwk0nC/iC9M+Jd3kue7ecFeqSBIcBbadAwmggC3FW2uLb5sjlzEWkul9oCQzeMM
	NISuIQEtt6s71aiAvIgDcMkmAygICb+biJvauELy01y5juD43BhGIAKrYxMib5SYpo+YIL95qyz
	lUI32YQLXzrN/oiTPgB27Y5VpgUo
X-Received: by 2002:ac8:5903:0:b0:4a7:693a:6ae8 with SMTP id d75a77b69052e-4a77a25763fmr190862241cf.52.1750672864585;
        Mon, 23 Jun 2025 03:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXzLpFhw4QDvJz+bsfP+zBCHk665drBIUKJoN12gXU74K8bXpg+kpWK89icqArO8RccMpeNw==
X-Received: by 2002:ac8:5903:0:b0:4a7:693a:6ae8 with SMTP id d75a77b69052e-4a77a25763fmr190861721cf.52.1750672864007;
        Mon, 23 Jun 2025 03:01:04 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.202.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d4e5d5sm36886681cf.7.2025.06.23.03.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 03:01:02 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Andy King <acking@vmware.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH net] vsock/uapi: fix linux/vm_sockets.h userspace compilation errors
Date: Mon, 23 Jun 2025 12:00:53 +0200
Message-ID: <20250623100053.40979-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w_LFe4emLrM4PqczBTH9xQSJJmNKqVXh4BjWB3anvCI_1750672865
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

If a userspace application just include <linux/vm_sockets.h> will fail
to build with the following errors:

    /usr/include/linux/vm_sockets.h:182:39: error: invalid application of ‘sizeof’ to incomplete type ‘struct sockaddr’
      182 |         unsigned char svm_zero[sizeof(struct sockaddr) -
          |                                       ^~~~~~
    /usr/include/linux/vm_sockets.h:183:39: error: ‘sa_family_t’ undeclared here (not in a function)
      183 |                                sizeof(sa_family_t) -
          |

Include <sys/socket.h> for userspace (guarded by ifndef __KERNEL__)
where `struct sockaddr` and `sa_family_t` are defined.
We already do something similar in <linux/mptcp.h> and <linux/if.h>.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vm_sockets.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index ed07181d4eff..e05280e41522 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -17,6 +17,10 @@
 #ifndef _UAPI_VM_SOCKETS_H
 #define _UAPI_VM_SOCKETS_H
 
+#ifndef __KERNEL__
+#include <sys/socket.h>        /* for struct sockaddr and sa_family_t */
+#endif
+
 #include <linux/socket.h>
 #include <linux/types.h>
 
-- 
2.49.0

