Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ED0C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 13:57:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2CA23ECD
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 13:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2CA23ECD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 73A38873E3;
	Fri, 11 Dec 2020 13:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id II5mWwFj-kGi; Fri, 11 Dec 2020 13:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2EAD87385;
	Fri, 11 Dec 2020 13:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9352FC0893;
	Fri, 11 Dec 2020 13:57:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7706DC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 13:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5CEE9872BA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 13:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n+7BoseCGEHy
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 13:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 004E9872B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 13:57:07 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id t4so9092084wrr.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 05:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=/kA40mSIrLnZ0RgEQ2Dpjs3F6f+M4jjau+UbsX3Ywow=;
 b=EcQVLUcdBvbn1YsbP+wEwu1A/ghGuwHAY6/pixBgGog1lTm6KJ/W3BmCKt7jdBZTeI
 +yko0DpUL1XuCQGbX3coFwO6rjq6p5HLxNbUd+YNtgsKTldh6m4NU8OYl7lyw94iNvXv
 LEl3H4SpoWT3lNz5NT7cW8Nip6LLX4Ic77uYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/kA40mSIrLnZ0RgEQ2Dpjs3F6f+M4jjau+UbsX3Ywow=;
 b=bXvFUImBPMLug8Abr00EXbLeFeT3bbaHDJXazVVZ2rFBLnzAhjVqpPXEYc+7GXDBux
 fBxX8xyTcSuyyOmdpkXqNkpyds8rBeOB86mql7ATc3Oj8GpHHyuu96oNQLtUrKGZxXui
 rwgYRli43vR6DrOGBPTVcSUSbi+nC+V3yDAmTBAyeYxGsg431cbTULoRoN5xSVZq10nt
 GvI6aa7y5yHS0t9xiWsOPDi1vciiFSs3i1hXLMhb3uK3kAq1TM8f2n3cw+ELbljyB9vD
 HpN/xhwyvIl0CZt1Bzr4v60/aLHWRWj+jvFXn0s3p/erfYt/agA+jeahbKxqHp4xKjXi
 HmSQ==
X-Gm-Message-State: AOAM533jaW84tAZPZD57jWU4xhYX9LykmieCgKu1J4ixVOb4FnBXO9KM
 SaI7qX82GbR/6g+Y+ZeVOO+99w==
X-Google-Smtp-Source: ABdhPJzDlOC0c73ofKS9HsJmwMYeq4QQFi9oMxc4voraOETJBiStS3UUdAbSSnl/S7E+WUYJRiwC+g==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr6337057wra.138.1607695026266; 
 Fri, 11 Dec 2020 05:57:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id h16sm9075486wrq.29.2020.12.11.05.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 05:57:05 -0800 (PST)
Date: Fri, 11 Dec 2020 14:57:03 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 2/8] drm/ast: Only map cursor BOs during updates
Message-ID: <20201211135703.GR401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-3-tzimmermann@suse.de>
 <20201211101833.GQ401619@phenom.ffwll.local>
 <0c628bab-e4e0-170b-e695-abf3cde13c01@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c628bab-e4e0-170b-e695-abf3cde13c01@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: eric@anholt.net, airlied@linux.ie, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
 hdegoede@redhat.com, Daniel Vetter <daniel@ffwll.ch>,
 virtualization@lists.linux-foundation.org, sean@poorly.run,
 christian.koenig@amd.com, linux-media@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 11, 2020 at 11:49:48AM +0100, Thomas Zimmermann wrote:
> =

> =

> Am 11.12.20 um 11:18 schrieb Daniel Vetter:
> > On Wed, Dec 09, 2020 at 03:25:21PM +0100, Thomas Zimmermann wrote:
> > > The HW cursor's BO used to be mapped permanently into the kernel's
> > > address space. GEM's vmap operation will be protected by locks, and
> > > we don't want to lock the BO's for an indefinate period of time.
> > > =

> > > Change the cursor code to map the HW BOs only during updates. The
> > > vmap operation in VRAM helpers is cheap, as a once estabished mapping
> > > is being reused until the BO actually moves. As the HW cursor BOs are
> > > permanently pinned, they never move at all.
> > > =

> > > v2:
> > > 	* fix typos in commit description
> > > =

> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> > =

> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > =

> > Now there's a pretty big issue here though: We can't take dma_resv_lock=
 in
> > commit_tail, because of possible deadlocks on at least gpus that do real
> > async rendering because of the dma_fences. Unfortunately my annotations
> > patches got stuck a bit, I need to refresh them.
> > =

