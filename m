From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [kvm-devel] [PATCH/RFC 0/2] CPU hotplug virtio driver
Date: Wed, 09 Jan 2008 12:21:54 -0200
Message-ID: <4784D882.1030104@redhat.com>
References: <11998740663306-git-send-email-gcosta@redhat.com>
	<200801091227.12261.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801091227.12261.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marcelo Tosatti <marcelo@kvack.org>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Am Mittwoch, 9. Januar 2008 schrieb Glauber de Oliveira Costa:
>> I'm sending a first draft of my proposed cpu hotplug driver for kvm/virtio
>> The first patch is the kernel module, while the second, the userspace pci 
> device.
> 
> I personally prefer to use non paravirtualized cpu hotplug and implement the 
> existing interfaces instead in the hypervisor. (sigp/sclp for s390 and 
> maybe acpi for x86 etc.). This is not a performance critical operation.
> 
> 
> Christian
It's barely "paravirtualized". It's a device driver talking to a 
hardware from the guest POV, not much different than acpi itself is, but 
sanner. The only difference is that acpi support "already exists", but 
virtio is a lot easier, and it wouldn't take long to write a driver like 
that for windows or anything else (not that I am volunteering ;-)).

Also, in the future the interface can be extended in ways acpi can't 
handle. (and just because nobody will change the hardware to embrace new 
things that fast)

That said, if acpi is really the preference here, and this patches have 
chance, no problem. But it will take me a little more time to implement 
them ;-)
