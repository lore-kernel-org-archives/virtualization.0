From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V8 9/9] virtio: Intel IFC VF driver for VDPA
Date: Thu, 26 Mar 2020 21:56:48 +0800
Message-ID: <a03edad7-e1c9-ae2f-5843-d63907289a3f@redhat.com>
References: <20200325082711.1107-1-jasowang@redhat.com>
 <20200325082711.1107-10-jasowang@redhat.com>
 <20200325123410.GX13183@mellanox.com>
 <ed04692d-236c-2eee-4429-6ef4d5d165fe@redhat.com>
 <20200326121705.GJ13183@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200326121705.GJ13183@mellanox.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, Bie Tiwei <tiwei.bie@intel.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/26 =E4=B8=8B=E5=8D=888:17, Jason Gunthorpe wrote:
> On Thu, Mar 26, 2020 at 01:50:53PM +0800, Jason Wang wrote:
>
>>>> +	adapter->vdpa.dma_dev =3D dev;
>>>> +	ret =3D vdpa_register_device(&adapter->vdpa);
>>>> +	if (ret) {
>>>> +		IFCVF_ERR(adapter->dev, "Failed to register ifcvf to vdpa bus");
>>>> +		goto err_msix;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_msix:
>>>> +	put_device(&adapter->vdpa.dev);
>>>> +	return ret;
>>>> +err_alloc:
>>>> +	pci_free_irq_vectors(pdev);
>>>> +err_vectors:
>>>> +	pci_release_regions(pdev);
>>>> +err_regions:
>>>> +	pci_disable_device(pdev);
>>>> +err_enable:
>>>> +	return ret;
>>>> +}
>>> I personally don't like seeing goto unwinds with multiple returns, an=
d
>>> here I think it is actually a tiny bug.
>>>
>>> All touches to the PCI device must stop before the driver core
>>> remove() returns - so these pci function cannot be in the kref put
>>> release function anyhow.
>>
>> I'm not sure I get here. IFCVF held refcnt of its PCI parent, so it lo=
oks to
>> me it's safe to free PCI resources in vDPA free callback?
> The refcnt doesn't prevent the driver core from re-binding the
> pci_device to another driver. Then the refcount put would do a
> pci_disable_device() after another driver has started
>
> For this reason all touches to a struct pci_device must stop before
> remove returns.
>
> Jason


Ok, will send a new version shortly.

Thanks


>