> > Rules are you can pin and unpin stuff in prepare/cleanup_plane, and also
> > take dma_resv_lock there, but not in commit_tail in-between. So I think
> > our vmap_local needs to loose the unconditional assert_locked and requi=
re
> > either that or a pin count.
> =

> I guess my commit description is misleading when it speaks of updates.
> ast_cursor_blit() is actually called from the cursor plane's prepare_fb
> function. [1] The vmap code in ast_cursor_show() could be moved into blit=
()
> as well, I think.

Oh I failed to check this properly. Even better.

> I guess the clean solution is to integrate the cursor code with the
> modesetting code in ast_mode. From there, locks and mappings can be
> established in prepare_fb and the HW state can be updated in atomic_commi=
t.

Yup. I'll still refresh my series with lockdep annotations, keeps paranoid
me at peace :-)
-Daniel

> =

> Best regards
> Thomas
> =

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/gpu/drm/ast/ast_mode.c#n646
> =

> > -Daniel
> > =

> > > ---
> > >   drivers/gpu/drm/ast/ast_cursor.c | 51 ++++++++++++++++++-----------=
---
> > >   drivers/gpu/drm/ast/ast_drv.h    |  2 --
> > >   2 files changed, 28 insertions(+), 25 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/a=
st_cursor.c
> > > index 68bf3d33f1ed..fac1ee79c372 100644
> > > --- a/drivers/gpu/drm/ast/ast_cursor.c
> > > +++ b/drivers/gpu/drm/ast/ast_cursor.c
> > > @@ -39,7 +39,6 @@ static void ast_cursor_fini(struct ast_private *ast)
> > >   	for (i =3D 0; i < ARRAY_SIZE(ast->cursor.gbo); ++i) {
> > >   		gbo =3D ast->cursor.gbo[i];
> > > -		drm_gem_vram_vunmap(gbo, &ast->cursor.map[i]);
> > >   		drm_gem_vram_unpin(gbo);
> > >   		drm_gem_vram_put(gbo);
> > >   	}
> > > @@ -53,14 +52,13 @@ static void ast_cursor_release(struct drm_device =
*dev, void *ptr)
> > >   }
> > >   /*
> > > - * Allocate cursor BOs and pins them at the end of VRAM.
> > > + * Allocate cursor BOs and pin them at the end of VRAM.
> > >    */
> > >   int ast_cursor_init(struct ast_private *ast)
> > >   {
> > >   	struct drm_device *dev =3D &ast->base;
> > >   	size_t size, i;
> > >   	struct drm_gem_vram_object *gbo;
> > > -	struct dma_buf_map map;
> > >   	int ret;
> > >   	size =3D roundup(AST_HWC_SIZE + AST_HWC_SIGNATURE_SIZE, PAGE_SIZE);
> > > @@ -77,15 +75,7 @@ int ast_cursor_init(struct ast_private *ast)
> > >   			drm_gem_vram_put(gbo);
> > >   			goto err_drm_gem_vram_put;
> > >   		}
> > > -		ret =3D drm_gem_vram_vmap(gbo, &map);
> > > -		if (ret) {
> > > -			drm_gem_vram_unpin(gbo);
> > > -			drm_gem_vram_put(gbo);
> > > -			goto err_drm_gem_vram_put;
> > > -		}
> > > -
> > >   		ast->cursor.gbo[i] =3D gbo;
> > > -		ast->cursor.map[i] =3D map;
> > >   	}
> > >   	return drmm_add_action_or_reset(dev, ast_cursor_release, NULL);
> > > @@ -94,7 +84,6 @@ int ast_cursor_init(struct ast_private *ast)
> > >   	while (i) {
> > >   		--i;
> > >   		gbo =3D ast->cursor.gbo[i];
> > > -		drm_gem_vram_vunmap(gbo, &ast->cursor.map[i]);
> > >   		drm_gem_vram_unpin(gbo);
> > >   		drm_gem_vram_put(gbo);
> > >   	}
> > > @@ -168,31 +157,38 @@ static void update_cursor_image(u8 __iomem *dst=
, const u8 *src, int width, int h
> > >   int ast_cursor_blit(struct ast_private *ast, struct drm_framebuffer=
 *fb)
> > >   {
> > >   	struct drm_device *dev =3D &ast->base;
> > > -	struct drm_gem_vram_object *gbo;
> > > -	struct dma_buf_map map;
> > > -	int ret;
> > > -	void *src;
> > > +	struct drm_gem_vram_object *dst_gbo =3D ast->cursor.gbo[ast->cursor=
.next_index];
> > > +	struct drm_gem_vram_object *src_gbo =3D drm_gem_vram_of_gem(fb->obj=
[0]);
> > > +	struct dma_buf_map src_map, dst_map;
> > >   	void __iomem *dst;
> > > +	void *src;
> > > +	int ret;
> > >   	if (drm_WARN_ON_ONCE(dev, fb->width > AST_MAX_HWC_WIDTH) ||
> > >   	    drm_WARN_ON_ONCE(dev, fb->height > AST_MAX_HWC_HEIGHT))
> > >   		return -EINVAL;
> > > -	gbo =3D drm_gem_vram_of_gem(fb->obj[0]);
> > > -
> > > -	ret =3D drm_gem_vram_vmap(gbo, &map);
> > > +	ret =3D drm_gem_vram_vmap(src_gbo, &src_map);
> > >   	if (ret)
> > >   		return ret;
> > > -	src =3D map.vaddr; /* TODO: Use mapping abstraction properly */
> > > +	src =3D src_map.vaddr; /* TODO: Use mapping abstraction properly */
> > > -	dst =3D ast->cursor.map[ast->cursor.next_index].vaddr_iomem;
> > > +	ret =3D drm_gem_vram_vmap(dst_gbo, &dst_map);
> > > +	if (ret)
> > > +		goto err_drm_gem_vram_vunmap;
> > > +	dst =3D dst_map.vaddr_iomem; /* TODO: Use mapping abstraction prope=
rly */
> > >   	/* do data transfer to cursor BO */
> > >   	update_cursor_image(dst, src, fb->width, fb->height);
> > > -	drm_gem_vram_vunmap(gbo, &map);
> > > +	drm_gem_vram_vunmap(dst_gbo, &dst_map);
> > > +	drm_gem_vram_vunmap(src_gbo, &src_map);
> > >   	return 0;
> > > +
> > > +err_drm_gem_vram_vunmap:
> > > +	drm_gem_vram_vunmap(src_gbo, &src_map);
> > > +	return ret;
> > >   }
> > >   static void ast_cursor_set_base(struct ast_private *ast, u64 addres=
s)
> > > @@ -243,17 +239,26 @@ static void ast_cursor_set_location(struct ast_=
private *ast, u16 x, u16 y,
> > >   void ast_cursor_show(struct ast_private *ast, int x, int y,
> > >   		     unsigned int offset_x, unsigned int offset_y)
> > >   {
> > > +	struct drm_device *dev =3D &ast->base;
> > > +	struct drm_gem_vram_object *gbo =3D ast->cursor.gbo[ast->cursor.nex=
t_index];
> > > +	struct dma_buf_map map;
> > >   	u8 x_offset, y_offset;
> > >   	u8 __iomem *dst;
> > >   	u8 __iomem *sig;
> > >   	u8 jreg;
> > > +	int ret;
> > > -	dst =3D ast->cursor.map[ast->cursor.next_index].vaddr;
> > > +	ret =3D drm_gem_vram_vmap(gbo, &map);
> > > +	if (drm_WARN_ONCE(dev, ret, "drm_gem_vram_vmap() failed, ret=3D%d\n=
", ret))
> > > +		return;
> > > +	dst =3D map.vaddr_iomem; /* TODO: Use mapping abstraction properly =
*/
> > >   	sig =3D dst + AST_HWC_SIZE;
> > >   	writel(x, sig + AST_HWC_SIGNATURE_X);
> > >   	writel(y, sig + AST_HWC_SIGNATURE_Y);
> > > +	drm_gem_vram_vunmap(gbo, &map);
> > > +
> > >   	if (x < 0) {
> > >   		x_offset =3D (-x) + offset_x;
> > >   		x =3D 0;
> > > diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_=
drv.h
> > > index ccaff81924ee..f871fc36c2f7 100644
> > > --- a/drivers/gpu/drm/ast/ast_drv.h
> > > +++ b/drivers/gpu/drm/ast/ast_drv.h
> > > @@ -28,7 +28,6 @@
> > >   #ifndef __AST_DRV_H__
> > >   #define __AST_DRV_H__
> > > -#include <linux/dma-buf-map.h>
> > >   #include <linux/i2c.h>
> > >   #include <linux/i2c-algo-bit.h>
> > >   #include <linux/io.h>
> > > @@ -133,7 +132,6 @@ struct ast_private {
> > >   	struct {
> > >   		struct drm_gem_vram_object *gbo[AST_DEFAULT_HWC_NUM];
> > > -		struct dma_buf_map map[AST_DEFAULT_HWC_NUM];
> > >   		unsigned int next_index;
> > >   	} cursor;
> > > -- =

> > > 2.29.2
> > > =

> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> =





-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
