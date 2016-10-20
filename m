From: Haiyang Zhang via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next v2 6/9] net: use core MTU range checking in virt
	drivers
Date: Thu, 20 Oct 2016 18:05:10 +0000
Message-ID: <BLUPR03MB141270CC6037546F918409AECAD50__29134.5232668847$1476986743$gmane$org@BLUPR03MB1412.namprd03.prod.outlook.com>
References: <20161019023333.15760-1-jarod@redhat.com>
	<20161020175524.6184-1-jarod@redhat.com>
	<20161020175524.6184-7-jarod@redhat.com>
Reply-To: Haiyang Zhang <haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161020175524.6184-7-jarod@redhat.com>
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
To: Jarod Wilson <jarod@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: David Kershner <david.kershner@unisys.com>, Wei Liu <wei.liu2@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, "VMware,
	Inc." <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Paul Durrant <paul.durrant@citrix.com>, Shrikrishna Khare <skhare@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jarod Wilson [mailto:jarod@redhat.com]
> Sent: Thursday, October 20, 2016 1:55 PM
> To: linux-kernel@vger.kernel.org
> Cc: Jarod Wilson <jarod@redhat.com>; netdev@vger.kernel.org;
> virtualization@lists.linux-foundation.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Michael S.
> Tsirkin <mst@redhat.com>; Shrikrishna Khare <skhare@vmware.com>; VMware,
> Inc. <pv-drivers@vmware.com>; Wei Liu <wei.liu2@citrix.com>; Paul
> Durrant <paul.durrant@citrix.com>; David Kershner
> <david.kershner@unisys.com>
> Subject: [PATCH net-next v2 6/9] net: use core MTU range checking in
> virt drivers
> 
> hyperv_net:
> - set min/max_mtu, per Haiyang, after rndis_filter_device_add
> 
> virtio_net:
> - set min/max_mtu
> - remove virtnet_change_mtu
> 
> vmxnet3:
> - set min/max_mtu
> 
> xen-netback:
> - min_mtu = 0, max_mtu = 65517
> 
> xen-netfront:
> - min_mtu = 0, max_mtu = 65535
> 
> unisys/visor:
> - clean up defines a little to not clash with network core or add
>   redundat definitions
> 
> CC: netdev@vger.kernel.org
> CC: virtualization@lists.linux-foundation.org
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Shrikrishna Khare <skhare@vmware.com>
> CC: "VMware, Inc." <pv-drivers@vmware.com>
> CC: Wei Liu <wei.liu2@citrix.com>
> CC: Paul Durrant <paul.durrant@citrix.com>
> CC: David Kershner <david.kershner@unisys.com>
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---

The hv_netvsc changes look fine. Thanks.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
