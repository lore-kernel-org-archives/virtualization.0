From: "Caitlin Bestler" <caitlinb@broadcom.com>
Subject: RE: [kvm-devel] [Xen-devel] More virtio users
Date: Fri, 15 Jun 2007 09:26:18 -0700
Message-ID: <1EF1E44200D82B47BD5BA61171E8CE9D0426A06D__9292.695640079$1181924846$gmane$org@NT-IRVA-0750.brcm.ad.broadcom.com>
References: <200706150139.36770.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200706150139.36770.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm-devel@lists.sourceforge.net, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> On Thursday 14 June 2007, Caitlin Bestler wrote:
>> 
>> Why not simply adopt the policy that if the IOMMU does not meet the
>> security requirements of the Hypervisor then it is not an IOMMU as
>> far as the Hypervisor is concerned?
>> 
>> More specificially, the Hypervisor should enable direct access by a
>> Guest to a device *only* if an IOMMU functionality exists to allow
>> the Hypervisor to create a virtual IO memory map that controls
>> *precisiley* which pages the device is allowed to access for that
>> guest. 
>> 
>> If such functionality is not available then the Guest MUST NOT access
>> the device directly, and a frontend/backend solution must be used
>> instead. 
>> 
>> Basically, there are no security problems using an IOMMU, because if
>> there is a security problem it is not an IOMMU.
> 
> We shouldn't redefine standard terms, IOMMUs have existed for
> a long time on systems that do not run hypervisors, and it's
> not often clear if they have a security problem or not.
> 
> In case of the Cell Broadband Engine I already mentioned,
> there is an IOMMU integrated on the CPU which has all the
> necessary features needed for secure operation. However,
> whether those are effective depends on the type of I/O device you
> connect to it. 
> 
> With the "axon" bridge chip, it is by default insecure and we
> should not allow access from any guest, while the "spider"
> bridge has some devices (e.g. USB and network) that are
> guaranteed to be safe when set up correctly, and other devices that
> are not. 
> 
> I agree that we shouldn't allow guest to access devices if
> that is dangerous, but that doesn't mean that the IOMMU
> magically is something else than an IOMMU.
> 
> 	Arnd <><

It's not making up a term, it's citing a specific standard.
I believe that only the degree of isolation provided by the
PCI-SIG SR IOV definition of an IOMMU, or something equivalent,
provides sufficient isolation to allow a Hypervisor to directly
connect a guest and a device.

If a guest can be "clever" (and/or clumbsy) and access memory
that was not assigned to it by the Hypervisor through the use
of a device then the guest cannot be allowed direct access to
the device.

Are you suggesting that the Hypervisor should allow guests
to access devices via limited IOMMUs that cannot guarantee
security and that these limitations should just be documented?

Whatever it is called elsewhere, an "IOMMU" that cannot guarantee
that it will only allow authorized memory access on request of
a directly connected guest is not relevant to discussions of
virtualization.
