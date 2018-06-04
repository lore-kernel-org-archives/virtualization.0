From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: Call qxl_bo_unref outside atomic context
Date: Mon, 4 Jun 2018 09:37:23 +0200
Message-ID: <20180604073723.ld7b2h5veqsxoun6__4007.06972363896$1528097759$gmane$org@sirius.home.kraxel.org>
References: <20180601200532.13619-1-jcline@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180601200532.13619-1-jcline@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Cline <jcline@redhat.com>
Cc: Ray Strode <rstrode@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 01, 2018 at 04:05:32PM -0400, Jeremy Cline wrote:
> "qxl_bo_unref" may sleep, but calling "qxl_release_map" causes
> "preempt_disable()" to be called and "preempt_enable()" isn't called
> until "qxl_release_unmap" is used. Move the call to "qxl_bo_unref" out
> from in between the two to avoid sleeping from an atomic context.
> 
> This issue can be demonstrated on a kernel with CONFIG_LOCKDEP=y by
> creating a VM using QXL, using a desktop environment using Xorg, then
> moving the cursor on or off a window.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1571128
> Fixes: 9428088c90b6 ("drm/qxl: reapply cursor after resetting primary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Pushed to drm-misc-fixes.

thanks,
  Gerd
