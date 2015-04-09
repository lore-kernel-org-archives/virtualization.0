From: Luke Gorrie <luke@snabb.co>
Subject: Re: [dpdk-dev] [snabb-devel] Re: memory barriers in virtq.lua?
Date: Thu, 9 Apr 2015 05:12:30 +0200
Message-ID: <CAA2XHbdNAB1ZsBFYHW7W1yhnkzaSixwKk4KvjU8G=7OLECpZhQ__21210.9222462916$1428549167$gmane$org@mail.gmail.com>
References: <20150127160126.GA10651@redhat.com>
	<CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw@mail.gmail.com>
	<CAA2XHbcU0tV0NrBXT6oh6LOz7sKm9P8jqD1=T-ZgTahSVM_qwQ@mail.gmail.com>
	<C37D651A908B024F974696C65296B57B0F42E766@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5780253560237414543=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <C37D651A908B024F974696C65296B57B0F42E766@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "snabb-devel@googlegroups.com" <snabb-devel@googlegroups.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============5780253560237414543==
Content-Type: multipart/alternative; boundary=047d7bb04272afd8c2051342049f

--047d7bb04272afd8c2051342049f
Content-Type: text/plain; charset=UTF-8

Howdy,

On 8 April 2015 at 17:15, Xie, Huawei <huawei.xie@intel.com> wrote:

> luke:
> 1. host read the flag. 2 guest toggles the flag 3.guest checks the used.
> 4. host update used.
> Is this your case?
>

Yep, that is exactly the case I mean.

Cheers,
-Luke

--047d7bb04272afd8c2051342049f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Howdy,<br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 8 April 2015 at 17:15, Xie, Huawei <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:huawei.xie@intel.com" target=3D"_blank">huawei.xie@intel.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">luke:<br>
1. host read the flag. 2 guest toggles the flag 3.guest checks the used.<br=
>
4. host update used.<br>
Is this your case?<br></blockquote><div><br></div><div>Yep, that is exactly=
 the case I mean.</div><div><br></div><div>Cheers,</div><div>-Luke</div><di=
v><br></div><div><br></div></div></div></div>

--047d7bb04272afd8c2051342049f--

--===============5780253560237414543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5780253560237414543==--
