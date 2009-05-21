From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 17:01:42 +0300
Message-ID: <4A155EC6.6070501__33412.6495327384$1242914829$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211423.20843.paul@codesourcery.com>
	<20090521134650.GI25309@redhat.com>
	<200905211453.14691.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905211453.14691.paul@codesourcery.com>
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
>>> which is a trivial wrapper around stl_phys.
>>>       
>> OK, but I'm adding another level of indirection in the middle,
>> to allow us to tie in a kvm backend.
>>     
>
> kvm has no business messing with the PCI device code.
>   

kvm has a fast path for irq injection.  If qemu wants to support it we 
need some abstraction here.

-- 
error compiling committee.c: too many arguments to function
