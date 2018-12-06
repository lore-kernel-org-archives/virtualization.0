From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: use qxl_num_crtc directly
Date: Thu, 6 Dec 2018 14:49:33 +0100
Message-ID: <20181206134933.krvdvoz52lkpewb5__27623.593240469$1544104054$gmane$org@sirius.home.kraxel.org>
References: <20181206103352.20587-1-kraxel@redhat.com>
	<207905511.48580418.1544093965441.JavaMail.zimbra@redhat.com>
	<20181206114217.vog4fgae73us437u@sirius.home.kraxel.org>
	<1902655248.48590444.1544100790071.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1902655248.48590444.1544100790071.JavaMail.zimbra@redhat.com>
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

On Thu, Dec 06, 2018 at 07:53:10AM -0500, Frediano Ziglio wrote:
> > 
> > On Thu, Dec 06, 2018 at 05:59:25AM -0500, Frediano Ziglio wrote:
> > > > 
> > > > Just use qxl_num_crtc directly everywhere instead of using
> > > > qdev->monitors_config->max_allowed.  Drops pointless indirection
> > > > and also is less confusing.
> > > > 
> > > 
> > > To me is MORE confusing, why comparing number of something with
> > > another number? Previously code was comparing number of monitors
> > > with number of monitors, not number of CRTs with number of
> > > monitors.
> > 
> > Yes, spice/qxl and drm/kms use slightly different terminology.
> > 
> > drm crtc == qxl monitor.
> > drm framebuffer == qxl surface.
> > 
> > You need to know that anyway when looking at the qxl ksm code.  We
> > have function names like qxl_crtc_update_monitors_config().  I fail
> > to see why that is a problem ...
> > 
> > cheers,
> >   Gerd
> 
> I don't see any problem too but you are explaining to me
> why your rationale "and also is less confusing" does not
> stand.

Well, it's less confusing because it takes away an indirection (not
because of the naming).

qdev->monitors_config->max_allowed is effectively set by a module
parameter.  So using the module parameter variable qxl_num_crtc
directly is better IMO.  The kernel doesn't need to dereference pointers
each time it needs the value, and when reading the code you don't have
to trace where and why qdev->monitors_config->max_allowed is set.

cheers,
  Gerd
