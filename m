From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Add virtio-scsi to the virtio spec
Date: Thu, 01 Dec 2011 09:55:30 +0100
Message-ID: <4ED74102.6040207@redhat.com>
References: <1322661042-28191-1-git-send-email-pbonzini@redhat.com>
	<87sjl5rnj6.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87sjl5rnj6.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12/01/2011 04:14 AM, Rusty Russell wrote:
> I'd prefer to see the spec only cover things
> which are implemented and tested, otherwise the risk of a flaw in the
> spec is really high in my experience.

In general I agree, and I did that for virtio-specific things such as 
the eventq and the configuration space.  This is also why I don't want 
to add untested controlq requests that people suggested.

However, there's tension between this and providing a complete SCSI 
transport.  SCSI is roughly defined as a set of RPC interfaces ("Send 
command", "Abort task", etc.) and transports provide the RPC protocol. 
The SCSI command set changes relatively often, but the RPC interfaces 
are pretty stable.  This stability limits the risk, and having a mapping 
for all interfaces also makes future changes less likely.

> Comments below:
>
>>    num_queues is the total number of virtqueues exposed by the
>>      device. The driver is free to use only one request queue, or
>>      it can use more to achieve better performance.
>
> s/total number of virtqueues/total number of request virtqueues/ ?

Ok.

>>    max_channel, max_target and max_lun can be used by the driver
>>      as hints for scanning the logical units on the host. In the
>>      current version of the spec, they will always be respectively
>>      0, 255 and 16383.
>
> s/hints for scanning/hints to constrain scanning/ ? (I assume).

Yes.

>> The driver queues requests to an arbitrary request queue, and they are
>> used by the device on that same queue. In this version of the spec,
>> if a driver uses more than one queue it is the responsibility of the
>> driver to ensure strict request ordering; commands placed on different
>> queue will be consumed with no order constraints.
>
> Suggest simplification of second sentence:
>
> It is the responsibility of the driver to ensure strict request
> ordering; commands placed on different queues will be consumed with no
> order constraints.

Agreed.

>> Task_attr, prio and crn should be left to zero: command priority
>> is explicitly not supported by this version of the device;
>> task_attr defines the task attribute as in the table above, but
>> all task attributes may be mapped to SIMPLE by the device; crn
>> may also be provided by clients, but is generally expected to be
>> 0. The maximum CRN value defined by the protocol is 255, since
>> CRN is stored in an 8-bit integer.
>
> Be braver in your language please.  It helps poor implementers who are
> already confused by learning SCSI and virtio:
>
>   Task_attr, and prio must be zero.[1] task_attr defines the task
>   attribute as in the table above, but all task attributes may be mapped
>   to SIMPLE by the device; crn may also be provided by clients, but is
>   generally expected to be 0.
>
>   [1] Future extensions may use these fields.
>
> Is it useful for a driver to specify ordered (or other) modes, knowing
> it could be reduced to SIMPLE without it being aware?  Or should we use
> feature bits to indicate what the device supports?

This is actually mandated by SCSI. (!)  It defines all the modes, but 
explicitly says that they can be reduced to SIMPLE.

>>    Note that since ACA is not supported by this version of the
>>    spec, VIRTIO_SCSI_T_TMF_CLEAR_ACA is always a no-operation.
>
> I think if you don't support ACA in the spec, don't define this.  How
> will a driver author use this information?

I will remove the text, no one will notice. :)

However, leaving the #define is preferrable because it keeps the SCSI 
transport complete.  SCSI unfortunately is full of obsolete concepts 
that no one implements but are still in the standard (and have funny 
names: ACA stands for Auto Contingent Allegiance).  Fallbacks are 
allowed and indeed defined by the standard, but an implementation is 
still supposed to provide the "concepts".  You can see this everywhere 
in drivers/target.

>>      struct virtio_scsi_ctrl_an {
>> 	 u32 type;
>> 	 u8  lun[8];
>> 	 u32 event_requested;
>> 	 u32 event_actual;
>> 	 u8  response;
>>      }
>
> With all these structures, you might want a comment indicating the
> read-only and write-only (from the device POV) parts of the struct, eg:
>
>       struct virtio_scsi_ctrl_an {
>           // Read-only part
> 	 u32 type;
> 	 u8  lun[8];
> 	 u32 event_requested;
>           // Write-only part
> 	 u32 event_actual;
> 	 u8  response;
>       }

(Very) good idea.

Paolo
