From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH][RFC] vmchannel a data channel between host and guest.
Date: Wed, 15 Oct 2008 10:56:02 -0500
Message-ID: <48F61292.9020504__37629.5205009685$1224086495$gmane$org@codemonkey.ws>
References: <20081012124534.GK11435@redhat.com>
	<48F39443.4070203@codemonkey.ws>
	<20081014090540.GB13153@redhat.com> <48F4A3B8.8050603@us.ibm.com>
	<20081014175900.GA18344@redhat.com>
	<48F4E1F3.3050606@codemonkey.ws>
	<20081015125837.GQ11435@redhat.com>
	<20081015141852.GA19554@vmware.com>
	<20081015154212.GS11435@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081015154212.GS11435@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Anupam Chanda <anupamc@vmware.com>, Andrew Biggadike <biggadike@vmware.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Gleb Natapov wrote:
> Andrew,
>
> On Wed, Oct 15, 2008 at 07:18:52AM -0700, Andrew Biggadike wrote:
>   
>> Gleb Natapov <gleb@redhat.com> wrote:
>>     
>>>> Of course, you should also take a look at VMware's VMCI.  If we're going
>>>> to have a socket interface, if we can have a compatible userspace
>>>> interface, that would probably be a good thing.
>>>>         
>>> I looked at what I could find about VMCI (http://pubs.vmware.com/vmci-sdk/index.html).
>>>       
>> I believe Anthony intended for you to look at the sockets interface to
>> VMCI: http://www.vmware.com/pdf/ws65_s2_vmci_sockets.pdf.
>>
>>     
> Using VMCI socket requires loading kernel module in a guest and in a host.
> Is this correct?
>   

Note that their addressing scheme uses a CID/port pair.  I think it's 
interesting and somewhat safe because it basically mirrors an IP/port 
pair.  That makes it relatively safe because that addressing mechanism 
is well known (with it's advantages and flaws).  For instance, you need 
some sort of authority to assign out ports.  It doesn't really help with 
discovery either.

Another possibility would be to have the address be like sockaddr_un.  
You could actually have it be file paths.  The effect would be that any 
VMs that can communicate with each other could have a common namespace.  
You could extend the analogy and actually create controllable 
permissions that could be used to control who can talk to who.  You 
could even create a synthetic filesystem in the guest that could mount 
this namespace allowing very sophisticated enumeration/permission 
control.  This is probably the complete opposite end in terms of having 
a novel interface.

The best solution is probably somewhere between the two.

Regards,

Anthony Liguori

> --
> 			Gleb.
>   
