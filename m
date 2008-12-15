From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] AF_VMCHANNEL address family
	for	guest<->host	communication.
Date: Tue, 16 Dec 2008 02:52:53 +0300
Message-ID: <20081215235253.GB24579__8785.94450555301$1229386309$gmane$org@ioremap.net>
References: <20081214115054.4066.14557.stgit@dhcp-1-237.tlv.redhat.com>
	<20081214.224436.55256593.davem@davemloft.net>
	<4946717F.2090809@codemonkey.ws> <494697D4.6080300@goop.org>
	<4946A5E0.5080303@codemonkey.ws> <4946DF97.7070600@goop.org>
	<4946E36D.8060503@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4946E36D.8060503@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 15, 2008 at 05:08:29PM -0600, Anthony Liguori (anthony@codemonkey.ws) wrote:
> The KVM model is that a guest is a process.  Any IO operations original 
> from the process (QEMU).  The advantage to this is that you get very 
> good security because you can use things like SELinux and simply treat 
> the QEMU process as you would the guest.  In fact, in general, I think 
> we want to assume that QEMU is guest code from a security perspective.
> 
> By passing up the network traffic to the host kernel, we now face a 
> problem when we try to get the data back.  We could setup a tun device 
> to send traffic to the kernel but then the rest of the system can see 
> that traffic too.  If that traffic is sensitive, it's potentially unsafe.

You can even use unix sockets in this case, and each socket will be
named as virtio channels names. IIRC tun/tap devices can be virtualizen
with recent kernels, which also solves all problems of shared access.

There are plenty of ways to implement this kind of functionality instead
of developing some new protocol, which is effectively a duplication of
what already exists in the kernel.

-- 
	Evgeniy Polyakov
