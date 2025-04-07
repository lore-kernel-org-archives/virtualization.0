Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514721506B;
	Mon,  7 Apr 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044831; cv=none; b=JzKqaNXbwOhq45dULnFNBIBj2GCNXiEr5grymYEBjIGWW2ukV+VHtwhqR6PqWAOb/nN9axglXbifbbCEZ5eD55pm13/xwL3AxLWYHhYpxixdlpuMEW4bq+77f4d5uHrv0dCYVDo52UyqcgMb114duMxd9y5VoUzqdFdJPIaknDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044831; c=relaxed/simple;
	bh=/63x5XDI05YRGMeuJSFJUfvCJJOQJc/pdKltFQW7xlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOnTrk+y8scecB/l3oX5GivgtkqmnHrYzRS/55DMpsjwkEh/jzfizVf5pvI9Zo3EdzRCFpsLEY6faNfdlWqne/Wd65wReX54B93ulXl1dI4hCbFTRtZi+9Yux5lq0Ds0AX/r1qfJvDchC62t0i/RPqscP1DVJBnEd2upZDr8ipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGxz1xm1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGxz1xm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34788C4CEE7;
	Mon,  7 Apr 2025 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044830;
	bh=/63x5XDI05YRGMeuJSFJUfvCJJOQJc/pdKltFQW7xlk=;
	h=From:To:Cc:Subject:Date:From;
	b=AGxz1xm1r9Hnp21PIbxWn9dhEJ5yxy+JfQ6hNVs4UlorrT8nR5Eq6yQAPmc+YGhhL
	 V0hAB53Kas2yj1BFVtkhmXu4bZi2JraRpvpigfERGeSX/sG6LuDvgVcu/BzavHztpf
	 eDtvMX6wVirlNs2UY9LHRXgHJ3DiJ8DTpnOkvnMYk/HozJkR/w3XiEPn56DNQNFLmr
	 wppJA2LDZ1hRIiQKYQrIBlo7o4g/GSnl6FXNHoR3AeeZe3GgKqAdBLe/pSgqpwBh6P
	 h7RCr40kvLFjokBWK1qjwGckcu/Ra+wUZqnYZDnQZKADgcjAnTXcMVztF6u0IUswZC
	 pwNvarCY3UB1w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtualization@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: virtio: pci-iommu: Add ref to pci-device.yaml
Date: Mon,  7 Apr 2025 11:53:40 -0500
Message-ID: <20250407165341.2934499-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio pci-iommu is a PCI device, so it should have a reference to
the pci-device.yaml schema. The pci-device.yaml schema defines the 'reg'
format as a schema, so the text description for 'reg' can be dropped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/virtio/pci-iommu.yaml          | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
index 972a785a42de..8bd6ad72ac7a 100644
--- a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
+++ b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
@@ -20,6 +20,9 @@ description: |
   virtio-iommu node doesn't have an "iommus" property, and is omitted from
   the iommu-map property of the root complex.
 
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml#
+
 properties:
   # If compatible is present, it should contain the vendor and device ID
   # according to the PCI Bus Binding specification. Since PCI provides
@@ -33,12 +36,7 @@ properties:
           - const: pci1af4,1057
 
   reg:
-    description: |
-      PCI address of the IOMMU. As defined in the PCI Bus Binding
-      reference, the reg property is a five-cell address encoded as (phys.hi
-      phys.mid phys.lo size.hi size.lo). phys.hi should contain the device's
-      BDF as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be
-      zero. See Documentation/devicetree/bindings/pci/pci.txt
+    maxItems: 1
 
   '#iommu-cells':
     const: 1
-- 
2.47.2

