From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: bochs_drm: failed bochs_hw_init() results in panic
Date: Mon, 13 Jan 2020 08:03:54 +0100
Message-ID: <20200113070354.hwozz5zhkifn7ted@sirius.home.kraxel.org>
References: <20200110013328.GA12596@mail-itl>
 <20200110053553.4gqlagjdpfi6pg3b@sirius.home.kraxel.org>
 <20200111000745.GF2507@mail-itl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200111000745.GF2507@mail-itl>
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

> Now the messages looks like this:
> 
> [   29.800835] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers: bar 0: 0xc0000000 -> 0xc0ffffff
> [   29.800840] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers: bar 2: 0xc1087000 -> 0xc1087fff
> [   29.800842] checking generic (c0000000 1000000) vs hw (c0000000 1000000)
> [   29.800843] fb0: switching to bochsdrmfb from EFI VGA
> [   29.805542] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
> [   29.805742] bochs-drm 0000:00:02.0: BAR 0: can't reserve [mem 0xc0000000-0xc0ffffff pref]
> [   29.805749] [drm:bochs_hw_init [bochs_drm]] *ERROR* Cannot request framebuffer

This is the problem.

> [   29.805781] bochs-drm: probe of 0000:00:02.0 failed with error -16
> [   30.129014] Trying to free nonexistent resource <00000000c0000000-00000000c0ffffff>
> 
> Is the last one an issue?

Not critical.  Probably the pci_release_regions() call, trying to free
all regions, including the one the driver could not request, so it warns
about that one.

cheers,
  Gerd
