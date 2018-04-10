From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware vhost
	backend
Date: Tue, 10 Apr 2018 09:51:43 +0200
Message-ID: <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
	<622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
	<20180410045723.rftsb7l4l3ip2ioi@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180410045723.rftsb7l4l3ip2ioi@debian>
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
To: Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xiao.w.wang@intel.com, ddutile@redhat.com, jianfeng.tan@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On 10/04/2018 06:57, Tiwei Bie wrote:
>> So you just move the abstraction layer from qemu to kernel, and you still
>> need different drivers in kernel for different device interfaces of
>> accelerators. This looks even more complex than leaving it in qemu. As you
>> said, another idea is to implement userspace vhost backend for accelerators
>> which seems easier and could co-work with other parts of qemu without
>> inventing new type of messages.
> 
> I'm not quite sure. Do you think it's acceptable to
> add various vendor specific hardware drivers in QEMU?

I think so.  We have vendor-specific quirks, and at some point there was
an idea of using quirks to implement (vendor-specific) live migration
support for assigned devices.

Paolo
