From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Multicast and receive filtering in TUN/TAP
Date: Fri, 11 Jul 2008 01:01:58 -0700
Message-ID: <48771376.4020401__45691.6990144693$1215763632$gmane$org@qualcomm.com>
References: <4875428F.4080704@qualcomm.com>
	<200807102223.40717.borntraeger@de.ibm.com>
	<4876C357.3030708@qualcomm.com>
	<200807111701.39070.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200807111701.39070.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Brian Braunstein <linuxkernel@bristyle.com>, Shaun Jackman <sjackman@gmail.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Friday 11 July 2008 12:20:07 Max Krasnyansky wrote:
>>>> I haven't looked at the virtio stuff much, I was assuming that the host
>>>> side of it is still the TUN driver. Is it not ?
>>> Yes, the host side is still tun/tap. The problem is that qemu doesnt know
>>> which multicast addresses are used inside the guest.
>> Ah, now I see what you meant by virtio_net does not do multicast. I guess
>> it should trivial to add. Rusty will clarify it I guess.
> 
> Yes, it could certainly be added; that's what feature bits are for :)

Sounds good.
I'll send the patch that lets you guys setup tx filters on the TAP devices.
Hypervisors will then need to translate rx filters set by the guest OS into
TAP tx filters. I'm thinking of doing it just like E1000 for example. 14 exact
filters and the rest is hashed.

Max
