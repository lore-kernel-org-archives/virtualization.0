From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: use qxl_num_crtc directly
Date: Thu, 6 Dec 2018 15:21:39 +0100
Message-ID: <20181206142139.afd75c6nmjsbx2m4__3369.06151283092$1544105980$gmane$org@sirius.home.kraxel.org>
References: <20181206103352.20587-1-kraxel@redhat.com>
	<207905511.48580418.1544093965441.JavaMail.zimbra@redhat.com>
	<20181206114217.vog4fgae73us437u@sirius.home.kraxel.org>
	<1902655248.48590444.1544100790071.JavaMail.zimbra@redhat.com>
	<20181206134933.krvdvoz52lkpewb5@sirius.home.kraxel.org>
	<621894308.48603466.1544105415949.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <621894308.48603466.1544105415949.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frediano Ziglio <fziglio@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > qdev->monitors_config->max_allowed is effectively set by a module
> > parameter.  So using the module parameter variable qxl_num_crtc
> > directly is better IMO.  The kernel doesn't need to dereference pointers
> > each time it needs the value, and when reading the code you don't have
> > to trace where and why qdev->monitors_config->max_allowed is set.
> 
> That should go to the commit message!
> With that the patch is fine for me.

ok, I'll improve the message.

> Maybe there's no much point on reusing the same structure used
> inside QXLRom/QXLRam but this is OT for this patch.

It's part of the qxl device ABI, the same structure is used for both
host->guest (config hint from spice-client) and guest->host (actual
configuration).

cheers,
  Gerd
