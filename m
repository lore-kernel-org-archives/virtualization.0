From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: unbind vgacon
Date: Thu, 21 Feb 2019 12:26:40 +0100
Message-ID: <20190221112640.vob3qxyligudm6io__19782.5627679535$1550748646$gmane$org@sirius.home.kraxel.org>
References: <20190220143640.9970-1-kraxel@redhat.com>
	<20190221095751.GN2665@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190221095751.GN2665@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> > +	/* unbind vgacon to make sure it doesn't touch our vga registers */
> > +	console_lock();
> > +	ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, true);
> > +	console_unlock();
> 
> Still seems very late, in i915 we kick out vgacon as pretty much the first
> thing in driver load. See i915_kick_out_vgacon.

So the idea isn't completely silly ...

thanks for the pointer,
  Gerd
