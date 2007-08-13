From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 0/2][KVM] guest time accounting
Date: Mon, 13 Aug 2007 17:37:22 +0300
Message-ID: <46C06CA2.8010303__32447.711521718$1187015941$gmane$org@qumranet.com>
References: <46BC8B39.6050202@bull.net>
	<200708131615.42643.borntraeger@de.ibm.com>
	<46C06885.3020908@qumranet.com>
	<200708131626.36275.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708131626.36275.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, Laurent Vivier <Laurent.Vivier@bull.net>, cotte@de.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Am Montag, 13. August 2007 schrieb Avi Kivity:
>   
>> Christian Borntraeger wrote:
>>     
>>> Am Montag, 13. August 2007 schrieb Laurent Vivier:
>>>   
>>>       
>>>>> [copying Ingo and Rusty]
>>>>>       
>>>>>           
>>> @Avi, seems that sourceforge is mangling the cc list?
>>>
>>>   
>>>       
>> It's not configured to do so.  Can you be more specific?
>>     
>
> I added Carsten and he was removed from the CC list in my copy I got from SF.
> And you cced Ingo and Rusty but I dont have them on cc, either.
>
>   

The only thing remotely relevant in the list config is that 'Filter out 
duplicate messages to list members (if possible)' is set as a default 
for new members.  Maybe this means that if a cc is also part of the 
list, that cc is stripped (which seems a wierd implementation; I'd have 
expected that cc be kept and just one copy sent out).

Anybody have a clue?


-- 
error compiling committee.c: too many arguments to function
