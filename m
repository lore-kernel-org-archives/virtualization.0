From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 12/29] compat_ioctl: move drivers to compat_ptr_ioctl
Date: Tue, 30 Jul 2019 14:43:29 -0700 (PDT)
Message-ID: <20190730.144329.2267958732987589628.davem__45857.3437341087$1564523781$gmane$org@davemloft.net>
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
To: arnd@arndb.de
Cc: devel@driverdev.osuosl.org, linux-input@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com, virtualization@lists.linux-foundation.org, jgg@mellanox.com, linux-mtd@lists.infradead.org, viro@zeniv.linux.org.uk, stefanha@redhat.com, jkosina@suse.cz, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-integrity@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jul 2019 21:50:28 +0200

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

I assume this has to go via your series, thus:

Acked-by: David S. Miller <davem@davemloft.net>
