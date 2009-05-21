From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 17:37:45 +0300
Message-ID: <4A156739.6060207__30354.5816023417$1242917221$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211453.14691.paul@codesourcery.com>
	<4A155EC6.6070501@redhat.com>
	<200905211514.31059.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905211514.31059.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Paul Brook wrote:
> On Thursday 21 May 2009, Avi Kivity wrote:
>   
>> Paul Brook wrote:
>>     
>>>>> which is a trivial wrapper around stl_phys.
>>>>>           
>>>> OK, but I'm adding another level of indirection in the middle,
>>>> to allow us to tie in a kvm backend.
>>>>         
>>> kvm has no business messing with the PCI device code.
>>>       
>> kvm has a fast path for irq injection.  If qemu wants to support it we
>> need some abstraction here.
>>     
>
> Fast path from where to where? Having the PCI layer bypass/re-implement the 
> APIC and inject the interrupt directly into the cpu core sounds a particularly 
> bad idea.
>   

kvm implements the APIC in the host kernel (qemu upstream doesn't 
support this yet).  The fast path is wired to the in-kernel APIC, not 
the cpu core directly.

The idea is to wire it to UIO for device assignment, to a virtio-device 
implemented in the kernel, and to qemu.

-- 
error compiling committee.c: too many arguments to function
