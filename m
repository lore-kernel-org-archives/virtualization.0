From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/10] virtio-mem: paravirtualized memory
Date: Tue, 14 Apr 2020 12:28:35 -0400
Message-ID: <20200414122716-mutt-send-email-mst@kernel.org>
References: <20200311171422.10484-1-david@redhat.com>
 <20200329084128-mutt-send-email-mst@kernel.org>
 <b9984195-bb48-e2a6-887d-0905692a7524@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-7059-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <b9984195-bb48-e2a6-887d-0905692a7524@redhat.com>
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>Johannes Weiner <ha>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 14, 2020 at 11:15:18AM +0200, David Hildenbrand wrote:
> On 29.03.20 14:42, Michael S. Tsirkin wrote:
> > On Wed, Mar 11, 2020 at 06:14:12PM +0100, David Hildenbrand wrote:
> >> This series is based on latest linux-next. The patches are located at:
> >>     https://github.com/davidhildenbrand/linux.git virtio-mem-v2
> >>
> >> I now have acks for all !virtio-mem changes. I'll be happy to get revi=
ew
> >> feedback, testing reports, etc. for the virtio-mem changes. If there a=
re
> >> no further comments, I guess this is good to go as a v1 soon.
> >=20
> > I'd like to queue it for merge after the release. If you feel it's read=
y
> > please ping me after the release to help make sure it didn't get
> > dropped.  I see there were some reports about people having trouble
> > using this, pls keep working on this meanwhile.
>=20
> Hi Michael,
>=20
> I think this is ready to go as a first version. There are a couple of
> future work items related to kexec/kdump:
> - Teach kexec-tools/kexec_file_load() to not place the kexec
>   kernel/initrd onto virtio-mem added memory.
> - Teach kexec-tools/kdump to consider a bigger number of memory
>   resources for dumping.
>=20
> In general, as virtio-mem adds a lot of memory resources, we might want
> to tweak performance in that area as well. Future stuff.
>=20
> So I suggest queuing this. If you need a resend, please let me know.
>=20
> Cheers!

Thanks!
I'll queue it for merge after the release. If possible please ping me
after the release to help make sure it didn't get dropped.




> --=20
> Thanks,
>=20
> David / dhildenb
