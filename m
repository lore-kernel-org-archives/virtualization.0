From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: VIRTIO adoption in other hypervisors
Date: Fri, 28 Feb 2020 17:29:01 -0800 (PST)
Message-ID: <alpine.DEB.2.21.2002281024490.3414@sstabellini-ThinkPad-T480s>
References: <87mu93vwy2.fsf@linaro.org>
 <db75fc2b-ac2e-2351-cc3c-cdb42a50ac24@siemens.com>
 <0b80da21-ed40-c550-c605-031a209115b1@siemens.com>
 <878skmwtei.fsf@linaro.org>
 <a64fd962-8b62-58d9-9fe3-cc2aa686ac02@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a64fd962-8b62-58d9-9fe3-cc2aa686ac02@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: alex.bennee@linaro.org
Cc: Wei Liu <liuw@liuw.name>, virtio-dev@lists.oasis-open.org, Stefano Stabellini <sstabellini@kernel.org>, jan.kiszka@siemens.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 28 Feb 2020, Jan Kiszka wrote:
> > It seems to me any KVM-like run loop trivially supports a range of
> > virtio devices by virtue of trapping accesses to the signalling area of
> > a virtqueue and allowing the VMM to handle the transaction which ever
> > way it sees fit.
> > 
> > I've not quite understood the way Xen interfaces to QEMU aside from it's
> > different to everything else. More over it seems the type-1 hypervisors
> > are more interested in providing better isolation between segments of a
> > system whereas VIRTIO currently assumes either the VMM or the hypervisor
> > has full access the full guest address space. I've seen quite a lot of
> > slides that want to isolate sections of device emulation to separate
> > processes or even separate guest VMs.
> 
> The point is in fact not only whether to trap IO accesses or to ask the guest
> to rather target something like ivshmem (in fact, that is where use cases I
> have in mind deviated from those of that cloud operator). It is specifically
> the question how the backend should be able to transfer data to/from the
> frontend. If you want to isolate the both from each other (driver
> VMs/domains/etc.), you either need a complex virtual IOMMU (or "grant tables")
> or a static DMA windows (like ivshmem). The former is more efficient with
> large transfers, the latter is much simpler and therefore more robust.

Jan explained it well +1

In addition to what Jan wrote, which is the most important aspect,
there is also actually a problem with IO trapping with Xen x86 PV
guests, but I think today is far less important than it used to be. We
are talking about a type of guest designed to run without virtualization
support in hardware. Trapping is not easy in that case. Today, on x86 we
have PVH and HVM guests which use virtualization extensions. On ARM, all
guests always had hardware virtualization support from the start. So, as
of today, all guests except for old-style x86 PV guests can trap IO
accesses without issues. IO trapping comes into play when you want to
hook up something like the QEMU implementation of the PCI virtio
backends. In fact, that works today with x86 HVM guests, but not with
x86 PV guests. It doesn't work on ARM simply because Xen on ARM hasn't
been using a QEMU emulator for anything yet, but there is nothing
architectural that would prevent it from working. In fact, I have seen a
demo of an emulator running together with Xen on ARM at a conference.

(FYI today you can run OpenAMP RPMesg, which is virtio-based, between
two Xen guests by setting up pre-shared memory between them.)
