Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC030DD30
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878934; cv=none; b=BaUWns8H6fmB4tbsNBwiF/Dsx+3aeaaqxbOKPh0HbznMpUbLEqjjycTcydPXK63QQUP1EoonwhzV/A9031BalVM41MyAzWCKq/Sm5Db6tOo2WsaMkPDCRokaODQMCQpfnbKXtLAvoe0gxjngxubiv4iDUZvPERRzMQIIXh//wME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878934; c=relaxed/simple;
	bh=BAGwWokpj3jQqtFx24Rbif/jSCnwnfhdg3DcxeI76m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C53cM2CILi7b/+GI+TXbAv+d/VWvroKPaxNLnAOfYpCEvs4sb6K3a4C8M/wZQGksM+o7pKt0X2orEFRagSf3qTFEPLfCk0gm5Idw58kcfz/X48VpzLf+uXkKV+Tuj69/LTSVAFdgnoJUQmhJ9ZSW+r7I62w9Czzx9/71GKIDbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cna5GU0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cna5GU0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCC81F00A3D;
	Tue,  8 Sep 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878925;
	bh=TMvOnYo1Atub+YhmvSaZeGPAhp1Pt3Xk5UUTa7YsERI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Cna5GU0pkOGTmnt7HuMnUuYcqtTiHYywQ7ekEZJR7fVB6d7aibkxDF/IgV3ls5MLm
	 k/1BD/k5HWDFDbhBVD0hfTyuUB/9gwNHYBIkuySg8GGiKtoEvRPqAyvhL3pWWIX1tC
	 R+cj3N9h83kFIEXJrZtpREKOVg+nSF3wHxpuDrMkktp2sQsVnZttpFpzorPwRg0//W
	 xHLco0TPmnpDto1M2M++joT+kM4ipsNYaJrt+uUI4c756TrT2cQrCHxGInI0ltnzHQ
	 8ck23F7hNbA6TDFHriA3OwPK3sEDrWDlzTgfqQQ9roZcg/u8w4fBtQukwNisbPDc3a
	 3KviQhpBJEl3g==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:46:54 +0200
Subject: [PATCH v4 23/41] drm/virtio: Convert to atomic_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-no-more-plane-reset-v4-23-a31b3fcfc989@kernel.org>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 airlied@redhat.com, dmitry.osipenko@collabora.com, 
 gurchetansingh@chromium.org, kraxel@redhat.com, olvaffe@gmail.com, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6083; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BAGwWokpj3jQqtFx24Rbif/jSCnwnfhdg3DcxeI76m4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkL5K+7OhnEn3wbdOmikSdr7tWG4ri31mF+t9zkflTwf
 q2quK/bMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZylImx4XLmgv/iLXu+LJ/8
 5vxV7gsd9+bOrNq+L/TKoYO5pn6BuY5hDXNZNk/g71MWEuTy/1mawljvPYNlzZJFjxtcroerqHJ
 MjuJIUfXy2PjN69T2HkEvjcezFv9eH/vS9CVn8T/521cbuX4AAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The plane only initializes a pristine state in its reset hook
using drm_atomic_helper_plane_reset(), which is equivalent to what
atomic_create_state expects. Convert to it.

The conversion was done using the following Coccinelle semantic patch:

@@
identifier funcs;
symbol drm_atomic_helper_plane_reset;
symbol drm_atomic_helper_plane_create_state;
@@

struct drm_plane_funcs funcs = {
  ...,
- .reset = drm_atomic_helper_plane_reset,
+ .atomic_create_state = drm_atomic_helper_plane_create_state,
  ...,
};

@match_struct_reset@
identifier funcs, reset_func;
@@
struct drm_plane_funcs funcs = {
    ...,
    .reset = reset_func,
    ...,
};

@reset_uses_helpers depends on match_struct_reset@
identifier match_struct_reset.reset_func;
@@

 void reset_func(...)
 {
 	<+...
(
 	__drm_atomic_helper_plane_reset(...);
|
	__drm_gem_reset_shadow_plane(...);
)
 	...+>
 }

@match_struct_destroy@
identifier funcs, destroy_func;
@@
struct drm_plane_funcs funcs = {
    ...,
    .atomic_destroy_state = destroy_func,
    ...,
};

@script:python renamed_func@
old_name << match_struct_reset.reset_func;
new_name;
@@
if old_name.endswith("_reset"):
    coccinelle.new_name = old_name.replace("_reset", "_create_state")
else:
    coccinelle.new_name = old_name

