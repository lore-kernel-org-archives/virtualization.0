From: Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
Date: Tue, 13 Aug 2019 20:09:26 +0800
Message-ID: <CALQxJuvxBc3MH3_B_fZ3FvURHOM3F3dvvZ6x=GtALUAvyu7Qxw__41390.3089169011$1565698195$gmane$org@mail.gmail.com>
References: <20190613223901.9523-1-murphyt7@tcd.ie>
	<20190624061945.GA4912@infradead.org>
	<20190810071952.GA25550@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7371737247767286920=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190810071952.GA25550@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Brown <david.brown@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============7371737247767286920==
Content-Type: multipart/alternative; boundary="000000000000c3526e058ffe83e2"

--000000000000c3526e058ffe83e2
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

I quit my job and am having a great time traveling South East Asia.

I definitely don't want this work to go to waste and I hope to repost it
later this week but I can't guarantee it.

Let me know if you need this urgently.

Thanks,
Tom

On Sat 10 Aug 2019, 3:20 p.m. Christoph Hellwig, <hch@infradead.org> wrote:

> On Sun, Jun 23, 2019 at 11:19:45PM -0700, Christoph Hellwig wrote:
> > Tom,
> >
> > next time please cc Jerg as the AMD IOMMU maintainer.
> >
> > Joerg, any chance you could review this?  Toms patches to convert the
> > AMD and Intel IOMMU drivers to the dma-iommu code are going to make my
> > life in DMA land significantly easier, so I have a vested interest
> > in this series moving forward :)
>
> Tom, can you repost the series?  Seems like there hasn't been any
> news for a month.
>

--000000000000c3526e058ffe83e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Christoph,</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">I quit my job and am having a great time traveling South East =
Asia.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">I definitely=
 don&#39;t want this work to go to waste and I hope to repost it later this=
 week but I can&#39;t guarantee it.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Let me know if you need this urgently.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Tom</div><div dir=
=3D"auto"><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Sat 10 Aug 2019, 3:20 p.m. Christoph Hellwig, &lt;<a hr=
ef=3D"mailto:hch@infradead.org">hch@infradead.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Sun, Jun 23, 2019 at 11:19:45PM -0700, Chr=
istoph Hellwig wrote:<br>
&gt; Tom,<br>
&gt; <br>
&gt; next time please cc Jerg as the AMD IOMMU maintainer.<br>
&gt; <br>
&gt; Joerg, any chance you could review this?=C2=A0 Toms patches to convert=
 the<br>
&gt; AMD and Intel IOMMU drivers to the dma-iommu code are going to make my=
<br>
&gt; life in DMA land significantly easier, so I have a vested interest<br>
&gt; in this series moving forward :)<br>
<br>
Tom, can you repost the series?=C2=A0 Seems like there hasn&#39;t been any<=
br>
news for a month.<br>
</blockquote></div></div></div>

--000000000000c3526e058ffe83e2--

--===============7371737247767286920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7371737247767286920==--
