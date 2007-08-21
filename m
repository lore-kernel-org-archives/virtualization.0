From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 20:12:38 +0300
Message-ID: <46CB1D06.1040005__16752.6790909053$1187716471$gmane$org@qumranet.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>	<1187313953.6449.70.camel@localhost.localdomain>	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>	<1187336618.6449.106.camel@localhost.localdomain>	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>	<1187652496.19435.141.camel@localhost.localdomain>	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>	<1187683122.19435.171.camel@localhost.localdomain>	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>	<1187704038.19435.194.camel@localhost.localdomain>	<1187705162.4363.323.camel@ghaskins-t60p.haskins.net>
	<1187714864.4363.358.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187714864.4363.358.camel@ghaskins-t60p.haskins.net>
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
> On Tue, 2007-08-21 at 10:06 -0400, Gregory Haskins wrote:
>   
>> On Tue, 2007-08-21 at 23:47 +1000, Rusty Russell wrote:
>>     
>>> 	In the guest -> host direction, an interface like virtio is designed
>>> for batching, with the explicit distinction between add_buf & sync.
>>>       
>> Right.  IOQ has "iter_push()" and "signal()" as synonymous operations.
>>     
>
> Hi Rusty,
>   This reminded me of an area that I thought might have been missing in
> virtio compared to IOQ.  That is, flexibility in the io-completion via
> the distinction between "signal" and "sync".  sync() implies that its a
> blocking call based on the full drain of the queue, correct?

No, sync() means "make the other side aware that there's work to be done".


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
