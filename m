From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to
	correct place
Date: Mon, 28 Jan 2019 12:40:41 +0100
Message-ID: <20190128114041.ujyrq4ls6kbi7w3a__34153.8607304514$1548681158$gmane$org@sirius.home.kraxel.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-11-kraxel@redhat.com>
	<b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
	<20190128081005.j6z2ecnytuocfidh@sirius.home.kraxel.org>
	<44e41026-e091-659d-ac9c-fefa47e2335b@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <44e41026-e091-659d-ac9c-fefa47e2335b@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > If the above explains things better to you I should probably replace the
> > commit message with that.
> 
> This is actually my first review of a driver that I'm not familiar with.
> I'm not quite sure how much in depth understanding that is required to
> put my ack on it.

Usually I try to show that by picking either Reviewed-by (I'm confident
the changes are fine) or Acked-by (Changes look sane, but I don't know
the code base and/or hardware good enough to be sure).

> Going further into the patchset I realised that
> there's no way that I can verify the logic without being intimate with
> the driver.

Yep.  Same for me when looking at patches for other drivers.  I think
this is one reason why it isn't that easy to get patches for drivers
reviewed where effectively only a single maintainer/developer is working
on.

> I liked your expanded explanation better.

Updated the commit message.

cheers,
  Gerd
