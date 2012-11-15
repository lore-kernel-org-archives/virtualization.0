From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Pv-drivers] [PATCH 0/6] VSOCK for Linux upstreaming
Date: Thu, 15 Nov 2012 15:32:07 -0600
Message-ID: <50A55F57.7080804__27257.0618348711$1353015769$gmane$org@us.ibm.com>
References: <783561822.12637564.1352139592543.JavaMail.root@vmware.com>
	<509A06AB.2020700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <509A06AB.2020700@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Andy King <acking@vmware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, gregkh@linuxfoundation.org, David Miller <davem@davemloft.net>, georgezhang@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On 11/07/2012 12:58 AM, Gerd Hoffmann wrote:
> On 11/05/12 19:19, Andy King wrote:
>> Hi David,
>>
>>> The big and only question is whether anyone can actually use any of
>>> this stuff without your proprietary bits?
>>
>> Do you mean the VMCI calls?  The VMCI driver is in the process of being
>> upstreamed into the drivers/misc tree.  Greg (cc'd on these patches) is
>> actively reviewing that code and we are addressing feedback.
>>
>> Also, there was some interest from RedHat into using vSockets as a unified
>> interface, routed over a hypervisor-specific transport (virtio or
>> otherwise, although for now VMCI is the only one implemented).
>
> Can you outline how this can be done?  From a quick look over the code
> it seems like vsock has a hard dependency on vmci, is that correct?
>
> When making vsock a generic, reusable kernel service it should be the
> other way around:  vsock should provide the core implementation and an
> interface where hypervisor-specific transports (vmci, virtio, xenbus,
> ...) can register themself.

This was already done in a hypervisor neutral way using virtio:

http://lists.openwall.net/netdev/2008/12/14/8

The concept was Nacked and that led to the abomination of virtio-serial.  If an 
address family for virtualization is on the table, we should reconsider 
AF_VMCHANNEL.

I'd be thrilled to get rid of virtio-serial...

Regards,

Anthony Liguori

>
> cheers,
>    Gerd
