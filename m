From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio over SW-defined/CPU-driven PCIe endpoint
Date: Fri, 30 Mar 2018 01:38:47 +0300
Message-ID: <20180330012730-mutt-send-email-mst@kernel.org>
References: <7cbb8e1c-a34b-2cef-9de3-f034f6afcdfd@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7cbb8e1c-a34b-2cef-9de3-f034f6afcdfd@wwwdotorg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 29, 2018 at 03:22:29PM -0600, Stephen Warren wrote:
> I've been investigating how to implement a virtio device (as opposed to a
> virtio driver) on a regular computer system with a PCIe controller that can
> operate in endpoint mode, as opposed to an endpoint that's implemented by a
> hypervisor that can preempt execution of a VM, or an endpoint that's
> implemented purely in hardware by logic gates. In my case (and I assume
> likely in most CPU-driven PCIe endpoint cases), the endpoint controller has
> the following capabilities:
> 
> - Host-initiated accesses to the endpoint's BARs can read/write normal
> memory, but not hardware registers within the endpoint system.
> 
> - Accesses to memory exposed by BARs can't be synchronously handled by the
> endpoint's local CPU. The local CPU can't be notified when the host writes
> memory in order to synchronously update other memory locations. The local
> CPU can't synchronously generate the result of a host read transaction, but
> rather the data must be present in memory ahead of time.
> 
> - Accesses to a small region of address space can be used to generate
> interrupts to the endpoint's local CPU. This region can be exposed through a
> PCI BAR (or perhaps as part of a BAR; not sure on details yet). This region
> of memory has a fixed format and is separate from true RAM, and so can't be
> used to hold PCI-virtio's discovery/capability data.
> 
> - The endpoint can emit PCI interrupts (e.g. MSI) to the attached host.
> 
> The model described in the virtio spec's "Virtio PCI Bus" section doesn't
> seem to work in this case, since it assumes:
> 
> - Writes to some fields in the PCI configuration space (e.g.
> {queue,device_feature,driver_feature}_select) synchronously update other
> fields (e.g. queue_size), which can immediately be accessed by the host.
> This isn't possible when the memory content is created by a CPU that isn't a
> synchronous part of PCI accesses.
> 
> - Writing to some fields in the PCI configuration space (e.g. device_status)
> are supposed to trigger a response by the device, without the need to
> explicitly notify the device of the memory write by some other means. This
> isn't possible when the endpoint's local CPU has no mechanism to be notified
> of such writes.
> 
> - The device_status field is asynchronously read-write by both the device
> and driver, yet the spec requires that the driver must always
> read-modify-write this field, and additionally that the driver must never
> clear any device status bit. These requirements seem impossible to satisfy
> in any case at all, let alone the current case.
> 
> I can see some possible solutions here:
> 
> 1) Just implement virtqueues but not all of the standardized PCI discovery
> protocol. virtqueues don't have the problems described above and should work
> fine between systems where there are asynchronous CPUs on both ends.
> virtqueus solely rely on normal memory access without side-effects and
> explicit notification. This would require implementing some
> custom/device-specific discovery protocol. I believe that remoteproc/rpmsg
> take this approach.
> 
> 2) Define a new standardized virtio PCI discovery protocol that is better
> suited to the device being an asynchronous CPU. For example, eliminate the
> need for the device to somehow notice memory accesses and rely on explicitl
> notification instead. Separate device-written and driver-written data into
> different cache-lines or pages.
> 
> 3) Use something other than virtio/virtqueues instead.
> 
> As an aside, I noticed that the memory allocation for virtqueues is very
> lopsided; the driver always allocates the storage. This means that the
> device must perform PCI reads to transfer data from the driver to the
> device. PCI reads are typically slower than PCI writes since reads require a
> round-trip transfer, whereas writes can be posted. I wonder if any thought
> has been put into having the device optionally allocate virtuqueue buffers
> so that the protocol can rely primarily on PCI writes? Perhaps there's some
> alternative protocol that's more optimized for true PCI-based communication
> rather than paravirtualized PCI-based communication?
> 
> Thanks for any thoughts on the best approach, or pointers to pre-existing
> work in this area.

I think Jan Kiszka wanted to add ability to put some data in the PCI
BAR. This was never formally proposed.

Your first step IMHO should be to send these thoughts to one of the
virtio TC mailing lists, that's where discussion about virtio interface
extensions takes place. virtualization@lists.linux-foundation.org is
mostly for Linux virtio drivers.

-- 
MST
