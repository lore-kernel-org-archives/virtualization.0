From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Date: Fri, 22 Feb 2019 08:14:18 +0100
Message-ID: <20190222071418.mafr3rtrtspd44fr__18938.9244232856$1550819949$gmane$org@sirius.home.kraxel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
	<20190221113534.20764-3-kraxel@redhat.com>
	<20190221122011.GP2665@phenom.ffwll.local>
	<20190221151139.ul2ihzd2yi4m47tf@sirius.home.kraxel.org>
	<CAKMK7uE+YzvBuaJVrNc0VzTQKmnDzNMoZDXohrh0M+PAfRFcBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uE+YzvBuaJVrNc0VzTQKmnDzNMoZDXohrh0M+PAfRFcBw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> PCI_COMMAND_MEM and PCI_COMMAND_IO. There doesn't seem to be any
> separate bits really. That's at least what I've gleaned from vgaarb.c.
> The magic legacy vga decode bits only seem to exist on bridges, maybe
> we can extract that logic from vgaarb.c (yes this is all a bit
> spiralling out of control).

Also makes me wonder whenever vgaarb is the better place (compared to
drm_fb_helper).  Tried that, doesn't look too bad, should continue
working with CONFIG_FB=n.  Will send patches in a moment.

cheers,
  Gerd
