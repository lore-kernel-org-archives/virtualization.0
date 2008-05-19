From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Mon, 19 May 2008 13:26:28 +0300
Message-ID: <483155D4.2090700__38224.0556682975$1211192943$gmane$org@qumranet.com>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<200805190016.10823.rusty@rustcorp.com.au>
	<48303CB9.7070406@qumranet.com>
	<200805191152.28409.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805191152.28409.rusty@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>> We should have thought of this before, though, especially as Xen does
>>
>> this or something very similar:
>>     
>>> /* Shared ring page */                            \
>>> struct __name##_sring {                            \
>>>     RING_IDX req_prod, req_event;                    \
>>>     RING_IDX rsp_prod, rsp_event;                    \
>>>     uint8_t  pad[48];                            \
>>>     union __name##_sring_entry ring[1]; /* variable-length */        \
>>> };                                    \
>>>       
>> req_event and rsp_event allow the other side to indicate when it wants a
>> notification.
>>     
>
> Well, we do have such a thing, in the ring suppression flags.

Can you point me at this?

>   Note that DaveM 
> is talking about moving network tx queue into the net drivers themselves, 
> which will make them much more efficient (ie. drain entire queue before 
> kick), which may again change the balance of what the Right Thing is.
>   

That depends on whether Linux knows whether more packets are coming.

-- 
error compiling committee.c: too many arguments to function
