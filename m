From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3 09/26] compat_ioctl: move drivers to
 compat_ptr_ioctl
Date: Tue, 16 Apr 2019 22:31:24 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1904162230560.9803__42646.5694721387$1555718290$gmane$org@cbobk.fhfr.pm>
References: <20190416202013.4034148-1-arnd@arndb.de>
	<20190416202013.4034148-10-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190416202013.4034148-10-arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-usb@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, virtualization@lists.linux-foundation.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-mtd@lists.infradead.org, Peter Huewe <peterhuewe@gmx.de>, linux1394-devel@lists.sourceforge.net, linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org, Jason Gunthorpe <jgg@ziepe.ca>, y2038@lists.linaro.org, Richard Weinberger <richard@nod.at>, Marek Vasut <marek.vasut@gmail.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>, Alexandre Torgue <alexandre.torgue@st.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Willem
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 16 Apr 2019, Arnd Bergmann wrote:

> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/ppdev.c              | 12 +---------
>  drivers/char/tpm/tpm_vtpm_proxy.c | 12 +---------
>  drivers/firewire/core-cdev.c      | 12 +---------
>  drivers/hid/usbhid/hiddev.c       | 11 +--------

For hiddev.c:

Reviewed-by: Jiri Kosina <jkosina@suse.cz> 

-- 
Jiri Kosina
SUSE Labs
