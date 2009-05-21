From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 13:23:09 +0300
Message-ID: <4A152B8D.5020006__45420.8894087516$1242901566$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211109.09844.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905211109.09844.paul@codesourcery.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Paul Brook wrote:
> On Wednesday 20 May 2009, Michael S. Tsirkin wrote:
>   
>> define api for allocating/setting up msi-x irqs, and for updating them
>> with msi-x vector information, supply implementation in ioapic. Please
>> comment on this API: I intend to port my msi-x patch to work on top of
>> it.
>>     
>
> I though the point of MSI is that they are just a regular memory writes, and 
> don't require any special bus support.
>   

The PCI bus doesn't need any special support (I think) but something on 
the other end needs to interpret those writes.

In any case we need some internal API for this, and qemu_irq looks like 
a good choice.

-- 
error compiling committee.c: too many arguments to function
