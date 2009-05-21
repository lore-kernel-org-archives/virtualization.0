From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 14:01:00 +0300
Message-ID: <4A15346C.8090906__38020.0653723024$1242903829$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211109.09844.paul@codesourcery.com>
	<4A152B8D.5020006@redhat.com>
	<200905211134.21184.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905211134.21184.paul@codesourcery.com>
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
>> The PCI bus doesn't need any special support (I think) but something on
>> the other end needs to interpret those writes.
>>     
>
> Sure. But there's definitely nothing PCI specific about it. I assumed this 
> would all be contained within the APIC.
>   

MSIs are defined by PCI and their configuration is done using the PCI 
configuration space.

>> In any case we need some internal API for this, and qemu_irq looks like
>> a good choice.
>>     
>
> What do you expect to be using this API?
>   

virtio, emulated devices capable of supporting MSI (e1000?), device 
assignment (not yet in qemu.git).

-- 
error compiling committee.c: too many arguments to function
