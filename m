From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 12/29] compat_ioctl: move drivers to compat_ptr_ioctl
Date: Wed, 31 Jul 2019 10:37:51 +0200
Message-ID: <20190731103751.3cc53132.cohuck__10060.3301705391$1564562998$gmane$org@redhat.com>
References: <20190730192552.4014288-1-arnd@arndb.de>
	<20190730195227.742215-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190730195227.742215-1-arnd@arndb.de>
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
Cc: devel@driverdev.osuosl.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, virtualization@lists.linux-foundation.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, linux-input@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, ceph-devel@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Jason Gunthorpe <jgg@mellanox.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 30 Jul 2019 21:50:28 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

>  drivers/vfio/vfio.c               | 39 +++----------------------------

vfio changes:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