@update_struct depends on match_struct_reset && reset_uses_helpers@
identifier match_struct_reset.funcs, match_struct_reset.reset_func;
identifier renamed_func.new_name;
@@
struct drm_plane_funcs funcs = {
    ...,
-   .reset = reset_func,
+   .atomic_create_state = new_name,
    ...,
};

@drop_destroy depends on update_struct && match_struct_destroy@
identifier match_struct_reset.reset_func;
identifier match_struct_destroy.destroy_func;
identifier container_func;
identifier P;
symbol drm_atomic_helper_plane_destroy_state;
symbol __drm_atomic_helper_plane_destroy_state;
@@

 void reset_func(struct drm_plane *P)
 {
 	...
(
-	if (P->state) {
- 		<+...
(
-		drm_atomic_helper_plane_destroy_state(P, P->state);
|
-		__drm_atomic_helper_plane_destroy_state(P->state);
|
-		P->funcs->atomic_destroy_state(P, P->state);
|
-		destroy_func(P, P->state);
)
- 		...+>
- 	}
|
-	drm_WARN_ON_ONCE(P->dev, P->state);
|
-	WARN_ON(P->state);
)
 	...
(
-	kfree(P->state);
|
-	kfree(container_func(P->state));
|
 	// kfree is optional
)
(
-	P->state = NULL;
|
 	// plane->state clearing is optional
)
 	...
 }

@drop_destroy_mtk depends on update_struct@
identifier P;
symbol __drm_atomic_helper_plane_destroy_state;
symbol to_mtk_plane_state;
@@

 void mtk_plane_reset(struct drm_plane *P)
 {
 	...
-	if (P->state) {
-		__drm_atomic_helper_plane_destroy_state(P->state);
-		...
-	} else {
 		...
-	}
 	...
 }

@transform_nv50_wndw depends on update_struct@
identifier S;
@@

 void nv50_wndw_reset(...)
 {
 	...
-	if (WARN_ON(!(S = kzalloc_obj(*S))))
+	S = kzalloc_obj(*S);
+	if (WARN_ON(!S))
 		return;
 	...
 }

@transform_kzalloc depends on update_struct@
identifier match_struct_reset.reset_func;
identifier P, S;
statement ST;
statement list STL;
@@

 void reset_func(struct drm_plane *P)
 {
 	<...
 	S = kzalloc_obj(*S);
(
-	if (S)
-	{
-		STL
-	}
+	if (!S) return;
+
+	STL
|
-	if (S) ST
+	if (!S) return;
+
+	ST
)
	...>
 }

@transform_body depends on update_struct@
identifier match_struct_reset.reset_func;
identifier renamed_func.new_name;
identifier S, P;
expression PS;
@@
- void reset_func(struct drm_plane *P)
+ struct drm_plane_state *new_name(struct drm_plane *P)
{
	...
 	S = kzalloc_obj(*S);
	...
(
 	if (!S) {
		...
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
|
 	if (WARN_ON(!S)) {
		...
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
|
 	if (S == NULL) {
 		...
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
)
	...
(
-	__drm_atomic_helper_plane_reset(P, PS);
+	__drm_atomic_helper_plane_state_init(PS, P);
|
-	__drm_gem_reset_shadow_plane(P, PS);
+	__drm_gem_shadow_plane_state_init(P, PS);
)
	...
}

@update_early_return depends on update_struct@
identifier match_struct_reset.reset_func;
identifier renamed_func.new_name;
identifier P;
expression PS;
@@
 struct drm_plane_state *new_name(struct drm_plane *P)
{
	<+...
-	return;
+	return ERR_PTR(-EINVAL);
	...+>
}

@update_return_plane depends on update_struct@
identifier match_struct_reset.reset_func;
identifier renamed_func.new_name;
identifier P;
expression PS;
@@
 struct drm_plane_state *new_name(struct drm_plane *P)
{
	...
 	__drm_atomic_helper_plane_state_init(PS, P);
	...
+
+	return PS;
}

@update_return_shadow depends on update_struct@
identifier renamed_func.new_name;
identifier P;
expression PS;
@@
 struct drm_plane_state *new_name(struct drm_plane *P)
{
	...
 	__drm_gem_shadow_plane_state_init(P, PS);
	...
+
+	return &PS->base;
}

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: airlied@redhat.com
Cc: dmitry.osipenko@collabora.com
Cc: gurchetansingh@chromium.org
Cc: kraxel@redhat.com
Cc: olvaffe@gmail.com
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 1d1b27ece62a..52971864db50 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -89,11 +89,11 @@ drm_plane_state *virtio_gpu_plane_duplicate_state(struct drm_plane *plane)
 }
 
 static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state = drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state = virtio_gpu_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
 static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,

-- 
2.55.0

