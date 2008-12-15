From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Mon, 15 Dec 2008 17:17:43 -0600
Message-ID: <4946E597.6070308__23270.1019304388$1229385244$gmane$org@codemonkey.ws>
References: <4946C1AA.4080404@codemonkey.ws>	<20081215.142918.190909950.davem@davemloft.net>	<4946E1BA.80206@codemonkey.ws>
	<20081215.151044.262451532.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081215.151044.262451532.davem@davemloft.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

David Miller wrote:
> From: Anthony Liguori <anthony@codemonkey.ws>
> Date: Mon, 15 Dec 2008 17:01:14 -0600
>
>   
>> No, TCP falls under the not simple category because it requires the
>> backend to have access to a TCP/IP stack.
>>     
>
> I'm at a loss for words if you need TCP in the hypervisor, if that's
> what you're implying here.
>   

No.  KVM is not a traditional "hypervisor".  It's more of a userspace 
accelerator for emulators.

QEMU, a system emulator, calls in to the Linux kernel whenever it needs 
to run guest code.  Linux returns to QEMU whenever the guest has done an 
MMIO operation or something of that nature.  In this way, all of our 
device emulation (including paravirtual backends) are implemented in the 
host userspace in the QEMU process.

If we used TCP, we don't have a useful TCP/IP stack in QEMU, so we'd 
have to inject that traffic into the host Linux instance, and then 
receive the traffic in QEMU.  Besides being indirect, it has some nasty 
security implications that I outlined in my response to Jeremy's last note.

Regards,

Anthony Liguori

> You only need it in the guest and the host, which you already have,
> in the Linux kernel.  Just transport that over virtio or whatever
> and be done with it.
>   
