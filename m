From: Shrikrishna Khare <skhare@shri-linux.eng.vmware.com>
Subject: Re: [PATCH net-next 5/6] net: use core MTU range checking in virt
	drivers
Date: Wed, 19 Oct 2016 15:21:35 -0700
Message-ID: <alpine.DEB.2.10.1610191520370.10567__30635.9470043846$1476990608$gmane$org@shri-linux.eng.vmware.com>
References: <20161019023333.15760-1-jarod@redhat.com>
	<20161019023333.15760-6-jarod@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161019023333.15760-6-jarod@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jarod Wilson <jarod@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "VMware,
	Inc." <pv-drivers@vmware.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Shrikrishna Khare <skhare@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org



On Wed, 19 Oct 2016, Jarod Wilson wrote:

> hyperv_net:
> - set min/max_mtu
> 
> virtio_net:
> - set min/max_mtu
> - remove virtnet_change_mtu
> 
> vmxnet3:
> - set min/max_mtu
> 
> CC: netdev@vger.kernel.org
> CC: virtualization@lists.linux-foundation.org
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Shrikrishna Khare <skhare@vmware.com>
> CC: "VMware, Inc." <pv-drivers@vmware.com>
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---

The vmxnet3 part of the change looks good to me.

Thanks,
Shri
