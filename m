From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Thu, 3 Sep 2015 11:08:18 +0300
Message-ID: <20150903105304-mutt-send-email-mst@redhat.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55E55539.4030008@siemens.com>
	<20150901104914-mutt-send-email-mst@redhat.com>
	<55E56BD8.5010202@siemens.com>
	<20150901121743-mutt-send-email-mst@redhat.com>
	<55E5B1A8.9080506@siemens.com>
	<20150901172239-mutt-send-email-mst@redhat.com>
	<55E5C58D.6000104@siemens.com>
	<20150901184922-mutt-send-email-mst@redhat.com>
	<55E5D22C.6020108@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55E5D22C.6020108@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: virtio-dev@lists.oasis-open.org, Claudio.Fontana@huawei.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Varun Sethi <Varun.Sethi@freescale.com>, opnfv-tech-discuss@lists.opnfv.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 01, 2015 at 06:28:28PM +0200, Jan Kiszka wrote:
> On 2015-09-01 18:02, Michael S. Tsirkin wrote:
> > On Tue, Sep 01, 2015 at 05:34:37PM +0200, Jan Kiszka wrote:
> >> On 2015-09-01 16:34, Michael S. Tsirkin wrote:
> >>> On Tue, Sep 01, 2015 at 04:09:44PM +0200, Jan Kiszka wrote:
> >>>> On 2015-09-01 11:24, Michael S. Tsirkin wrote:
> >>>>> On Tue, Sep 01, 2015 at 11:11:52AM +0200, Jan Kiszka wrote:
> >>>>>> On 2015-09-01 10:01, Michael S. Tsirkin wrote:
> >>>>>>> On Tue, Sep 01, 2015 at 09:35:21AM +0200, Jan Kiszka wrote:
> >>>>>>>> Leaving all the implementation and interface details aside, this
> >>>>>>>> discussion is first of all about two fundamentally different approaches:
> >>>>>>>> static shared memory windows vs. dynamically remapped shared windows (a
> >>>>>>>> third one would be copying in the hypervisor, but I suppose we all agree
> >>>>>>>> that the whole exercise is about avoiding that). Which way do we want or
> >>>>>>>> have to go?
> >>>>>>>>
> >>>>>>>> Jan
> >>>>>>>
> >>>>>>> Dynamic is a superset of static: you can always make it static if you
> >>>>>>> wish. Static has the advantage of simplicity, but that's lost once you
> >>>>>>> realize you need to invent interfaces to make it work.  Since we can use
> >>>>>>> existing IOMMU interfaces for the dynamic one, what's the disadvantage?
> >>>>>>
> >>>>>> Complexity. Having to emulate even more of an IOMMU in the hypervisor
> >>>>>> (we already have to do a bit for VT-d IR in Jailhouse) and doing this
> >>>>>> per platform (AMD IOMMU, ARM SMMU, ...) is out of scope for us. In that
> >>>>>> sense, generic grant tables would be more appealing.
> >>>>>
> >>>>> That's not how we do things for KVM, PV features need to be
> >>>>> modular and interchangeable with emulation.
> >>>>
> >>>> I know, and we may have to make some compromise for Jailhouse if that
> >>>> brings us valuable standardization and broad guest support. But we will
> >>>> surely not support an arbitrary amount of IOMMU models for that reason.
> >>>>
> >>>>>
> >>>>> If you just want something that's cross-platform and easy to
> >>>>> implement, just build a PV IOMMU. Maybe use virtio for this.
> >>>>
> >>>> That is likely required to keep the complexity manageable and to allow
> >>>> static preconfiguration.
> >>>
> >>> Real IOMMU allow static configuration just fine. This is exactly
> >>> what VFIO uses.
> >>
> >> Please specify more precisely which feature in which IOMMU you are
> >> referring to. Also, given that you refer to VFIO, I suspect we have
> >> different thing in mind. I'm talking about an IOMMU device model, like
> >> the one we have in QEMU now for VT-d. That one is not at all
> >> preconfigured by the host for VFIO.
> > 
> > I really just mean that VFIO creates a mostly static IOMMU configuration.
> > 
> > It's configured by the guest, not the host.
> 
> OK, that resolves my confusion.
> 
> > 
> > I don't see host control over configuration as being particularly important.
> 
> We do, see below.
> 
> > 
> > 
> >>>
> >>>> Well, we could declare our virtio-shmem device to be an IOMMU device
> >>>> that controls access of a remote VM to RAM of the one that owns the
> >>>> device. In the static case, this access may at most be enabled/disabled
> >>>> but not moved around. The static regions would have to be discoverable
> >>>> for the VM (register read-back), and the guest's firmware will likely
> >>>> have to declare those ranges reserved to the guest OS.
> >>>> In the dynamic case, the guest would be able to create an alternative
> >>>> mapping.
> >>>
> >>>
> >>> I don't think we want a special device just to support the
> >>> static case. It might be a bit less code to write, but
> >>> eventually it should be up to the guest.
> >>> Fundamentally, it's policy that host has no business
> >>> dictating.
> >>
> >> "A bit less" is to be validated, and I doubt its just "a bit". But if
> >> KVM and its guests will also support some PV-IOMMU that we can reuse for
> >> our scenarios, than that is fine. KVM would not have to mandate support
> >> for it while we would, that's all.
> > 
> > Someone will have to do this work.
> > 
> >>>
> >>>> We would probably have to define a generic page table structure
> >>>> for that. Or do you rather have some MPU-like control structure in mind,
> >>>> more similar to the memory region descriptions vhost is already using?
> >>>
> >>> I don't care much. Page tables use less memory if a lot of memory needs
> >>> to be covered. OTOH if you want to use virtio (e.g. to allow command
> >>> batching) that likely means commands to manipulate the IOMMU, and
> >>> maintaining it all on the host. You decide.
> >>
> >> I don't care very much about the dynamic case as we won't support it
> >> anyway. However, if the configuration concept used for it is applicable
> >> to static mode as well, then we could reuse it. But preconfiguration
> >> will required register-based region description, I suspect.
> > 
> > I don't know what you mean by preconfiguration exactly.
> > 
> > Do you want the host to configure the IOMMU? Why not let the
> > guest do this?
> 
> We simply freeze GPA-to-HPA mappings during runtime. Avoids having to
> validate and synchronize guest-triggered changes.

