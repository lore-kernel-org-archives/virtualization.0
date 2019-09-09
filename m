From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Xorg indefinitely hangs in kernelspace
Date: Mon, 9 Sep 2019 07:52:19 +0200
Message-ID: <20190909055219.q44k27cczwkuio3z@sirius.home.kraxel.org>
References: <20190906055322.17900-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190906055322.17900-1-hdanton@sina.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hillf Danton <hdanton@sina.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Jaak Ristioja <jaak@ristioja.ee>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

--verbose please.  Do you see the same hang?  Does the patch fix it?

> --- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> @@ -97,8 +97,9 @@ int ttm_eu_reserve_buffers(struct ww_acq
>  			   struct list_head *dups, bool del_lru)
[ ... ]

> +			if (locked)
> +				ttm_eu_backoff_reservation_reverse(list, entry);

Hmm, I think the patch is wrong.  As far I know it is the qxl drivers's
job to call ttm_eu_backoff_reservation().  Doing that automatically in
ttm will most likely break other ttm users.

So I guess the call is missing in the qxl driver somewhere, most likely
in some error handling code path given that this bug is a relatively
rare event.

There is only a single ttm_eu_reserve_buffers() call in qxl.
So how about this?

----------------------- cut here --------------------
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 312216caeea2..2f9950fa0b8d 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -262,18 +262,20 @@ int qxl_release_reserve_list(struct qxl_release *release, bool no_intr)
 	ret = ttm_eu_reserve_buffers(&release->ticket, &release->bos,
 				     !no_intr, NULL, true);
 	if (ret)
-		return ret;
+		goto err_backoff;
 
 	list_for_each_entry(entry, &release->bos, tv.head) {
 		struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
 
 		ret = qxl_release_validate_bo(bo);
-		if (ret) {
-			ttm_eu_backoff_reservation(&release->ticket, &release->bos);
-			return ret;
-		}
+		if (ret)
+			goto err_backoff;
 	}
 	return 0;
+
+err_backoff:
+	ttm_eu_backoff_reservation(&release->ticket, &release->bos);
+	return ret;
 }
 
 void qxl_release_backoff_reserve_list(struct qxl_release *release)
----------------------- cut here --------------------

cheers,
  Gerd
