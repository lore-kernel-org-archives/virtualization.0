From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Fri, 17 Jan 2020 13:58:25 +0100
Message-ID: <20200117125825.3in2t2m6nxbblsaf@sirius.home.kraxel.org>
References: <20200110163211.GB29736@mail-itl>
 <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
 <20200115003356.GL2507@mail-itl>
 <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
 <20200115134119.GP1314@mail-itl>
 <20200115141353.3kse3uj2mg6ik6k5@sirius.home.kraxel.org>
 <20200115142741.GM2507@mail-itl>
 <20200115161635.ekrnk5rmjqbxxu77@sirius.home.kraxel.org>
 <20200116025232.GN2507@mail-itl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200116025232.GN2507@mail-itl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> Should switching to bochsdrmfb be deferred until efifb gets properly
> destroyed? How?

Should be in do_remove_conflicting_framebuffers, everyone might run into
this.  So lets try wait for all (other) references went away:

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d04554959ea7..2d4911cc7ec4 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1726,7 +1726,9 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	fbcon_fb_unregistered(fb_info);
 	console_unlock();
 
-	/* this may free fb info */
+	while (atomic_read(&fb_info->count) > 1)
+		msleep(10);
+	/* this will free fb info */
 	put_fb_info(fb_info);
 }
