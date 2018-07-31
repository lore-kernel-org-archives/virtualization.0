From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
	virtio_direct_dma_ops selectively
Date: Tue, 31 Jul 2018 12:30:19 +0530
Message-ID: <1e197586-4e11-48e1-a0dd-c2c440c64f9e__2256.28550765595$1533020319$gmane$org@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-3-khandual@linux.vnet.ibm.com>
	<20180730092551.GB26245@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180730092551.GB26245@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On 07/30/2018 02:55 PM, Christoph Hellwig wrote:
>> +const struct dma_map_ops virtio_direct_dma_ops;
> 
> This belongs into a header if it is non-static.  If you only
> use it in this file anyway please mark it static and avoid a forward
> declaration.

Sure, will make it static, move the definition up in the file to avoid
forward declaration.
 
> 
>> +
>>  int virtio_finalize_features(struct virtio_device *dev)
>>  {
>>  	int ret = dev->config->finalize_features(dev);
>> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (virtio_has_iommu_quirk(dev))
>> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> 
> This needs a big fat comment explaining what is going on here.

Sure, will do. Also talk about the XEN domain exception as well once
that goes into this conditional statement.

> 
> Also not new, but I find the existance of virtio_has_iommu_quirk and its
> name horribly confusing.  It might be better to open code it here once
> only a single caller is left.

Sure will do. There is one definition in the tools directory which can
be removed and then this will be the only one left.
