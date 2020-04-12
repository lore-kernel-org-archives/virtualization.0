From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] vhost: fixes, vdpa
Date: Sun, 12 Apr 2020 04:37:55 -0400
Message-ID: <20200412041730-mutt-send-email-mst@kernel.org>
References: <20200406171124-mutt-send-email-mst@kernel.org>
 <CAHk-=wg7sMywb2V8gifhpUDE=DWQTvg1wDieKVc0UoOSsOrynw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7sMywb2V8gifhpUDE=DWQTvg1wDieKVc0UoOSsOrynw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Hildenbrand <david@redhat.com>, eperezma@redhat.com, "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>, lingshan.zhu@intel.com, Michal Hocko <mhocko@kernel.org>, Nadav Amit <namit@vmware.com>, Randy Dunlap <rdunlap@infradead.org>, David Rientjes <rientjes@google.com>, tiwei.bie@intel.com, tysand@google.comCc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, li
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 11, 2020 at 09:38:05AM -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 2:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The new vdpa subsystem with two first drivers.
> 
> So this one is really annoying to configure.
> 
> First it asks for vDPA driver for virtio devices (VIRTIO_VDPA) support.
> 
> If you say 'n', it then asks *again* for VDPA drivers (VDPA_MENU).
> 
> And then when you say 'n' to *that* it asks you for Vhost driver for
> vDPA-based backend (VHOST_VDPA).
> 
> This kind of crazy needs to stop.
> 
> Doing kernel configuration is not supposed to be like some truly
> horrendously boring Colossal Cave Adventure game where you have to
> search for a way out of maze of twisty little passages, all alike.
> 
>                 Linus

Hmm it's a good point.  Thanks, Linus!
I think this was copied from virtio which has drivers spread all over
the tree.

Jason, if VDPA_MENU is off, then we don't have any drivers. So what's
the point of selecting VDPA core from vhost/virtio then?

So how about this? Lightly tested. Jason, could you pls play with this
a bit more and let me know if you see any issues?

-->
vdpa: make vhost, virtio depend on menu

If user did not configure any vdpa drivers, neither vhost
nor virtio vdpa are going to be useful. So there's no point
in prompting for these and selecting vdpa core automatically.
Simplify configuration by making virtio and vhost vdpa
drivers depend on vdpa menu entry. Once done, we no longer
need a separate menu entry, so also get rid of this.
While at it, fix up the IFC entry: VDPA->vDPA for consistency
with other places.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index cb6b17323eb2..3b43411361fe 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -64,7 +64,7 @@ config VHOST_VDPA
 	tristate "Vhost driver for vDPA-based backend"
 	depends on EVENTFD
 	select VHOST
-	select VDPA
+	depends on VDPA_MENU
 	help
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest virtio devices with the vDPA-based backends.
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 2aadf398d8cc..bf13755a5ba5 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -45,7 +45,7 @@ config VIRTIO_PCI_LEGACY
 
 config VIRTIO_VDPA
 	tristate "vDPA driver for virtio devices"
-	select VDPA
+	depend on VDPA_MENU
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual
