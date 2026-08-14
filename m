Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E1470425
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719526; cv=none; b=BT5vLs8PbOS5/ZGA+VAAAK98OrCctE7Q3lvipVGBMIEHxDKss+jK3kwEhaDSC6g1vEH/bby+Btx39YVdazO9Ut+I6z1yrGL8CwlyHpILH+2TD+t+fVLuFp0biCuueA67BlnKCTH2jvk+9Pq1pBpYbPUKVW6TcNGsh9EYFKHvBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719526; c=relaxed/simple;
	bh=bsKeonj3Crd7q/wfCxemOnQeMGzoZ4V7xF+G5AzyPjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtEVZNopLHkDY1J9QHTdyw6TuM2mEpeNy3RkbMkIVuHoiqU5Z8z/SCLrBsQefjK+dE/wYO3BNVhDIpg2Ct1FiMTfwh933RqxeBMa449PqMSeOM32x3sKLgfL/gz9p2KDfLwoTJWBiHDsYppvUWZOohlBHN4xAmMScv0ITUaEBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvH9+e6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvH9+e6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C661F000E9;
	Fri, 14 Aug 2026 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719523;
	bh=J1/asScdIgqZCXba+2CTFMQ8oRnF+s2Ldkae2j8yqYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hvH9+e6lOF5TKub/vnNs/eFCqX2C9IwCIUl+3J6C88Mh+/uoSXEn7cojSAxrREI2u
	 GCZszCcHjdGAsjuuiFtiJb7wVD2dTgpYef1OBReSvCGj7688Jw/xkBI7IOmSDjeZus
	 dz3vljnJqY1/eJpL9spVJY9y0vw+T9sDrq/1fxoPnzytqThXQRX1befLVl0vP6uwNM
	 1FRQ8ezGqaGsudfoQcktKU6g4XFpn2efFSzGgLQ7N19AYffwP/QVen13OoRccz97cY
	 mjFwgSb4uckqcTYjovtWW+91Ohpv4gpPhsAkPxKShmFuk9mM/uX5vmItW2baJPHaOU
	 rEU/O9ho7LIeQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:16 +0200
Subject: [PATCH v2 27/61] drm/qxl: Convert to atomic_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-27-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 airlied@redhat.com, kraxel@redhat.com, spice-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6661; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bsKeonj3Crd7q/wfCxemOnQeMGzoZ4V7xF+G5AzyPjk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OhcCe8KfmE136+DaFy7fdjmTq2EjT0S4lcfhl59dn
 /8/H97XMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACaydyljfWLGRpOiQJdp5zw0
 u6ZI3rbenOvokyv+8nTU4xie7Y6uRib6PauCmne9nPF8hXG0zO04xobDPM+ky8M/Rq7lnCfQ5Hf
 4t+Q6I9X7NosPB9xbPadF7ugCN9fi4t5Yw/e3dRhnxt31vwQA
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
Cc: kraxel@redhat.com
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 7f4178800afd..76337661c09e 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -927,11 +927,11 @@ static const struct drm_plane_helper_funcs qxl_cursor_helper_funcs = {
 
 static const struct drm_plane_funcs qxl_cursor_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_helper_destroy,
-	.reset		= drm_atomic_helper_plane_reset,
+	.atomic_create_state = drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
 static const uint32_t qxl_primary_plane_formats[] = {
@@ -949,11 +949,11 @@ static const struct drm_plane_helper_funcs primary_helper_funcs = {
 
 static const struct drm_plane_funcs qxl_primary_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_helper_destroy,
-	.reset		= drm_atomic_helper_plane_reset,
+	.atomic_create_state = drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
 static struct drm_plane *qxl_create_plane(struct qxl_device *qdev,

-- 
2.55.0

