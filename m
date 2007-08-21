From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 15:25:48 +0300
Message-ID: <46CAD9CC.6050209__42866.3201550536$1187699253$gmane$org@qumranet.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>	<1187313953.6449.70.camel@localhost.localdomain>	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>	<1187336618.6449.106.camel@localhost.localdomain>	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>	<1187652496.19435.141.camel@localhost.localdomain>	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>	<1187683122.19435.171.camel@localhost.localdomain>
	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <ghaskins@novell.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Gregory Haskins wrote:
> On Tue, 2007-08-21 at 17:58 +1000, Rusty Russell wrote:
>
>   
>> Partly the horror of the code, but mainly because it is an in-order
>> ring.  You'll note that we use a reply ring, so we don't need to know
>> how much the other side has consumed (and it needn't do so in order).
>>
>>     
>
> I have certainly been known to take a similar stance when looking at Xen
> code ;) (recall the lapic work I did).  However, that said I am not yet
> convinced that an out-of-order ring (at least as a fundamental
> primitive) buys us much.  

It's pretty much required for block I/O into disk arrays.

Xen does out-of-order, btw, on its single ring, but at the cost of some 
complexity.  I don't believe it is worthwhile and prefer split 
request/reply rings.

With my VJ T-shirt on, I can even say it's more efficient, as each side 
of the ring will have a single writer and a single reader, reducing 
ping-pong effects if the interrupt completions happens to land on the 
wrong cpu.

> I think the use of rings for the tx-path in of
> itself is questionable unless you can implement something like the bidir
> NAPI that I demonstrated in ioqnet.  Otherwise, you end up having to
> hypercall on each update to the ring anyway and you might as well
> hypercall directly w/o using a ring.
>   

Network tx can be out of order too (with some traffic destined to other 
guests, some to the host, and some to external interfaces, completions 
will be out of order).

-- 
error compiling committee.c: too many arguments to function
