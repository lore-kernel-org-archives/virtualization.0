From: Dor Laor <dlaor@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 18:12:46 +0300
Message-ID: <4A3664EE.30207__17674.353803932$1245080342$gmane$org@redhat.com>
References: <4A364381.401@redhat.com> <4A364401.6010500@codemonkey.ws>
	<4A3647FB.9010808@redhat.com> <4A364B53.9080007@codemonkey.ws>
	<4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>
	<20090615143737.GB14405@redhat.com>
	<4A3662BA.6030304@codemonkey.ws> <20090615150804.GH7233@redhat.com>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090615150804.GH7233@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Mark McLoughlin <markmc@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Daniel P. Berrange wrote:
> On Mon, Jun 15, 2009 at 10:03:22AM -0500, Anthony Liguori wrote:
>   
>> Michael S. Tsirkin wrote:
>>     
>>>> I'm not at all arguing against pci_addr.  I'm arguing about how libvirt  
>>>> should use it with respect to the "genesis" use-case where libvirt has  
>>>> no specific reason to choose one PCI slot over another.  In that case,  
>>>> I'm merely advocating that we want to let QEMU make the decision.
>>>>    
>>>>         
>>> The allocation code could be moved out into a library, and libvirt could
>>> link with it (ducks).
>>>  
>>>       
>> Why does libvirt want to do allocation?
>>     
>
> It doesn't want to. As Mark said, libvirt just wants to be able to ensure
> a stable guest ABI, of which stable PCI addresses is one aspect. This does
> not imply libvirt wants to allocate the PCI addresses, just that it wants
> a way to keep them stable. All else being equal I'd rather libvirt wasn't
> in the PCI address allocation business.
>   

It's not about what libvirt wants. It's about what will serve the end 
user the most.
Apart for stable guest ABI, end users need to have the option to control 
the slot for
their devices. Just like them have for physical machines. It's not 
theoretical discussion,
limiting issues with shared irq is one real life example.

Thanks, dor
