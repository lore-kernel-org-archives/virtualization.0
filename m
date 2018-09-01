From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 00/12] remove_conflicting_framebuffers() cleanup
Date: Sat, 1 Sep 2018 15:45:31 +0200
Message-ID: <20180901134531.GA23402@qmqm.qmqm.pl>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
	<cover.1535656077.git.mirq-linux@rere.qmqm.pl>
	<20180831090439.GT21634@phenom.ffwll.local>
	<153570646209.15613.3061584574975657074@skylake-alporthouse-com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <153570646209.15613.3061584574975657074@skylake-alporthouse-com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 31, 2018 at 10:07:42AM +0100, Chris Wilson wrote:
[...]
> Ahah, someone is looking at remove_conflicting_framebuffers(). May I
> interest you in a use-after-free?

> [  378.423513] stack segment: 0000 [#1] PREEMPT SMP PTI
> [  378.423530] CPU: 1 PID: 4338 Comm: pm_rpm Tainted: G     U            =
4.19.0-rc1-CI-CI_DRM_4746+ #1
> [  378.423548] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.=
M./J4205-ITX, BIOS P1.10 09/29/2016
> [  378.423570] RIP: 0010:do_remove_conflicting_framebuffers+0x56/0x170
> [  378.423587] Code: 49 8b 45 00 48 85 c0 74 50 f6 40 0a 08 74 4a 4d 85 e=
4 48 8b a8 78 04 00 00 74 1f 48 85 ed 74 1a 41 8b 0c 24 31 db 85 c9 74 10 <=
8b> 55 00 85 d2 75 42 83 c3 01 41 39 1c 24 77 f0 48 85 ed 74 1a 45
> [  378.423620] RSP: 0018:ffffc900001dfa88 EFLAGS: 00010202
> [  378.423632] RAX: ffff880274470008 RBX: 0000000000000000 RCX: 000000000=
0000001
> [  378.423646] RDX: 0000000000000001 RSI: ffffffffa025c634 RDI: ffff88025=
cc3b428
> [  378.423660] RBP: 6b6b6b6b6b6b6b6b R08: 000000001edaddfa R09: ffffffffa=
025c634
> [  378.423673] R10: ffffc900001dfae8 R11: ffffffff820de938 R12: ffff88025=
cc3b428
> [  378.423687] R13: ffffffff8234ca20 R14: ffffffff8234cb20 R15: 000000000=
0000001
> [  378.423701] FS:  00007fcf03d0a980(0000) GS:ffff880277e80000(0000) knlG=
S:0000000000000000
> [  378.423717] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  378.423729] CR2: 00007fffece1fdb8 CR3: 00000001fe32e000 CR4: 000000000=
03406e0
> [  378.423742] Call Trace:
> [  378.423756]  remove_conflicting_framebuffers+0x28/0x40
> [  378.423856]  i915_driver_load+0x7f5/0x10c0 [i915]
[...]

Looks like registered_fb[] entry is pointing to (partially?) freed or
corrupted fb_info, but I can't see how this could be an effect of
remove_conflicting_framebuffers().

Best Regards,
Micha=B3 Miros=B3aw
