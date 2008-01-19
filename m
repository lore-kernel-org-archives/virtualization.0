From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Sat, 19 Jan 2008 09:05:52 +0200
Message-ID: <4791A150.3030402__19430.4043231115$1200726853$gmane$org@qumranet.com>
References: <20080114200357.GA18354@dmt>	<200801171245.59510.rusty@rustcorp.com.au>	<478EBA22.30301@codemonkey.ws>	<200801171429.32888.rusty@rustcorp.com.au>
	<478ED32A.1060803@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <478ED32A.1060803@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>>   
>>     
>>> It would be very useful too to write vb->num_pages into the config space
>>> whenever it was updated.  This way, the host can easily keep track of
>>> where the guest is at in terms of ballooning.
>>>     
>>>       
>> OTOH it's currently pretty obvious (and usually fatal) if the guest has 
>> trouble meeting the balloon requirements.  A serious host needs a way of 
>> detecting stress in the guest anyway, which this doesn't offer until it's too 
>> late...
>>   
>>     
>
> The question I'm interested in answering though is not if but when.  I 
> would like to know when the guest has reached it's target.
>
>   

Yes.  We don't want to activate the RSS controller immediately; give the 
guest some time to adjust voluntarily.


-- 
Any sufficiently difficult bug is indistinguishable from a feature.
