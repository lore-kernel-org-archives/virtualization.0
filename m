Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC226B777
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338065; cv=none; b=JTHKwDScg0UMvBmIM1MeJSymCL2TbKFqCBRV8O1MeE8yF/FTIHelJVBbsh2pF5pNnsA8lPvwcXCr72S/MZiKn5ugkFG6SkLcxTPQiyhe3nvruIT1qe5ZYNyg5bwsTpXlSgweqI6tGk17t1dI8kZxNKDmked17EQBiOREYXPt22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338065; c=relaxed/simple;
	bh=jbzi2Emj0Xf9BmoPlY0PU4j/8PVZ/5uK5OX2z0vqwIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAqr9F7NG+8v1XXvrV86kCbcJWsBtYsZf85RzxWHOqgqjQXkCrit7H1440yRxt2+MpOFVhwvOCBcO5A8DnqJZcanQlwzuSBXi+VbfwZwVpFgGCfSf6WLe+ReZQTfrEF9yODl2edn3CkY7lt5A6B5jbtEOUzfQw+HyG2Rai4f7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=IFWvEHVq; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="IFWvEHVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778338055;
	bh=jbzi2Emj0Xf9BmoPlY0PU4j/8PVZ/5uK5OX2z0vqwIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=IFWvEHVqRN+dbqESIEPH8cTPJG/YquOkq1iOSQhwNhJoqAwDsOMD+MocZakkJLfJT
	 f9LPZPOA0r/ODpNCAWtQtwek+6bRf0aIIchTvX9rAqj5tjm87VGlSpmK3Gy1mMH0x+
	 KCc5deYIUIxNphOrgqlYIlOCaJnT1aZBdI1yhtKLF7xzkdYC0/EwOtYKP0DdcKuKjV
	 K3KPxEiOBYlDZqT2FMzxb4p4u82C3XlR+VsGqNZltGTzG2vWAs9/5n9+ekKuSxUkX2
	 DA7+cvt+U2MitF+SIrGnvWPuW12JOABcwVRl5n35lBZYlmDsyCwHpRP63i5133vcA1
	 8NgHjtws5koyhsjMzz+C2RzUTF09Fw981qFvRHoNH1nvGSAi2sW5bUG3jqnTNhZ6oy
	 h3sWx/tfB+R4OEefhOAej30fDTzCOjfXKD0Fyo8lpXZZ7fs7fpejJmMSNdpxHYpmFl
	 I+hbOZ9LL9t84sLWjj7nHzlZriXQlHe69fm6VJlf3E3YgJ2ymvcYU93Bpf1MWaua5R
	 +h6ZTuRIxQvi9qAoYP6q6Y1vO6vDWxbNqkSQvuFohcx7rDgm7BW1yWEDwfVopzHwkS
	 0CyYOcEHSeo23NBBTXE1XS3y7xtW4BXVbCyX/7cHQch2TBX8gE5/beFo5FNn/WlrRi
	 V/ZvJY3pRggvCK0i0BGZfBJs=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sat, 09 May 2026 17:46:55 +0300
Subject: [PATCH RFC v2 1/6] rust/bindings: generate virtio bindings
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-rust-virtio-v2-1-c1e30ec2bd21@pitsidianak.is>
References: <20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is>
In-Reply-To: <20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Peter Hilber <peter.hilber@oss.qualcomm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manos Pitsidianakis <manos@pitsidianak.is>
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=jbzi2Emj0Xf9BmoPlY0PU4j/8PVZ/5uK5OX2z0vqwIQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYkFLVC9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnAvMGtDUGloZ1VPNXRrc1RZc1hRWDJzQTdsV01VCnA2T2Q0Mm5UZnVBd2RJdnlR
 d3lKQWpJRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWY5SkFnQUt
 DUkIzS2Nkd2YzNEowRHRTRC9VWEhZaEpQNnZnMVY3eER3bWVMMDNPbWNXQ0xPTFd1WWg0VXY2MA
 preDQxRFU2NC8xb2xDcFk2T2RGb21HV04xOExwSVlMcWsyNk1WNGQvUUd3V2J0UjViZlJOYjhid
 nBQb3dQNlduCjV0YXBSS0s3Q3l4azgxSXBVelpld3ZuUWRYODhmL01ZcXRiN1BheXVMN1ErN3Bn
 b21aR0pLd2RoV3pVNEpqR2EKc0Nqd2lhT0pKVDU4Q0loZjUzbXNBdDlzbjlaM0kwMElsTWp0a1h
 pTHlOSnFRbWo2ZlAvNDJCOUdCSXRoU3lnVQpYK1M2bU1DMXN1S2s3a2pIbkN1VDk0R0U4R2Y3UF
 dFZW1sQzdyMmwyZVJxc0hRVDRvbjdkWXJ6Tmd6M2lFUnRICnV3U3lqeWN4MHc1RHJxZjY2QktNT
 UlLK2lTMnZVdDlVVUpIWXV0TktOU3hXbU5acmZUVW02SUdJVWZTaVQ2UUMKbGp6UnJQQW9kbG1O
 VVI4RE92VmN0cHlMRHV0RHJYR0dMYXdGT1lsQUZNdkk1VVpjdmZGVkpPSGtNRDZlVEVDOApWZkt
 ka0pjSkRrQzRySnd0N1V0bFFTaDFIUFlId3VLcjhQcjBiNWpUaGdOMTJiZHZSclRDUGRwQnJGNU
 FEaGI5CjZVbGdCM3VyRWxReDcxU3Z6U2dIT0F6UmJtS1dLbW10UVJ3L1ZuZWJpdVMrdmVWeW1qM
 DZabHF2TjlRbTlFZm4KSDQzcHlBd29NWjZNSmUwZTlUODVHbjlRRE5HaERES0VDWlNDL2tTV25Y
 S2hkalUwdHQvdkhNdTdrdi9mVmhkaAo4TTMrSFJvWXMxS1B4UUFXWmZqTUpDQ04yUG5PcnozNkF
 1RG1uY3Rrb2c1QUQyYlNRcTlOY2hacDZITWxXZVJZCmtSUE4KPTkxaFUKLS0tLS1FTkQgUEdQIE
 1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Add virtio headers if CONFIG_VIRTIO is enabled.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/bindings/bindings_helper.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952c2b29ab82d5d481063a1cf48bccf..1cbe1a4b5647fd646c1be3c5c80fb24ae7b97a4a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -151,3 +151,8 @@ const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
 #include "../../drivers/android/binder/rust_binder_events.h"
 #include "../../drivers/android/binder/page_range_helper.h"
 #endif
+
+#if IS_ENABLED(CONFIG_VIRTIO)
+#include <linux/virtio_config.h>
+#include <uapi/linux/virtio_ids.h>
+#endif /* IS_ENABLED(CONFIG_VIRTIO) */

-- 
2.47.3

