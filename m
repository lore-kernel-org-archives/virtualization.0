From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] Virtual Machine Device Queues(VMDq) support on KVM
Date: Tue, 22 Sep 2009 20:34:28 +0200
Message-ID: <200909222034.28865.arnd__46776.9217947081$1253644544$gmane$org@arndb.de>
References: <C85CEDA13AB1CF4D9D597824A86D2B9006AEB94861@PDSMSX501.ccr.corp.intel.com>
	<200909221350.54847.arnd@arndb.de> <20090922092957.17e68cbc@s6510>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090922092957.17e68cbc@s6510>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: "Xin, Xiaohui" <xiaohui.xin@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@elte.hu" <mingo@elte.hu>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 22 September 2009, Stephen Hemminger wrote:
> > My idea for that was to open multiple file descriptors to the same
> > macvtap device and let the kernel figure out the  right thing to
> > do with that. You can do the same with raw packed sockets in case
> > of vhost_net, but I wouldn't want to add more complexity to the
> > tun/tap driver for this.
> > 
> Or get tap out of the way entirely. The packets should not have
> to go out to user space at all (see veth)

How does veth relate to that, do you mean vhost_net? With vhost_net,
you could still open multiple sockets, only the access is in the kernel.
Obviously, once it all is in the kernel, that could be done under the
covers, but I think it would be cleaner to treat vhost_net purely as
a way to bypass the syscalls for user space, with as little as possible
visible impact otherwise.

	Arnd <><
