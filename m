From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/5] Intel MIC Card Driver Changes for Virtio Devices.
Date: Mon, 29 Jul 2013 11:28:58 +0930
Message-ID: <87txje6s9p.fsf__31434.1400204741$1375063411$gmane$org@rustcorp.com.au>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
	<ff721c257100467e8f78421ba9055b97e447551e.1374717252.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ff721c257100467e8f78421ba9055b97e447551e.1374717252.git.sudeep.dutt@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Sudeep Dutt <sudeep.dutt@intel.com> writes:
> From: Ashutosh Dixit <ashutosh.dixit@intel.com>
>
> This patch introduces the card "Virtio over PCIe" interface for
> Intel MIC. It allows virtio drivers on the card to communicate with their
> user space backends on the host via a device page. Ring 3 apps on the host
> can add, remove and configure virtio devices. A thin MIC specific
> virtio_config_ops is implemented which is borrowed heavily from previous
> similar implementations in lguest and s390 @
> drivers/lguest/lguest_device.c
> drivers/s390/kvm/kvm_virtio.c

Wow, this is pretty cool!

Note that the lguest implementation is a bit limited, but lguest doesn't
have a real ABI, so we can simply change it if we wanted to.  I assume
you don't have that luxury.

In particular, you may want to get rid of the historical align constant,
and have explicit avail and used addresses.

Cheers,
Rusty.
