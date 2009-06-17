From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Wed, 17 Jun 2009 12:03:03 +0300
Message-ID: <4A38B147.1030207__30354.689868591$1245229593$gmane$org@redhat.com>
References: <4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>	
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>	
	<4A366348.1030202@redhat.com> <1245083229.3222.103.camel@blaa>	
	<4A368F12.2090504@codemonkey.ws>
	<1245154451.11407.22.camel@blaa>	 <4A378FE5.5050303@redhat.com>
	<1245155992.30082.8.camel@blaa>	
	<20090616184404.GJ11893@shareable.org>
	<1245227632.27028.29.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245227632.27028.29.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/17/2009 11:33 AM, Mark McLoughlin wrote:
>> I particularly don't like the idea of arcane machine-dependent slot
>> allocation knowledge living in libvirt, because it needs to be in Qemu
>> anyway for non-libvirt users.  No point in having two implementations
>> of something tricky and likely to have machine quirks, if one will do.
>>      
>
> Indeed.
>    

I don't understand this.  Management already has to allocate MAC 
addresses, UUIDs, IDE interface and master/slave role, SCSI 
LUNs/targets/whatever.  It has to understand NUMA (if not do actual 
allocation).  Even if it doesn't allocate the slots, it has to be able 
to query them so it can tell the user which NIC or controller is 
connected where, or to do hotunplug.  It has to understand that there is 
a limitation on the number of slots, and know what that limitation is 
(unless it feels that launching an overcommitted guest and showing an 
error to the user is preferable to not allowing the user to overcommit 
in the first place.

If you'll review my patent application for pci slot allocation, you'll 
see the following line:

   slot_nr = nb_allocated_slots++; /* Allocate pci slot */

while there is a lot of complicated setup code before that (see the 
prior art section as well), I believe licensees could well implement the 
algorithm in two short months, including testing.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
