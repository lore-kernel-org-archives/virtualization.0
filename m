From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Mon, 15 Dec 2008 17:01:14 -0600
Message-ID: <4946E1BA.80206__48979.9232841053$1232290052$gmane$org@codemonkey.ws>
References: <4946717F.2090809@codemonkey.ws>	<20081215.114315.165733593.davem@davemloft.net>	<4946C1AA.4080404@codemonkey.ws>
	<20081215.142918.190909950.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081215.142918.190909950.davem@davemloft.net>
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
> Date: Mon, 15 Dec 2008 14:44:26 -0600
>
>   
>> We want this communication mechanism to be simple and reliable as we
>> want to implement the backends drivers in the host userspace with
>> minimum mess.
>>     
>
> One implication of your statement here is that TCP is unreliable.
> That's absolutely not true.
>   

No, TCP falls under the not simple category because it requires the 
backend to have access to a TCP/IP stack.

>> Within the guest, we need the interface to be always available and
>> we need an addressing scheme that is hypervisor specific.  Yes, we
>> can build this all on top of TCP/IP.  We could even build it on top
>> of a serial port.  Both have their down-sides wrt reliability and
>> complexity.
>>     
>
> I don't know of any zero-copy through the hypervisor mechanisms for
> serial ports, but I know we do that with the various virtualization
> network devices.
>   

Yes, and I went down the road of using a dedicated network device and 
using raw ethernet as the protocol.  The thing that killed that was the 
fact that it's not reliable.  You need something like TCP to add 
reliability.

But that's a lot of work and a bit backwards.  Use a unreliable 
transport but use TCP on top of it to get reliability.  Our link 
(virtio) is inherently reliable so why not just expose a reliable 
interface to userspace?

>> Do you have another recommendation?
>>     
>
> I don't have to make alternative recommendations until you can
> show that what we have can't solve the problem acceptably, and
> TCP emphatically can.
>   

It can solve the problem but I don't think it's the best way to solve 
the problem mainly because the complexity it demands on the backend.

Regards,

Anthony Liguori
