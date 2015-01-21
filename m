From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 10/16] s390: add pci_iomap_range
Date: Wed, 21 Jan 2015 11:13:14 +1030
Message-ID: <87fvb5arq5.fsf@rustcorp.com.au>
References: <1421256142-11512-1-git-send-email-mst@redhat.com>
	<1421256142-11512-11-git-send-email-mst@redhat.com>
	<alpine.LFD.2.11.1501161051380.1742@denkbrett>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.11.1501161051380.1742@denkbrett>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sebastian Ott <sebott@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Sebastian Ott <sebott@linux.vnet.ibm.com> writes:
> On Wed, 14 Jan 2015, Michael S. Tsirkin wrote:
>>  }
>> -EXPORT_SYMBOL_GPL(pci_iomap);
>> +EXPORT_SYMBOL_GPL(pci_iomap_range);
>> +
>> +void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
>> +{
>> +	return pci_iomap_range(dev, bar, 0, maxlen);
>> +}
>> +EXPORT_SYMBOL(pci_iomap);
>
> As discussed earlier, could you please leave that as EXPORT_SYMBOL_GPL.
> If there's a reason to have these interfaces as EXPORT_SYMBOL, we could
> change all of them in an extra patch.
>
> With this change integrated you can add
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

OK, I've gone back and rebased virtio-next to fix this (I don't really
want to think too hard about the legal consequences of having a version
which isn't EXPORT_SYMBOL_GPL).

Thanks,
Rusty.
