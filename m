From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Wed, 05 Sep 2012 13:54:07 +0800
Message-ID: <5046E8FF.9020504@redhat.com>
References: <20120903044133.GA9980@moria.home.lan>
	<87wr0ae26e.fsf@rustcorp.com.au> <5046D3A2.3070108@redhat.com>
	<20120905054830.GB7517@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120905054830.GB7517@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kent Overstreet <koverstreet@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/05/2012 01:48 PM, Michael S. Tsirkin wrote:
> On Wed, Sep 05, 2012 at 12:22:58PM +0800, Asias He wrote:
>> On 09/04/2012 02:23 PM, Rusty Russell wrote:
>>> Kent Overstreet <koverstreet@google.com> writes:
>>>
>>>> CONFIG_VIRTIO isn't exposed, everything else is supposed to select it
>>>> instead.
>>>
>>> This is a slight mis-understanding.  It's supposed to be selected by
>>> the particular driver, probably virtio_pci in your case.
>>
>> virtio_mmio selects virtio as well.
>>
>> drivers/virtio/Kconfig
>> config VIRTIO_MMIO
>>        select VIRTIO
>> config VIRTIO_PCI
>>        select VIRTIO
>>
>> How about this:
>> config VIRTIO_BLK
>>        depends on EXPERIMENTAL && (VIRTIO_PCI || VIRTIO_MMIO)
> 
> Isn't this exactly what depends on VIRTIO achieves?

Yes. But this gives the information that virtio_blk depends on one of
the virtio transport: virito_pci or virtio_mmio.

-- 
Asias
