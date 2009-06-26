From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCHv6 05/12] qemu/pci: MSI-X support functions
Date: Fri, 26 Jun 2009 11:01:12 -0500
Message-ID: <4A44F0C8.8020807__46816.9588399634$1246032168$gmane$org@codemonkey.ws>
References: <cover.1245594586.git.mst@redhat.com>
	<20090621164954.GF10164@redhat.com>
	<20090626142635.GD5939@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090626142635.GD5939@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> On Sun, Jun 21, 2009 at 07:49:54PM +0300, Michael S. Tsirkin wrote:
>   
>> +    dev->msix_mmio_index = cpu_register_io_memory(0, msix_mmio_read,
>> +                                                  msix_mmio_write, dev);
>>     
>
>
> The signature for cpu_register_io_memory changed meanwhile so this now
> needs to be:
>
> +    dev->msix_mmio_index = cpu_register_io_memory(msix_mmio_read,
> +                                                  msix_mmio_write, dev);
>
> Anthony, I guess you figured this out, or do you want me to respin the series
> with this minor fix?
>   

It's already changed in staging.

Regards,

Anthony Liguori
