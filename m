From: Avi Kivity <avi@qumranet.com>
Subject: List stripping out cc's (was: Re: [kvm-devel] [PATCH 0/2][KVM] guest
 time accounting)
Date: Sun, 19 Aug 2007 12:32:48 +0300
Message-ID: <46C80E40.9__36234.9214301959$1187516106$gmane$org@qumranet.com>
References: <46BC8B39.6050202@bull.net>
	<200708131615.42643.borntraeger@de.ibm.com>
	<46C06885.3020908@qumranet.com>
	<200708131626.36275.borntraeger@de.ibm.com>
	<46C06CA2.8010303@qumranet.com>
	<20070813204023.GA10283@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070813204023.GA10283@osiris.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: cotte@de.ibm.com, kvm-devel@lists.sourceforge.net, Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Heiko Carstens wrote:
>>  The only thing remotely relevant in the list config is that 'Filter out 
>>  duplicate messages to list members (if possible)' is set as a default for 
>>  new members.  Maybe this means that if a cc is also part of the list, that 
>>  cc is stripped (which seems a wierd implementation; I'd have expected that 
>>  cc be kept and just one copy sent out).
>>
>>  Anybody have a clue?
>>     
>
> I got also removed when I was cc'ed. IIRC that started when I subscribed to
> the list. So it looks like people who are subscribed to the list get
> removed from the cc list.
> That's very annoying btw. ;)
>   

I think I see what is happening.  The list gets a message that you are 
copied on.  It sees you have opted not to receive duplicates, it strips 
you from the cc list, since it knows that you will receive another copy 
by direct routing (outside the list).

What it should do, is keep you on the cc list but remove you from the 
smtp recipient list... that would both remove duplicates and keep you 
copied on messages.

So I recommend disabling 'Filter duplicate messages' in your list 
preferences and living with the duplicates.  I'll change the defaults 
for new subscriptions.

-- 
error compiling committee.c: too many arguments to function
