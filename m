From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
	vhost backend
Date: Wed, 11 Apr 2018 01:38:29 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910E3505__23846.3011025035$1523410605$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
	<622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
	<20180410045723.rftsb7l4l3ip2ioi@debian>
	<7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
	<20180410163105-mutt-send-email-mst@kernel.org>
	<D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
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
To: "Liang, Cunming" <cunming.liang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Xiao W" <xiao.w.wang@intel.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Tan,
	Jianfeng" <jianfeng.tan@intel.com>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Liang, Cunming
> Sent: Tuesday, April 10, 2018 10:24 PM
> 
[...]
> >
> > As others said, we do not need to go overeboard. A couple of small
> vendor-
> > specific quirks in qemu isn't a big deal.
> 
> It's quite challenge to identify it's small or not, there's no uniform metric.
> 
> It's only dependent on QEMU itself, that's the obvious benefit. Tradeoff is
> to build the entire device driver. We don't object to do that in QEMU, but
> wanna make sure to understand the boundary size clearly.
> 

It might be helpful if you can post some sample code using proposed 
framework - then people have a clear feeling about what size is talked 
about here and whether it falls into the concept of 'small quirks'.

Thanks
Kevin
