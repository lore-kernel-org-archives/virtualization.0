From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Date: Mon, 11 Mar 2019 14:39:19 +0100
Message-ID: <20190311133919.azyhtioxf23duf3g__6480.20692621998$1552311570$gmane$org@sirius.home.kraxel.org>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
	<20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
	<20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
	<20190311130716.6hjqci43clic5lxx@sirius.home.kraxel.org>
	<20190311132358.GF2665@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190311132358.GF2665@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > IIRC the drm code checks for the atomic_enable callback presence to
> > figure whenever it should take the atomic or legacy code paths.
> 
> It should check for drm_driver->mode_config.funcs.atomic_commit for that,
> see drm_drv_uses_atomic_modeset(). Anything else should be a bug.
> 
> Or do you mean the fallback to the old crtc helper prepare/commit
> callbacks?

Probably the later.  There was some reason why I've left in the empty
bochs_crtc_atomic_enable() callback ...

cheers,
  Gerd
