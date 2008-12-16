From: Dor Laor <dlaor@redhat.com>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Wed, 17 Dec 2008 01:20:15 +0200
Message-ID: <494837AF.6090108__8284.91957295245$1229469834$gmane$org@redhat.com>
References: <4946717F.2090809@codemonkey.ws>
	<20081215.114315.165733593.davem@davemloft.net>
	<4946C1AA.4080404@codemonkey.ws>
	<20081215.142918.190909950.davem@davemloft.net>
	<4946E1BA.80206@codemonkey.ws> <20081215234511.GA24579@ioremap.net>
	<20081216065727.GD13794@redhat.com>
	<20081216212532.GA15360@ioremap.net>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081216212532.GA15360@ioremap.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Evgeniy Polyakov wrote:
> On Tue, Dec 16, 2008 at 08:57:27AM +0200, Gleb Natapov (gleb@redhat.com) wrote:
>   
>>> Another approach is to implement that virtio backend with netlink based
>>> userspace interface (like using connector or genetlink). This does not
>>> differ too much from what you have with special socket family, but at
>>> least it does not duplicate existing functionality of
>>> userspace-kernelspace communications.
>>>
>>>       
>> I implemented vmchannel using connector initially (the downside is that
>> message can be dropped). Is this more expectable for upstream? The
>> implementation was 300 lines of code.
>>     
>
> Hard to tell, it depends on implementation. But if things are good, I
> have no objections as connector maintainer :)
>
> Messages in connector in particular and netlink in general are only
> dropped, when receiving buffer is full (or when there is no memory), you
> can tune buffer size to match virtual queue size or vice versa.
>
>   
Gleb was aware of that and it's not a problem since all of the 
anticipated usages may
drop msgs (guest statistics, cut&paste, mouse movements, single sign on 
commands, etc).
Service that would need reliability could use basic acks.
