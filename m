From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Mon, 13 Jan 2020 08:19:39 +0100
Message-ID: <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
References: <20200110163211.GB29736@mail-itl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200110163211.GB29736@mail-itl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 10, 2020 at 05:32:11PM +0100, Marek Marczykowski-G=F3recki wrot=
e:
> Hi,
> =

> This is the context of "bochs_drm: failed bochs_hw_init() results in
> panic". When I boot the system, if plymouth is visible, it crashes. But
> if I press ESC to hide it, it boots fine. bochs_drm is build as module
> and _not_ included in the initramfs, so it is loaded only after root
> filesystem is mounted. And before that, efifb works just fine, including
> nice graphical disk passphrase prompt.

> [   32.951345] fb0: switching to bochsdrmfb from EFI VGA
[ ... ]
> [   33.030158] bochs-drm 0000:00:02.0: BAR 0: can't reserve [mem 0xc00000=
00-0xc0ffffff pref]

Looks like efifb continues to claim the framebuffer resource
(0xc0000000-0xc0ffffff) for some reason, so bochs-drm can't
reserve it.

No clue why, also doesn't reproduce here (standard fedora 31 5.4.7
kernel).  I don't have an encrypted disk, so no passphrase prompt,
maybe that makes a difference.

How does /proc/iomem look after boot, specifically the 0000:00:02.0 pci
bars?

cheers,
  Gerd
