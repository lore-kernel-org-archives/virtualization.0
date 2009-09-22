From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] Virtual Machine Device Queues(VMDq) support on KVM
Date: Tue, 22 Sep 2009 13:50:54 +0200
Message-ID: <200909221350.54847.arnd__12063.6605112397$1253620486$gmane$org@arndb.de>
References: <C85CEDA13AB1CF4D9D597824A86D2B9006AEB94861@PDSMSX501.ccr.corp.intel.com>
	<20090921162718.GM26034@sequoia.sous-sol.org>
	<20090922103807.GA2555@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090922103807.GA2555@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Xin, Xiaohui" <xiaohui.xin@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger <shemminger@vyatta.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 22 September 2009, Michael S. Tsirkin wrote:
> > > More importantly, when virtualizations is used with multi-queue
> > > NIC's the virtio-net NIC is a single CPU bottleneck. The virtio-net
> > > NIC should preserve the parallelism (lock free) using multiple
> > > receive/transmit queues. The number of queues should equal the
> > > number of CPUs.
> > 
> > Yup, multiqueue virtio is on todo list ;-)
> > 
> 
> Note we'll need multiqueue tap for that to help.

My idea for that was to open multiple file descriptors to the same
macvtap device and let the kernel figure out the  right thing to
do with that. You can do the same with raw packed sockets in case
of vhost_net, but I wouldn't want to add more complexity to the
tun/tap driver for this.

	Arnd <><
