From: Srivatsa Vaddagiri <vatsa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Date: Thu, 30 Apr 2020 16:32:06 +0530
Message-ID: <20200430110206.GB3204@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <20200430100821.GC19932@willie-the-truck>
 <20200430102939.GG5097@quicinc.com>
 <20200430103919.GF19932@willie-the-truck>
Reply-To: Srivatsa Vaddagiri <vatsa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200430103919.GF19932@willie-the-truck>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, virtio-dev-sDuHXQ4OtrM4h7I2RyI4rWD2FQJk+8+b@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, christoffer.dall-5wv7dgnIgG8@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.bennee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stefano.stabellini-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

* Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [2020-04-30 11:39:19]:

> Hi Vatsa,
> 
> On Thu, Apr 30, 2020 at 03:59:39PM +0530, Srivatsa Vaddagiri wrote:
> > > What's stopping you from implementing the trapping support in the
> > > hypervisor? Unlike the other patches you sent out, where the guest memory
> > > is not accessible to the host, there doesn't seem to be any advantage to
> > > not having trapping support, or am I missing something here?
> > 
> > 	I have had this discussion with hypervisor folks. They seem to be
> > concerned about complexity of having a VM's fault be handled in another
> > untrusted VM. They are not keen to add MMIO support.
> 
> Right, but I'm concerned about forking the implementation from the spec
> and I'm not keen to add these hooks ;)
> 
> What does your hook actually do? I'm assuming an HVC? 

Yes, it will issue message-queue related hypercalls

> If so, then where the
> fault is handled seems to be unrelated and whether the guest exit is due to
> an HVC or a stage-2 fault should be immaterial. 

A stage-2 fault would be considered fatal normally and result in termination of
guest. Modifying that behavior to allow resumption in case of virtio config
space access, especially including the untrusted VM in this flow, is
perhaps the concern. HVC calls OTOH are more vetted interfaces that the
hypervisor has to do nothing additional to handle.

> In other words, I don't
> follow why the trapping mechanism necessitates the way in which the fault is
> handled.

Let me check with our hypervisor folks again. Thanks for your inputs.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
