From: "Liang, Cunming" <cunming.liang@intel.com>
Subject: RE: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
	vhost backend
Date: Tue, 10 Apr 2018 09:23:53 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E9222F4__45513.7759483934$1523352157$gmane$org@SHSMSX104.ccr.corp.intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
	<622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
	<20180410045723.rftsb7l4l3ip2ioi@debian>
	<7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Xiao W" <xiao.w.wang@intel.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Tan,
	Jianfeng" <jianfeng.tan@intel.com>, "Wang,
	Zhihong" <zhihong.wang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Tuesday, April 10, 2018 3:52 PM
> To: Bie, Tiwei <tiwei.bie@intel.com>; Jason Wang <jasowang@redhat.com>
> Cc: mst@redhat.com; alex.williamson@redhat.com; ddutile@redhat.com;
> Duyck, Alexander H <alexander.h.duyck@intel.com>; virtio-dev@lists.oasis-
> open.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> virtualization@lists.linux-foundation.org; netdev@vger.kernel.org; Daly, Dan
> <dan.daly@intel.com>; Liang, Cunming <cunming.liang@intel.com>; Wang,
> Zhihong <zhihong.wang@intel.com>; Tan, Jianfeng <jianfeng.tan@intel.com>;
> Wang, Xiao W <xiao.w.wang@intel.com>
> Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
> vhost backend
> 
> On 10/04/2018 06:57, Tiwei Bie wrote:
> >> So you just move the abstraction layer from qemu to kernel, and you
> >> still need different drivers in kernel for different device
> >> interfaces of accelerators. This looks even more complex than leaving
> >> it in qemu. As you said, another idea is to implement userspace vhost
> >> backend for accelerators which seems easier and could co-work with
> >> other parts of qemu without inventing new type of messages.
> >
> > I'm not quite sure. Do you think it's acceptable to add various vendor
> > specific hardware drivers in QEMU?
> 
> I think so.  We have vendor-specific quirks, and at some point there was an
> idea of using quirks to implement (vendor-specific) live migration support for
> assigned devices.

Vendor-specific quirks of accessing VGA is a small portion. Other major portions are still handled by guest driver.

While in this case, when saying various vendor specific drivers in QEMU, it says QEMU takes over and provides the entire user space device drivers. Some parts are even not relevant to vhost, they're basic device function enabling. Moreover, it could be different kinds of devices(network/block/...) under vhost. No matter # of vendors or # of types, total LOC is not small.

The idea is to avoid introducing these extra complexity out of QEMU, keeping vhost adapter simple. As vhost protocol is de factor standard, it leverages kernel device driver to provide the diversity. Changing once in QEMU, then it supports multi-vendor devices whose drivers naturally providing kernel driver there.

If QEMU is going to build a user space driver framework there, we're open mind on that, even leveraging DPDK as the underlay library. Looking forward to more others' comments from community.

Steve

> 
> Paolo
