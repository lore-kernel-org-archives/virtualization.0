From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Tue, 1 Sep 2015 16:09:44 +0200
Message-ID: <55E5B1A8.9080506@siemens.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55E55539.4030008@siemens.com>
	<20150901104914-mutt-send-email-mst@redhat.com>
	<55E56BD8.5010202@siemens.com>
	<20150901121743-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150901121743-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Claudio.Fontana@huawei.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Varun Sethi <Varun.Sethi@freescale.com>, opnfv-tech-discuss@lists.opnfv.org
List-Id: virtualization@lists.linuxfoundation.org

On 2015-09-01 11:24, Michael S. Tsirkin wrote:
> On Tue, Sep 01, 2015 at 11:11:52AM +0200, Jan Kiszka wrote:
>> On 2015-09-01 10:01, Michael S. Tsirkin wrote:
>>> On Tue, Sep 01, 2015 at 09:35:21AM +0200, Jan Kiszka wrote:
>>>> Leaving all the implementation and interface details aside, this
>>>> discussion is first of all about two fundamentally different approaches:
>>>> static shared memory windows vs. dynamically remapped shared windows (a
>>>> third one would be copying in the hypervisor, but I suppose we all agree
>>>> that the whole exercise is about avoiding that). Which way do we want or
>>>> have to go?
>>>>
>>>> Jan
>>>
>>> Dynamic is a superset of static: you can always make it static if you
>>> wish. Static has the advantage of simplicity, but that's lost once you
>>> realize you need to invent interfaces to make it work.  Since we can use
>>> existing IOMMU interfaces for the dynamic one, what's the disadvantage?
>>
>> Complexity. Having to emulate even more of an IOMMU in the hypervisor
>> (we already have to do a bit for VT-d IR in Jailhouse) and doing this
>> per platform (AMD IOMMU, ARM SMMU, ...) is out of scope for us. In that
>> sense, generic grant tables would be more appealing.
> 
> That's not how we do things for KVM, PV features need to be
> modular and interchangeable with emulation.

I know, and we may have to make some compromise for Jailhouse if that
brings us valuable standardization and broad guest support. But we will
surely not support an arbitrary amount of IOMMU models for that reason.

> 
> If you just want something that's cross-platform and easy to
> implement, just build a PV IOMMU. Maybe use virtio for this.

That is likely required to keep the complexity manageable and to allow
static preconfiguration.

Well, we could declare our virtio-shmem device to be an IOMMU device
that controls access of a remote VM to RAM of the one that owns the
device. In the static case, this access may at most be enabled/disabled
but not moved around. The static regions would have to be discoverable
for the VM (register read-back), and the guest's firmware will likely
have to declare those ranges reserved to the guest OS.

In the dynamic case, the guest would be able to create an alternative
mapping. We would probably have to define a generic page table structure
for that. Or do you rather have some MPU-like control structure in mind,
more similar to the memory region descriptions vhost is already using?
Also not yet clear to me are how the vhost-pci device and the
translations it will have to do should look like for VM2.

> 
>> But what we would
>> actually need is an interface that is only *optionally* configured by a
>> guest for dynamic scenarios, otherwise preconfigured by the hypervisor
>> for static setups. And we need guests that support both. That's the
>> challenge.
>>
>> Jan
> 
> That's already there for IOMMUs: vfio does the static setup by default,
> enabling iommu by guests is optional.

Cannot follow yet how vfio comes into play regarding some preconfigured
virtual IOMMU.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
