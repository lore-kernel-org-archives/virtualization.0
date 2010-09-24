From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] PROBLEM: [BISECTED] 2.6.35.5 xen domU panics just
 after	the boot
Date: Fri, 24 Sep 2010 11:00:03 -0700
Message-ID: <4C9CE723.5090308@goop.org>
References: <20100921190525.GD4573@davabel.touk.pl> <4C9BEA8C.2030808@goop.org> <20100924054000.GA4689@pzz.touk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100924054000.GA4689@pzz.touk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-2?Q?Pawe=B3_Zuzelski?= <pawelz@pld-linux.org>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>, James Dingwall <james.dingwall@amdocs.com>
List-Id: virtualization@lists.linuxfoundation.org

 On 09/23/2010 10:40 PM, Pawe=B3 Zuzelski wrote:
> Have you seen the message from James Dingwall?
>
> He had found the typo in fb412a178502dc498430723b082a932f797e4763
> commit and sent the patch to lkml that fixes it.
>
> Please, see https://patchwork.kernel.org/patch/202282/ if you have
> not received James' mail. That patch resolves the problem for me and
> for James.
>

(!) Oh, well.  Yes, that would explain it. I'd noticed the missing 'x',
but assumed I'd just done it with an editor fat-finger...

Looks like upstream is OK, so it crept in with the stable
cherry-pick/backport to both stable-2.6.32/master and stable-2.6.35/mas=
ter.

    J
