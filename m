From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 08:55:13 -0500
Message-ID: <47E26CC1.8080900__42753.3790855252$1206021688$gmane$org@codemonkey.ws>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E20A35.2000600@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E20A35.2000600@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Rusty Russell wrote:
>   
>> Hi all,
>>
>>    Just finished my prototype of inter-guest virtio, using networking as an 
>> example.  Each guest mmaps the other's address space and uses a FIFO for 
>> notifications.
>>
>>   
>>     
>
> Isn't that a security hole (hole? chasm)?  If the two guests can access 
> each other's memory, they might as well be just one guest, and 
> communicate internally.
>   

Each guest's host userspace mmaps the other guest's address space.  The 
userspace then does a copy on both the tx and rx paths.

Conceivably, this could be done as a read-only mapping so that each 
guest userspace copies only the rx packets.  That's about as secure as 
you're going to get with this approach I think.

Regards,

Anthony Liguori

> My feeling is that the host needs to copy the data, using dma if 
> available.  Another option is to have one guest map the other's memory 
> for read and write, while the other guest is unprivileged.  This allows 
> one privileged guest to provide services for other, unprivileged guests, 
> like domain 0 or driver domains in Xen.
>
>   
