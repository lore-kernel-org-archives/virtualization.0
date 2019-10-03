From: Hillf Danton <hdanton@sina.com>
Subject: Re: [Spice-devel] Xorg indefinitely hangs in kernelspace
Date: Thu,  3 Oct 2019 16:23:30 +0800
Message-ID: <20191003082330.15260-1-hdanton@sina.com>
References: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
	<20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
	<e4b7d889-15f3-0c90-3b9f-d395344499c0@ristioja.ee>
	<ccafdbaf-7f8e-8616-5543-2a178bd63828@ristioja.ee>
	<1174991123.3693721.1569850187145.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1174991123.3693721.1569850187145.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frediano Ziglio <fziglio@redhat.com>, Jaak Ristioja <jaak@ristioja.ee>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, spice-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 3 Oct 2019 09:45:55 +0300 Jaak Ristioja wrote:
> On 30.09.19 16:29, Frediano Ziglio wrote:
> >   Why didn't you update bug at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1813620?
> > I know it can seem tedious but would help tracking it.
> 
> I suppose the lack on centralized tracking and handling of Linux kernel
> bugs is a delicate topic, so I don't want to rant much more on that.
> Updating that bug would tedious and time-consuming indeed, which is why
> I haven't done that. To be honest, I don't have enough time and motivation.

Give the diff below a go only when it is convenient and only if it makes
a bit of sense to you.

--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -110,6 +110,7 @@ int ttm_eu_reserve_buffers(struct ww_acq
 		ww_acquire_init(ticket, &reservation_ww_class);
 
 	list_for_each_entry(entry, list, head) {
+		bool lockon = false;
 		struct ttm_buffer_object *bo = entry->bo;
 
 		ret = __ttm_bo_reserve(bo, intr, (ticket == NULL), ticket);
@@ -150,6 +151,7 @@ int ttm_eu_reserve_buffers(struct ww_acq
 				dma_resv_lock_slow(bo->base.resv, ticket);
 				ret = 0;
 			}
+			lockon = !ret;
 		}
 
 		if (!ret && entry->num_shared)
@@ -157,6 +159,8 @@ int ttm_eu_reserve_buffers(struct ww_acq
 								entry->num_shared);
 
 		if (unlikely(ret != 0)) {
+			if (lockon)
+				dma_resv_unlock(bo->base.resv);
 			if (ret == -EINTR)
 				ret = -ERESTARTSYS;
 			if (ticket) {
