From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: Disable CONFIG_S390_GUEST_OLD_TRANSPORT by
	default
Date: Tue, 26 Sep 2017 12:41:41 +0200
Message-ID: <376655d1-87e3-4187-d2d1-d1f23c02431a__20139.9065008902$1506422534$gmane$org@de.ibm.com>
References: <1506350729-11311-1-git-send-email-thuth@redhat.com>
	<3c2b8ae8-ca2a-7b26-8ebd-14f14c286529@linux.vnet.ibm.com>
	<83cacb4a-94b1-c7c2-e50d-70afea5d3e9c@de.ibm.com>
	<20170926104019.GA3209@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170926104019.GA3209@osiris>
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
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 09/26/2017 12:40 PM, Heiko Carstens wrote:
> On Mon, Sep 25, 2017 at 08:37:36PM +0200, Christian Borntraeger wrote:
>>
>> On 09/25/2017 07:54 PM, Halil Pasic wrote:
>>>
>>>
>>> On 09/25/2017 04:45 PM, Thomas Huth wrote:
>>>> There is no recent user space application available anymore which still
>>>> supports this old virtio transport, so let's disable this by default.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> I don't have any objections, but there may be something I'm not aware of.
>>> Let's see what Connie says. From my side it's ack.
>>>
>>> Via whom is this supposed to go in? Looking at the MAINTAINERS, I would
>>> say Martin or Heiko but I don't see them among the recipients.
>>
>> FWIW as the original author of that transport
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> I can pick this up for Martins/Heikos tree if you want.
> 
> When will this code be removed?
> 
> When the config option was initially added Conny said it should survive
> "probably two kernel releases or so, depending on feedback".
> It was merged for v4.8. Now we are five kernel releases later...

Lets wait for one release and then get rid of it?
