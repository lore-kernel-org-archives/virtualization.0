From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] Revert "drivers/net: Disable UFO through virtio"
	in macvtap and tun
Date: Tue, 11 Nov 2014 16:33:34 -0500 (EST)
Message-ID: <20141111.163334.1377662236347206666.davem@davemloft.net>
References: <1415708246.3398.88.camel@decadent.org.uk>
	<20141111155750.GA17418@redhat.com>
	<1415725978.3398.101.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1415725978.3398.101.camel@decadent.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ben@decadent.org.uk
Cc: kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, stefanha@redhat.com, jelledejong@powercraft.nl
List-Id: virtualization@lists.linuxfoundation.org

From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 11 Nov 2014 17:12:58 +0000

> This reverts commit 88e0e0e5aa722b193c8758c8b45d041de5316924 for
> the tap drivers, but leaves UFO disabled in virtio_net.
> 
> libvirt at least assumes that tap features will never be dropped
> in new kernel versions, and doing so prevents migration of VMs to
> the never kernel version while they are running with virtio net
> devices.
> 
> Fixes: 88e0e0e5aa7a ("drivers/net: Disable UFO through virtio")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> Compile-tested only.

After you get some Tested-by:, please resubmit to netdev.

Thanks.
