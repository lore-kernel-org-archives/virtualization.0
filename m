From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Date: Thu, 21 Feb 2019 16:11:39 +0100
Message-ID: <20190221151139.ul2ihzd2yi4m47tf__19093.0464350217$1550762130$gmane$org@sirius.home.kraxel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
	<20190221113534.20764-3-kraxel@redhat.com>
	<20190221122011.GP2665@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190221122011.GP2665@phenom.ffwll.local>
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

  Hi,

> I was thinking of checking whether pdev is a VGA class device and whether
> it decodes vga access, and in that case automatically calling

How can I figure that?  Ok, class is easy, but decode?  pci.h offers
functions to set vga decode but not to get that info ...

thanks,
  Gerd
