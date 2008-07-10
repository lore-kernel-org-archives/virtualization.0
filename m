From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Multicast and receive filtering in TUN/TAP
Date: Thu, 10 Jul 2008 10:29:17 +0200
Message-ID: <200807101029.17121.borntraeger__49272.9096361019$1215678713$gmane$org@de.ibm.com>
References: <4875428F.4080704@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4875428F.4080704@qualcomm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, Brian Braunstein <linuxkernel@bristyle.com>, Max Krasnyansky <maxk@qualcomm.com>, Shaun Jackman <sjackman@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 10. Juli 2008 schrieb Max Krasnyansky:
[...]
> The second question is do you guys think that QEMU/KVM/LGUEST/etc would 
> benefit if receive filtering was done by the host OS. Here is a specific 
> example of what I'm talking about.
> We can do what qemu/hw/e1000.c:receive_filter() does in the _host_ 
> context (that function currently runs in the guest context). By looking 
> at libvirt, typical QEMU based setup is that you have a single bridge 
> and all the TAPs from different VMs are hooked up to that bridge. What 
> that means is that if one VM is getting MC traffic or when the bridge 
> sees MACADDR that is not in its tables the packets get delivered to all 
> the VMs. ie We have to wake all of the up only to so that they could 
> drop that packet. Instead, we could setup filters in the host's side of 
> the TAP device.
> Does that sound like something useful for QEMU/KVM ?
> If yes we can talk about the API. If not then I'll just nuke it.

Max,

I know that on s390 the shared OSA network card have multicast filter 
capabilities. So I guess it is worthwile for a virtualization environments 
with lots of guests. I also think, that this kind of filtering should be 
straightforward to implement with the qemu e1000 code. Qemu already knows the 
multicast addresses.

Thing is, we are heading towards virtio. Unfortunately, virtio_net currently 
does not offer a method to register multicast addresses.

Rusty, do you think its worthwile to notify the host about registered 
multicast addresses?

Christian
