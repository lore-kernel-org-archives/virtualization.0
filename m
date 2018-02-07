From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [vhost:vhost 20/20] ERROR: "page_poisoning_enabled"
	[drivers/virtio/virtio_balloon.ko] undefined!
Date: Wed, 7 Feb 2018 03:26:31 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739432E31__29399.1370512687$1517973903$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <201802070951.paWH8wop%fengguang.wu@intel.com>
	<5A7A639F.5020402@intel.com>
	<20180207044338-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180207044338-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Liang Li <liang.z.li@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kbuild-all@01.org" <kbuild-all@01.org>, "Wu,
	Fengguang" <fengguang.wu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, February 7, 2018 10:52 AM, Michael S. Tsirkin wrote:
> On Wed, Feb 07, 2018 at 10:25:35AM +0800, Wei Wang wrote:
> > On 02/07/2018 09:26 AM, kbuild test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> vhost
> > > head:   96bcd04462b99e2c80e09f6537770a0ca6b288d0
> > > commit: 96bcd04462b99e2c80e09f6537770a0ca6b288d0 [20/20]
> > > virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> > > config: ia64-allmodconfig (attached as .config)
> > > compiler: ia64-linux-gcc (GCC) 7.2.0
> > > reproduce:
> > >          wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          git checkout 96bcd04462b99e2c80e09f6537770a0ca6b288d0
> > >          # save the attached .config to linux build tree
> > >          make.cross ARCH=ia64
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/auxdisplay/img-ascii-lcd.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-
> ath79.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-
> iop.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/iio/accel/kxsd9-i2c.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/iio/adc/qcom-vadc-common.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/media/platform/tegra-cec/tegra_cec.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/mtd/nand/denali_pci.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/pinctrl/pxa/pinctrl-pxa2xx.o
> > >     see include/linux/module.h for more information
> > >     WARNING: modpost: missing MODULE_LICENSE() in
> drivers/power/reset/zx-reboot.o
> > >     see include/linux/module.h for more information
> > > > > ERROR: "page_poisoning_enabled" [drivers/virtio/virtio_balloon.ko]
> undefined!
> >
> > page_poisoning_enabled needs to be exposed. I'll send a small patch to
> > add EXPORT_SYMBOL_GPL(page_poisoning_enabled).
> >
> >
> > Best,
> > Wei
> 
> This will probably miss this release cycle.

OK if it's too difficult.  My bad, didn't capture that, too sad :(

I just resent that patch with the fix.

Best,
Wei
