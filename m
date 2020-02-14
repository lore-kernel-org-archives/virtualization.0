From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Fri, 14 Feb 2020 22:17:26 +0100
Message-ID: <8B1B3CD6-10D5-46D3-B8E5-A6AD0B8E41BC@redhat.com>
References: <CAJuQAmpGKcyWo8Ojnia_pXZAaOt98u0c_Sk-8ieCO218hutW1g@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: multipart/mixed; boundary="===============0044154316470416689=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmpGKcyWo8Ojnia_pXZAaOt98u0c_Sk-8ieCO218hutW1g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Tyler Sanderson <tysand@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============0044154316470416689==
Content-Type: multipart/alternative; boundary=Apple-Mail-3738AA56-3B37-4F6D-A815-7B956B2B47A0

--Apple-Mail-3738AA56-3B37-4F6D-A815-7B956B2B47A0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> Am 14.02.2020 um 21:49 schrieb Tyler Sanderson <tysand@google.com>:
>=20
> =EF=BB=BF
> Regarding Wei's patch that modifies the shrinker implementation, versus t=
his patch which reverts to OOM notifier:
> I am in favor of both patches. But I do want to make sure a fix gets back=
 ported to 4.19 where the performance regression was first introduced.
> My concern with reverting to the OOM notifier is, as mst@ put it (in the =
other thread):
> "when linux hits OOM all kind of error paths are being hit, latent bugs s=
tart triggering, latency goes up drastically."

Yeah, and that was the default behavior for years, so it=E2=80=98s not big =
news :)

> The guest could be in a lot of pain before the OOM notifier is invoked, a=
nd it seems like the shrinker API might allow more fine grained control of =
when we deflate.
>=20
> On the other hand, I'm not totally convinced that Wei's patch is an expec=
ted use of the shrinker/page-cache APIs, and maybe it is fragile. Needs mor=
e testing and scrutiny.
>=20
> It seems to me like the shrinker API is the right API in the long run, pe=
rhaps with some fixes and modifications. But maybe reverting to OOM notifie=
r is the best patch to back

I think that=E2=80=98s a good idea. Revert to the old state we had for year=
s and then implement a proper, fully tested solution (e.g., shrinkers with =
priorities).

Cheers!
--Apple-Mail-3738AA56-3B37-4F6D-A815-7B956B2B47A0
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto"><div dir=3D"ltr"><br></div><div dir=3D"=
ltr"><br><blockquote type=3D"cite">Am 14.02.2020 um 21:49 schrieb Tyler San=
derson &lt;tysand@google.com&gt;:<br><br></blockquote></div><blockquote typ=
e=3D"cite"><div dir=3D"ltr">=EF=BB=BF<div dir=3D"ltr"><div>Regarding Wei's =
patch that modifies the shrinker implementation, versus this patch which re=
verts to OOM notifier:</div><div>I am in favor of both patches. But I do wa=
nt to make sure a fix gets back ported to 4.19 where the performance regres=
sion was first introduced.</div><div>My concern with reverting to the OOM n=
otifier is, as mst@ put it (in the other thread):<br><span style=3D"color:r=
gb(80,0,80)">"when linux hits OOM&nbsp;</span><span style=3D"color:rgb(80,0=
,80)">all kind of error paths are being hit, latent bugs start triggering,&=
nbsp;</span><span style=3D"color:rgb(80,0,80)">latency goes up drastically.=
"</span><br></div></div></div></blockquote><div><br></div><div>Yeah, and th=
at was the default behavior for years, so it=E2=80=98s not big news :)</div=
><br><blockquote type=3D"cite"><div dir=3D"ltr"><div dir=3D"ltr"><div>The g=
uest could be in a lot of pain before the OOM notifier is invoked, and it s=
eems like the shrinker API might allow more fine grained control of when we=
 deflate.</div><div><br></div><div>On the other hand, I'm not totally convi=
nced that Wei's patch is an expected use of the shrinker/page-cache APIs, a=
nd maybe it is fragile. Needs more testing&nbsp;and scrutiny.</div><div><br=
></div><div>It seems to me like the shrinker API is the right API in the lo=
ng run, perhaps with some fixes and modifications. But maybe reverting to O=
OM notifier is the best patch to back</div></div></div></blockquote><br><di=
v>I think that=E2=80=98s a good idea. Revert to the old state we had for ye=
ars and then implement a proper, fully tested solution (e.g., shrinkers wit=
h priorities).</div><div><br></div><div>Cheers!</div></body></html>
--Apple-Mail-3738AA56-3B37-4F6D-A815-7B956B2B47A0--


--===============0044154316470416689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0044154316470416689==--
