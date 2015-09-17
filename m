From: "Xie, Huawei" <huawei.xie@intel.com>
Subject: Re: [dpdk-dev] virtio optimization idea
Date: Thu, 17 Sep 2015 15:41:36 +0000
Message-ID: <C37D651A908B024F974696C65296B57B40F1D8C1__34881.2818796889$1442504522$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <C37D651A908B024F974696C65296B57B2BDB8C06@SHSMSX101.ccr.corp.intel.com>
	<20150908083926.3f2f409f@urahara>
	<C37D651A908B024F974696C65296B57B2BDC0872@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "ms >> Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 9/8/2015 11:54 PM, Xie, Huawei wrote:
> On 9/8/2015 11:39 PM, Stephen Hemminger wrote:
>> On Fri, 4 Sep 2015 08:25:05 +0000
>> "Xie, Huawei" <huawei.xie@intel.com> wrote:
>>
>>> Hi:
>>>
>>> Recently I have done one virtio optimization proof of concept. The
>>> optimization includes two parts:
>>> 1) avail ring set with fixed descriptors
>>> 2) RX vectorization
>>> With the optimizations, we could have several times of performance boost
>>> for purely vhost-virtio throughput.
>>>
>>> Here i will only cover the first part, which is the prerequisite for the
>>> second part.
>>> Let us first take RX for example. Currently when we fill the avail ring
>>> with guest mbuf, we need
>>> a) allocate one descriptor(for non sg mbuf) from free descriptors
>>> b) set the idx of the desc into the entry of avail ring
>>> c) set the addr/len field of the descriptor to point to guest blank mbuf
>>> data area
>>>
>>> Those operation takes time, and especially step b results in modifed (M)
>>> state of the cache line for the avail ring in the virtio processing
>>> core. When vhost processes the avail ring, the cache line transfer from
>>> virtio processing core to vhost processing core takes pretty much CPU
>>> cycles.
>>> To solve this problem, this is the arrangement of RX ring for DPDK
>>> pmd(for non-mergable case).
>>>    
>>>                     avail                      
>>>                     idx                        
>>>                     +                          
>>>                     |                          
>>> +----+----+---+-------------+------+           
>>> | 0  | 1  | 2 | ... |  254  | 255  |  avail ring
>>> +-+--+-+--+-+-+---------+---+--+---+           
>>>   |    |    |       |   |      |               
>>>   |    |    |       |   |      |               
>>>   v    v    v       |   v      v               
>>> +-+--+-+--+-+-+---------+---+--+---+           
>>> | 0  | 1  | 2 | ... |  254  | 255  |  desc ring
>>> +----+----+---+-------------+------+           
>>>                     |                          
>>>                     |                          
>>> +----+----+---+-------------+------+           
>>> | 0  | 1  | 2 |     |  254  | 255  |  used ring
>>> +----+----+---+-------------+------+           
>>>                     |                          
>>>                     +    
>>> Avail ring is initialized with fixed descriptor and is never changed,
>>> i.e, the index value of the nth avail ring entry is always n, which
>>> means virtio PMD is actually refilling desc ring only, without having to
>>> change avail ring.
>>> When vhost fetches avail ring, if not evicted, it is always in its first
>>> level cache.
>>>
>>> When RX receives packets from used ring, we use the used->idx as the
>>> desc idx. This requires that vhost processes and returns descs from
>>> avail ring to used ring in order, which is true for both current dpdk
>>> vhost and kernel vhost implementation. In my understanding, there is no
>>> necessity for vhost net to process descriptors OOO. One case could be
>>> zero copy, for example, if one descriptor doesn't meet zero copy
>>> requirment, we could directly return it to used ring, earlier than the
>>> descriptors in front of it.
>>> To enforce this, i want to use a reserved bit to indicate in order
>>> processing of descriptors.
>>>
>>> For tx ring, the arrangement is like below. Each transmitted mbuf needs
>>> a desc for virtio_net_hdr, so actually we have only 128 free slots.
>>>                                                                                       
>>>
>>>                            

                            ++                                                           
                            ||                                                           
                            ||                                                           
   +-----+-----+-----+--------------+------+------+------+                               
   |  0  |  1  | ... |  127 || 128  | 129  | ...  | 255  |   avail ring                  
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
      |     |            |  ||  |      |             |                                   
      v     v            v  ||  v      v             v                                   
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
   | 127 | 128 | ... |  255 || 127  | 128  | ...  | 255  |   desc ring for virtio_net_hdr
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
      |     |            |  ||  |      |             |                                   
      v     v            v  ||  v      v             v                                   
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
   |  0  |  1  | ... |  127 ||  0   |  1   | ...  | 127  |   desc ring for tx dat 

>>>           
>>>
>> Does this still work with Linux (or BSD) guest/host.
>> If you are assuming both virtio/vhost are DPDK this is never going
>> to be usable.
> It works with both dpdk vhost and kernel vhost implementations.
> But to enforce this, we had better add a new feature bit.
Hi Stephen, some update about compatibility:
This optimization in theory is compliant with current kernel vhost,
qemu, and dpdk vhost implementations.
Today i run dpdk virtio PMD with qemu and kernel vhost, and it works fine.


>> On a related note, have you looked at getting virtio to support the
>> new standard (not legacy) mode?
> Yes, we add it to our plan to support virtio 1.0.
>>
>
