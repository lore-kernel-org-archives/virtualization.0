From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm/cirrus: remove leftover files
Date: Wed, 22 May 2019 17:06:34 +0200
Message-ID: <20190522150634.GA26677__5647.72463855974$1558537610$gmane$org@ravnborg.org>
References: <20190522103307.12711-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190522103307.12711-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 22, 2019 at 12:33:07PM +0200, Gerd Hoffmann wrote:
> cirrus_drv.h and cirrus_ttm.c are unused since commit ab3e023b1b4c
> ("drm/cirrus: rewrite and modernize driver"), apparently I ran "rm"
> instead of "git rm" on them so they are still in present the tree.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Always nice with the code removal patches.
Will you apply yourself?

	Sam
