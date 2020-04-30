From: Srivatsa Vaddagiri <vatsa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Date: Thu, 30 Apr 2020 19:03:21 +0530
Message-ID: <20200430133321.GC3204@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
 <20200430111156.GI5097@quicinc.com>
 <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
Reply-To: Srivatsa Vaddagiri <vatsa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7bf8bffe-267b-6c66-86c9-40017d3ca4c2-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Cc: tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, virtio-dev-sDuHXQ4OtrM4h7I2RyI4rWD2FQJk+8+b@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, christoffer.dall-5wv7dgnIgG8@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.bennee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stefano.stabellini-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

* Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org> [2020-04-30 14:59:50]:

> >I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> >(for life-cycle management of VMs), which our hypervisor may not support. A
> >simple shared memory and doorbell or message-queue based transport will work for
> >us.
> 
> As written in our private conversation, a mapping of the ivshmem2 device
> discovery to platform mechanism (device tree etc.) and maybe even the
> register access for doorbell and life-cycle management to something
> hypercall-like would be imaginable. What would count more from virtio
> perspective is a common mapping on a shared memory transport.

Yes that sounds simpler for us.

> That said, I also warned about all the features that PCI already defined
> (such as message-based interrupts) which you may have to add when going a
> different way for the shared memory device.

Is it really required to present this shared memory as belonging to a PCI
device? I would expect the device-tree to indicate the presence of this shared
memory region, which we should be able to present to ivshmem2 as shared memory
region to use (along with some handles for doorbell or message queue use).

I understand the usefulness of modeling the shared memory as part of device so
that hypervisor can send events related to peers going down or coming up. In our
case, there will be other means to discover those events and avoiding this
requirement on hypervisor (to emulate PCI) will simplify the solution for us.

Any idea when we can expect virtio over ivshmem2 to become available?!
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
