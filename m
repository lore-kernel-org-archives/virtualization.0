From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH] virtio: change config to guest endian.
Date: Tue, 22 Apr 2008 17:13:01 -0500
Message-ID: <480E62ED.2090004__38506.7916046411$1208902504$gmane$org@codemonkey.ws>
References: <200804221357.34571.rusty@rustcorp.com.au>	<200804221529.14750.hollisb@us.ibm.com>	<200804230705.38495.rusty@rustcorp.com.au>
	<200804221708.39452.hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804221708.39452.hollisb@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hollis Blanchard wrote:
> On Tuesday 22 April 2008 16:05:38 Rusty Russell wrote:
>   
>> On Wednesday 23 April 2008 06:29:14 Hollis Blanchard wrote:
>>     
>>> On Tuesday 22 April 2008 09:31:35 Rusty Russell wrote:
>>>       
>>>> We may still regret not doing *everything* little-endian, but this
>>>> doesn't make it worse.
>>>>         
>>> Hmm, why *don't* we just do everything LE, including the ring?
>>>       
>> Mainly because when requirements are in doubt, simplicity wins, I think.
>>     
>
> Well, I think the definition of simplicity is up for debate in this 
> case... "LE everywhere" is much simpler than "it depends", IMHO.
>   

You couldn't use the vringfd direct ring mapping optimization in KVM for 
PPC without teaching the kernel to access a vring in LE format.  I'm 
pretty sure the later would get rejected on LKML anyway for vringfd as a 
generic mechanism.

Regards,

Anthony Liguori
