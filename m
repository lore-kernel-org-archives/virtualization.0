From: Jeff Garzik <jeff@garzik.org>
Subject: Re: List stripping out cc's
Date: Sun, 19 Aug 2007 15:53:46 -0400
Message-ID: <46C89FCA.3010802__42360.2863368162$1187553404$gmane$org@garzik.org>
References: <46BC8B39.6050202@bull.net>
	<200708131615.42643.borntraeger@de.ibm.com>
	<46C06885.3020908@qumranet.com>
	<200708131626.36275.borntraeger@de.ibm.com>
	<46C06CA2.8010303@qumranet.com>
	<20070813204023.GA10283@osiris.ibm.com> <46C80E40.9@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C80E40.9@qumranet.com>
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
Cc: cotte@de.ibm.com, kvm-devel@lists.sourceforge.net, Laurent Vivier <Laurent.Vivier@bull.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Heiko Carstens wrote:
>>>  The only thing remotely relevant in the list config is that 'Filter 
>>> out  duplicate messages to list members (if possible)' is set as a 
>>> default for  new members.  Maybe this means that if a cc is also part 
>>> of the list, that  cc is stripped (which seems a wierd 
>>> implementation; I'd have expected that  cc be kept and just one copy 
>>> sent out).
>>>
>>>  Anybody have a clue?
>>>     
>>
>> I got also removed when I was cc'ed. IIRC that started when I 
>> subscribed to
>> the list. So it looks like people who are subscribed to the list get
>> removed from the cc list.
>> That's very annoying btw. ;)
>>   
> 
> I think I see what is happening.  The list gets a message that you are 
> copied on.  It sees you have opted not to receive duplicates, it strips 
> you from the cc list, since it knows that you will receive another copy 
> by direct routing (outside the list).

Well, there is also /quite/ the problem with the Mail-Followup-To 
header, which causes most mailers to ignore the preferences of the 
community in favor of the preferences of the message author -- which 
totally screws up traditional To/CC handling on LKML.

	Jeff
