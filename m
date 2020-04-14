From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 07/10] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Date: Tue, 14 Apr 2020 12:35:02 -0400
Message-ID: <20200414123438-mutt-send-email-mst@kernel.org>
References: <20200311171422.10484-1-david@redhat.com>
 <20200311171422.10484-8-david@redhat.com>
 <156601a9-e919-b88f-2278-97ecee554d21@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-7061-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <156601a9-e919-b88f-2278-97ecee554d21@redhat.com>
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2020 at 06:19:04PM +0100, David Hildenbrand wrote:
> On 11.03.20 18:14, David Hildenbrand wrote:
> > virtio-mem wants to offline and remove a memory block once it unplugged
> > all subblocks (e.g., using alloc_contig_range()). Let's provide
> > an interface to do that from a driver. virtio-mem already supports to
> > offline partially unplugged memory blocks. Offlining a fully unplugged
> > memory block will not require to migrate any pages. All unplugged
> > subblocks are PageOffline() and have a reference count of 0 - so
> > offlining code will simply skip them.
> >=20
> > All we need is an interface to offline and remove the memory from kerne=
l
> > module context, where we don't have access to the memory block devices
> > (esp. find_memory_block() and device_offline()) and the device hotplug
> > lock.
> >=20
> > To keep things simple, allow to only work on a single memory block.
> >=20
>=20
> Lost the ACK from Michael
>=20
> Acked-by: Michal Hocko <mhocko@suse.com> [1]
>=20
> [1] https://lkml.kernel.org/r/20200302142737.GP4380@dhcp22.suse.cz


Andrew, could you pls ack merging this through the vhost tree,
with the rest of the patchset?

> --=20
> Thanks,
>=20
> David / dhildenb