Fine, but this assumes guest does very specific things, right?
E.g. should guest reconfigure device's BAR, you would have
to change GPA to HPA mappings?


> >>>
> >>>> Also not yet clear to me are how the vhost-pci device and the
> >>>> translations it will have to do should look like for VM2.
> >>>
> >>> I think we can use vhost-pci BAR + VM1 bus address as the
> >>> VM2 physical address. In other words, all memory exposed to
> >>> virtio-pci by VM1 through it's IOMMU is mapped into BAR of
> >>> vhost-pci.
> >>>
> >>> Bus addresses can be validated to make sure they fit
> >>> in the BAR.
> >>
> >> Sounds simple but may become challenging for VMs that have many of such
> >> devices (in order to connect to many possibly large VMs).
> > 
> > You don't need to be able to map all guest memory if you know
> > guest won't try to allow device access to all of it.
> > It's a question of how good is the bus address allocator.
> 
> But those BARs need to allocate a guest-physical address range as large
> as the other guest's RAM is, possibly even larger if that RAM is not
> contiguous, and you can't put other resources into potential holes
> because VM2 does not know where those holes will be.

No - only the RAM that you want addressable by VM2.

IOW if you wish, you actually can create a shared memory device,
make it accessible to the IOMMU and place some or all
data there.




> > 
> >>>
> >>>
> >>> One issue to consider is that VM1 can trick VM2 into writing
> >>> into bus address that isn't mapped in the IOMMU, or
> >>> is mapped read-only.
> >>> We probably would have to teach KVM to handle this somehow,
> >>> e.g. exit to QEMU, or even just ignore. Maybe notify guest
> >>> e.g. by setting a bit in the config space of the device,
> >>> to avoid easy DOS.
> >>
> >> Well, that would be trivial for VM1 to check if there are only one or
> >> two memory windows. Relying on the hypervisor to handle it may be
> >> unacceptable for real-time VMs.
> >>
> >> Jan
> > 
> > Why? real-time != fast. I doubt you can avoid vm exits completely.
> 
> We can, one property of Jailhouse (on x86, ARM is waiting for GICv4).
> 
> Real-time == deterministic. And if you have such vm exits potentially in
> your code path, you have them always - for worst-case analysis. One may
> argue about probability in certain scenarios, but if the triggering side
> is malicious, probability may become 1.
> 
> Jan

You are doing a special hypervisor anyway, I think you could
detect that setup is done, and freeze
the configuration.

If afterwards a VM attempts to modify mappings, you can
say it's malicious and ignore it, or kill it, or whatever.



> -- 
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
