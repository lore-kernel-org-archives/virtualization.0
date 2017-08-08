From: Joe Kniss via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [Intel-gfx] [PATCH libdrm] drm: Remove create_handle()
	drm_framebuffer "virtual".
Date: Tue, 8 Aug 2017 16:53:45 -0700
Message-ID: <CAOvnNvbEdMA-8bGiZquYEoLGUPTc083-EbUn6UpAZvd7khGixw__38000.7999403917$1509078966$gmane$org@mail.gmail.com>
References: <20170808234237.62051-1-djmk@google.com>
	<CAPM=9tzQuont4B9ybMXEDpqP583V_G64ypCR4E+zGvxLGdTULw@mail.gmail.com>
Reply-To: Joe Kniss <djmk@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6671432745317679366=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9tzQuont4B9ybMXEDpqP583V_G64ypCR4E+zGvxLGdTULw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Edward O'Callaghan <funfunctor@folklore1984.net>, Dave Airlie <airlied@linux.ie>, nouveau <nouveau@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Vetter,
	Daniel" <daniel.vetter@intel.com>, baoyou.xie@linaro.org, Alex Xie <AlexBin.Xie@amd.com>, "StDenis,
	Tom" <tom.stdenis@amd.com>, zhoucm1 <David1.Zhou@amd.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Russell King <linux@armlinux.org.uk>, krzk@kernel.org, jonathanh@nvidia.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Tomi
List-Id: virtualization@lists.linuxfoundation.org

--===============6671432745317679366==
Content-Type: multipart/alternative; boundary="001a113cdeaa859de8055646ac90"

--001a113cdeaa859de8055646ac90
Content-Type: text/plain; charset="UTF-8"

I didn't mean to add libdrm, sorry, there is a separate change for that.
I'll double check and test the drivers that don't implement the virtual.

Thanks for the quick reply!

-j

On Tue, Aug 8, 2017 at 4:50 PM, Dave Airlie <airlied@gmail.com> wrote:

> On 9 August 2017 at 09:42, Joe Kniss <djmk@chromium.org> wrote:
> > Because all drivers currently use gem objects for framebuffer planes,
> > the virtual create_handle() is not required.  This change adds a
> > struct drm_gem_object *gems[4] field to drm_framebuffer and removes
> > create_handle() function pointer from drm_framebuffer_funcs.  The
> > corresponding *_create_handle() function is removed from each driver.
> >
> > In many cases this change eliminates a struct *_framebuffer object,
> > as the only need for the derived struct is the addition of the gem
> > object pointer.
>
> Why the libdrm in the tag? this isn't for libdrm.
>
> This will break drivers that don't current implement the virtual at all.
>
> I think vwmgfx.
>
> The current code checks if the virtual is there before callng it, this code
> just calls the gem code always.
>
> Dave.
>



-- 
Dr. Joe Michael Kniss |  Google ChromeOS |  djmk@google.com   |
1-801-898-7977

--001a113cdeaa859de8055646ac90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I didn&#39;t mean to add libdrm, sorry, there is a separat=
e change for that.=C2=A0 I&#39;ll double check and test the drivers that do=
n&#39;t implement the virtual. =C2=A0<div><br></div><div>Thanks for the qui=
ck reply!</div><div><br></div><div>-j</div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Tue, Aug 8, 2017 at 4:50 PM, Dave Airlie=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:airlied@gmail.com" target=3D"_blan=
k">airlied@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><span class=3D"">On 9 August 2017 at 09:42, Joe Kniss &lt;<a href=3D"mail=
to:djmk@chromium.org">djmk@chromium.org</a>&gt; wrote:<br>
&gt; Because all drivers currently use gem objects for framebuffer planes,<=
br>
&gt; the virtual create_handle() is not required.=C2=A0 This change adds a<=
br>
&gt; struct drm_gem_object *gems[4] field to drm_framebuffer and removes<br=
>
&gt; create_handle() function pointer from drm_framebuffer_funcs.=C2=A0 The=
<br>
&gt; corresponding *_create_handle() function is removed from each driver.<=
br>
&gt;<br>
&gt; In many cases this change eliminates a struct *_framebuffer object,<br=
>
&gt; as the only need for the derived struct is the addition of the gem<br>
&gt; object pointer.<br>
<br>
</span>Why the libdrm in the tag? this isn&#39;t for libdrm.<br>
<br>
This will break drivers that don&#39;t current implement the virtual at all=
.<br>
<br>
I think vwmgfx.<br>
<br>
The current code checks if the virtual is there before callng it, this code=
<br>
just calls the gem code always.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Dave.<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr"><table cellspacing=3D"0" cellpadding=3D"0" =
style=3D"text-align:center;color:rgb(80,0,80);font-family:&#39;Times New Ro=
man&#39;"><tbody><tr style=3D"color:rgb(85,85,85);font-family:sans-serif;fo=
nt-size:small"><td nowrap style=3D"border-top-style:solid;border-top-color:=
rgb(213,15,37);border-top-width:2px"><font size=3D"1"><font face=3D"garamon=
d, serif">Dr. Joe Michael Kniss </font>|</font></td><td nowrap style=3D"bor=
der-top-style:solid;border-top-color:rgb(51,105,232);border-top-width:2px">=
<font size=3D"1">=C2=A0<font face=3D"garamond, serif"><font color=3D"#0b539=
4">G</font><font color=3D"#cc0000">o</font><font color=3D"#bf9000">o</font>=
<font color=3D"#0b5394">g</font><font color=3D"#38761d">l</font><font color=
=3D"#cc0000">e</font><font color=3D"#000000">=C2=A0</font><font color=3D"#4=
44444">ChromeOS</font></font><font color=3D"#000000">=C2=A0</font>|</font><=
/td><td nowrap style=3D"border-top-style:solid;border-top-color:rgb(0,153,5=
7);border-top-width:2px"><font size=3D"1"><font face=3D"garamond, serif">=
=C2=A0<a href=3D"mailto:djmk@google.com" target=3D"_blank">djmk<font color=
=3D"#1155cc">@google.com</font></a>=C2=A0</font>=C2=A0</font></td><td nowra=
p style=3D"border-top-style:solid;border-top-color:rgb(238,178,17);border-t=
op-width:2px"><font size=3D"1"><a value=3D"+16504298119" style=3D"color:rgb=
(17,85,204)">| </a><font face=3D"garamond, serif"><font color=3D"#1155cc">1=
-801-898-7977</font><br></font></font></td></tr></tbody></table></div></div=
></div></div>
</div>

--001a113cdeaa859de8055646ac90--

--===============6671432745317679366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6671432745317679366==--
