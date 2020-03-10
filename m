From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Tue, 10 Mar 2020 23:02:58 +0100
Message-ID: <6021D755-F883-4524-B3D1-07C03C7DF11B@redhat.com>
References: <20200310172114-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310172114-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Tyler Sanderson <tysand@google.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



> Am 10.03.2020 um 22:25 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Tue, Mar 10, 2020 at 08:13:19PM +0100, David Hildenbrand wrote=
:
>>> Should this have:
>>>=20
>>> Cc: stable@vger.kernel.org # 4.19+
>>=20
>> I guess as nothing will actually "crash" it's not worth stable.
>=20
>=20
> No - it's a regression, it would be a stable candidate from that POV.

AFAIK

=E2=80=9E It must fix a problem that causes a build error (but not for thing=
s marked CONFIG_BROKEN), an oops, a hang, data corruption, a real security i=
ssue, or some =E2=80=9Coh, that=E2=80=99s not good=E2=80=9D issue. In short,=
 something critical.=E2=80=9C

If this regression is that critical is debatable. But it doesn=E2=80=98t mat=
ter as you correctly say, it=E2=80=98s too big :)=
