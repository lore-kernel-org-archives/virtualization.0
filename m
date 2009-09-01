From: "Xin, Xiaohui" <xiaohui.xin@intel.com>
Subject: RE: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 1 Sep 2009 22:58:44 +0800
Message-ID: <C85CEDA13AB1CF4D9D597824A86D2B9006AEC02EC0__42751.4625167989$1251828420$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <E88DD564E9DC5446A76B2B47C3BCCA150219600F9B@pdsmsx503.ccr.corp.intel.com>
	<C85CEDA13AB1CF4D9D597824A86D2B9006AEB944B8@PDSMSX501.ccr.corp.intel.com>
	<200908311723.34067.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908311723.34067.arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@elte.hu" <mingo@elte.hu>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

>I don't think we should do that with the tun/tap driver. By design, tun/tap is a way to interact >with the
>networking stack as if coming from a device. The only way this connects to an external >adapter is through
>a bridge or through IP routing, which means that it does not correspond to a specific NIC.
>I have worked on a driver I called 'macvtap' in lack of a better name, to add a new tap >frontend to
>the 'macvlan' driver. Since macvlan lets you add slaves to a single NIC device, this gives you >a direct
>connection between one or multiple tap devices to an external NIC, which works a lot better >than when
>you have a bridge inbetween. There is also work underway to add a bridging capability to >macvlan, so
>you can communicate directly between guests like you can do with a bridge.
>Michael's vhost_net can plug into the same macvlan infrastructure, so the work is >complementary.

We use TUN/TAP device to implement the prototype, and agree that it's not the only
choice here. We'd compare the two if possible.
And what we cares more about is the modification in the kernel like the net_dev and 
skb structures' modifications, thanks.

Thanks
Xiaohui

-----Original Message-----
From: Arnd Bergmann [mailto:arnd@arndb.de] 
Sent: Monday, August 31, 2009 11:24 PM
To: Xin, Xiaohui
Cc: mst@redhat.com; netdev@vger.kernel.org; virtualization@lists.linux-foundation.org; kvm@vger.kernel.org; linux-kernel@vger.kernel.org; mingo@elte.hu; linux-mm@kvack.org; akpm@linux-foundation.org; hpa@zytor.com; gregory.haskins@gmail.com
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server

On Monday 31 August 2009, Xin, Xiaohui wrote:
> 
> Hi, Michael
> That's a great job. We are now working on support VMDq on KVM, and since the VMDq hardware presents L2 sorting
> based on MAC addresses and VLAN tags, our target is to implement a zero copy solution using VMDq.

I'm also interested in helping there, please include me in the discussions.

> We stared
> from the virtio-net architecture. What we want to proposal is to use AIO combined with direct I/O:
> 1) Modify virtio-net Backend service in Qemu to submit aio requests composed from virtqueue.

right, that sounds useful.

> 2) Modify TUN/TAP device to support aio operations and the user space buffer directly mapping into the host kernel.
> 3) Let a TUN/TAP device binds to single rx/tx queue from the NIC.

I don't think we should do that with the tun/tap driver. By design, tun/tap is a way to interact with the
networking stack as if coming from a device. The only way this connects to an external adapter is through
a bridge or through IP routing, which means that it does not correspond to a specific NIC.

I have worked on a driver I called 'macvtap' in lack of a better name, to add a new tap frontend to
the 'macvlan' driver. Since macvlan lets you add slaves to a single NIC device, this gives you a direct
connection between one or multiple tap devices to an external NIC, which works a lot better than when
you have a bridge inbetween. There is also work underway to add a bridging capability to macvlan, so
you can communicate directly between guests like you can do with a bridge.

Michael's vhost_net can plug into the same macvlan infrastructure, so the work is complementary.

> 4) Modify the net_dev and skb structure to permit allocated skb to use user space directly mapped payload
> buffer address rather then kernel allocated.

yes.

> As zero copy is also your goal, we are interested in what's in your mind, and would like to collaborate with you if possible.
> BTW, we will send our VMDq write-up very soon.

Ok, cool.

	Arnd <><
