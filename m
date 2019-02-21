From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Date: Thu, 21 Feb 2019 16:17:03 +0100
Message-ID: <CAKMK7uE+YzvBuaJVrNc0VzTQKmnDzNMoZDXohrh0M+PAfRFcBw__22168.7347556994$1550762393$gmane$org@mail.gmail.com>
References: <20190221113534.20764-1-kraxel@redhat.com>
	<20190221113534.20764-3-kraxel@redhat.com>
	<20190221122011.GP2665@phenom.ffwll.local>
	<20190221151139.ul2ihzd2yi4m47tf@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190221151139.ul2ihzd2yi4m47tf@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2019 at 4:11 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > I was thinking of checking whether pdev is a VGA class device and whether
> > it decodes vga access, and in that case automatically calling
>
> How can I figure that?  Ok, class is easy, but decode?  pci.h offers
> functions to set vga decode but not to get that info ...

PCI_COMMAND_MEM and PCI_COMMAND_IO. There doesn't seem to be any
separate bits really. That's at least what I've gleaned from vgaarb.c.
The magic legacy vga decode bits only seem to exist on bridges, maybe
we can extract that logic from vgaarb.c (yes this is all a bit
spiralling out of control).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
