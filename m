From: Hillf Danton <hdanton@sina.com>
Subject: Re: Xorg indefinitely hangs in kernelspace
Date: Mon,  9 Sep 2019 20:12:50 +0800
Message-ID: <20190909121250.11176-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, Jaak Ristioja <jaak@ristioja.ee>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On Mon, 9 Sep 2019 from Gerd Hoffmann <kraxel@redhat.com>
>
> Hmm, I think the patch is wrong.

Hmm...it should have added change only in the error path, leaving locks
for drivers to release if job is done with no error returned.

> As far I know it is the qxl drivers's
> job to call ttm_eu_backoff_reservation().

Like other drivers, qxl is currently doing the right.

> Doing that automatically in
> ttm will most likely break other ttm users.
>
You are right. They are responsible for doing backoff if error happens
while validating buffers afterwards.


--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -111,8 +111,10 @@ int ttm_eu_reserve_buffers(struct ww_acq
 
 	list_for_each_entry(entry, list, head) {
 		struct ttm_buffer_object *bo = entry->bo;
+		bool lockon;
 
 		ret = __ttm_bo_reserve(bo, intr, (ticket == NULL), ticket);
+		lockon = !ret;
 		if (!ret && unlikely(atomic_read(&bo->cpu_writers) > 0)) {
 			reservation_object_unlock(bo->resv);
 
@@ -151,6 +153,7 @@ int ttm_eu_reserve_buffers(struct ww_acq
 				ret = 0;
 			}
 		}
+		lockon = !ret;
 
 		if (!ret && entry->num_shared)
 			ret = reservation_object_reserve_shared(bo->resv,
@@ -163,6 +166,8 @@ int ttm_eu_reserve_buffers(struct ww_acq
 				ww_acquire_done(ticket);
 				ww_acquire_fini(ticket);
 			}
+			if (lockon)
+				ttm_eu_backoff_reservation_reverse(list, entry);
 			return ret;
 		}
 
--
